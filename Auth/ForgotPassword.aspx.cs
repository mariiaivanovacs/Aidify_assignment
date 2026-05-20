using System;
using System.Configuration;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim().ToLower();

            try
            {
                var user = new UserRepository().GetByEmail(email);

                if (user != null && user.IsActive)
                {
                    var auth   = new AuthService();
                    string token   = auth.CreateEmailToken(user.UserId, "Reset", expiryHours: 1);
                    string siteUrl = ConfigurationManager.AppSettings["SiteUrl"]
                                     ?? Request.Url.GetLeftPart(UriPartial.Authority);
                    string link = siteUrl + ResolveUrl("~/Auth/ResetPassword.aspx") + "?t=" + token;

                    EmailService.Send(
                        email,
                        "Reset your Aidify password",
                        $"<p>Hi {Server.HtmlEncode(user.FullName)},</p>" +
                        $"<p>Click the link below to reset your password. It expires in 1 hour.</p>" +
                        $"<p><a href='{link}'>Reset my password</a></p>" +
                        $"<p>If you did not request this, you can safely ignore this email.</p>");
                }
                // If user doesn't exist, we fall through silently to prevent email enumeration
            }
            catch
            {
                // Suppress all errors — always show the same message below
            }

            // Always the same message regardless of whether the email exists
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "If that email is registered, a reset link has been sent. Check your inbox (and spam folder).";
        }
    }
}
