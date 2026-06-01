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

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetStats()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            var s = new AdminRepository().GetPlatformStats();
            return new
            {
                totalUsers = s.TotalUsers,
                activeLearners = s.ActiveLearners,
                pendingModules = s.PendingModules,
                totalAttempts = s.TotalAttempts,

                completionRate = s.CompletionRate,
                completedLessons = s.CompletedLessons,
                expectedCompletions = s.ExpectedCompletions,
                completionLabel = s.CompletedLessons + " of " + s.ExpectedCompletions + " completed",

                userGrowthLabel = s.TotalUsers > 0 ? "Live" : "No users",
                learnerStatusLabel = s.CompletedLessons + " completed",
                attemptsStatusLabel = s.TotalAttempts > 0 ? s.TotalAttempts + " recorded" : "No attempts",
                alertStatusLabel = s.PendingModules > 0 ? "Priority" : "Clear",

                learnerProgressPercent = s.CompletionRate
            };
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetRecentActivity()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            var logs = new AdminRepository().GetAuditLogs(withinHours: 168);
            int take = Math.Min(5, logs.Count);

            var result = new System.Collections.Generic.List<object>();

            for (int i = 0; i < take; i++)
            {
                var l = logs[i];

                result.Add(new
                {
                    action = l.Action,
                    targetEntity = l.TargetEntity,
                    timestamp = l.Timestamp,
                    actorName = l.ActorName,
                    actorInitials = l.ActorInitials
                });
            }

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static string GetDailySummary()
        {
            var role = HttpContext.Current.Session[Constants.SessionRole] as string;

            if (role != Constants.RoleAdmin)
                return "Access denied.";

            var service = new AIInsightsService();

            return Task.Run(() => service.GetDailySummaryAsync())
                       .GetAwaiter()
                       .GetResult();
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetEngagementTrend(int days)
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            if (days != 7 && days != 30)
                days = 7;

            return new AdminRepository().GetEngagementTrend(days);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetSystemAlerts()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository().GetSystemAlerts();
        }
    }
}