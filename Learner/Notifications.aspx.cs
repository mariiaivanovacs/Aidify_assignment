using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Notifications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotifications();
            }
        }

        public void BindNotifications()
        {
            //string sql = @"
            //    SELECT NotifId, Title, Body, Url, IsRead, CreatedAt
            //    FROM   Notifications
            //    WHERE  UserId = @UserId
            //    ORDER BY CreatedAt DESC
            //    ";
            var notifications = new[]
            {
                // Dummy data
                new { NotificationId = 1, Message = "You passed the C# Fundamentals Quiz!",
                      IsRead = false, CreatedAt = new DateTime(2026, 5, 20, 9, 0, 0) },
                new { NotificationId = 2, Message = "New challenge available: 7-Day Streak.",
                      IsRead = false, CreatedAt = new DateTime(2026, 5, 19, 14, 30, 0) },
                new { NotificationId = 3, Message = "You earned the Quiz Master badge!",
                      IsRead = true, CreatedAt = new DateTime(2026, 5, 15, 11, 0, 0) },
            };

            rptNotifications.DataSource = notifications;
            rptNotifications.DataBind();
            lblNoNotifications.Visible = notifications.Length == 0;
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "MarkRead") return;

            int notificationId = Convert.ToInt32(e.CommandArgument);

            //string sql = @"
            //    UPDATE Notifications SET IsRead = 1 
            //    WHERE NotifId = @Id AND UserId = @U
            //    ";

            BindNotifications();
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            //string sql = @"
            //    UPDATE Notifications SET IsRead = 1 
            //    WHERE UserId = @U
            //    ";

            BindNotifications();
        }
    }
}