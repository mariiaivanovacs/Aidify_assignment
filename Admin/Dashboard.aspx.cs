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
