using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ConfirmEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // If the user clicked the link in their email (e.g. ?t=<token>), auto-confirm.
            string token = Request.QueryString["t"];
            if (!string.IsNullOrEmpty(token))
            {
                bool ok = new AuthService().ConfirmEmail(token);
                lblMessage.ForeColor = ok ? Color.Green : Color.Red;
                lblMessage.Text = ok
                    ? "Email confirmed! You can now <a href='Login.aspx'>log in</a>."
                    : "This confirmation link is invalid or has already been used. " +
                      "Please register again or contact support.";
            }
        }

        // Fallback: user manually types the token/code from the email body.
        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string code = txtCode.Text.Trim();

            if (string.IsNullOrWhiteSpace(code))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Please enter the verification code from your email.";
                return;
            }

            bool ok = new AuthService().ConfirmEmail(code);
            lblMessage.ForeColor = ok ? Color.Green : Color.Red;
            lblMessage.Text = ok
                ? "Email confirmed! You can now <a href='Login.aspx'>log in</a>."
                : "The code is invalid or has already been used. " +
                  "Please request a new confirmation email by registering again.";
        }
    }
}
