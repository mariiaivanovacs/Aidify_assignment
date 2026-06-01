using System;
using System.Data.SqlClient;
using System.IO;

namespace Aidify_assigment.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.Enctype = "multipart/form-data";

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            int userId = AuthHelper.GetUserId();

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
                    SELECT FullName, Email, AvatarPath
                    FROM Users
                    WHERE UserId = @UserId
                ", conn);

                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string fullName = reader["FullName"].ToString();
                    string avatar = reader["AvatarPath"] == DBNull.Value
                        ? ""
                        : reader["AvatarPath"].ToString();

                    txtFullName.Text = fullName;
                    txtEmail.Text = reader["Email"].ToString();
                    txtRole.Text = AuthHelper.GetRole();
                    imgAvatar.ImageUrl = !string.IsNullOrWhiteSpace(avatar)
                        ? ResolveUrl(avatar)
                        : "https://ui-avatars.com/api/?name=" + Uri.EscapeDataString(fullName)
                          + "&background=E53935&color=fff&size=96";
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();

            if (string.IsNullOrWhiteSpace(fullName))
            {
                lblMessage.CssClass = "text-danger fw-bold";
                lblMessage.Text = "Name cannot be empty.";
                return;
            }

            int userId = AuthHelper.GetUserId();
            string newAvatar = null;

            if (fuAvatar.HasFile)
            {
                string validationError;
                if (!TrySaveAvatar(userId, out newAvatar, out validationError))
                {
                    lblMessage.CssClass = "text-danger fw-bold";
                    lblMessage.Text = validationError;
                    return;
                }
            }

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = newAvatar == null
                    ? @"
                    UPDATE Users
                    SET FullName = @FullName
                    WHERE UserId = @UserId
                "
                    : @"
                    UPDATE Users
                    SET FullName = @FullName,
                        AvatarPath = @AvatarPath
                    WHERE UserId = @UserId
                ";

                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@UserId", userId);
                if (newAvatar != null) cmd.Parameters.AddWithValue("@AvatarPath", newAvatar);

                cmd.ExecuteNonQuery();
            }

            Session[Constants.SessionName] = fullName;
            if (newAvatar != null) imgAvatar.ImageUrl = ResolveUrl(newAvatar);

            lblMessage.CssClass = "text-success fw-bold";
            lblMessage.Text = "Profile updated successfully.";
        }

        protected string GetDashboardUrl()
        {
            string role = AuthHelper.GetRole();
            if (role == Constants.RoleInstructor) return "~/Instructor/Dashboard.aspx";
            if (role == Constants.RoleLearner) return "~/Learner/Dashboard.aspx";
            return "~/Admin/Dashboard.aspx";
        }

        private bool TrySaveAvatar(int userId, out string avatarPath, out string error)
        {
            avatarPath = null;
            error = null;

            string[] allowedContentTypes = { "image/jpeg", "image/png", "image/gif" };
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            string contentType = fuAvatar.PostedFile.ContentType;
            string extension = Path.GetExtension(fuAvatar.FileName).ToLowerInvariant();

            if (Array.IndexOf(allowedContentTypes, contentType) < 0 ||
                Array.IndexOf(allowedExtensions, extension) < 0)
            {
                error = "Images only: JPEG, PNG, or GIF.";
                return false;
            }

            if (fuAvatar.PostedFile.ContentLength > 2 * 1024 * 1024)
            {
                error = "Max image size is 2 MB.";
                return false;
            }

            string dir = Server.MapPath("~/Uploads/Avatars/");
            if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

            avatarPath = "~/Uploads/Avatars/" + userId + extension;
            fuAvatar.SaveAs(Server.MapPath(avatarPath));
            return true;
        }
    }
}
