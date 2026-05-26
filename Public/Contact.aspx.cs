using System;
using System.Configuration;
using Aidify_assigment;

namespace Aidify_assigment.Public
{
    public partial class Contact : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnSend.Click += btnSend_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) ShowFlash();
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            string name    = txtName.Text.Trim();
            string from    = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(from) ||
                string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(message))
            {
                SetFlash("Please fill in all fields.", "danger");
                DoRedirect(); return;
            }

            try
            {
                string adminEmail = ConfigurationManager.AppSettings["SmtpUser"];
                EmailService.Send(
                    adminEmail,
                    "Contact Form: " + subject,
                    $"<p><strong>From:</strong> {Server.HtmlEncode(name)} &lt;{Server.HtmlEncode(from)}&gt;</p>" +
                    $"<p><strong>Subject:</strong> {Server.HtmlEncode(subject)}</p>" +
                    $"<p><strong>Message:</strong><br/>{Server.HtmlEncode(message).Replace("\n", "<br/>")}</p>");

                SetFlash("Your message has been sent. We will get back to you shortly.", "success");
            }
            catch
            {
                SetFlash("Message could not be sent. Please try again later.", "danger");
            }

            DoRedirect();
        }

        private void SetFlash(string msg, string type)
        {
            Session["ContactMsg"]  = msg;
            Session["ContactType"] = type;
        }

        private void ShowFlash()
        {
            if (Session["ContactMsg"] == null) return;
            string msg  = Session["ContactMsg"].ToString();
            string type = Session["ContactType"]?.ToString() ?? "info";
            Session.Remove("ContactMsg");
            Session.Remove("ContactType");
            string js = $"document.addEventListener('DOMContentLoaded',function(){{" +
                        $"var d=document.createElement('div');" +
                        $"d.className='alert alert-{type} m-3';" +
                        $"d.textContent='{msg.Replace("'", "\\'")}';" +
                        $"(document.querySelector('.container')||document.body).prepend(d);}});";
            ClientScript.RegisterStartupScript(GetType(), "flash", js, true);
        }

        private void DoRedirect()
        {
            Response.Redirect("Contact.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
