using System;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public class BadgeService
    {
        // Called after every quiz submit and every lesson completion.
        // Checks all badge rules in the Badges table and awards any the user
        // hasn't earned yet but now qualifies for.
        public void Evaluate(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var rules = new System.Collections.Generic.List<BadgeRule>();
                var rulesCmd = new SqlCommand(
                    "SELECT BadgeId, Name, RuleType, RuleThreshold FROM Badges", conn);

                using (var r = rulesCmd.ExecuteReader())
                {
                    while (r.Read())
                        rules.Add(new BadgeRule
                        {
                            BadgeId = (int)r["BadgeId"],
                            Name = r["Name"].ToString(),
                            RuleType = r["RuleType"] == DBNull.Value ? "" : r["RuleType"].ToString(),
                            RuleThreshold = r["RuleThreshold"] == DBNull.Value ? 0 : (int)r["RuleThreshold"]
                        });
                }

                foreach (var rule in rules)
                {
                    if (AlreadyHas(userId, rule.BadgeId, conn)) continue;

                    bool earned = false;
                    switch (rule.RuleType)
                    {
                        case "QuizScore":
                            earned = GetBestScore(userId, conn) >= rule.RuleThreshold;
                            break;
                        case "ModulesCompleted":
                            earned = GetCompletedModulesCount(userId, conn) >= rule.RuleThreshold;
                            break;
                    }

                    if (earned) Award(userId, rule.BadgeId, rule.Name, conn);
                }
            }
        }

        private static bool AlreadyHas(int userId, int badgeId, SqlConnection conn)
        {
            var cmd = new SqlCommand(
                "SELECT COUNT(*) FROM UserBadges WHERE UserId=@U AND BadgeId=@B", conn);
            cmd.Parameters.AddWithValue("@U", userId);
            cmd.Parameters.AddWithValue("@B", badgeId);
            return (int)cmd.ExecuteScalar() > 0;
        }

        // Returns the user's single highest quiz score (0-100).
        private static int GetBestScore(int userId, SqlConnection conn)
        {
            var cmd = new SqlCommand(
                "SELECT ISNULL(MAX(Score),0) FROM QuizAttempts WHERE UserId=@U", conn);
            cmd.Parameters.AddWithValue("@U", userId);
            return (int)(decimal)cmd.ExecuteScalar();
        }

        // Returns the number of modules the user has fully completed (100%).
        private static int GetCompletedModulesCount(int userId, SqlConnection conn)
        {
            var cmd = new SqlCommand(@"
                SELECT COUNT(*) FROM (
                    SELECT e.ModuleId
                    FROM   Enrollments e
                    JOIN   Modules m ON m.ModuleId = e.ModuleId AND m.IsDeleted = 0
                    WHERE  e.UserId = @U
                      AND  (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e.ModuleId) > 0
                      AND  (SELECT COUNT(*) FROM Lessons l WHERE l.ModuleId = e.ModuleId)
                         = (SELECT COUNT(*) FROM Progress p
                            JOIN Lessons l2 ON l2.LessonId = p.LessonId
                            WHERE p.EnrolId = e.EnrolId AND l2.ModuleId = e.ModuleId)
                ) AS completed", conn);
            cmd.Parameters.AddWithValue("@U", userId);
            return (int)cmd.ExecuteScalar();
        }

        private static void Award(int userId, int badgeId, string name, SqlConnection conn)
        {
            var ins = new SqlCommand(
                "INSERT INTO UserBadges (UserId, BadgeId) VALUES (@U, @B)", conn);
            ins.Parameters.AddWithValue("@U", userId);
            ins.Parameters.AddWithValue("@B", badgeId);
            ins.ExecuteNonQuery();

            NotificationService.Push(userId,
                "Badge Earned!",
                "You earned the \"" + name + "\" badge.",
                "~/Learner/Progress.aspx");
        }

        private class BadgeRule
        {
            public int BadgeId { get; set; }
            public string Name { get; set; }
            public string RuleType { get; set; }
            public int RuleThreshold { get; set; }
        }
    }
}
