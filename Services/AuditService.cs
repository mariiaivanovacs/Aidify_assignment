using System.Data.SqlClient;

namespace Aidify_assigment
{
    // Stub — Phase B1 (Mariia) replaces this with the real INSERT into AuditLogs.
    public static class AuditService
    {
        public static void Log(int userId, string action, string targetEntity = null,
                               int? targetId = null,
                               SqlConnection conn = null, SqlTransaction tx = null)
        {
        }
    }
}
