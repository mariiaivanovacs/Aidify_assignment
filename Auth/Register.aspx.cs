// REQUIRES: BCrypt.Net-Next NuGet package
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

            if (!CheckBox1.Checked)
            {
                lblError.Text = "⚠ You must agree to the Terms and Privacy Policy.";
                lblError.Visible = true;
                return;
            }

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;

            if (!System.Text.RegularExpressions.Regex.IsMatch(
                password,
                @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$"))
            {
                lblError.Text = "Password must contain at least 8 characters, including uppercase, lowercase, number, and special symbol.";
                lblError.Visible = true;
                return;
            }

            var auth = new AuthService();

            if (!auth.VerifyRecaptcha(Request.Form["g-recaptcha-response"]))
            {
                lblError.Text = "Please complete the CAPTCHA.";
                lblError.Visible = true;
                return;
            }

            try
            {
                var repo = new UserRepository();
                var existingUser = repo.GetByEmail(email);

                int userId;
                string emailName;

                if (existingUser != null)
                {
                    if (existingUser.IsEmailConfirmed)
                    {
                        lblError.Text = "An account with that email already exists.";
                        lblError.Visible = true;
                        return;
                    }

                    userId = existingUser.UserId;
                    emailName = existingUser.FullName;
                }
                else
                {
                    userId = auth.RegisterUser(fullName, email, password);
                    emailName = fullName;
                }

                string token = auth.CreateEmailToken(userId, "Confirm", expiryHours: 24);

                string siteUrl = ConfigurationManager.AppSettings["SiteUrl"]
                                 ?? Request.Url.GetLeftPart(UriPartial.Authority);

                string link = siteUrl + ResolveUrl("~/Auth/ConfirmEmail.aspx") + "?t=" + token;

                EmailService.Send(
                    email,
                    "Confirm your Aidify account",
                    $"<p>Hi {Server.HtmlEncode(emailName)},</p>" +
                    $"<p>Click the link below to confirm your account. It expires in 24 hours.</p>" +
                    $"<p><a href='{link}'>Confirm my account</a></p>");

                pnlSuccess.Visible = true;
                lblError.Visible = false;
            }
            catch (InvalidOperationException ex)
            {
                lblError.Text = ex.Message;
                lblError.Visible = true;
            }
            catch
            {
                lblError.Text = "An unexpected error occurred. Please try again.";
                lblError.Visible = true;
            }
        }
    }
}
