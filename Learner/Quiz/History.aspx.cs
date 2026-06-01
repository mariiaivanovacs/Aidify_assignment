using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Learner.Quiz
{
    public partial class History : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindAttempts();
        }

        private void BindAttempts()
        {
            var attempts = new List<AttemptRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT qa.AttemptId, q.Title, qa.Score, qa.Passed, qa.SubmittedAt
                    FROM   QuizAttempts qa
                    JOIN   Quizzes q ON q.QuizId = qa.QuizId
                    WHERE  qa.UserId = @UserId
                    ORDER BY qa.SubmittedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        attempts.Add(new AttemptRow
                        {
                            AttemptId = (int)r["AttemptId"],
                            Title = r["Title"].ToString(),
                            Score = r["Score"] != DBNull.Value ? (int)(decimal)r["Score"] : 0,
                            Passed = r["Passed"] != DBNull.Value && (bool)r["Passed"],
                            SubmittedAt = r["SubmittedAt"] != DBNull.Value ? (DateTime)r["SubmittedAt"] : DateTime.Now
                        });
            }

            rptAttempts.DataSource = attempts;
            rptAttempts.DataBind();
            lblNoAttempts.Visible = attempts.Count == 0;
        }

        private class AttemptRow
        {
            public int AttemptId, Score;
            public string Title;
            public bool Passed;
            public DateTime SubmittedAt;
        }
    }
}