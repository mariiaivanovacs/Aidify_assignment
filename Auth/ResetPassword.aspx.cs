using System;
using System.Drawing;
using System.Text.RegularExpressions;

namespace Aidify_assigment.Auth
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) 
                return;

            string token = Request.QueryString["t"];

            if (string.IsNullOrEmpty(token))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Invalid or missing reset link.<br/>" +
                  "Please enter your email address to request a new password reset link " +
                  "<a href='ForgotPassword.aspx'>here</a>.";
                btnReset.Enabled = false;
                return;
            }

            var row = new UserRepository().GetValidEmailToken(token, "Reset");

            if (row == null)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "This reset link has expired or has already been used.<br/>" +
                                  "Please enter your email address to request a new password reset link " +
                                  "<a href='ForgotPassword.aspx'>here</a>.";
                btnReset.Enabled = false;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string newPwd = txtNewPassword.Text;
            string confirmPwd = txtConfirmPassword.Text;

            if (newPwd != confirmPwd)
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            if (!Regex.IsMatch(newPwd, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$"))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Password must contain at least 8 characters, including uppercase, lowercase, number, and special symbol.";
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
                lblMessage.Text = "This reset link has expired or has already been used.<br/>" +
                  "Please enter your email address to request a new password reset link " +
                  "<a href='ForgotPassword.aspx'>here</a>.";
            }
        }
    }
}