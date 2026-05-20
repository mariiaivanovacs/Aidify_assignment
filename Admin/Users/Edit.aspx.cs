using System;
using System.Configuration;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Admin.Users
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        private int EditUserId
        {
            get { return ViewState["EditUserId"] != null ? (int)ViewState["EditUserId"] : 0; }
            set { ViewState["EditUserId"] = value; }
        }

        private readonly AdminRepository _repo = new AdminRepository();

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnSave.Click += btnSave_Click;

            // Markup has wrong items ("Administrator","Supervisor") — replace with Constants values
            ddlRole.Items.Clear();
            ddlRole.Items.Add(new ListItem("Learner",    Constants.RoleLearner));
            ddlRole.Items.Add(new ListItem("Instructor", Constants.RoleInstructor));
            ddlRole.Items.Add(new ListItem("Admin",      Constants.RoleAdmin));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle force-reset postback before the IsPostBack guard
            if (IsPostBack && Request.Form["forceReset"] == "1")
            {
                HandleForceReset();
                return;
            }

            if (IsPostBack) return;

            ShowFlash();

            int userId;
            if (!int.TryParse(Request.QueryString["userId"], out userId)) return;

            var user = _repo.GetUserById(userId);
            if (user == null) return;

            EditUserId = userId;

            int space = user.FullName.IndexOf(' ');
            txtFirstName.Text = space > 0 ? user.FullName.Substring(0, space)       : user.FullName;
            txtLastName.Text  = space > 0 ? user.FullName.Substring(space + 1)      : string.Empty;
            txtEmail.Text     = user.Email;

            var item = ddlRole.Items.FindByValue(user.RoleName);
            if (item != null) item.Selected = true;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            string first = txtFirstName.Text.Trim();
            string last  = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string role  = ddlRole.SelectedValue;

            if (string.IsNullOrEmpty(first) || string.IsNullOrEmpty(email))
            {
                SetFlash("First name and email are required.", "danger");
                DoRedirect(); return;
            }

            try
            {
                using (var conn = DbHelper.GetConnection())
                {
                    conn.Open();
                    using (var tx = conn.BeginTransaction())
                    {
                        _repo.UpdateUser(EditUserId, (first + " " + last).Trim(),
                                         email, role, true, conn, tx);
                        AuditService.Log(AuthHelper.GetUserId(),
                                         "UpdateUser", "Users", EditUserId, conn, tx);
                        tx.Commit();
                    }
                }
                SetFlash("User updated successfully.", "success");
            }
            catch
            {
                SetFlash("An error occurred. Please try again.", "danger");
            }

            DoRedirect();
        }

        private void HandleForceReset()
        {
            int userId;
            if (!int.TryParse(Request.QueryString["userId"], out userId)) { DoRedirect(); return; }

            try
            {
                var user = _repo.GetUserById(userId);
                if (user == null) { SetFlash("User not found.", "danger"); DoRedirect(); return; }

                var auth   = new AuthService();
                string token   = auth.CreateEmailToken(userId, "Reset", expiryHours: 24);
                string siteUrl = ConfigurationManager.AppSettings["SiteUrl"]
                                 ?? Request.Url.GetLeftPart(UriPartial.Authority);
                string link = siteUrl + ResolveUrl("~/Auth/ResetPassword.aspx") + "?t=" + token;

                EmailService.Send(user.Email,
                    "Your Aidify password has been reset by an administrator",
                    $"<p>Hi {Server.HtmlEncode(user.FullName)},</p>" +
                    $"<p>An administrator has initiated a password reset for your account.</p>" +
                    $"<p><a href='{link}'>Click here to set a new password</a> (link valid for 24 hours).</p>");

                AuditService.Log(AuthHelper.GetUserId(), "ForceResetPassword", "Users", userId);
                SetFlash("Password reset email sent to " + user.Email + ".", "success");
            }
            catch
            {
                SetFlash("Could not send reset email. Check SMTP settings.", "danger");
            }

            DoRedirect();
        }

        private void SetFlash(string msg, string type)
        {
            Session["AdminEditMsg"]  = msg;
            Session["AdminEditType"] = type;
        }

        private void ShowFlash()
        {
            if (Session["AdminEditMsg"] == null) return;
            string msg  = Session["AdminEditMsg"].ToString();
            string type = Session["AdminEditType"]?.ToString() ?? "info";
            Session.Remove("AdminEditMsg");
            Session.Remove("AdminEditType");
            string js = $"document.addEventListener('DOMContentLoaded',function(){{" +
                        $"var d=document.createElement('div');" +
                        $"d.className='alert alert-{type} m-3';" +
                        $"d.textContent='{msg.Replace("'", "\\'")}';" +
                        $"(document.querySelector('.container')||document.body).prepend(d);}});";
            ClientScript.RegisterStartupScript(GetType(), "flash", js, true);
        }

        private void DoRedirect()
        {
            string qs = EditUserId > 0 ? "?userId=" + EditUserId : string.Empty;
            Response.Redirect("Edit.aspx" + qs, false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
