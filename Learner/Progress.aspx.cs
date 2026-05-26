using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Progress : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = AuthHelper.GetUserId();
                BindModuleProgress(userId);
                BindBadges(userId);
                BindCertificates(userId);
            }
        }

        private void BindModuleProgress(int userId)
        {
            var rows = new List<ProgressRow>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT m.Title,
                           COUNT(DISTINCT l.LessonId)  AS Total,
                           COUNT(DISTINCT p.LessonId)  AS Completed,
                           CASE WHEN COUNT(DISTINCT l.LessonId) = 0 THEN 0
                                ELSE CAST(COUNT(DISTINCT p.LessonId) * 100.0
                                     / COUNT(DISTINCT l.LessonId) AS INT)
                           END AS Pct
                    FROM   Enrollments e
                    JOIN   Modules  m ON m.ModuleId  = e.ModuleId
                    LEFT JOIN Lessons l ON l.ModuleId  = m.ModuleId
                    LEFT JOIN Progress p ON p.EnrolId  = e.EnrolId
                                       AND p.LessonId = l.LessonId
                    WHERE  e.UserId = @UserId AND m.IsDeleted = 0
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY m.Title", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new ProgressRow {
                            ModuleName = r["Title"].ToString(),
                            Completed  = (int)r["Completed"],
                            Total      = (int)r["Total"],
                            Pct        = (int)(decimal)r["Pct"]
                        });
            }
            rptModuleProgress.DataSource = rows;
            rptModuleProgress.DataBind();
        }

        private void BindBadges(int userId)
        {
            var rows = new List<BadgeRow>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT b.Name, ub.AwardedAt
                    FROM   UserBadges ub
                    JOIN   Badges b ON b.BadgeId = ub.BadgeId
                    WHERE  ub.UserId = @UserId
                    ORDER BY ub.AwardedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new BadgeRow {
                            Icon        = "🏅",
                            BadgeName   = r["Name"].ToString(),
                            AwardedDate = ((DateTime)r["AwardedAt"]).ToString("MMM yyyy")
                        });
            }
            rptBadges.DataSource = rows;
            rptBadges.DataBind();
            lblNoBadges.Visible = rows.Count == 0;
        }

        private void BindCertificates(int userId)
        {
            var rows = new List<CertRow>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT m.Title, c.IssuedAt, c.PdfPath
                    FROM   Certificates c
                    JOIN   Modules m ON m.ModuleId = c.ModuleId
                    WHERE  c.UserId = @UserId
                    ORDER BY c.IssuedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new CertRow {
                            ModuleName  = r["Title"].ToString(),
                            IssueDate   = ((DateTime)r["IssuedAt"]).ToString("MMMM yyyy"),
                            DownloadUrl = r["PdfPath"] != DBNull.Value
                                ? ResolveUrl(r["PdfPath"].ToString()) : "#"
                        });
            }
            rptCertificates.DataSource = rows;
            rptCertificates.DataBind();
            lblNoCertificates.Visible = rows.Count == 0;
        }

        private class ProgressRow { public string ModuleName; public int Completed, Total, Pct; }
        private class BadgeRow    { public string Icon, BadgeName, AwardedDate; }
        private class CertRow     { public string ModuleName, IssueDate, DownloadUrl; }
    }
}
