using System;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;

namespace Aidify_assigment
{
    public class CertificateService
    {
        public bool EnsureForCompletedModule(int userId, int moduleId)
        {
            if (userId <= 0 || moduleId <= 0) return false;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                if (CertificateExists(userId, moduleId, conn)) return false;
                if (!ModuleIsCompleted(userId, moduleId, conn)) return false;

                string moduleTitle = GetModuleTitle(moduleId, conn);
                string learnerName = GetLearnerName(userId, conn);
                string virtualPath = WriteCertificateFile(userId, moduleId, learnerName, moduleTitle);

                var insert = new SqlCommand(@"
                    INSERT INTO Certificates (UserId, ModuleId, PdfPath, IssuedAt)
                    VALUES (@UserId, @ModuleId, @PdfPath, GETUTCDATE())", conn);
                insert.Parameters.AddWithValue("@UserId", userId);
                insert.Parameters.AddWithValue("@ModuleId", moduleId);
                insert.Parameters.AddWithValue("@PdfPath", virtualPath);
                insert.ExecuteNonQuery();

                NotificationService.Push(
                    userId,
                    "Certificate Earned!",
                    "Your certificate for " + moduleTitle + " is ready.",
                    "~/Learner/Certificate.aspx");

                return true;
            }
        }

        private static bool CertificateExists(int userId, int moduleId, SqlConnection conn)
        {
            var cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Certificates WHERE UserId=@UserId AND ModuleId=@ModuleId", conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ModuleId", moduleId);
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }

        private static bool ModuleIsCompleted(int userId, int moduleId, SqlConnection conn)
        {
            var cmd = new SqlCommand(@"
                SELECT CASE
                    WHEN LessonCounts.TotalLessons > 0
                     AND LessonCounts.TotalLessons = LessonCounts.CompletedLessons
                    THEN 1 ELSE 0 END
                FROM (
                    SELECT
                        (SELECT COUNT(*) FROM Lessons WHERE ModuleId=@ModuleId) AS TotalLessons,
                        (SELECT COUNT(DISTINCT p.LessonId)
                         FROM Enrollments e
                         JOIN Progress p ON p.EnrolId=e.EnrolId
                         JOIN Lessons l ON l.LessonId=p.LessonId
                         WHERE e.UserId=@UserId
                           AND e.ModuleId=@ModuleId
                           AND l.ModuleId=@ModuleId) AS CompletedLessons
                ) LessonCounts", conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ModuleId", moduleId);
            return Convert.ToInt32(cmd.ExecuteScalar()) == 1;
        }

        private static string GetModuleTitle(int moduleId, SqlConnection conn)
        {
            var cmd = new SqlCommand("SELECT Title FROM Modules WHERE ModuleId=@ModuleId", conn);
            cmd.Parameters.AddWithValue("@ModuleId", moduleId);
            var title = cmd.ExecuteScalar();
            return title == null || title == DBNull.Value ? "Completed Module" : title.ToString();
        }

        private static string GetLearnerName(int userId, SqlConnection conn)
        {
            var cmd = new SqlCommand("SELECT FullName FROM Users WHERE UserId=@UserId", conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            var name = cmd.ExecuteScalar();
            return name == null || name == DBNull.Value ? "Aidify Learner" : name.ToString();
        }

        private static string WriteCertificateFile(int userId, int moduleId, string learnerName, string moduleTitle)
        {
            string relativeDirectory = "~/Certificates/" + userId;
            string virtualPath = relativeDirectory + "/module-" + moduleId + "-certificate.html";
            string physicalDirectory = HttpContext.Current.Server.MapPath(relativeDirectory);
            string physicalPath = HttpContext.Current.Server.MapPath(virtualPath);

            Directory.CreateDirectory(physicalDirectory);
            File.WriteAllText(physicalPath, BuildCertificateHtml(learnerName, moduleTitle), Encoding.UTF8);

            return virtualPath;
        }

        private static string BuildCertificateHtml(string learnerName, string moduleTitle)
        {
            string safeLearnerName = HttpUtility.HtmlEncode(learnerName);
            string safeModuleTitle = HttpUtility.HtmlEncode(moduleTitle);
            string issuedDate = DateTime.UtcNow.ToString("MMMM dd, yyyy");

            return @"<!doctype html>
<html>
<head>
  <meta charset=""utf-8"" />
  <title>Aidify Certificate</title>
  <style>
    body { font-family: Arial, sans-serif; background:#f7f7f7; margin:0; padding:40px; color:#262626; }
    .certificate { max-width:900px; margin:0 auto; background:#fff; border:10px solid #C0392B; padding:64px; text-align:center; }
    .brand { color:#C0392B; font-size:32px; font-weight:800; letter-spacing:0; }
    h1 { font-size:42px; margin:32px 0 12px; }
    .name { font-size:34px; font-weight:800; margin:24px 0; }
    .module { font-size:24px; font-weight:700; color:#C0392B; }
    .date { margin-top:48px; color:#666; }
  </style>
</head>
<body>
  <div class=""certificate"">
    <div class=""brand"">Aidify</div>
    <h1>Certificate of Completion</h1>
    <p>This certifies that</p>
    <div class=""name"">" + safeLearnerName + @"</div>
    <p>has successfully completed</p>
    <div class=""module"">" + safeModuleTitle + @"</div>
    <div class=""date"">Issued " + issuedDate + @" UTC</div>
  </div>
</body>
</html>";
        }
    }
}
