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
                           cp.Status AS ParticipationStatus,
                           cp.CompletedAt
                    FROM   Challenges c
                    LEFT JOIN ChallengeParticipation cp
                           ON cp.ChallengeId = c.ChallengeId
                          AND cp.UserId = @UserId
                    WHERE  c.Status = 'Published'
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
                            ParticipationStatus = r["ParticipationStatus"] == DBNull.Value ? "" : r["ParticipationStatus"].ToString(),
                            CompletedAt = r["CompletedAt"] != DBNull.Value ? (DateTime?)r["CompletedAt"] : null
                        });
            }

            rptChallenges.DataSource = challenges;
            rptChallenges.DataBind();
            lblNoChallenges.Visible = challenges.Count == 0;
        }

        protected void rptChallenges_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = AuthHelper.GetUserId();
            int challengeId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Join")
            {
                JoinChallenge(userId, challengeId);
            }
            else if (e.CommandName == "Complete")
            {
                CompleteChallenge(userId, challengeId);
            }

            BindChallenges();
        }

        private static void JoinChallenge(int userId, int challengeId)
        {
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
        }

        private static void CompleteChallenge(int userId, int challengeId)
        {
            int reward = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var cmd = new SqlCommand(@"
                        SELECT cp.CPId, cp.Status, c.PointsReward
                        FROM ChallengeParticipation cp
                        JOIN Challenges c ON c.ChallengeId = cp.ChallengeId
                        WHERE cp.ChallengeId=@ChallengeId
                          AND cp.UserId=@UserId
                          AND c.Status='Published'", conn, tx);
                    cmd.Parameters.AddWithValue("@ChallengeId", challengeId);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    int cpId = 0;
                    string status = "";
                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            cpId = Convert.ToInt32(r["CPId"]);
                            status = r["Status"] == DBNull.Value ? "" : r["Status"].ToString();
                            reward = Convert.ToInt32(r["PointsReward"]);
                        }
                    }

                    if (cpId == 0 || string.Equals(status, "Completed", StringComparison.OrdinalIgnoreCase))
                    {
                        tx.Commit();
                        return;
                    }

                    var update = new SqlCommand(@"
                        UPDATE ChallengeParticipation
                        SET Status='Completed', CompletedAt=GETUTCDATE()
                        WHERE CPId=@CPId AND ISNULL(Status,'Joined') <> 'Completed'", conn, tx);
                    update.Parameters.AddWithValue("@CPId", cpId);
                    update.ExecuteNonQuery();

                    LeagueService.AddPoints(userId, reward, conn, tx);
                    tx.Commit();
                }
            }

            NotificationService.Push(userId, "Challenge Completed", "You earned " + reward + " league points.", "~/Learner/Challenges.aspx");
            try { new BadgeService().Evaluate(userId); } catch { /* badge failure must never block challenge completion */ }
        }

        private class ChallengeRow
        {
            public int ChallengeId { get; set; }
            public int PointsReward { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime? EndDate { get; set; }
            public string ParticipationStatus { get; set; }
            public DateTime? CompletedAt { get; set; }
            public bool AlreadyJoined { get { return !string.IsNullOrWhiteSpace(ParticipationStatus); } }
            public bool IsCompleted { get { return CompletedAt.HasValue || string.Equals(ParticipationStatus, "Completed", StringComparison.OrdinalIgnoreCase); } }
        }
    }
}
