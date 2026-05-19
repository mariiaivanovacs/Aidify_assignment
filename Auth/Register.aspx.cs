// REQUIRES: BCrypt.Net-Next NuGet package (install via VS NuGet Manager)
using System;
using System.Configuration;
using Aidify_assigment;

namespace Aidify_assigment.Auth
{
    public partial class Register : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnRegister.Click += btnRegister_Click;
        }

        protected void Page_Load(object sender, EventArgs e) { }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtFullName.Text.Trim();
            string email    = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;
            var auth        = new AuthService();

            try
            {
                int userId = auth.RegisterUser(fullName, email, password);
                string token   = auth.CreateEmailToken(userId, "Confirm", expiryHours: 24);
                string siteUrl = ConfigurationManager.AppSettings["SiteUrl"]
                                 ?? Request.Url.GetLeftPart(System.UriPartial.Authority);
                string link = siteUrl + ResolveUrl("~/Auth/ConfirmEmail.aspx") + "?t=" + token;

                EmailService.Send(
                    email,
                    "Confirm your Aidify account",
                    $"<p>Hi {Server.HtmlEncode(fullName)},</p>" +
                    $"<p>Click the link below to confirm your account. It expires in 24 hours.</p>" +
                    $"<p><a href='{link}'>Confirm my account</a></p>");

                pnlSuccess.Visible = true;
                lblError.Visible   = false;
            }
            catch (InvalidOperationException ex)
            {
                lblError.Text    = ex.Message;
                lblError.Visible = true;
            }
            catch
            {
                lblError.Text    = "An unexpected error occurred. Please try again.";
                lblError.Visible = true;
            }
        }
    }
}
