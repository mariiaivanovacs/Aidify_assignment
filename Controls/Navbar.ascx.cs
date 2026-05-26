using System;
using Aidify_assigment;

namespace Aidify_assigment.Controls
{
    public partial class Navbar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var role = Session[Constants.SessionRole] as string ?? string.Empty;

            pnlVisitor.Visible    = string.IsNullOrEmpty(role);
            pnlLearner.Visible    = role == Constants.RoleLearner;
            pnlInstructor.Visible = role == Constants.RoleInstructor;
            pnlAdmin.Visible      = role == Constants.RoleAdmin;
        }
    }
}
