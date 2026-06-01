using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace Aidify_assigment.Admin
{
    public partial class Roles : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected string GetRoleCardsHtml()
        {
            var counts = GetRoleCounts();
            var roles = new[] { "Visitor", "Learner", "Instructor", "Admin" };
            var html = new StringBuilder();

            foreach (var role in roles)
            {
                int count = counts.ContainsKey(role) ? counts[role] : 0;
                string subtitle = role == "Visitor"
                    ? "Unauthenticated public users"
                    : "Active non-deleted accounts";

                html.AppendLine("<div class=\"col-md-6 col-lg-3\">");
                html.AppendLine("<div class=\"role-card shadow-sm\">");
                html.AppendLine("<small>" + HttpUtility.HtmlEncode(role) + "</small>");
                html.AppendLine("<div class=\"role-count\">" + count + "</div>");
                html.AppendLine("<div class=\"text-muted\">" + HttpUtility.HtmlEncode(subtitle) + "</div>");
                html.AppendLine("</div></div>");
            }

            return html.ToString();
        }

        protected string GetPermissionRowsHtml()
        {
            var rows = new[]
            {
                new PermissionRow("Visitor",
                    new[] { "Home, About, Contact, FAQ", "Emergency awareness resources", "Preview modules and preview quizzes", "Register, confirm email, login, forgot/reset password" },
                    new[] { "Learner dashboard and course progress", "Instructor authoring pages", "Admin control center" },
                    "Public pages plus Auth pages. Protected pages redirect through BaseRolePage."),
                new PermissionRow("Learner",
                    new[] { "Learner dashboard", "Course catalogue, enrolment, lessons", "Quiz attempts and results", "Progress, badges, certificates, notifications, events, challenges, discussions" },
                    new[] { "Instructor content authoring", "Admin user/content/audit/analytics pages" },
                    "Learner pages require Constants.RoleLearner."),
                new PermissionRow("Instructor",
                    new[] { "Instructor dashboard", "Manage modules, lessons, materials, quizzes, questions", "View performance, discussions, challenges, events" },
                    new[] { "Learner-only progress pages", "Admin-only user lifecycle, audits, analytics" },
                    "Instructor pages require Constants.RoleInstructor."),
                new PermissionRow("Admin",
                    new[] { "Admin dashboard and system stats", "User lifecycle, approvals, analytics, AI insights", "Audit logs, roles matrix, content/event creation" },
                    new[] { "No admin area restrictions after login; still separate from learner/instructor workflows by role page guards" },
                    "Admin pages require Constants.RoleAdmin.")
            };

            var html = new StringBuilder();
            foreach (var row in rows)
            {
                html.AppendLine("<tr>");
                html.AppendLine("<td><strong>" + HttpUtility.HtmlEncode(row.Role) + "</strong></td>");
                html.AppendLine("<td>" + BuildList(row.Allowed) + "</td>");
                html.AppendLine("<td>" + BuildList(row.Blocked) + "</td>");
                html.AppendLine("<td>" + HttpUtility.HtmlEncode(row.Implementation) + "</td>");
                html.AppendLine("</tr>");
            }

            return html.ToString();
        }

        private static Dictionary<string, int> GetRoleCounts()
        {
            var counts = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
            {
                { "Visitor", 0 },
                { "Learner", 0 },
                { "Instructor", 0 },
                { "Admin", 0 }
            };

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var cmd = new SqlCommand(@"
                    SELECT r.RoleName, COUNT(u.UserId) AS UserCount
                    FROM Roles r
                    LEFT JOIN Users u ON u.RoleId = r.RoleId
                                     AND u.IsActive = 1
                                     AND ISNULL(u.IsDeleted, 0) = 0
                    GROUP BY r.RoleName", conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string role = Convert.ToString(reader["RoleName"]);
                        int count = Convert.ToInt32(reader["UserCount"]);
                        counts[role] = count;
                    }
                }
            }

            return counts;
        }

        private static string BuildList(IEnumerable<string> items)
        {
            var html = new StringBuilder("<ul class=\"permission-list\">");
            foreach (var item in items)
                html.AppendLine("<li>" + HttpUtility.HtmlEncode(item) + "</li>");
            html.AppendLine("</ul>");
            return html.ToString();
        }

        private class PermissionRow
        {
            public PermissionRow(string role, string[] allowed, string[] blocked, string implementation)
            {
                Role = role;
                Allowed = allowed;
                Blocked = blocked;
                Implementation = implementation;
            }

            public string Role { get; private set; }
            public string[] Allowed { get; private set; }
            public string[] Blocked { get; private set; }
            public string Implementation { get; private set; }
        }
    }
}
