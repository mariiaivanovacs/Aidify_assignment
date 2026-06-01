using System;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Controls
{
    public partial class NotificationBell : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AuthHelper.IsLoggedIn()) return;

            int userId = AuthHelper.GetUserId();
            int count = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT COUNT(*) FROM Notifications
                    WHERE UserId = @U AND IsRead = 0", conn);
                cmd.Parameters.AddWithValue("@U", userId);
                count = (int)cmd.ExecuteScalar();
            }

            lblUnreadCount.Text = count.ToString();
            lblUnreadCount.Visible = count > 0;
        }
    }
}