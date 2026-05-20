using System;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class Dashboard : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Returns live platform stats for the four stat cards.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetStats()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;
            var s = new AdminRepository().GetPlatformStats();
            return new
            {
                totalUsers     = s.TotalUsers,
                activeLearners = s.ActiveLearners,
                pendingModules = s.PendingModules,
                totalAttempts  = s.TotalAttempts
            };
        }

        // Returns the last 5 audit log entries for the Recent Activity table.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetRecentActivity()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;
            var logs = new AdminRepository().GetAuditLogs(withinHours: 168);
            int take = System.Math.Min(5, logs.Count);
            var result = new System.Collections.Generic.List<object>();
            for (int i = 0; i < take; i++)
            {
                var l = logs[i];
                result.Add(new {
                    action        = l.Action,
                    targetEntity  = l.TargetEntity,
                    timestamp     = l.Timestamp,
                    actorName     = l.ActorName,
                    actorInitials = l.ActorInitials
                });
            }
            return result;
        }

        // Called via $.ajax() from the AI summary card on the dashboard.
        // Returns the daily insight string (cached 24 h server-side).
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static string GetDailySummary()
        {
            var role = HttpContext.Current.Session[Constants.SessionRole] as string;
            if (role != Constants.RoleAdmin)
                return "Access denied.";

            var service = new AIInsightsService();
            return Task.Run(() => service.GetDailySummaryAsync())
                        .GetAwaiter().GetResult();
        }
    }
}
