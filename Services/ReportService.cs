using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace Aidify_assigment
{
    // CSV export — no NuGet required, pure StringBuilder.
    public static class ReportService
    {
        public static void DownloadUsersCsv(HttpResponse response, List<UserListDto> users)
        {
            response.Clear();
            response.ContentType = "text/csv";
            response.AddHeader("Content-Disposition",
                "attachment; filename=users_" + DateTime.UtcNow.ToString("yyyyMMdd") + ".csv");

            var sb = new StringBuilder();
            sb.AppendLine("UserId,FullName,Email,Role,Status");
            foreach (var u in users)
                sb.AppendLine(string.Join(",",
                    u.UserId,
                    Esc(u.FullName),
                    Esc(u.Email),
                    Esc(u.RoleName),
                    Esc(u.StatusLabel)));

            response.Write(sb.ToString());
            response.End();
        }

        public static void DownloadAuditLogsCsv(HttpResponse response, List<AuditLogDto> logs)
        {
            response.Clear();
            response.ContentType = "text/csv";
            response.AddHeader("Content-Disposition",
                "attachment; filename=auditlogs_" + DateTime.UtcNow.ToString("yyyyMMdd") + ".csv");

            var sb = new StringBuilder();
            sb.AppendLine("AuditId,Timestamp,Actor,Action,TargetEntity,IPAddress");
            foreach (var l in logs)
                sb.AppendLine(string.Join(",",
                    l.AuditId,
                    l.Timestamp.ToString("yyyy-MM-dd HH:mm:ss"),
                    Esc(l.ActorName),
                    Esc(l.Action),
                    Esc(l.TargetEntity),
                    Esc(l.IPAddress)));

            response.Write(sb.ToString());
            response.End();
        }

        private static string Esc(string v)
        {
            if (string.IsNullOrEmpty(v)) return string.Empty;
            if (v.Contains(",") || v.Contains("\"") || v.Contains("\n"))
                return "\"" + v.Replace("\"", "\"\"") + "\"";
            return v;
        }
    }
}
