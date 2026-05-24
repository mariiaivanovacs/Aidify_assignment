using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Challenges : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChallenges();
            }
        }

        private void BindChallenges()
        {
            //string sql = @"
            //    SELECT ChallengeId, Title, Description, StartDate, EndDate, PointsReward, Status
            //    FROM   Challenges
            //    WHERE  Status = 'Published' AND (EndDate IS NULL OR EndDate > GETUTCDATE())
            //    ORDER BY StartDate
            //    ";

            var challenges = new[]
            {
                // Dummy data
                new { ChallengeId = 1, Title = "7-Day Streak",
                      Description = "Complete at least one lesson every day for 7 days.",
                      StartDate = new DateTime(2026, 5, 1), EndDate = (DateTime?)new DateTime(2026, 5, 31),
                      PointsReward = 100, AlreadyJoined = false },
                new { ChallengeId = 2, Title = "Quiz Ace",
                      Description = "Score 90% or above on any 3 quizzes.",
                      StartDate = new DateTime(2026, 5, 1), EndDate = (DateTime?)null,
                      PointsReward = 150, AlreadyJoined = true },
                new { ChallengeId = 3, Title = "Course Finisher",
                      Description = "Complete any full course before the deadline.",
                      StartDate = new DateTime(2026, 4, 15), EndDate = (DateTime?)new DateTime(2026, 6, 30),
                      PointsReward = 200, AlreadyJoined = false },
            };

            rptChallenges.DataSource = challenges;
            rptChallenges.DataBind();
            lblNoChallenges.Visible = challenges.Length == 0;
        }

        protected void rptChallenges_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Join") return;

            int challengeId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserId"]);

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (var conn = new System.Data.SqlClient.SqlConnection(connStr))
            {
                conn.Open();

                // Check not already joined
                string checkSql = @"
            SELECT COUNT(*) FROM ChallengeParticipation
            WHERE ChallengeId = @ChallengeId AND UserId = @UserId";

                using (var checkCmd = new System.Data.SqlClient.SqlCommand(checkSql, conn))
                {
                    checkCmd.Parameters.AddWithValue("@ChallengeId", challengeId);
                    checkCmd.Parameters.AddWithValue("@UserId", userId);

                    int alreadyJoined = (int)checkCmd.ExecuteScalar();

                    if (alreadyJoined == 0)
                    {
                        // Not joined yet — insert
                        string insertSql = @"
                    INSERT INTO ChallengeParticipation (ChallengeId, UserId)
                    VALUES (@ChallengeId, @UserId)";

                        using (var insertCmd = new System.Data.SqlClient.SqlCommand(insertSql, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@ChallengeId", challengeId);
                            insertCmd.Parameters.AddWithValue("@UserId", userId);
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            BindChallenges();
        }

    }
}