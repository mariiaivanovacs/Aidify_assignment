using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Notifications : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindNotifications();
        }

        private void BindNotifications()
        {
            var notifications = new List<NotifRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT NotificationId, Message, IsRead, CreatedAt
                    FROM   Notifications
                    WHERE  UserId = @UserId
                    ORDER BY CreatedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        notifications.Add(new NotifRow
                        {
                            NotificationId = (int)r["NotificationId"],
                            Message = r["Message"].ToString(),
                            IsRead = (bool)r["IsRead"],
                            CreatedAt = (DateTime)r["CreatedAt"]
                        });
            }

            rptNotifications.DataSource = notifications;
            rptNotifications.DataBind();
            lblNoNotifications.Visible = notifications.Count == 0;
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "MarkRead") return;

            int userId = AuthHelper.GetUserId();
            int notificationId = Convert.ToInt32(e.CommandArgument);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    UPDATE Notifications SET IsRead = 1
                    WHERE NotificationId = @Id AND UserId = @U", conn);
                cmd.Parameters.AddWithValue("@Id", notificationId);
                cmd.Parameters.AddWithValue("@U", userId);
                cmd.ExecuteNonQuery();
            }

            BindNotifications();
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    UPDATE Notifications SET IsRead = 1
                    WHERE UserId = @U AND IsRead = 0", conn);
                cmd.Parameters.AddWithValue("@U", userId);
                cmd.ExecuteNonQuery();
            }

            BindNotifications();
        }

        private class NotifRow
        {
            public int NotificationId;
            public string Message;
            public bool IsRead;
            public DateTime CreatedAt;
        }
    }
}