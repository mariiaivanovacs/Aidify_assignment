using System;
using System.Web.UI;

namespace Aidify_assigment
{
    public class BaseRolePage : Page
    {
        protected virtual string RequiredRole => null;

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);

            if (RequiredRole == null) return;

            // Allow AJAX WebMethod calls like /Admin/Dashboard.aspx/GetStats
            if (!string.IsNullOrEmpty(Request.PathInfo))
                return;

            var role = Session[Constants.SessionRole] as string;

            if (string.IsNullOrEmpty(role) || role != RequiredRole)
            {
                Response.Redirect("~/Auth/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}