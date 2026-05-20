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
                            ProgressPct = (int)(decimal)r["ProgressPct"]
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

        // Reads Tier and Points from League; shows defaults if learner has no row yet.
        private void BindLeague(int userId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT Tier, Points FROM League WHERE UserId = @UserId", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        lblLeagueTier.Text   = r["Tier"].ToString();
                        lblLeaguePoints.Text = r["Points"].ToString();
                    }
                    else
                    {
                        lblLeagueTier.Text   = "Bronze";
                        lblLeaguePoints.Text = "0";
                    }
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
