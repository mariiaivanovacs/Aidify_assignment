using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Aidify_assigment.Admin.Users
{
    public partial class Create : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnCreateUser.Click += btnCreateUser_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void btnCreateUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim().ToLower();
                string role = ddlRole.SelectedValue;
                bool isActive = chkIsActive.Checked;

                using (var conn = DbHelper.GetConnection())
                {
                    conn.Open();

                    var checkCmd = new SqlCommand(
                        "SELECT COUNT(*) FROM Users WHERE Email = @Email",
                        conn);

                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        lblError.Text = "A user with this email already exists.";
                        lblError.Visible = true;
                        lblMessage.Visible = false;
                        return;
                    }

                    string temporaryPassword = Guid.NewGuid().ToString("N");
                    string passwordHash = BCrypt.Net.BCrypt.HashPassword(temporaryPassword, 11);

                    var insertCmd = new SqlCommand(@"
                        INSERT INTO Users
                        (
                            FullName,
                            Email,
                            PasswordHash,
                            RoleId,
                            IsActive,
                            IsEmailConfirmed,
                            CreatedAt
                        )
                        OUTPUT INSERTED.UserId
                        VALUES
                        (
                            @FullName,
                            @Email,
                            @PasswordHash,
                            (SELECT RoleId FROM Roles WHERE RoleName = @Role),
                            @IsActive,
                            1,
                            GETUTCDATE()
                        )", conn);

                    insertCmd.Parameters.AddWithValue("@FullName", fullName);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    insertCmd.Parameters.AddWithValue("@Role", role);
                    insertCmd.Parameters.AddWithValue("@IsActive", isActive);

                    int newUserId = Convert.ToInt32(insertCmd.ExecuteScalar());

                    string token = Guid.NewGuid().ToString("N");

                    new UserRepository().InsertEmailToken(
                        newUserId,
                        token,
                        "Reset",
                        DateTime.UtcNow.AddMinutes(1));

                    string siteUrl = ConfigurationManager.AppSettings["SiteUrl"];
                    string resetLink = siteUrl + "/Auth/ResetPassword.aspx?t=" + token;

                    string emailBody =
                        "<h2>Welcome to Aidify</h2>" +
                        "<p>Your Aidify account has been created by an administrator.</p>" +
                        "<p>Please click the button below to set your password:</p>" +
                        "<p><a href='" + resetLink + "' " +
                        "style='background:#E53935;color:white;padding:12px 18px;" +
                        "text-decoration:none;border-radius:8px;font-weight:bold;'>Set Password</a></p>" +
                        "<p>If the button does not work, copy and paste this link into your browser:</p>" +
                        "<p>" + resetLink + "</p>" +
                        "<p>This link will expire in 1 minute.</p>" +
                        "<p>Regards,<br/>Aidify Team</p>";

                    EmailService.Send(
                        email,
                        "Welcome to Aidify - Set Your Password",
                        emailBody);

                    int adminId = Convert.ToInt32(Session[Constants.SessionUserId]);

                    AuditService.Log(
                        adminId,
                        "CreateUser",
                        "Users",
                        newUserId
                    );

                    lblMessage.Text = "User created successfully. Password setup email sent.";
                    lblMessage.Visible = true;
                    lblError.Visible = false;

                    Response.Redirect("List.aspx");
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                lblError.Visible = true;
                lblMessage.Visible = false;
            }
        }
    }
}