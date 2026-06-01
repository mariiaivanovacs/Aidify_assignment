using System;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin.Users
{
    public partial class List : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Returns the full user list as a JSON-serialisable array.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetUsers()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetAllUsers()
                .Select(u => new
                {
                    userId      = u.UserId,
                    fullName    = u.FullName,
                    email       = u.Email,
                    roleName    = u.RoleName,
                    roleBadgeCss= u.RoleBadgeCss,
                    isActive    = u.IsActive,
                    initials    = u.Initials,
                    lastActive  = u.LastActive
                })
                .ToList();
        }

        // Returns platform stats for the 4 header cards on the Users List page.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetUserStats()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            var stats = new AdminRepository().GetPlatformStats();

            // Completion rate — same query as Analytics page
            decimal completionRate = 0;
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new System.Data.SqlClient.SqlCommand(@"
                    SELECT COUNT(*) AS Total,
                           SUM(CASE WHEN c.EnrolId IS NOT NULL THEN 1 ELSE 0 END) AS Done
                    FROM Enrollments e
                    LEFT JOIN (
                        SELECT e2.EnrolId FROM Enrollments e2
                        JOIN   Modules m ON m.ModuleId = e2.ModuleId AND m.IsDeleted = 0
                        WHERE (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId) > 0
                          AND (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId)
                            = (SELECT COUNT(*) FROM Progress p
                               JOIN Lessons l2 ON l2.LessonId = p.LessonId
                               WHERE p.EnrolId = e2.EnrolId AND l2.ModuleId = e2.ModuleId)
                    ) AS c ON c.EnrolId = e.EnrolId", conn);
                using (var r = cmd.ExecuteReader())
                    if (r.Read())
                    {
                        int total = Convert.ToInt32(r["Total"] == DBNull.Value ? 0 : r["Total"]);
                        int done = Convert.ToInt32(r["Done"] == DBNull.Value ? 0 : r["Done"]);
                        completionRate = total > 0
                            ? System.Math.Round(done * 100m / total, 1) : 0;
                    }
            }

            return new {
                totalUsers     = stats.TotalUsers,
                activeLearners = stats.ActiveLearners,
                pendingModules = stats.PendingModules,
                completionRate
            };
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetRecentAuditLogs()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetAuditLogs(withinHours: 168)
                .Take(3)
                .Select(x => new
                {
                    x.Action,
                    x.ActorName,
                    x.Timestamp
                })
                .ToList();
        }

        // Enables or disables a user account. Writes to AuditLogs inside the same transaction.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static void SetUserActive(int userId, bool active)
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return;
            new AdminRepository().SetUserActive(userId, active);
        }
    }
}
