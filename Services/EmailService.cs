using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Aidify_assigment
{
    public static class EmailService
    {
        public static void Send(string to, string subject, string htmlBody)
        {
            var user = ConfigurationManager.AppSettings["SmtpUser"];
            var pass = ConfigurationManager.AppSettings["SmtpPass"];
            using (var client = new SmtpClient("smtp.gmail.com", 587))
            {
                client.Credentials = new NetworkCredential(user, pass);
                client.EnableSsl   = true;
                var msg = new MailMessage(user, to, subject, htmlBody) { IsBodyHtml = true };
                client.Send(msg);
            }
        }
    }
}
