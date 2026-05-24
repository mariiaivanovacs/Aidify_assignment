using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class League : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTier();
                BindLeaderboard();
            }
        }

        private void BindTier()
        {
            string sql = @"
                SELECT Tier, Points FROM League WHERE UserId = @UserId
                ";
            string tier = "Bronze";
            int points = 320;

            lblTier.Text = tier;
            lblTier.CssClass += " " + GetTierBadge(tier);
            lblPoints.Text = points + " pts";
        }

        private void BindLeaderboard()
        {
            //string sql = @"
            //    SELECT TOP 20 u.FullName, l.Tier, l.Points,
            //        ROW_NUMBER() OVER (ORDER BY l.Points DESC) AS Rank
            //    FROM   League l
            //    JOIN   Users u ON u.UserId = l.UserId
            //    ORDER BY l.Points DESC
            //    ";

            var leaderboard = new[]
            {
                // Dummy data
                new { Rank = 1,  FullName = "Alice",  Tier = "Gold",     Points = 980,  IsCurrentUser = false },
                new { Rank = 2,  FullName = "Bob",    Tier = "Gold",     Points = 870,  IsCurrentUser = false },
                new { Rank = 3,  FullName = "Carol",  Tier = "Silver",   Points = 750,  IsCurrentUser = false },
                new { Rank = 4,  FullName = "Manoj",  Tier = "Bronze",   Points = 320,  IsCurrentUser = true  },
                new { Rank = 5,  FullName = "Dave",   Tier = "Bronze",   Points = 280,  IsCurrentUser = false },
            };

            rptLeaderboard.DataSource = leaderboard;
            rptLeaderboard.DataBind();
        }

        public string GetTierBadge(string tier)
        {
            switch (tier)
            {
                case "Bronze": return "bg-warning text-dark";
                case "Silver": return "bg-secondary";
                case "Gold": return "bg-warning";
                case "Platinum": return "bg-primary";
                default: return "bg-secondary";
            }
        }
    }
}