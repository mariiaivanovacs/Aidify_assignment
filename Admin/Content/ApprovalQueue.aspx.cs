using System;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin.Content
{
    public partial class ApprovalQueue : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"];
            string type = Request.QueryString["type"];
            string idString = Request.QueryString["id"];
            string reason = Request.QueryString["reason"];

            int id;

            if (!string.IsNullOrEmpty(action) &&
                !string.IsNullOrEmpty(type) &&
                int.TryParse(idString, out id) &&
                id > 0)
            {
                int adminId = AuthHelper.GetUserId();
                var repo = new AdminRepository();

                if (type == "module")
                {
                    if (action == "approve")
                        repo.ApproveModule(id, adminId);
                    else if (action == "reject")
                        repo.RejectModule(id, adminId, reason);
                }
                else if (type == "event")
                {
                    if (action == "approve")
                        repo.ApproveEvent(id, adminId);
                    else if (action == "reject")
                        repo.RejectEvent(id, adminId, reason);
                }
                else if (type == "challenge")
                {
                    if (action == "approve")
                        repo.ApproveChallenge(id, adminId);
                    else if (action == "reject")
                        repo.RejectChallenge(id, adminId, reason);
                }

                Response.Redirect("ApprovalQueue.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPendingModules()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetPendingModules()
                .Select(m => new
                {
                    itemType = "Module",
                    itemId = m.ModuleId,
                    title = m.Title,
                    difficultyLevel = m.DifficultyLevel,
                    createdByName = m.CreatedByName,
                    submittedAt = m.CreatedAt
                })
                .ToList();
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPendingEvents()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetPendingEvents()
                .Select(e => new
                {
                    itemType = "Event",
                    itemId = e.EventId,
                    title = e.Title,
                    location = e.Location,
                    createdByName = e.CreatedByName,
                    submittedAt = e.EventDate
                })
                .ToList();
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPendingChallenges()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetPendingChallenges()
                .Select(c => new
                {
                    itemType = "Challenge",
                    itemId = c.ChallengeId,
                    title = c.Title,
                    pointsReward = c.PointsReward,
                    createdByName = c.CreatedByName,
                    submittedAt = c.SubmittedAt
                })
                .ToList();
        }
    }
}
