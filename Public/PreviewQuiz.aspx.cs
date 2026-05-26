using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Public
{
    public partial class PreviewQuiz : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnSubmitPreviewQuiz.Click += btnSubmitPreviewQuiz_Click;
        }

        protected void Page_Load(object sender, EventArgs e) { }

        private void btnSubmitPreviewQuiz_Click(object sender, EventArgs e)
        {
            const string js = "document.addEventListener('DOMContentLoaded',function(){" +
                "var d=document.createElement('div');" +
                "d.className='container py-3';" +
                "d.innerHTML='<div class=\"alert alert-success\">" +
                "<strong>Thanks for trying the preview quiz!</strong> " +
                "<a href=\"../Auth/Register.aspx\">Register for free</a> " +
                "to access full quizzes with instant scoring, progress tracking, and certificates." +
                "</div>';" +
                "document.body.insertBefore(d,document.body.firstChild);});";
            ClientScript.RegisterStartupScript(GetType(), "quizDone", js, true);
        }

        // Returns the first IsPreview quiz's questions + options (no attempt saved).
        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPreviewQuestions()
        {
            var result = new List<object>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Find first preview quiz
                var qc = new SqlCommand(
                    "SELECT TOP 1 QuizId FROM Quizzes WHERE IsPreview = 1", conn);
                var quizIdObj = qc.ExecuteScalar();
                if (quizIdObj == null) return result;
                int quizId = (int)quizIdObj;

                // Load questions + options
                var cmd = new SqlCommand(@"
                    SELECT q.QuestionId, q.QuestionText,
                           MAX(CASE WHEN rn=1 THEN o.OptionText END) AS Opt1,
                           MAX(CASE WHEN rn=2 THEN o.OptionText END) AS Opt2,
                           MAX(CASE WHEN rn=3 THEN o.OptionText END) AS Opt3,
                           MAX(CASE WHEN rn=4 THEN o.OptionText END) AS Opt4
                    FROM   Questions q
                    CROSS APPLY (
                        SELECT OptionText, ROW_NUMBER() OVER (ORDER BY OptionId) AS rn
                        FROM   Options WHERE QuestionId = q.QuestionId
                    ) o
                    WHERE  q.QuizId = @Qid
                    GROUP BY q.QuestionId, q.QuestionText
                    ORDER BY q.QuestionId", conn);
                cmd.Parameters.AddWithValue("@Qid", quizId);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                    {
                        var opts = new List<string>();
                        for (int i = 1; i <= 4; i++)
                        {
                            string col = "Opt" + i;
                            if (r[col] != System.DBNull.Value && !string.IsNullOrEmpty(r[col].ToString()))
                                opts.Add(r[col].ToString());
                        }
                        result.Add(new {
                            questionId   = (int)r["QuestionId"],
                            questionText = r["QuestionText"].ToString(),
                            options      = opts
                        });
                    }
            }
            return result;
        }
    }
}
