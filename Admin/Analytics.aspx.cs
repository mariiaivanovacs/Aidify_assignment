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

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetAnalyticsData()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            var stats = new AdminRepository().GetPlatformStats();

            var attemptsByModule = new List<object>();
            var popularModules = new List<object>();
            var scoreDistribution = new List<object>();
            decimal completionRate = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var crCmd = new SqlCommand(@"
                    SELECT
                        CAST(COUNT(*) AS INT) AS Total,
                        CAST(ISNULL(SUM(CASE WHEN completed.EnrolId IS NOT NULL THEN 1 ELSE 0 END), 0) AS INT) AS Done
                    FROM Enrollments e
                    LEFT JOIN (
                        SELECT e2.EnrolId
                        FROM Enrollments e2
                        JOIN Modules m ON m.ModuleId = e2.ModuleId AND m.IsDeleted = 0
                        WHERE (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId) > 0
                          AND (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e2.ModuleId)
                              = (SELECT COUNT(*) FROM Progress p
                                 JOIN Lessons l2 ON l2.LessonId = p.LessonId
                                 WHERE p.EnrolId = e2.EnrolId
                                 AND l2.ModuleId = e2.ModuleId)
                    ) AS completed ON completed.EnrolId = e.EnrolId", conn);

                using (var cr = crCmd.ExecuteReader())
                {
                    if (cr.Read())
                    {
                        int total = SafeInt(cr["Total"]);
                        int done = SafeInt(cr["Done"]);

                        completionRate = total > 0
                            ? Math.Round(done * 100m / total, 1)
                            : 0;
                    }
                }

                var cmd1 = new SqlCommand(@"
                    SELECT TOP 7
                           m.Title,
                           CAST(COUNT(qa.AttemptId) AS INT) AS Attempts
                    FROM Modules m
                    LEFT JOIN Quizzes q ON q.ModuleId = m.ModuleId
                    LEFT JOIN QuizAttempts qa ON qa.QuizId = q.QuizId
                    WHERE m.IsDeleted = 0
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Attempts DESC", conn);

                using (var r = cmd1.ExecuteReader())
                {
                    while (r.Read())
                    {
                        attemptsByModule.Add(new
                        {
                            title = SafeString(r["Title"], "Untitled Module"),
                            attempts = SafeInt(r["Attempts"])
                        });
                    }
                }

                var cmd2 = new SqlCommand(@"
                    SELECT TOP 5
                           m.Title,
                           CAST(COUNT(e.EnrolId) AS INT) AS Enrolments
                    FROM Modules m
                    LEFT JOIN Enrollments e ON e.ModuleId = m.ModuleId
                    WHERE m.IsDeleted = 0
                    AND m.Status = 'Published'
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Enrolments DESC", conn);

                using (var r = cmd2.ExecuteReader())
                {
                    while (r.Read())
                    {
                        popularModules.Add(new
                        {
                            title = SafeString(r["Title"], "Untitled Module"),
                            enrolments = SafeInt(r["Enrolments"])
                        });
                    }
                }

                var cmd3 = new SqlCommand(@"
                SELECT
                    CASE
                        WHEN Score < 50 THEN '<50'
                        WHEN Score BETWEEN 50 AND 69 THEN '50-69'
                        WHEN Score BETWEEN 70 AND 84 THEN '70-84'
                        WHEN Score BETWEEN 85 AND 100 THEN '85-100'
                    END AS ScoreRange,
                    COUNT(*) AS Total
                FROM QuizAttempts
                GROUP BY
                    CASE
                        WHEN Score < 50 THEN '<50'
                        WHEN Score BETWEEN 50 AND 69 THEN '50-69'
                        WHEN Score BETWEEN 70 AND 84 THEN '70-84'
                        WHEN Score BETWEEN 85 AND 100 THEN '85-100'
                    END
                 ", conn);

                    using (var r = cmd3.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            scoreDistribution.Add(new
                            {
                                range = SafeString(r["ScoreRange"], ""),
                                total = SafeInt(r["Total"])
                            });
                        }
                    }
            }



            return new
            {
                totalUsers = stats.TotalUsers,
                activeLearners = stats.ActiveLearners,
                totalAttempts = stats.TotalAttempts,
                completionRate = completionRate,
                attemptsByModule = attemptsByModule,
                popularModules = popularModules,
                scoreDistribution = scoreDistribution
            };
        }

        private static int SafeInt(object value)
        {
            if (value == null || value == DBNull.Value)
                return 0;

            int result;
            return int.TryParse(value.ToString(), out result) ? result : 0;
        }

        private static string SafeString(object value, string fallback)
        {
            if (value == null || value == DBNull.Value)
                return fallback;

            return value.ToString();
        }
    }
}