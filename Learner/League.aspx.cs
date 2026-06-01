using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class League : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = AuthHelper.GetUserId();
                BindTier(userId);
                BindLeaderboard(userId);
            }
        }

        private void BindTier(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT Tier, Points FROM League WHERE UserId = @UserId", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        string tier = r["Tier"].ToString();
                        lblTier.Text = tier;
                        lblTier.CssClass += " " + GetTierBadge(tier);
                        lblPoints.Text = r["Points"].ToString() + " pts";
                    }
                    else
                    {
                        lblTier.Text = "Bronze";
                        lblTier.CssClass += " bg-warning text-dark";
                        lblPoints.Text = "0 pts";
                    }
                }
            }
        }

        private void BindLeaderboard(int userId)
        {
            var rows = new List<LeaderRow>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 20 u.FullName, l.Tier, l.Points,
                           ROW_NUMBER() OVER (ORDER BY l.Points DESC) AS Rank,
                           CASE WHEN l.UserId = @UserId THEN 1 ELSE 0 END AS IsCurrentUser
                    FROM   League l
                    JOIN   Users u ON u.UserId = l.UserId
                    ORDER BY l.Points DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new LeaderRow
                        {
                            FullName = r["FullName"].ToString(),
                            Tier = r["Tier"].ToString(),
                            Points = (int)r["Points"],
                            Rank = (int)(long)r["Rank"],
                            IsCurrentUser = (int)r["IsCurrentUser"] == 1
                        });
            }

            rptLeaderboard.DataSource = rows;
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

        private class LeaderRow
        {
            public string FullName, Tier;
            public int Points, Rank;
            public bool IsCurrentUser;
        }
    }
}