using System;
using System.Data.SqlClient;
using System.IO;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Profile : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.Enctype = "multipart/form-data";

            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            int userId = AuthHelper.GetUserId();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT FullName, Email, AvatarPath FROM Users WHERE UserId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", userId);
                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return;
                    string name = r["FullName"].ToString();
                    txtFullName.Text    = name;
                    txtEmail.Text       = r["Email"].ToString();
                    lblDisplayName.Text = name;
                    string avatar = r["AvatarPath"] != DBNull.Value ? r["AvatarPath"].ToString() : "";
                    imgAvatar.ImageUrl  = !string.IsNullOrEmpty(avatar)
                        ? ResolveUrl(avatar)
                        : "https://ui-avatars.com/api/?name=" + Uri.EscapeDataString(name)
                          + "&background=C0392B&color=fff&size=100";
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int    userId   = AuthHelper.GetUserId();
            string fullName = txtFullName.Text.Trim();
            string email    = txtEmail.Text.Trim().ToLower();
            string newAvatar = null;

            if (ContainsMarkup(fullName) || ContainsMarkup(email))
            {
                lblProfileStatus.CssClass = "text-danger d-block";
                lblProfileStatus.Visible = true;
                lblProfileStatus.Text = "HTML or script tags are not allowed in profile fields.";
                return;
            }

            if (fuAvatar.HasFile)
            {
                string[] allowed = { "image/jpeg", "image/png", "image/gif" };
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                string ext = Path.GetExtension(fuAvatar.FileName).ToLowerInvariant();
                if (Array.IndexOf(allowed, fuAvatar.PostedFile.ContentType) < 0 ||
                    Array.IndexOf(allowedExtensions, ext) < 0)
                { lblProfileStatus.CssClass = "text-danger d-block"; lblProfileStatus.Visible = true; lblProfileStatus.Text = "Images only (JPEG/PNG/GIF)."; return; }
                if (fuAvatar.PostedFile.ContentLength > 2 * 1024 * 1024)
                { lblProfileStatus.CssClass = "text-danger d-block"; lblProfileStatus.Visible = true; lblProfileStatus.Text = "Max image size is 2 MB."; return; }
                string dir = Server.MapPath("~/Uploads/Avatars/");
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                newAvatar = "~/Uploads/Avatars/" + userId + ext;
                fuAvatar.SaveAs(Server.MapPath(newAvatar));
            }

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var duplicate = new SqlCommand(@"
                    SELECT COUNT(*)
                    FROM Users
                    WHERE Email=@Email
                      AND UserId<>@UserId
                      AND ISNULL(IsDeleted, 0)=0", conn);
                duplicate.Parameters.AddWithValue("@Email", email);
                duplicate.Parameters.AddWithValue("@UserId", userId);

                if (Convert.ToInt32(duplicate.ExecuteScalar()) > 0)
                {
                    lblProfileStatus.CssClass = "text-danger d-block";
                    lblProfileStatus.Visible = true;
                    lblProfileStatus.Text = "Another active user already uses this email.";
                    return;
                }

                using (var tx = conn.BeginTransaction())
                {
                    string sql = newAvatar != null
                        ? "UPDATE Users SET FullName=@N, Email=@E, AvatarPath=@A WHERE UserId=@Id"
                        : "UPDATE Users SET FullName=@N, Email=@E WHERE UserId=@Id";
                    var cmd = new SqlCommand(sql, conn, tx);
                    cmd.Parameters.AddWithValue("@N",  fullName);
                    cmd.Parameters.AddWithValue("@E",  email);
                    cmd.Parameters.AddWithValue("@Id", userId);
                    if (newAvatar != null) cmd.Parameters.AddWithValue("@A", newAvatar);
                    cmd.ExecuteNonQuery();
                    AuditService.Log(userId, "UpdateProfile", "Users", userId, conn, tx);
                    tx.Commit();
                }
            }

            Session[Constants.SessionName] = fullName;
            lblDisplayName.Text = fullName;
            if (newAvatar != null) imgAvatar.ImageUrl = ResolveUrl(newAvatar);
            lblProfileStatus.CssClass = "text-success d-block";
            lblProfileStatus.Visible = true;
            lblProfileStatus.Text     = "Profile updated successfully.";
        }

        private static bool ContainsMarkup(string value)
        {
            return !string.IsNullOrEmpty(value) &&
                   (value.IndexOf("<", StringComparison.Ordinal) >= 0 ||
                    value.IndexOf(">", StringComparison.Ordinal) >= 0);
        }
    }
}
