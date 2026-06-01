using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ConfirmEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            string token = Request.QueryString["t"];

            if (string.IsNullOrWhiteSpace(token))
            {
                ShowResult(
                    false,
                    "Invalid Confirmation Link",
                    "No confirmation token was found in the link.",
                    "This confirmation link is missing required information. Please use the link sent to your email."
                );
                return;
            }

            bool ok = new AuthService().ConfirmEmail(token);

            if (ok)
            {
                ShowResult(
                    true,
                    "Email Confirmed",
                    "Your email has been verified successfully.",
                    "Email confirmed successfully. You can now log in."
                );
            }
            else
            {
                ShowResult(
                    false,
                    "Confirmation Failed",
                    "This confirmation link is invalid, expired, or already used.",
                    "Please request a new confirmation link or contact support."
                );
            }
        }

        private void ShowResult(bool success, string title, string subtitle, string message)
        {
            litIcon.Text = success ? "✅" : "⚠️";
            litTitle.Text = title;
            litSubtitle.Text = subtitle;

            lblMessage.ForeColor = success ? Color.Green : Color.Red;
            lblMessage.Text = message;

            lnkResend.Visible = !success;
        }
    }
}