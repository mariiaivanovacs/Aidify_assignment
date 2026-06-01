using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Public
{
    public partial class PreviewModules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPreviewModules()
        {
            var modules = new List<object>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 6
                           m.ModuleId,
                           m.Title,
                           m.Description,
                           m.DifficultyLevel,
                           COUNT(l.LessonId) AS LessonCount,
                           ISNULL(SUM(ISNULL(l.EstimatedMinutes, 0)), 0) AS EstimatedMinutes,
                           pq.QuizId AS PreviewQuizId
                    FROM Modules m
                    LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
                    OUTER APPLY (
                        SELECT TOP 1 QuizId
                        FROM Quizzes q
                        WHERE q.ModuleId = m.ModuleId
                          AND q.IsPreview = 1
                        ORDER BY q.QuizId
                    ) pq
                    WHERE m.Status = 'Published'
                      AND m.IsDeleted = 0
                      AND m.IsPreview = 1
                      AND EXISTS (
                          SELECT 1
                          FROM Quizzes q
                          JOIN Questions qs ON qs.QuizId = q.QuizId
                          WHERE q.ModuleId = m.ModuleId
                            AND q.IsPreview = 1
                      )
                    GROUP BY m.ModuleId, m.Title, m.Description, m.DifficultyLevel, m.CreatedAt, pq.QuizId
                    ORDER BY m.ModuleId", conn);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        modules.Add(new {
                            moduleId    = (int)r["ModuleId"],
                            title       = r["Title"].ToString(),
                            description = r["Description"] != DBNull.Value ? r["Description"].ToString() : "",
                            difficulty  = r["DifficultyLevel"] != DBNull.Value ? r["DifficultyLevel"].ToString() : "Beginner",
                            lessonCount = (int)r["LessonCount"],
                            estimatedMinutes = Convert.ToInt32(r["EstimatedMinutes"]),
                            previewQuizId = r["PreviewQuizId"] != DBNull.Value ? Convert.ToInt32(r["PreviewQuizId"]) : 0
                        });
            }
            return modules;
        }
    }
}
