using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Controls
{
    public partial class NotificationBell : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Uncomment when AuthHelper and DB are ready:
            //if (AuthHelper.IsLoggedIn())
            //{
            //    string sql = @"
            //        SELECT COUNT(*)
            //        FROM   Notifications
            //        WHERE  UserId = @UserId AND IsRead = 0";
            //
            //    // int count = ... execute scalar ...
            //    // lblUnreadCount.Text = count.ToString();
            //    // lblUnreadCount.Visible = count > 0;
            //}

            // Dummy data
            int count = 2;
            lblUnreadCount.Text = count.ToString();
            lblUnreadCount.Visible = count > 0;
        }
    }
}