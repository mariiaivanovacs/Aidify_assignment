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
            // Handle approve / reject from query string links
            string action   = Request.QueryString["action"];
            string idString = Request.QueryString["id"];
            int moduleId;

            if (!string.IsNullOrEmpty(action) && int.TryParse(idString, out moduleId) && moduleId > 0)
            {
                int adminId = AuthHelper.GetUserId();
                var repo    = new AdminRepository();

                if (action == "approve")
                    repo.ApproveModule(moduleId, adminId);
                else if (action == "reject")
                    repo.RejectModule(moduleId, adminId);

                // PRG — redirect back to clean URL so F5 doesn't repeat the action
                Response.Redirect("ApprovalQueue.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        // Returns pending modules as JSON for the JS card renderer.
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
                    moduleId       = m.ModuleId,
                    title          = m.Title,
                    difficultyLevel= m.DifficultyLevel,
                    createdByName  = m.CreatedByName,
                    submittedAt    = m.CreatedAt
                })
                .ToList();
        }
    }
}
