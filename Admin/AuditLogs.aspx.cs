using System;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class AuditLogs : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetAuditLogs(
            string search,
            string action,
            int withinHours,
            int page,
            int pageSize)
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            if (page < 1) page = 1;
            if (pageSize <= 0) pageSize = 25;

            var allLogs = new AdminRepository()
                .GetAuditLogs(
                    search: string.IsNullOrWhiteSpace(search) ? null : search.Trim(),
                    action: string.IsNullOrWhiteSpace(action) ? null : action.Trim(),
                    withinHours: withinHours
                );

            int totalCount = allLogs.Count;

            var pageLogs = allLogs
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(l => new
                {
                    AuditId = l.AuditId,
                    Action = l.Action,
                    TargetEntity = l.TargetEntity,
                    TargetId = l.TargetId,
                    IPAddress = l.IPAddress,
                    Timestamp = l.Timestamp,
                    ActorName = l.ActorName ?? "Unknown",
                    ActorInitials = l.ActorInitials ?? "?"
                })
                .ToList();

            return new
            {
                logs = pageLogs,
                totalCount = totalCount
            };
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetAuditStats()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            int failedLogins = 0;
            int totalActions = 0;
            int passwordResets = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Failed logins in the last 24 hours
                using (var cmd = new System.Data.SqlClient.SqlCommand(@"
                    SELECT COUNT(*)
                    FROM   LoginHistory
                    WHERE  Success = 0
                    AND    [Timestamp] >= DATEADD(HOUR, -24, GETUTCDATE())", conn))
                {
                    failedLogins = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Total audit events in the last 24 hours
                using (var cmd = new System.Data.SqlClient.SqlCommand(@"
                    SELECT COUNT(*)
                    FROM   AuditLogs
                    WHERE  [Timestamp] >= DATEADD(HOUR, -24, GETUTCDATE())", conn))
                {
                    totalActions = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Admin-forced password resets in the last 24 hours
                using (var cmd = new System.Data.SqlClient.SqlCommand(@"
                    SELECT COUNT(*)
                    FROM   AuditLogs
                    WHERE  Action IN ('ForceReset', 'ForceResetPassword')
                    AND    [Timestamp] >= DATEADD(HOUR, -24, GETUTCDATE())", conn))
                {
                    passwordResets = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }

            return new
            {
                FailedLogins = failedLogins,
                TotalActions = totalActions,
                PasswordResets = passwordResets
            };
        }
    }
}
