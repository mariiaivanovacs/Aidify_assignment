using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Password reset successfully.";
        }
    }
}