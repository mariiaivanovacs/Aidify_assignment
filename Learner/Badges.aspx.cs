using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Learner
{
    public partial class Badges : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindBadges();
        }

        private void BindBadges()
        {
            var badges = new List<BadgeRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT b.Name, b.IconPath, ub.AwardedAt
                    FROM   UserBadges ub
                    JOIN   Badges b ON b.BadgeId = ub.BadgeId
                    WHERE  ub.UserId = @UserId
                    ORDER BY ub.AwardedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        badges.Add(new BadgeRow
                        {
                            Name = r["Name"].ToString(),
                            IconPath = r["IconPath"] != DBNull.Value ? r["IconPath"].ToString() : "",
                            AwardedAt = (DateTime)r["AwardedAt"]
                        });
            }

            rptBadges.DataSource = badges;
            rptBadges.DataBind();
            lblNoBadges.Visible = badges.Count == 0;
        }

        private class BadgeRow
        {
            public string Name, IconPath;
            public DateTime AwardedAt;
        }
    }
}