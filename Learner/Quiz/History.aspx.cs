using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Quiz
{
    public partial class History : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAttempts();
            }
        }

        private void BindAttempts()
        {
            string sql = @"
                SELECT qa.AttemptId, q.Title, qa.Score, qa.Passed, qa.SubmittedAt
                FROM   QuizAttempts qa
                JOIN   Quizzes q ON q.QuizId = qa.QuizId
                WHERE  qa.UserId = @UserId
                ORDER BY qa.SubmittedAt DESC";
            var attempts = new[]
            {
                // Dummy data
                    new { AttemptId = 1, Title = "C# Fundamentals Quiz",
                        Score = 85, Passed = true,
                        SubmittedAt = new DateTime(2026, 3, 10) },
                    new { AttemptId = 2, Title = "SQL Basics Quiz",
                        Score = 60, Passed = false,
                        SubmittedAt = new DateTime(2026, 3, 22) },
                    new { AttemptId = 3, Title = "ASP.NET Web Forms Quiz",
                        Score = 90, Passed = true,
                        SubmittedAt = new DateTime(2026, 4, 5) },
                };

            rptAttempts.DataSource = attempts;
            rptAttempts.DataBind();
            lblNoAttempts.Visible = attempts.Length == 0;
        }
    }
}