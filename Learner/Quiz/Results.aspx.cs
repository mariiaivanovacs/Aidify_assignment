using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Quiz
{
    public partial class Results : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadResults();
        }

        private void LoadResults()
        {
            int attemptId;
            if (!int.TryParse(Request.QueryString["attemptId"], out attemptId)) return;

            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Attempt header
                var ac = new SqlCommand(@"
                    SELECT qa.Score, qa.Passed, qa.QuizId, q.Title, q.PassingPct, q.ModuleId
                    FROM   QuizAttempts qa
                    JOIN   Quizzes q ON q.QuizId = qa.QuizId
                    WHERE  qa.AttemptId = @Id AND qa.UserId = @U", conn);
                ac.Parameters.AddWithValue("@Id", attemptId);
                ac.Parameters.AddWithValue("@U",  userId);

                int quizId = 0, moduleId = 0;
                bool passed = false;
                using (var r = ac.ExecuteReader())
                {
                    if (!r.Read()) return;
                    decimal score   = r["Score"] != DBNull.Value ? (decimal)r["Score"] : 0;
                    int     passing = (int)r["PassingPct"];
                    passed   = (bool)r["Passed"];
                    quizId   = (int)r["QuizId"];
                    moduleId = r["ModuleId"] != DBNull.Value ? (int)r["ModuleId"] : 0;

                    lblQuizTitle.Text  = r["Title"].ToString();
                    lblScore.Text      = (int)score + "%";
                    lblPassingPct.Text = "passing score: " + passing + "%";
                    lblVerdict.Text    = passed ? "PASSED" : "FAILED";
                    lblVerdict.CssClass += passed ? " bg-success" : " bg-danger";
                }

                pnlPassed.Visible = passed;
                pnlFailed.Visible = !passed;

                if (passed && moduleId > 0)
                    lnkDownloadCert.NavigateUrl = "~/Learner/Courses/Details.aspx?moduleId=" + moduleId;
                if (!passed)
                    lnkRetakeQuiz.NavigateUrl = "~/Learner/Quiz/Take.aspx?quizId=" + quizId;

                lnkBackToLesson.NavigateUrl = moduleId > 0
                    ? "~/Learner/Courses/Details.aspx?moduleId=" + moduleId
                    : "~/Learner/Dashboard.aspx";

                // Per-question feedback
                var feedback = new List<FeedbackRow>();
                var fc = new SqlCommand(@"
                    SELECT q.QuestionText, aa.IsCorrect,
                           (SELECT OptionText FROM Options
                            WHERE OptionId = aa.SelectedOptionId) AS YourAnswer,
                           (SELECT TOP 1 OptionText FROM Options
                            WHERE QuestionId = q.QuestionId AND IsCorrect = 1) AS CorrectAnswer
                    FROM   AttemptAnswers aa
                    JOIN   Questions q ON q.QuestionId = aa.QuestionId
                    WHERE  aa.AttemptId = @Id
                    ORDER BY aa.AnswerId", conn);
                fc.Parameters.AddWithValue("@Id", attemptId);
                using (var r = fc.ExecuteReader())
                    while (r.Read())
                        feedback.Add(new FeedbackRow {
                            QuestionText  = r["QuestionText"].ToString(),
                            YourAnswer    = r["YourAnswer"]    != DBNull.Value ? r["YourAnswer"].ToString()    : "—",
                            CorrectAnswer = r["CorrectAnswer"] != DBNull.Value ? r["CorrectAnswer"].ToString() : "—",
                            IsCorrect     = r["IsCorrect"]     != DBNull.Value && (bool)r["IsCorrect"],
                            Explanation   = ""
                        });

                rptFeedback.DataSource = feedback;
                rptFeedback.DataBind();
            }
        }

        private class FeedbackRow
        {
            public string QuestionText, YourAnswer, CorrectAnswer, Explanation;
            public bool   IsCorrect;
        }
    }
}
