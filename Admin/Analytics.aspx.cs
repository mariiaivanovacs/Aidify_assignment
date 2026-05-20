using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class Analytics : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["export"] == "users_csv")
                ExportUsersCsv();
        }

        private void ExportUsersCsv()
        {
            var users = new AdminRepository().GetAllUsers();
            ReportService.DownloadUsersCsv(Response, users);
        }

        // Returns stats + chart data for the Analytics page.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetAnalyticsData()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            var stats = new AdminRepository().GetPlatformStats();

            var attemptsByModule = new List<object>();
            var popularModules   = new List<object>();
            decimal completionRate = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Completion rate = enrollments where all lessons done / total enrollments
                var crCmd = new SqlCommand(@"
                    SELECT
                        COUNT(*) AS Total,
                        SUM(CASE WHEN completed.EnrolId IS NOT NULL THEN 1 ELSE 0 END) AS Done
                    FROM Enrollments e
                    LEFT JOIN (
                        SELECT e2.EnrolId
                        FROM   Enrollments e2
                        JOIN   Modules m ON m.ModuleId = e2.ModuleId AND m.IsDeleted = 0
                        WHERE  (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId) > 0
                          AND  (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId)
                             = (SELECT COUNT(*) FROM Progress p
                                JOIN Lessons l2 ON l2.LessonId = p.LessonId
                                WHERE p.EnrolId = e2.EnrolId AND l2.ModuleId = e2.ModuleId)
                    ) AS completed ON completed.EnrolId = e.EnrolId", conn);
                using (var cr = crCmd.ExecuteReader())
                {
                    if (cr.Read())
                    {
                        int total = (int)cr["Total"];
                        int done  = (int)cr["Done"];
                        completionRate = total > 0
                            ? System.Math.Round(done * 100m / total, 1) : 0;
                    }
                }

                // Attempts per module — top 7 for bar chart
                var cmd1 = new SqlCommand(@"
                    SELECT TOP 7
                           m.Title,
                           COUNT(qa.AttemptId) AS Attempts
                    FROM   Modules m
                    LEFT JOIN Quizzes  q  ON q.ModuleId  = m.ModuleId
                    LEFT JOIN QuizAttempts qa ON qa.QuizId = q.QuizId
                    WHERE  m.IsDeleted = 0
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Attempts DESC", conn);

                using (var r = cmd1.ExecuteReader())
                    while (r.Read())
                        attemptsByModule.Add(new
                        {
                            title    = r["Title"].ToString(),
                            attempts = (int)r["Attempts"]
                        });

                // Most enrolled modules — top 5 for ranking bars
                var cmd2 = new SqlCommand(@"
                    SELECT TOP 5
                           m.Title,
                           COUNT(e.EnrolId) AS Enrolments
                    FROM   Modules m
                    LEFT JOIN Enrollments e ON e.ModuleId = m.ModuleId
                    WHERE  m.IsDeleted = 0 AND m.Status = 'Published'
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Enrolments DESC", conn);

                using (var r = cmd2.ExecuteReader())
                    while (r.Read())
                        popularModules.Add(new
                        {
                            title      = r["Title"].ToString(),
                            enrolments = (int)r["Enrolments"]
                        });
            }

            return new
            {
                totalUsers      = stats.TotalUsers,
                activeLearners  = stats.ActiveLearners,
                totalAttempts   = stats.TotalAttempts,
                completionRate,
                attemptsByModule,
                popularModules
            };
        }
    }
}
