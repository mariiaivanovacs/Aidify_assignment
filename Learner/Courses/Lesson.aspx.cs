using System;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Courses
{
    public partial class Lesson : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadLesson();
        }

        private void LoadLesson()
        {
            int lessonId, userId = AuthHelper.GetUserId();
            if (!int.TryParse(Request.QueryString["lessonId"], out lessonId)) return;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Lesson + module info
                var lc = new SqlCommand(@"
                    SELECT l.LessonId, l.Title, l.BodyHtml, l.ModuleId, m.Title AS ModuleTitle
                    FROM   Lessons l
                    JOIN   Modules m ON m.ModuleId = l.ModuleId
                    WHERE  l.LessonId = @Id", conn);
                lc.Parameters.AddWithValue("@Id", lessonId);
                int moduleId = 0;
                using (var r = lc.ExecuteReader())
                {
                    if (!r.Read()) return;
                    moduleId = (int)r["ModuleId"];
                    lblLessonTitle.Text      = r["Title"].ToString();
                    lblModuleBreadcrumb.Text = r["ModuleTitle"].ToString();
                    litLessonBody.Text       = r["BodyHtml"] != DBNull.Value
                        ? r["BodyHtml"].ToString() : "<p>No content yet.</p>";
                    hfModuleId.Value = moduleId.ToString();
                    hfLessonId.Value = lessonId.ToString();
                }

                // Check if already completed
                var ec = new SqlCommand(@"
                    SELECT TOP 1 p.ProgressId
                    FROM   Progress p
                    JOIN   Enrollments e ON e.EnrolId = p.EnrolId
                    WHERE  e.UserId = @U AND p.LessonId = @L", conn);
                ec.Parameters.AddWithValue("@U", userId);
                ec.Parameters.AddWithValue("@L", lessonId);
                bool completed = ec.ExecuteScalar() != null;

                lblAlreadyComplete.Visible = completed;
                pnlMarkComplete.Visible    = !completed;
                pnlAfterComplete.Visible   = completed;

                // Next lesson link
                var nc = new SqlCommand(@"
                    SELECT TOP 1 LessonId FROM Lessons
                    WHERE  ModuleId = @M AND SequenceOrder >
                           (SELECT SequenceOrder FROM Lessons WHERE LessonId = @L)
                    ORDER BY SequenceOrder", conn);
                nc.Parameters.AddWithValue("@M", moduleId);
                nc.Parameters.AddWithValue("@L", lessonId);
                var nextId = nc.ExecuteScalar();
                lnkNextLesson.NavigateUrl = nextId != null
                    ? "~/Learner/Courses/Lesson.aspx?lessonId=" + nextId
                    : "~/Learner/Courses/Details.aspx?moduleId=" + moduleId;

                // Quiz link for this module
                var qc = new SqlCommand(
                    "SELECT TOP 1 QuizId FROM Quizzes WHERE ModuleId = @M", conn);
                qc.Parameters.AddWithValue("@M", moduleId);
                var quizId = qc.ExecuteScalar();
                lnkStartQuiz.NavigateUrl = quizId != null
                    ? "~/Learner/Quiz/Take.aspx?quizId=" + quizId
                    : "~/Learner/Courses/Details.aspx?moduleId=" + moduleId;
            }
        }

        protected void btnMarkComplete_Click(object sender, EventArgs e)
        {
            int userId   = AuthHelper.GetUserId();
            int lessonId = int.Parse(hfLessonId.Value);
            int moduleId = int.Parse(hfModuleId.Value);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    // Find enrolment
                    var ec = new SqlCommand(
                        "SELECT EnrolId FROM Enrollments WHERE UserId=@U AND ModuleId=@M",
                        conn, tx);
                    ec.Parameters.AddWithValue("@U", userId);
                    ec.Parameters.AddWithValue("@M", moduleId);
                    var enrolResult = ec.ExecuteScalar();
                    if (enrolResult == null) { tx.Rollback(); return; }
                    int enrolId = (int)enrolResult;

                    // Insert progress row if not already there
                    var exists = new SqlCommand(
                        "SELECT COUNT(*) FROM Progress WHERE EnrolId=@E AND LessonId=@L",
                        conn, tx);
                    exists.Parameters.AddWithValue("@E", enrolId);
                    exists.Parameters.AddWithValue("@L", lessonId);
                    if ((int)exists.ExecuteScalar() == 0)
                    {
                        var ins = new SqlCommand(
                            "INSERT INTO Progress (EnrolId, LessonId) VALUES (@E, @L)",
                            conn, tx);
                        ins.Parameters.AddWithValue("@E", enrolId);
                        ins.Parameters.AddWithValue("@L", lessonId);
                        ins.ExecuteNonQuery();

                        // Add 5 league points
                        AddLeaguePoints(userId, 5, conn, tx);
                    }
                    tx.Commit();
                }
            }

            pnlMarkComplete.Visible    = false;
            lblAlreadyComplete.Visible = true;
            pnlAfterComplete.Visible   = true;
        }

        private static void AddLeaguePoints(int userId, int pts, SqlConnection conn, SqlTransaction tx)
        {
            var upd = new SqlCommand(@"
                IF EXISTS (SELECT 1 FROM League WHERE UserId=@U)
                    UPDATE League SET Points = Points + @Pts,
                        Tier = CASE WHEN Points + @Pts >= 500 THEN 'Platinum'
                                    WHEN Points + @Pts >= 300 THEN 'Gold'
                                    WHEN Points + @Pts >= 100 THEN 'Silver'
                                    ELSE 'Bronze' END,
                        UpdatedAt = GETUTCDATE()
                    WHERE UserId = @U
                ELSE
                    INSERT INTO League (UserId, Tier, Points) VALUES (@U, 'Bronze', @Pts)",
                conn, tx);
            upd.Parameters.AddWithValue("@U",   userId);
            upd.Parameters.AddWithValue("@Pts", pts);
            upd.ExecuteNonQuery();
        }
    }
}
