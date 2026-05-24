using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Badges : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBadges();
            }
        }

        private void BindBadges()
        {
            //string sql = @"
            //    SELECT b.Name, b.IconPath, ub.AwardedAt
            //    FROM   UserBadges ub
            //    JOIN   Badges b ON b.BadgeId = ub.BadgeId
            //    WHERE  ub.UserId = @UserId
            //    ORDER BY ub.AwardedAt DESC
            //    ";
            var badges = new[]
            {
                // Dummy data
                new { Name = "First Lesson",  IconPath = "", AwardedAt = new DateTime(2026, 1, 10) },
                new { Name = "On a Roll",     IconPath = "", AwardedAt = new DateTime(2026, 2, 14) },
                new { Name = "Quiz Master",   IconPath = "", AwardedAt = new DateTime(2026, 3, 5)  },
            };

            rptBadges.DataSource = badges;
            rptBadges.DataBind();
            lblNoBadges.Visible = badges.Length == 0;
        }
    }
}