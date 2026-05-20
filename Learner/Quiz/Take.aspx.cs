using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Quiz
{
    public partial class Take : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadQuiz();
        }

        private void LoadQuiz()
        {
            int quizId;
            if (!int.TryParse(Request.QueryString["quizId"], out quizId)) return;

            var questions = new List<QuizRow>();
            var correctMap = new Dictionary<int, int>(); // questionId → correct option index (0-3)

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Quiz metadata
                var qc = new SqlCommand(
                    "SELECT Title, Description, TimeLimitSec FROM Quizzes WHERE QuizId = @Id", conn);
                qc.Parameters.AddWithValue("@Id", quizId);
                using (var r = qc.ExecuteReader())
                {
                    if (!r.Read()) return;
                    lblQuizTitle.Text       = r["Title"].ToString();
                    lblQuizDescription.Text = r["Description"] == DBNull.Value ? "" : r["Description"].ToString();
                    hfQuizId.Value          = quizId.ToString();
                    int tl = r["TimeLimitSec"] != DBNull.Value ? (int)r["TimeLimitSec"] : 0;
                    hfTimeLimitSec.Value    = tl.ToString();
                }

                // Questions + options
                var oc = new SqlCommand(@"
                    SELECT q.QuestionId, q.QuestionText,
                           MAX(CASE WHEN rn=1 THEN o.OptionText END) AS Option1,
                           MAX(CASE WHEN rn=2 THEN o.OptionText END) AS Option2,
                           MAX(CASE WHEN rn=3 THEN o.OptionText END) AS Option3,
                           MAX(CASE WHEN rn=4 THEN o.OptionText END) AS Option4,
                           MAX(CASE WHEN o.IsCorrect=1 THEN rn END)-1 AS CorrectIdx
                    FROM   Questions q
                    CROSS APPLY (
                        SELECT OptionText, IsCorrect,
                               ROW_NUMBER() OVER (ORDER BY OptionId) AS rn
                        FROM   Options WHERE QuestionId = q.QuestionId
                    ) o
                    WHERE  q.QuizId = @QuizId
                    GROUP BY q.QuestionId, q.QuestionText
                    ORDER BY q.QuestionId", conn);
                oc.Parameters.AddWithValue("@QuizId", quizId);
                using (var r = oc.ExecuteReader())
                    while (r.Read())
                    {
                        int qid = (int)r["QuestionId"];
                        int ci  = r["CorrectIdx"] != DBNull.Value ? (int)(long)r["CorrectIdx"] : 0;
                        questions.Add(new QuizRow {
                            QuestionId   = qid,
                            QuestionText = r["QuestionText"].ToString(),
                            Option1      = r["Option1"]?.ToString() ?? "",
                            Option2      = r["Option2"]?.ToString() ?? "",
                            Option3      = r["Option3"]?.ToString() ?? "",
                            Option4      = r["Option4"]?.ToString() ?? ""
                        });
                        correctMap[qid] = ci;
                    }
            }

            Session["QuizCorrectMap"] = correctMap;
            Session["QuizQuestionIds"] = questions.ConvertAll(q => q.QuestionId);

            rptQuestions.DataSource = questions;
            rptQuestions.DataBind();
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            int userId = AuthHelper.GetUserId();
            int quizId;
            if (!int.TryParse(hfQuizId.Value, out quizId)) return;

            var correctMap  = Session["QuizCorrectMap"]   as Dictionary<int, int>;
            var questionIds = Session["QuizQuestionIds"]   as List<int>;
            if (correctMap == null || questionIds == null) return;

            int correct = 0, total = 0;
            var answers = new List<(int questionId, int selectedIdx, bool isCorrect)>();

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                if (item.ItemIndex >= questionIds.Count) continue;
                int questionId = questionIds[item.ItemIndex];

                var rb0 = (RadioButton)item.FindControl("rbOption_0");
                var rb1 = (RadioButton)item.FindControl("rbOption_1");
                var rb2 = (RadioButton)item.FindControl("rbOption_2");
                var rb3 = (RadioButton)item.FindControl("rbOption_3");

                int selected = rb0.Checked ? 0 : rb1.Checked ? 1 : rb2.Checked ? 2 : rb3.Checked ? 3 : -1;
                int expectedCorrect = correctMap.ContainsKey(questionId) ? correctMap[questionId] : -1;
                bool ok = selected >= 0 && selected == expectedCorrect;

                if (ok) correct++;
                total++;
                answers.Add((questionId, selected, ok));
            }

            decimal score = total > 0 ? Math.Round(correct * 100m / total, 2) : 0;

            // Get passing threshold
            int passingPct = 70;
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var pc = new SqlCommand("SELECT PassingPct FROM Quizzes WHERE QuizId=@Id", conn);
                pc.Parameters.AddWithValue("@Id", quizId);
                var pv = pc.ExecuteScalar();
                if (pv != null) passingPct = (int)pv;
            }

            bool passed = score >= passingPct;
            int attemptId;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var ins = new SqlCommand(@"
                        INSERT INTO QuizAttempts (UserId, QuizId, Score, Passed, IsPopQuiz)
                        OUTPUT INSERTED.AttemptId
                        VALUES (@U, @Q, @S, @P, 0)", conn, tx);
                    ins.Parameters.AddWithValue("@U", userId);
                    ins.Parameters.AddWithValue("@Q", quizId);
                    ins.Parameters.AddWithValue("@S", score);
                    ins.Parameters.AddWithValue("@P", passed);
                    attemptId = (int)ins.ExecuteScalar();

                    foreach (var (qid, sel, ok) in answers)
                    {
                        var ai = new SqlCommand(@"
                            INSERT INTO AttemptAnswers (AttemptId, QuestionId, IsCorrect)
                            VALUES (@A, @Q, @C)", conn, tx);
                        ai.Parameters.AddWithValue("@A", attemptId);
                        ai.Parameters.AddWithValue("@Q", qid);
                        ai.Parameters.AddWithValue("@C", ok);
                        ai.ExecuteNonQuery();
                    }

                    // Add league points if passed
                    if (passed)
                        AddLeaguePoints(userId, 10, conn, tx);

                    tx.Commit();
                }
            }

            Session.Remove("QuizCorrectMap");
            Session.Remove("QuizQuestionIds");

            // Evaluate badge rules after every quiz submission
            try { new BadgeService().Evaluate(userId); } catch { /* badge failure must never block redirect */ }

            Response.Redirect("~/Learner/Quiz/Results.aspx?attemptId=" + attemptId, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private static void AddLeaguePoints(int userId, int pts, SqlConnection conn, SqlTransaction tx)
        {
            var upd = new SqlCommand(@"
                IF EXISTS (SELECT 1 FROM League WHERE UserId=@U)
                    UPDATE League SET Points = Points + @Pts,
                        Tier = CASE WHEN Points + @Pts >= 500 THEN 'Platinum'
                                    WHEN Points + @Pts >= 300 THEN 'Gold'
                                    WHEN Points + @Pts >= 100 THEN 'Silver'
                                    ELSE 'Bronze' END,
                        UpdatedAt = GETUTCDATE()
                    WHERE UserId = @U
                ELSE
                    INSERT INTO League (UserId, Tier, Points) VALUES (@U, 'Bronze', @Pts)",
                conn, tx);
            upd.Parameters.AddWithValue("@U",   userId);
            upd.Parameters.AddWithValue("@Pts", pts);
            upd.ExecuteNonQuery();
        }

        private class QuizRow
        {
            public int    QuestionId;
            public string QuestionText, Option1, Option2, Option3, Option4;
        }
    }
}
