using System;
using System.Data;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public class UserDto
    {
        public int    UserId           { get; set; }
        public string FullName         { get; set; }
        public string Email            { get; set; }
        public string PasswordHash     { get; set; }
        public string RoleName         { get; set; }
        public bool   IsActive         { get; set; }
        public bool   IsEmailConfirmed { get; set; }
    }

    public class UserRepository
    {
        public UserDto GetByEmail(string email)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT u.UserId, u.FullName, u.Email, u.PasswordHash,
                           r.RoleName, u.IsActive, u.IsEmailConfirmed
                    FROM   Users u
                    JOIN   Roles r ON r.RoleId = u.RoleId
                    WHERE  u.Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                using (var r = cmd.ExecuteReader())
                {
                    return r.Read() ? Map(r) : null;
                }
            }
        }

        public UserDto GetById(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT u.UserId, u.FullName, u.Email, u.PasswordHash,
                           r.RoleName, u.IsActive, u.IsEmailConfirmed
                    FROM   Users u
                    JOIN   Roles r ON r.RoleId = u.RoleId
                    WHERE  u.UserId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", userId);
                using (var r = cmd.ExecuteReader())
                {
                    return r.Read() ? Map(r) : null;
                }
            }
        }

        public int Insert(string fullName, string email, string passwordHash, string roleName)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
                    SELECT @FullName, @Email, @Hash,
                           (SELECT RoleId FROM Roles WHERE RoleName = @Role), 1, 0;
                    SELECT SCOPE_IDENTITY();", conn);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email",    email);
                cmd.Parameters.AddWithValue("@Hash",     passwordHash);
                cmd.Parameters.AddWithValue("@Role",     roleName);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public bool EmailExists(string email)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT COUNT(1) FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        public void ConfirmEmail(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "UPDATE Users SET IsEmailConfirmed = 1 WHERE UserId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", userId);
                cmd.ExecuteNonQuery();
            }
        }

        public void UpdatePasswordHash(int userId, string newHash)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "UPDATE Users SET PasswordHash = @Hash WHERE UserId = @Id", conn);
                cmd.Parameters.AddWithValue("@Hash", newHash);
                cmd.Parameters.AddWithValue("@Id",   userId);
                cmd.ExecuteNonQuery();
            }
        }

        public void InsertEmailToken(int userId, string token, string purpose, DateTime expiresAt)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO EmailTokens (UserId, Token, Purpose, ExpiresAt)
                    VALUES (@UserId, @Token, @Purpose, @ExpiresAt)", conn);
                cmd.Parameters.AddWithValue("@UserId",    userId);
                cmd.Parameters.AddWithValue("@Token",     token);
                cmd.Parameters.AddWithValue("@Purpose",   purpose);
                cmd.Parameters.AddWithValue("@ExpiresAt", expiresAt);
                cmd.ExecuteNonQuery();
            }
        }

        public DataRow GetValidEmailToken(string token, string purpose)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TokenId, UserId, ExpiresAt, UsedAt
                    FROM   EmailTokens
                    WHERE  Token = @Token AND Purpose = @Purpose", conn);
                cmd.Parameters.AddWithValue("@Token",   token);
                cmd.Parameters.AddWithValue("@Purpose", purpose);
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                if (dt.Rows.Count == 0) return null;
                var row = dt.Rows[0];
                if (row["UsedAt"] != DBNull.Value)              return null;
                if ((DateTime)row["ExpiresAt"] < DateTime.UtcNow) return null;
                return row;
            }
        }

        public void MarkTokenUsed(int tokenId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "UPDATE EmailTokens SET UsedAt = GETUTCDATE() WHERE TokenId = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", tokenId);
                cmd.ExecuteNonQuery();
            }
        }

        public void LogLoginAttempt(int? userId, bool success, string ipAddress)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO LoginHistory (UserId, Success, IPAddress)
                    VALUES (@UserId, @Success, @IP)", conn);
                cmd.Parameters.AddWithValue("@UserId",  (object)userId ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Success", success);
                cmd.Parameters.AddWithValue("@IP",      ipAddress ?? string.Empty);
                cmd.ExecuteNonQuery();
            }
        }

        public int GetRecentFailCount(string email, int withinMinutes = 15)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT COUNT(1)
                    FROM   LoginHistory lh
                    JOIN   Users u ON u.UserId = lh.UserId
                    WHERE  u.Email   = @Email
                      AND  lh.Success = 0
                      AND  lh.Timestamp >= DATEADD(MINUTE, -@Min, GETUTCDATE())", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Min",   withinMinutes);
                return (int)cmd.ExecuteScalar();
            }
        }

        private static UserDto Map(SqlDataReader r)
        {
            return new UserDto
            {
                UserId           = (int)r["UserId"],
                FullName         = r["FullName"].ToString(),
                Email            = r["Email"].ToString(),
                PasswordHash     = r["PasswordHash"].ToString(),
                RoleName         = r["RoleName"].ToString(),
                IsActive         = (bool)r["IsActive"],
                IsEmailConfirmed = (bool)r["IsEmailConfirmed"]
            };
        }
    }
}
