using System;
using System.Configuration;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ResendConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnResend_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim().ToLower();

            try
            {
                var repo = new UserRepository();
                var user = repo.GetByEmail(email);

                if (user != null && user.IsActive && !user.IsEmailConfirmed)
                {
                    var auth = new AuthService();

                    string token = auth.CreateEmailTokenMinutes(user.UserId, "Confirm", 1);

                    string siteUrl = ConfigurationManager.AppSettings["SiteUrl"]
                                     ?? Request.Url.GetLeftPart(UriPartial.Authority);

                    string link = siteUrl + ResolveUrl("~/Auth/ConfirmEmail.aspx") + "?t=" + token;

                    EmailService.Send(
                        email,
                        "Confirm your Aidify account",
                        $"<p>Hi {Server.HtmlEncode(user.FullName)},</p>" +
                        $"<p>Click the link below to confirm your account. It expires in 1 minute.</p>" +
                        $"<p><a href='{link}'>Confirm my account</a></p>");
                }

                lblMessage.ForeColor = Color.Green;
                lblMessage.Text = "If that email belongs to an unconfirmed account, a new confirmation link has been sent.";
            }
            catch
            {
                lblMessage.ForeColor = Color.Green;
                lblMessage.Text = "If that email belongs to an unconfirmed account, a new confirmation link has been sent.";
            }
        }
    }
}