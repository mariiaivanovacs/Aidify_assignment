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

            if (fuAvatar.HasFile)
            {
                string[] allowed = { "image/jpeg", "image/png", "image/gif" };
                if (Array.IndexOf(allowed, fuAvatar.PostedFile.ContentType) < 0)
                { lblProfileStatus.CssClass = "text-danger d-block"; lblProfileStatus.Text = "Images only (JPEG/PNG/GIF)."; return; }
                if (fuAvatar.PostedFile.ContentLength > 2 * 1024 * 1024)
                { lblProfileStatus.CssClass = "text-danger d-block"; lblProfileStatus.Text = "Max image size is 2 MB."; return; }
                string ext = Path.GetExtension(fuAvatar.FileName);
                string dir = Server.MapPath("~/Uploads/Avatars/");
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                newAvatar = "~/Uploads/Avatars/" + userId + ext;
                fuAvatar.SaveAs(Server.MapPath(newAvatar));
            }

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
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
            lblProfileStatus.Text     = "Profile updated successfully.";
        }
    }
}
