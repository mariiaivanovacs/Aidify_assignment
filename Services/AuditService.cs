using System.Data.SqlClient;
using System.Web;

namespace Aidify_assigment
{
    public static class AuditService
    {
        public static void Log(int userId, string action, string targetEntity = null,
                               int? targetId = null,
                               SqlConnection conn = null, SqlTransaction tx = null)
        {
            bool ownsConn = conn == null;
            if (ownsConn) { conn = DbHelper.GetConnection(); conn.Open(); }

            try
            {
                string ip  = HttpContext.Current?.Request?.UserHostAddress ?? string.Empty;
                var cmd    = new SqlCommand(@"
                    INSERT INTO AuditLogs (UserId, Action, TargetEntity, TargetId, IPAddress)
                    VALUES (@UserId, @Action, @Entity, @TargetId, @IP)", conn, tx);
                cmd.Parameters.AddWithValue("@UserId",   userId);
                cmd.Parameters.AddWithValue("@Action",   action);
                cmd.Parameters.AddWithValue("@Entity",   (object)targetEntity ?? System.DBNull.Value);
                cmd.Parameters.AddWithValue("@TargetId", (object)targetId     ?? System.DBNull.Value);
                cmd.Parameters.AddWithValue("@IP",       ip);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (ownsConn) conn.Dispose();
            }
        }
    }
}
