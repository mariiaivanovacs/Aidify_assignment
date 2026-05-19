using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public class PlatformStats
    {
        public int TotalUsers      { get; set; }
        public int ActiveLearners  { get; set; }
        public int PendingModules  { get; set; }
        public int TotalAttempts   { get; set; }
    }

    public class UserListDto
    {
        public int    UserId       { get; set; }
        public string FullName     { get; set; }
        public string Email        { get; set; }
        public string RoleName     { get; set; }
        public bool   IsActive     { get; set; }
        public string StatusLabel  { get; set; }
        public string Initials     { get; set; }
        public string RoleBadgeCss { get; set; }
    }

    public class AuditLogDto
    {
        public int      AuditId        { get; set; }
        public string   Action         { get; set; }
        public string   TargetEntity   { get; set; }
        public string   IPAddress      { get; set; }
        public DateTime Timestamp      { get; set; }
        public string   ActorName      { get; set; }
        public string   ActorInitials  { get; set; }
    }

    public class PendingModuleDto
    {
        public int      ModuleId        { get; set; }
        public string   Title           { get; set; }
        public string   DifficultyLevel { get; set; }
        public string   CreatedByName   { get; set; }
        public DateTime CreatedAt       { get; set; }
    }

    public class AdminRepository
    {
        // ── Stats ────────────────────────────────────────────────────────────

        public PlatformStats GetPlatformStats()
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT
                        (SELECT COUNT(*) FROM Users WHERE IsActive = 1) AS TotalUsers,
                        (SELECT COUNT(*) FROM Users u
                           JOIN Roles r ON r.RoleId = u.RoleId
                           WHERE r.RoleName = 'Learner' AND u.IsActive = 1) AS ActiveLearners,
                        (SELECT COUNT(*) FROM Modules
                           WHERE Status = 'PendingReview' AND IsDeleted = 0) AS PendingModules,
                        (SELECT COUNT(*) FROM QuizAttempts) AS TotalAttempts", conn);

                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return new PlatformStats();
                    return new PlatformStats
                    {
                        TotalUsers     = (int)r["TotalUsers"],
                        ActiveLearners = (int)r["ActiveLearners"],
                        PendingModules = (int)r["PendingModules"],
                        TotalAttempts  = (int)r["TotalAttempts"]
                    };
                }
            }
        }

        // ── User management ──────────────────────────────────────────────────

        public List<UserListDto> GetAllUsers(string search = null, string roleFilter = null)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive
                    FROM   Users u
                    JOIN   Roles r ON r.RoleId = u.RoleId
                    WHERE  (@Search IS NULL OR u.FullName LIKE @Search OR u.Email LIKE @Search)
                      AND  (@Role   IS NULL OR r.RoleName = @Role)
                    ORDER BY u.CreatedAt DESC", conn);

                cmd.Parameters.AddWithValue("@Search",
                    string.IsNullOrWhiteSpace(search) ? (object)DBNull.Value : "%" + search + "%");
                cmd.Parameters.AddWithValue("@Role",
                    string.IsNullOrWhiteSpace(roleFilter) ? (object)DBNull.Value : roleFilter);

                var list = new List<UserListDto>();
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        var dto = MapUser(r);
                        list.Add(dto);
                    }
                }
                return list;
            }
        }

        public UserListDto GetUserById(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive
                    FROM   Users u
                    JOIN   Roles r ON r.RoleId = u.RoleId
                    WHERE  u.UserId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", userId);
                using (var r = cmd.ExecuteReader())
                {
                    return r.Read() ? MapUser(r) : null;
                }
            }
        }

        public void UpdateUser(int userId, string fullName, string email, string roleName,
                               bool isActive,
                               SqlConnection conn = null, SqlTransaction tx = null)
        {
            bool ownsConn = conn == null;
            if (ownsConn) { conn = DbHelper.GetConnection(); conn.Open(); }

            try
            {
                var cmd = new SqlCommand(@"
                    UPDATE Users
                    SET    FullName = @FullName,
                           Email    = @Email,
                           RoleId   = (SELECT RoleId FROM Roles WHERE RoleName = @Role),
                           IsActive = @IsActive
                    WHERE  UserId = @Id", conn, tx);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email",    email);
                cmd.Parameters.AddWithValue("@Role",     roleName);
                cmd.Parameters.AddWithValue("@IsActive", isActive);
                cmd.Parameters.AddWithValue("@Id",       userId);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (ownsConn) conn.Dispose();
            }
        }

        public void SetUserActive(int userId, bool isActive)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var cmd = new SqlCommand(
                        "UPDATE Users SET IsActive = @Active WHERE UserId = @Id",
                        conn, tx);
                    cmd.Parameters.AddWithValue("@Active", isActive);
                    cmd.Parameters.AddWithValue("@Id",     userId);
                    cmd.ExecuteNonQuery();

                    int adminId = System.Web.HttpContext.Current != null &&
                                  System.Web.HttpContext.Current.Session[Constants.SessionUserId] != null
                        ? (int)System.Web.HttpContext.Current.Session[Constants.SessionUserId]
                        : 0;

                    AuditService.Log(adminId,
                        isActive ? "EnableUser" : "DisableUser",
                        "Users", userId, conn, tx);

                    tx.Commit();
                }
            }
        }

        // ── Audit logs ───────────────────────────────────────────────────────

        public List<AuditLogDto> GetAuditLogs(string search = null,
                                               string action = null,
                                               int withinHours = 24)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 100
                           a.AuditId, a.Action, a.TargetEntity, a.IPAddress, a.Timestamp,
                           ISNULL(u.FullName, 'System') AS ActorName
                    FROM   AuditLogs a
                    LEFT JOIN Users u ON u.UserId = a.UserId
                    WHERE  a.Timestamp >= DATEADD(HOUR, -@Hours, GETUTCDATE())
                      AND  (@Action IS NULL OR a.Action = @Action)
                      AND  (@Search IS NULL
                             OR a.Action   LIKE @Search
                             OR a.IPAddress LIKE @Search
                             OR u.FullName  LIKE @Search)
                    ORDER BY a.Timestamp DESC", conn);

                cmd.Parameters.AddWithValue("@Hours",  withinHours);
                cmd.Parameters.AddWithValue("@Action",
                    string.IsNullOrWhiteSpace(action) ? (object)DBNull.Value : action);
                cmd.Parameters.AddWithValue("@Search",
                    string.IsNullOrWhiteSpace(search) ? (object)DBNull.Value : "%" + search + "%");

                var list = new List<AuditLogDto>();
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string actor = r["ActorName"].ToString();
                        list.Add(new AuditLogDto
                        {
                            AuditId       = (int)r["AuditId"],
                            Action        = r["Action"].ToString(),
                            TargetEntity  = r["TargetEntity"] == DBNull.Value ? "" : r["TargetEntity"].ToString(),
                            IPAddress     = r["IPAddress"]    == DBNull.Value ? "" : r["IPAddress"].ToString(),
                            Timestamp     = (DateTime)r["Timestamp"],
                            ActorName     = actor,
                            ActorInitials = Initials(actor)
                        });
                    }
                }
                return list;
            }
        }

        // ── Content approval ─────────────────────────────────────────────────

        public List<PendingModuleDto> GetPendingModules()
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT m.ModuleId, m.Title, m.DifficultyLevel, m.CreatedAt,
                           ISNULL(u.FullName, 'Unknown') AS CreatedByName
                    FROM   Modules m
                    LEFT JOIN Users u ON u.UserId = m.CreatedBy
                    WHERE  m.Status = 'PendingReview' AND m.IsDeleted = 0
                    ORDER BY m.CreatedAt DESC", conn);

                var list = new List<PendingModuleDto>();
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        list.Add(new PendingModuleDto
                        {
                            ModuleId        = (int)r["ModuleId"],
                            Title           = r["Title"].ToString(),
                            DifficultyLevel = r["DifficultyLevel"] == DBNull.Value ? "" : r["DifficultyLevel"].ToString(),
                            CreatedByName   = r["CreatedByName"].ToString(),
                            CreatedAt       = (DateTime)r["CreatedAt"]
                        });
                }
                return list;
            }
        }

        public void ApproveModule(int moduleId, int adminUserId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    Execute(conn, tx,
                        "UPDATE Modules SET Status = 'Published' WHERE ModuleId = @Id",
                        new SqlParameter("@Id", moduleId));

                    NotifyCreator(conn, tx, moduleId,
                        "Module Approved",
                        "Your module has been approved and is now published.",
                        "~/Instructor/Dashboard.aspx");

                    AuditService.Log(adminUserId, "ApproveModule", "Modules", moduleId, conn, tx);
                    tx.Commit();
                }
            }
        }

        public void RejectModule(int moduleId, int adminUserId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    Execute(conn, tx,
                        "UPDATE Modules SET Status = 'Draft' WHERE ModuleId = @Id",
                        new SqlParameter("@Id", moduleId));

                    NotifyCreator(conn, tx, moduleId,
                        "Module Rejected",
                        "Your module requires revisions before it can be published.",
                        "~/Instructor/Dashboard.aspx");

                    AuditService.Log(adminUserId, "RejectModule", "Modules", moduleId, conn, tx);
                    tx.Commit();
                }
            }
        }

        // ── Helpers ──────────────────────────────────────────────────────────

        private static UserListDto MapUser(SqlDataReader r)
        {
            var dto = new UserListDto
            {
                UserId   = (int)r["UserId"],
                FullName = r["FullName"].ToString(),
                Email    = r["Email"].ToString(),
                RoleName = r["RoleName"].ToString(),
                IsActive = (bool)r["IsActive"]
            };
            dto.StatusLabel  = dto.IsActive ? "Active" : "Disabled";
            dto.Initials     = Initials(dto.FullName);
            dto.RoleBadgeCss = dto.RoleName == Constants.RoleAdmin      ? "role-admin"
                             : dto.RoleName == Constants.RoleInstructor  ? "role-instructor"
                             : "role-learner";
            return dto;
        }

        private static string Initials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "?";
            var parts = name.Trim().Split(' ');
            return parts.Length >= 2
                ? (parts[0][0].ToString() + parts[parts.Length - 1][0]).ToUpper()
                : name.Substring(0, Math.Min(2, name.Length)).ToUpper();
        }

        private static void Execute(SqlConnection conn, SqlTransaction tx,
                                    string sql, params SqlParameter[] parms)
        {
            var cmd = new SqlCommand(sql, conn, tx);
            foreach (var p in parms) cmd.Parameters.Add(p);
            cmd.ExecuteNonQuery();
        }

        private static void NotifyCreator(SqlConnection conn, SqlTransaction tx,
                                          int moduleId, string title, string body, string url)
        {
            var cmd = new SqlCommand(
                "SELECT CreatedBy FROM Modules WHERE ModuleId = @Id", conn, tx);
            cmd.Parameters.AddWithValue("@Id", moduleId);
            var creatorId = cmd.ExecuteScalar();
            if (creatorId != null && creatorId != DBNull.Value)
                NotificationService.Push((int)creatorId, title, body, url);
        }
    }
}
