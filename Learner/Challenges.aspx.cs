using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Challenges : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindChallenges();
        }

        private void BindChallenges()
        {
            var challenges = new List<ChallengeRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT c.ChallengeId, c.Title, c.Description,
                           c.StartDate, c.EndDate, c.PointsReward,
                           CASE WHEN EXISTS (
                               SELECT 1 FROM ChallengeParticipation
                               WHERE ChallengeId = c.ChallengeId AND UserId = @UserId
                           ) THEN 1 ELSE 0 END AS AlreadyJoined
                    FROM   Challenges c
                    WHERE  Status = 'Published'
                      AND  (EndDate IS NULL OR EndDate > GETUTCDATE())
                    ORDER BY StartDate", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        challenges.Add(new ChallengeRow
                        {
                            ChallengeId = (int)r["ChallengeId"],
                            Title = r["Title"].ToString(),
                            Description = r["Description"] != DBNull.Value ? r["Description"].ToString() : "",
                            StartDate = (DateTime)r["StartDate"],
                            EndDate = r["EndDate"] != DBNull.Value ? (DateTime?)r["EndDate"] : null,
                            PointsReward = (int)r["PointsReward"],
                            AlreadyJoined = (int)r["AlreadyJoined"] == 1
                        });
            }

            rptChallenges.DataSource = challenges;
            rptChallenges.DataBind();
            lblNoChallenges.Visible = challenges.Count == 0;
        }

        protected void rptChallenges_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Join") return;

            int userId = AuthHelper.GetUserId();
            int challengeId = Convert.ToInt32(e.CommandArgument);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var chk = new SqlCommand(@"
                    SELECT COUNT(*) FROM ChallengeParticipation
                    WHERE ChallengeId = @C AND UserId = @U", conn);
                chk.Parameters.AddWithValue("@C", challengeId);
                chk.Parameters.AddWithValue("@U", userId);
                if ((int)chk.ExecuteScalar() == 0)
                {
                    var ins = new SqlCommand(@"
                        INSERT INTO ChallengeParticipation (ChallengeId, UserId)
                        VALUES (@C, @U)", conn);
                    ins.Parameters.AddWithValue("@C", challengeId);
                    ins.Parameters.AddWithValue("@U", userId);
                    ins.ExecuteNonQuery();
                }
            }

            BindChallenges();
        }

        private class ChallengeRow
        {
            public int ChallengeId, PointsReward;
            public string Title, Description;
            public DateTime StartDate;
            public DateTime? EndDate;
            public bool AlreadyJoined;
        }
    }
}