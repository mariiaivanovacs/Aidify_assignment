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

        // Returns module lessons and preview quiz questions without saving an attempt.
        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPreviewContent(int moduleId, int quizId)
        {
            var lessons = new List<object>();
            var questions = new List<object>();
            object module = null;
            object quiz = null;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                if (moduleId <= 0 && quizId > 0)
                {
                    var moduleCmd = new SqlCommand(
                        "SELECT ModuleId FROM Quizzes WHERE QuizId = @QuizId AND IsPreview = 1", conn);
                    moduleCmd.Parameters.AddWithValue("@QuizId", quizId);
                    var moduleIdObj = moduleCmd.ExecuteScalar();
                    if (moduleIdObj != null && moduleIdObj != DBNull.Value)
                        moduleId = Convert.ToInt32(moduleIdObj);
                }

                if (moduleId <= 0)
                {
                    var moduleCmd = new SqlCommand(@"
                        SELECT TOP 1 ModuleId
                        FROM Modules
                        WHERE Status = 'Published'
                          AND IsDeleted = 0
                          AND IsPreview = 1
                        ORDER BY CreatedAt DESC", conn);
                    var moduleIdObj = moduleCmd.ExecuteScalar();
                    if (moduleIdObj == null || moduleIdObj == DBNull.Value)
                        return new { module, quiz, lessons, questions };

                    moduleId = Convert.ToInt32(moduleIdObj);
                }

                var moduleDetailsCmd = new SqlCommand(@"
                    SELECT ModuleId, Title, Description, DifficultyLevel
                    FROM Modules
                    WHERE ModuleId = @ModuleId
                      AND Status = 'Published'
                      AND IsDeleted = 0", conn);
                moduleDetailsCmd.Parameters.AddWithValue("@ModuleId", moduleId);

                using (var r = moduleDetailsCmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        module = new
                        {
                            moduleId = (int)r["ModuleId"],
                            title = r["Title"].ToString(),
                            description = r["Description"] != DBNull.Value ? r["Description"].ToString() : "",
                            difficulty = r["DifficultyLevel"] != DBNull.Value ? r["DifficultyLevel"].ToString() : "Beginner"
                        };
                    }
                }

                var lessonCmd = new SqlCommand(@"
                    SELECT LessonId, Title, BodyHtml, SequenceOrder, EstimatedMinutes
                    FROM Lessons
                    WHERE ModuleId = @ModuleId
                    ORDER BY SequenceOrder, LessonId", conn);
                lessonCmd.Parameters.AddWithValue("@ModuleId", moduleId);

                using (var r = lessonCmd.ExecuteReader())
                    while (r.Read())
                        lessons.Add(new
                        {
                            lessonId = (int)r["LessonId"],
                            title = r["Title"].ToString(),
                            bodyHtml = r["BodyHtml"] != DBNull.Value ? r["BodyHtml"].ToString() : "",
                            sequenceOrder = Convert.ToInt32(r["SequenceOrder"]),
                            estimatedMinutes = r["EstimatedMinutes"] != DBNull.Value ? Convert.ToInt32(r["EstimatedMinutes"]) : 0
                        });

                if (quizId <= 0)
                {
                    var quizCmd = new SqlCommand(@"
                        SELECT TOP 1 QuizId
                        FROM Quizzes
                        WHERE ModuleId = @ModuleId
                          AND IsPreview = 1
                        ORDER BY QuizId", conn);
                    quizCmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    var quizIdObj = quizCmd.ExecuteScalar();
                    if (quizIdObj != null && quizIdObj != DBNull.Value)
                        quizId = Convert.ToInt32(quizIdObj);
                }

                if (quizId <= 0)
                    return new { module, quiz, lessons, questions };

                var quizDetailsCmd = new SqlCommand(@"
                    SELECT QuizId, Title, Description
                    FROM Quizzes
                    WHERE QuizId = @QuizId
                      AND IsPreview = 1", conn);
                quizDetailsCmd.Parameters.AddWithValue("@QuizId", quizId);

                using (var r = quizDetailsCmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        quiz = new
                        {
                            quizId = (int)r["QuizId"],
                            title = r["Title"].ToString(),
                            description = r["Description"] != DBNull.Value ? r["Description"].ToString() : ""
                        };
                    }
                }

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
                        questions.Add(new {
                            questionId   = (int)r["QuestionId"],
                            questionText = r["QuestionText"].ToString(),
                            options      = opts
                        });
                    }
            }

            return new { module, quiz, lessons, questions };
        }
    }
}
