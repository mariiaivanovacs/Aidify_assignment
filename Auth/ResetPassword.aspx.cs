using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Validate token is present before user fills the form
            string token = Request.QueryString["t"];
            if (string.IsNullOrEmpty(token))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Invalid or missing reset link. " +
                                  "Please <a href='ForgotPassword.aspx'>request a new one</a>.";
                btnReset.Enabled = false;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string newPwd     = txtNewPassword.Text;
            string confirmPwd = txtConfirmPassword.Text;

            if (newPwd != confirmPwd)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            if (newPwd.Length < 8)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Password must be at least 8 characters.";
                return;
            }

            string token = Request.QueryString["t"];
            if (string.IsNullOrEmpty(token))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Reset link is missing. Please request a new one.";
                return;
            }

            bool ok = new AuthService().ResetPassword(token, newPwd);

            if (ok)
            {
                lblMessage.ForeColor = Color.Green;
                lblMessage.Text = "Password reset successfully! " +
                                  "You can now <a href='Login.aspx'>log in</a> with your new password.";
                btnReset.Enabled = false;
            }
            else
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "This reset link has expired or already been used. " +
                                  "Please <a href='ForgotPassword.aspx'>request a new one</a>.";
            }
        }
    }
}
