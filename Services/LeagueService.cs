using System;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public static class LeagueService
    {
        public static string GetTierForPoints(int points)
        {
            if (points >= 500) return "Platinum";
            if (points >= 300) return "Gold";
            if (points >= 100) return "Silver";
            return "Bronze";
        }

        public static void EnsureLeagueRow(int userId, SqlConnection conn, SqlTransaction tx = null)
        {
            var cmd = new SqlCommand(@"
                IF NOT EXISTS (SELECT 1 FROM League WHERE UserId=@UserId)
                    INSERT INTO League (UserId, Tier, Points)
                    VALUES (@UserId, 'Bronze', 0)", conn, tx);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.ExecuteNonQuery();
        }

        public static void AddPoints(int userId, int points, SqlConnection conn, SqlTransaction tx = null)
        {
            if (points == 0)
            {
                EnsureLeagueRow(userId, conn, tx);
                return;
            }

            var cmd = new SqlCommand(@"
                IF EXISTS (SELECT 1 FROM League WHERE UserId=@UserId)
                    UPDATE League
                    SET Points = Points + @Points,
                        Tier = @Tier,
                        UpdatedAt = GETUTCDATE()
                    WHERE UserId=@UserId
                ELSE
                    INSERT INTO League (UserId, Tier, Points)
                    VALUES (@UserId, @TierForNewRow, @Points)", conn, tx);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Points", points);
            cmd.Parameters.AddWithValue("@Tier", GetTierForPoints(GetCurrentPoints(userId, conn, tx) + points));
            cmd.Parameters.AddWithValue("@TierForNewRow", GetTierForPoints(points));
            cmd.ExecuteNonQuery();
        }

        public static void RecalculateUserTier(int userId, SqlConnection conn, SqlTransaction tx = null)
        {
            var points = GetCurrentPoints(userId, conn, tx);
            var cmd = new SqlCommand(@"
                UPDATE League
                SET Tier=@Tier,
                    UpdatedAt=GETUTCDATE()
                WHERE UserId=@UserId", conn, tx);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Tier", GetTierForPoints(points));
            cmd.ExecuteNonQuery();
        }

        public static int RecalculateAllTiers()
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    UPDATE League
                    SET Tier = CASE WHEN Points >= 500 THEN 'Platinum'
                                    WHEN Points >= 300 THEN 'Gold'
                                    WHEN Points >= 100 THEN 'Silver'
                                    ELSE 'Bronze' END,
                        UpdatedAt = GETUTCDATE()", conn);
                return cmd.ExecuteNonQuery();
            }
        }

        private static int GetCurrentPoints(int userId, SqlConnection conn, SqlTransaction tx)
        {
            var cmd = new SqlCommand("SELECT ISNULL(MAX(Points),0) FROM League WHERE UserId=@UserId", conn, tx);
            cmd.Parameters.AddWithValue("@UserId", userId);
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }
}
