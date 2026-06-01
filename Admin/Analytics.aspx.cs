using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
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
            {
                ExportUsersCsv();
                return;
            }

            if (Request.QueryString["export"] == "admin_report")
            {
                ExportAdminReport();
                return;
            }
        }

        private void ExportUsersCsv()
        {
            var users = new AdminRepository().GetAllUsers();
            ReportService.DownloadUsersCsv(Response, users);
        }

        private void ExportAdminReport()
        {
            var stats = new AdminRepository().GetPlatformStats();
            var popularModules = new List<Tuple<string, int>>();
            var attemptsByModule = new List<Tuple<string, int>>();
            var scoreDistribution = new List<Tuple<string, int>>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                using (var cmd = new SqlCommand(@"
                    SELECT TOP 5 m.Title, CAST(COUNT(e.EnrolId) AS INT) AS Enrolments
                    FROM Modules m
                    LEFT JOIN Enrollments e ON e.ModuleId = m.ModuleId
                    WHERE m.IsDeleted = 0 AND m.Status = 'Published'
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Enrolments DESC", conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        popularModules.Add(Tuple.Create(SafeString(r["Title"], "Untitled Module"), SafeInt(r["Enrolments"])));
                }

                using (var cmd = new SqlCommand(@"
                    SELECT TOP 7 m.Title, CAST(COUNT(qa.AttemptId) AS INT) AS Attempts
                    FROM Modules m
                    LEFT JOIN Quizzes q ON q.ModuleId = m.ModuleId
                    LEFT JOIN QuizAttempts qa ON qa.QuizId = q.QuizId
                    WHERE m.IsDeleted = 0
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY Attempts DESC", conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        attemptsByModule.Add(Tuple.Create(SafeString(r["Title"], "Untitled Module"), SafeInt(r["Attempts"])));
                }

                using (var cmd = new SqlCommand(@"
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
                    ORDER BY ScoreRange", conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        scoreDistribution.Add(Tuple.Create(SafeString(r["ScoreRange"], "Unknown"), SafeInt(r["Total"])));
                }
            }

            var html = new StringBuilder();
            html.AppendLine("<!doctype html><html><head><meta charset=\"utf-8\"><title>Aidify Admin Analytics Report</title>");
            html.AppendLine("<style>body{font-family:Arial,sans-serif;margin:32px;color:#1f2937}h1{color:#E53935}.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:12px}.card{border:1px solid #ddd;border-radius:8px;padding:16px}table{width:100%;border-collapse:collapse;margin-top:12px}th,td{border-bottom:1px solid #eee;text-align:left;padding:10px}button{background:#E53935;color:white;border:0;border-radius:6px;padding:10px 16px}@media print{button{display:none}}</style>");
            html.AppendLine("</head><body>");
            html.AppendLine("<button onclick=\"window.print()\">Print Report</button>");
            html.AppendLine("<h1>Aidify Admin Analytics Report</h1>");
            html.AppendLine("<p>Generated: " + HttpUtility.HtmlEncode(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")) + "</p>");
            html.AppendLine("<div class=\"stats\">");
            html.AppendLine(ReportCard("Total Users", stats.TotalUsers.ToString()));
            html.AppendLine(ReportCard("Active Learners", stats.ActiveLearners.ToString()));
            html.AppendLine(ReportCard("Quiz Attempts", stats.TotalAttempts.ToString()));
            html.AppendLine(ReportCard("Completion Rate", stats.CompletionRate + "%"));
            html.AppendLine("</div>");
            html.AppendLine(ReportTable("Popular Modules", "Module", "Enrolments", popularModules));
            html.AppendLine(ReportTable("Quiz Attempts By Module", "Module", "Attempts", attemptsByModule));
            html.AppendLine(ReportTable("Score Distribution", "Score Range", "Attempts", scoreDistribution));
            html.AppendLine("</body></html>");

            Response.Clear();
            Response.ContentType = "text/html";
            Response.AddHeader("Content-Disposition", "inline; filename=admin_report_" + DateTime.Now.ToString("yyyyMMdd") + ".html");
            Response.Write(html.ToString());
            Response.End();
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

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

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
                completionRate = stats.CompletionRate,
                attemptsByModule = attemptsByModule,
                popularModules = popularModules,
                scoreDistribution = scoreDistribution
            };
        }

        private static string ReportCard(string label, string value)
        {
            return "<div class=\"card\"><strong>" + HttpUtility.HtmlEncode(label) + "</strong><br><span style=\"font-size:28px\">" + HttpUtility.HtmlEncode(value) + "</span></div>";
        }

        private static string ReportTable(string title, string leftHeader, string rightHeader, List<Tuple<string, int>> rows)
        {
            var html = new StringBuilder();
            html.AppendLine("<h2>" + HttpUtility.HtmlEncode(title) + "</h2>");
            html.AppendLine("<table><thead><tr><th>" + HttpUtility.HtmlEncode(leftHeader) + "</th><th>" + HttpUtility.HtmlEncode(rightHeader) + "</th></tr></thead><tbody>");

            if (rows.Count == 0)
            {
                html.AppendLine("<tr><td colspan=\"2\">No data available.</td></tr>");
            }

            foreach (var row in rows)
            {
                html.AppendLine("<tr><td>" + HttpUtility.HtmlEncode(row.Item1) + "</td><td>" + row.Item2 + "</td></tr>");
            }

            html.AppendLine("</tbody></table>");
            return html.ToString();
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
