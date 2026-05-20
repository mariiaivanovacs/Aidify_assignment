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

        protected void Page_Load(object sender, EventArgs e) { }

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

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

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
                attemptsByModule,
                popularModules
            };
        }
    }
}
