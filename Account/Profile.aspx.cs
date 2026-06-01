using System;
using System.Data.SqlClient;

namespace Aidify_assigment.Account
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                    SELECT FullName, Email
                    FROM Users
                    WHERE UserId = @UserId
                ", conn);

                cmd.Parameters.AddWithValue("@UserId", userId);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFullName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtRole.Text = AuthHelper.GetRole();
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

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
                    UPDATE Users
                    SET FullName = @FullName
                    WHERE UserId = @UserId
                ", conn);

                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@UserId", userId);

                cmd.ExecuteNonQuery();
            }

            Session[Constants.SessionName] = fullName;

            lblMessage.CssClass = "text-success fw-bold";
            lblMessage.Text = "Profile updated successfully.";
        }
    }
}