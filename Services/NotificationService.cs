using System;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public static class NotificationService
    {
        public static void Push(int userId, string title, string body, string url = null)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO Notifications (UserId, Title, Body, Url, IsRead, CreatedAt)
                    VALUES (@UserId, @Title, @Body, @Url, 0, GETUTCDATE())", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Title", string.IsNullOrWhiteSpace(title) ? "Notification" : title);
                cmd.Parameters.AddWithValue("@Body", string.IsNullOrWhiteSpace(body) ? (object)DBNull.Value : body);
                cmd.Parameters.AddWithValue("@Url", string.IsNullOrWhiteSpace(url) ? (object)DBNull.Value : url);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
