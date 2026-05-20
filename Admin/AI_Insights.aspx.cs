using System;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class AI_Insights : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Called via jQuery $.ajax() from the chat widget in AI_Insights.aspx.
        // Returns plain-text AI answer wrapped in {"d": "..."} by ASP.NET.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static string AskAI(string question)
        {
            // Auth guard — WebMethods bypass OnPreInit so we check session manually.
            var role = HttpContext.Current.Session[Constants.SessionRole] as string;
            if (role != Constants.RoleAdmin)
                return "Access denied.";

            if (string.IsNullOrWhiteSpace(question))
                return "Please enter a question.";

            // Per-session rate limit: max 20 AI calls per hour
            var session     = HttpContext.Current.Session;
            var count       = (int)(session["AiCallCount"]        ?? 0);
            var windowStart = (session["AiCallWindowStart"] as DateTime?) ?? DateTime.UtcNow;
            if (DateTime.UtcNow - windowStart > TimeSpan.FromHours(1))
            {
                count       = 0;
                windowStart = DateTime.UtcNow;
                session["AiCallWindowStart"] = windowStart;
            }
            if (count >= 20)
                return "AI rate limit reached (20 calls/hour). Please try again later.";

            session["AiCallCount"] = count + 1;

            // Call AI synchronously (Task.Run avoids sync-context deadlock in Web Forms)
            var service = new AIInsightsService();
            return Task.Run(() => service.AnswerQuestionAsync(question))
                        .GetAwaiter().GetResult();
        }
    }
}
