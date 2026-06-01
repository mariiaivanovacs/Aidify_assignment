using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public class PlatformStats
    {
        public int TotalUsers { get; set; }
        public int ActiveLearners { get; set; }
        public int TotalInstructors { get; set; }

        public int TotalModules { get; set; }
        public int PublishedModules { get; set; }
        public int DraftModules { get; set; }
        public int PendingModules { get; set; }

        public int TotalAttempts { get; set; }

        public int CompletionRate { get; set; }
        public int CompletedLessons { get; set; }
        public int ExpectedCompletions { get; set; }
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
        public string LastActive   { get; set; }
    }

    public class AuditLogDto
    {
        public int      AuditId        { get; set; }
        public string   Action         { get; set; }
        public string   TargetEntity   { get; set; }
        public int      TargetId       { get; set; }
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

    public class EngagementTrendDto
    {
        public string DayLabel { get; set; }
        public int Count { get; set; }
        public int Percent { get; set; }
    }

    public class SystemAlertDto
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public string Severity { get; set; }
        public string TimeLabel { get; set; }
    }

    public class PendingEventDto
    {
        public int EventId { get; set; }
        public string Title { get; set; }
        public string Location { get; set; }
        public string CreatedByName { get; set; }
        public DateTime EventDate { get; set; }
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

                (SELECT COUNT(*) FROM Users u
                JOIN Roles r ON r.RoleId = u.RoleId
                WHERE r.RoleName = 'Instructor' AND u.IsActive = 1) AS TotalInstructors,

                (SELECT COUNT(*) FROM Modules
                    WHERE IsDeleted = 0) AS TotalModules,

                (SELECT COUNT(*) FROM Modules
                    WHERE Status = 'Published' AND IsDeleted = 0) AS PublishedModules,

                (SELECT COUNT(*) FROM Modules
                    WHERE Status = 'Draft' AND IsDeleted = 0) AS DraftModules,

                (SELECT COUNT(*) FROM Modules
                    WHERE Status = 'PendingReview' AND IsDeleted = 0) AS PendingModules,

                (SELECT COUNT(*) FROM QuizAttempts) AS TotalAttempts,

                (SELECT COUNT(*) FROM Lessons) AS TotalLessons,

                (SELECT COUNT(*) FROM Progress
                 WHERE CompletedAt IS NOT NULL) AS CompletedLessons", conn);

                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return new PlatformStats();

                    int activeLearners = (int)r["ActiveLearners"];
                    int totalLessons = (int)r["TotalLessons"];
                    int completedLessons = (int)r["CompletedLessons"];

                    int expectedCompletions = activeLearners * totalLessons;

                    int completionRate = expectedCompletions == 0
                        ? 0
                        : (completedLessons * 100) / expectedCompletions;

                    return new PlatformStats
                    {
                        TotalUsers = (int)r["TotalUsers"],
                        ActiveLearners = activeLearners,
                        TotalInstructors = (int)r["TotalInstructors"],

                        TotalModules = (int)r["TotalModules"],
                        PublishedModules = (int)r["PublishedModules"],
                        DraftModules = (int)r["DraftModules"],
                        PendingModules = (int)r["PendingModules"],

                        TotalAttempts = (int)r["TotalAttempts"],
                        CompletedLessons = completedLessons,
                        ExpectedCompletions = expectedCompletions,
                        CompletionRate = completionRate
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
                    SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive,
                           (SELECT MAX(lh.Timestamp)
                            FROM   LoginHistory lh
                            WHERE  lh.UserId = u.UserId AND lh.Success = 1) AS LastLogin
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
            SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive,
                   (SELECT MAX(lh.Timestamp)
                    FROM LoginHistory lh
                    WHERE lh.UserId = u.UserId AND lh.Success = 1) AS LastLogin
            FROM Users u
            JOIN Roles r ON r.RoleId = u.RoleId
            WHERE u.UserId = @Id", conn);

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
                        a.AuditId, a.Action, a.TargetEntity, a.TargetId, a.IPAddress, a.Timestamp,
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
                            AuditId = (int)r["AuditId"],
                            Action = r["Action"].ToString(),
                            TargetEntity = r["TargetEntity"] == DBNull.Value ? "" : r["TargetEntity"].ToString(),
                            TargetId = r["TargetId"] == DBNull.Value ? 0 : Convert.ToInt32(r["TargetId"]),
                            IPAddress = r["IPAddress"] == DBNull.Value ? "" : r["IPAddress"].ToString(),
                            Timestamp = TimeZoneInfo.ConvertTimeFromUtc(
                                            (DateTime)r["Timestamp"],
                                            TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time")
                                        ),
                            ActorName = actor,
                            ActorInitials = Initials(actor)
                        });
                    }
                }
                return list;
            }
        }

        // ── Content approval ─────────────────────────────────────────────────

        public List<PendingEventDto> GetPendingEvents()
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var cmd = new SqlCommand(@"
            SELECT
                e.EventId,
                e.Title,
                e.Location,
                e.EventDate,
                ISNULL(u.FullName,'Unknown') AS CreatedByName
            FROM Events e
            LEFT JOIN Users u ON u.UserId = e.CreatedBy
            WHERE e.Status = 'PendingReview'
            ORDER BY e.EventDate DESC
        ", conn);

                var list = new List<PendingEventDto>();

                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        list.Add(new PendingEventDto
                        {
                            EventId = (int)r["EventId"],
                            Title = r["Title"].ToString(),
                            Location = r["Location"].ToString(),
                            CreatedByName = r["CreatedByName"].ToString(),
                            EventDate = (DateTime)r["EventDate"]
                        });
                    }
                }

                return list;
            }
        }

        public void ApproveEvent(int eventId, int adminUserId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                using (var tx = conn.BeginTransaction())
                {
                    Execute(conn, tx,
                        "UPDATE Events SET Status = 'Published' WHERE EventId = @Id",
                        new SqlParameter("@Id", eventId));

                    AuditService.Log(
                        adminUserId,
                        "ApproveEvent",
                        "Events",
                        eventId,
                        conn,
                        tx);

                    tx.Commit();
                }
            }
        }

        public void RejectEvent(int eventId, int adminUserId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                using (var tx = conn.BeginTransaction())
                {
                    Execute(conn, tx,
                        "UPDATE Events SET Status = 'Draft' WHERE EventId = @Id",
                        new SqlParameter("@Id", eventId));

                    AuditService.Log(
                        adminUserId,
                        "RejectEvent",
                        "Events",
                        eventId,
                        conn,
                        tx);

                    tx.Commit();
                }
            }
        }

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

        public List<EngagementTrendDto> GetEngagementTrend(int days)
        {
            if (days != 7 && days != 30)
                days = 7;

            var counts = new Dictionary<DateTime, int>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var cmd = new SqlCommand(@"
            SELECT CAST([Timestamp] AS date) AS DayDate, COUNT(*) AS Total
            FROM LoginHistory
            WHERE [Timestamp] >= DATEADD(DAY, -@DaysBack, CAST(GETUTCDATE() AS date))
            GROUP BY CAST([Timestamp] AS date)", conn);

                cmd.Parameters.AddWithValue("@DaysBack", days - 1);

                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        counts[(DateTime)r["DayDate"]] = (int)r["Total"];
                }
            }

            int max = 0;
            foreach (var v in counts.Values)
                if (v > max) max = v;

            var list = new List<EngagementTrendDto>();

            for (int i = days - 1; i >= 0; i--)
            {
                DateTime day = DateTime.UtcNow.Date.AddDays(-i);
                int count = counts.ContainsKey(day) ? counts[day] : 0;

                list.Add(new EngagementTrendDto
                {
                    DayLabel = day.ToString("dd MMM"),
                    Count = count,
                    Percent = count == 0 ? 0 : Math.Max(10, (count * 100) / max)
                });
            }

            return list;
        }

        public List<SystemAlertDto> GetSystemAlerts()
        {
            var alerts = new List<SystemAlertDto>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var cmd = new SqlCommand(@"
                SELECT
                    (SELECT COUNT(*)
                     FROM Modules
                     WHERE Status = 'PendingReview'
                     AND IsDeleted = 0) AS PendingModules,

                    (SELECT COUNT(*)
                     FROM LoginHistory
                     WHERE Success = 0
                     AND [Timestamp] >= DATEADD(HOUR,-24,GETUTCDATE())) AS FailedLogins,

                    (SELECT COUNT(*)
                     FROM Users
                     WHERE IsEmailConfirmed = 0
                     AND IsActive = 1) AS UnconfirmedUsers,

                    (SELECT COUNT(*)
                     FROM Users
                     WHERE CreatedAt >= DATEADD(HOUR,-24,GETUTCDATE())) AS NewUsers,

                    (SELECT COUNT(*)
                     FROM Users u
                     INNER JOIN Roles r ON u.RoleId = r.RoleId
                     WHERE r.RoleName = 'Instructor'
                     AND u.CreatedAt >= DATEADD(DAY,-7,GETUTCDATE())) AS NewInstructors,

                    (SELECT COUNT(*)
                     FROM Events
                     WHERE EventDate >= GETUTCDATE()
                     AND EventDate <= DATEADD(DAY,7,GETUTCDATE())) AS UpcomingEvents
                ", conn);

                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        int pendingModules = Convert.ToInt32(r["PendingModules"]);
                        int failedLogins = Convert.ToInt32(r["FailedLogins"]);
                        int unconfirmedUsers = Convert.ToInt32(r["UnconfirmedUsers"]);
                        int newUsers = Convert.ToInt32(r["NewUsers"]);
                        int newInstructors = Convert.ToInt32(r["NewInstructors"]);
                        int upcomingEvents = Convert.ToInt32(r["UpcomingEvents"]);

                        if (pendingModules > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "Pending Module Review",
                                Message = pendingModules + " module(s) need admin approval.",
                                Severity = "danger",
                                TimeLabel = "Live"
                            });
                        }

                        if (failedLogins > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "Failed Login Attempts",
                                Message = failedLogins + " failed login attempt(s) detected in the last 24 hours.",
                                Severity = "warning",
                                TimeLabel = "24h"
                            });
                        }

                        if (unconfirmedUsers > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "Unconfirmed Accounts",
                                Message = unconfirmedUsers + " active account(s) still need email confirmation.",
                                Severity = "info",
                                TimeLabel = "Live"
                            });
                        }

                        if (newUsers > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "New User Registrations",
                                Message = newUsers + " user(s) registered in the last 24 hours.",
                                Severity = "info",
                                TimeLabel = "24h"
                            });
                        }

                        if (newInstructors > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "New Instructor Added",
                                Message = newInstructors + " instructor account(s) added during the last 7 days.",
                                Severity = "info",
                                TimeLabel = "7 Days"
                            });
                        }

                        if (upcomingEvents > 0)
                        {
                            alerts.Add(new SystemAlertDto
                            {
                                Title = "Upcoming Events",
                                Message = upcomingEvents + " event(s) scheduled within the next 7 days.",
                                Severity = "info",
                                TimeLabel = "7 Days"
                            });
                        }
                    }
                }
            }

            if (alerts.Count == 0)
            {
                alerts.Add(new SystemAlertDto
                {
                    Title = "No Critical Alerts",
                    Message = "No system issues require admin attention.",
                    Severity = "info",
                    TimeLabel = "Live"
                });
            }

            return alerts;
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
            dto.LastActive   = r["LastLogin"] == DBNull.Value
                ? "Never"
                : RelativeTime((DateTime)r["LastLogin"]);
            dto.RoleBadgeCss = dto.RoleName == Constants.RoleAdmin      ? "role-admin"
                             : dto.RoleName == Constants.RoleInstructor  ? "role-instructor"
                             : "role-learner";
            return dto;
        }

        private static string RelativeTime(DateTime utc)
        {
            var diff = DateTime.UtcNow - utc;
            if (diff.TotalMinutes < 2)   return "Just now";
            if (diff.TotalMinutes < 60)  return (int)diff.TotalMinutes + " mins ago";
            if (diff.TotalHours  < 24)   return (int)diff.TotalHours   + " hours ago";
            if (diff.TotalDays   < 7)    return (int)diff.TotalDays    + " days ago";
            return utc.ToLocalTime().ToString("dd MMM yyyy");
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
