using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Learner
{
    public partial class Dashboard : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = AuthHelper.GetUserId();
                lblWelcome.Text = "Welcome back, " + AuthHelper.GetName();
                BindEnrolledCourses(userId);
                BindLeague(userId);
                BindLatestBadge(userId);
                BindRecommendedModule(userId);
                SetNextLessonLink(userId);
            }
        }

        // Queries Enrollments + Modules + Progress to build the course list.
        private void BindEnrolledCourses(int userId)
        {
            var courses = new List<CourseRow>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT  m.ModuleId,
                            m.Title,
                            COUNT(DISTINCT l.LessonId) AS TotalLessons,
                            COUNT(DISTINCT p.LessonId) AS CompletedLessons,
                            CASE WHEN COUNT(DISTINCT l.LessonId) = 0 THEN 0
                                 ELSE CAST(
                                     COUNT(DISTINCT p.LessonId) * 100.0
                                     / COUNT(DISTINCT l.LessonId) AS INT)
                            END AS ProgressPct
                    FROM    Enrollments e
                    JOIN    Modules  m ON m.ModuleId  = e.ModuleId
                    LEFT JOIN Lessons l ON l.ModuleId  = m.ModuleId
                    LEFT JOIN Progress p
                           ON p.EnrolId  = e.EnrolId
                          AND p.LessonId = l.LessonId
                    WHERE   e.UserId   = @UserId
                      AND   m.IsDeleted = 0
                    GROUP BY m.ModuleId, m.Title
                    ORDER BY m.Title", conn);

                cmd.Parameters.AddWithValue("@UserId", userId);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        courses.Add(new CourseRow
                        {
                            ModuleId    = (int)r["ModuleId"],
                            ModuleTitle = r["Title"].ToString(),
                            ProgressPct = Convert.ToInt32(r["ProgressPct"])
                        });
            }

            if (courses.Count == 0)
                courses.Add(new CourseRow
                {
                    ModuleId    = 0,
                    ModuleTitle = "No courses yet — browse the catalogue!",
                    ProgressPct = 0
                });

            rptEnrolledCourses.DataSource = courses;
            rptEnrolledCourses.DataBind();
        }

        private void BindLeague(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    WITH RankedLeague AS (
                        SELECT UserId, Tier, Points,
                               ROW_NUMBER() OVER (ORDER BY Points DESC, UpdatedAt ASC, UserId ASC) AS RankNo
                        FROM League
                    )
                    SELECT Tier, Points, RankNo
                    FROM RankedLeague
                    WHERE UserId = @UserId", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        lblLeagueTier.Text   = r["Tier"].ToString();
                        lblLeaguePoints.Text = r["Points"].ToString();
                        lblLeagueRank.Text = "#" + r["RankNo"];
                    }
                    else
                    {
                        lblLeagueTier.Text   = "Bronze";
                        lblLeaguePoints.Text = "0";
                        lblLeagueRank.Text = "Not ranked yet";
                    }
                }
            }
        }

        private void BindLatestBadge(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 1 b.Name, b.IconPath, ub.AwardedAt
                    FROM UserBadges ub
                    JOIN Badges b ON b.BadgeId = ub.BadgeId
                    WHERE ub.UserId = @UserId
                    ORDER BY ub.AwardedAt DESC, ub.UserBadgeId DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read())
                    {
                        imgLatestBadge.Visible = false;
                        lblLatestBadgeName.Text = "No badges yet";
                        return;
                    }

                    string iconPath = r["IconPath"] == DBNull.Value ? "" : r["IconPath"].ToString();
                    imgLatestBadge.Visible = !string.IsNullOrWhiteSpace(iconPath);
                    if (imgLatestBadge.Visible)
                        imgLatestBadge.ImageUrl = iconPath;

                    lblLatestBadgeName.Text = r["Name"].ToString();
                }
            }
        }

        private void BindRecommendedModule(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 1 m.ModuleId, m.Title, m.Description, m.DifficultyLevel,
                           COUNT(l.LessonId) AS LessonCount
                    FROM Modules m
                    LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
                    WHERE m.Status = 'Published'
                      AND m.IsDeleted = 0
                      AND NOT EXISTS (
                          SELECT 1
                          FROM Enrollments e
                          WHERE e.UserId = @UserId
                            AND e.ModuleId = m.ModuleId
                      )
                    GROUP BY m.ModuleId, m.Title, m.Description, m.DifficultyLevel, m.CreatedAt
                    ORDER BY m.CreatedAt DESC, m.ModuleId DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read())
                    {
                        lblRecommendedTitle.Text = "Explore more courses";
                        lblRecommendedMeta.Text = "Catalogue";
                        lblRecommendedDescription.Text = "You are enrolled in all currently published modules.";
                        lnkRecommended.NavigateUrl = "~/Learner/Courses/Catalogue.aspx";
                        lnkRecommended.Text = "Open Catalogue";
                        return;
                    }

                    int moduleId = Convert.ToInt32(r["ModuleId"]);
                    string difficulty = r["DifficultyLevel"] == DBNull.Value ? "Beginner" : r["DifficultyLevel"].ToString();
                    int lessonCount = Convert.ToInt32(r["LessonCount"]);

                    lblRecommendedTitle.Text = r["Title"].ToString();
                    lblRecommendedMeta.Text = difficulty + " · " + lessonCount + " lessons";
                    lblRecommendedDescription.Text = r["Description"] == DBNull.Value
                        ? "Recommended next course based on modules you have not joined yet."
                        : r["Description"].ToString();
                    lnkRecommended.NavigateUrl = "~/Learner/Courses/Details.aspx?moduleId=" + moduleId;
                    lnkRecommended.Text = "View Course";
                }
            }
        }

        // Finds the first incomplete lesson across all enrolments for the "Continue" button.
        private void SetNextLessonLink(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT  TOP 1 l.LessonId
                    FROM    Enrollments e
                    JOIN    Lessons  l ON l.ModuleId  = e.ModuleId
                    LEFT JOIN Progress p
                           ON p.EnrolId  = e.EnrolId
                          AND p.LessonId = l.LessonId
                    WHERE   e.UserId   = @UserId
                      AND   p.LessonId IS NULL
                    ORDER BY l.ModuleId, l.SequenceOrder", conn);

                cmd.Parameters.AddWithValue("@UserId", userId);
                var result = cmd.ExecuteScalar();

                lnkNextLesson.NavigateUrl = result != null && result != DBNull.Value
                    ? "~/Learner/Courses/Lesson.aspx?lessonId=" + result
                    : "~/Learner/Courses/Catalogue.aspx";
            }
        }

        // Typed row used as repeater data source so Eval("PropertyName") works.
        private class CourseRow
        {
            public int    ModuleId    { get; set; }
            public string ModuleTitle { get; set; }
            public int    ProgressPct { get; set; }
        }
    }
}
