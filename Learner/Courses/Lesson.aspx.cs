using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
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
                bool insertedProgress = false;
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

                        LeagueService.AddPoints(userId, 5, conn, tx);
                        insertedProgress = true;
                    }
                    tx.Commit();
                }

                if (insertedProgress)
                {
                    try { new BadgeService().Evaluate(userId); } catch { /* badge failure must never block lesson completion */ }
                    try { new CertificateService().EnsureForCompletedModule(userId, moduleId); } catch { /* certificate failure must never block lesson completion */ }
                }
            }

            pnlMarkComplete.Visible    = false;
            lblAlreadyComplete.Visible = true;
            pnlAfterComplete.Visible   = true;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static PopQuizQuestion GetPopQuizQuestion(int moduleId)
        {
            if (!AuthHelper.IsRole(Constants.RoleLearner) || moduleId <= 0)
                return null;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                if (!LearnerCanAccessModule(AuthHelper.GetUserId(), moduleId, conn))
                    return null;

                var cmd = new SqlCommand(@"
                    SELECT TOP 1 q.QuestionId, q.QuestionText, q.QuizId
                    FROM Questions q
                    JOIN Quizzes quiz ON quiz.QuizId = q.QuizId
                    WHERE quiz.ModuleId = @ModuleId
                    ORDER BY NEWID()", conn);
                cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                int questionId = 0, quizId = 0;
                string questionText = "";
                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return null;
                    questionId = Convert.ToInt32(r["QuestionId"]);
                    quizId = Convert.ToInt32(r["QuizId"]);
                    questionText = r["QuestionText"].ToString();
                }

                var options = new List<PopQuizOption>();
                var optionCmd = new SqlCommand(@"
                    SELECT OptionId, OptionText
                    FROM Options
                    WHERE QuestionId=@QuestionId
                    ORDER BY OptionId", conn);
                optionCmd.Parameters.AddWithValue("@QuestionId", questionId);

                using (var r = optionCmd.ExecuteReader())
                    while (r.Read())
                        options.Add(new PopQuizOption
                        {
                            OptionId = Convert.ToInt32(r["OptionId"]),
                            OptionText = r["OptionText"].ToString()
                        });

                return new PopQuizQuestion
                {
                    QuestionId = questionId,
                    QuizId = quizId,
                    QuestionText = questionText,
                    Options = options
                };
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static PopQuizResult SubmitPopQuizAnswer(int questionId, int selectedOptionId)
        {
            if (!AuthHelper.IsRole(Constants.RoleLearner) || questionId <= 0 || selectedOptionId <= 0)
                return new PopQuizResult { IsCorrect = false, Message = "Unable to submit this answer." };

            int userId = AuthHelper.GetUserId();
            int quizId = 0, moduleId = 0;
            bool isCorrect = false;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var check = new SqlCommand(@"
                    SELECT q.QuizId, quiz.ModuleId,
                           CASE WHEN o.IsCorrect = 1 THEN 1 ELSE 0 END AS IsCorrect
                    FROM Questions q
                    JOIN Quizzes quiz ON quiz.QuizId = q.QuizId
                    JOIN Options o ON o.QuestionId = q.QuestionId
                    WHERE q.QuestionId = @QuestionId
                      AND o.OptionId = @SelectedOptionId", conn);
                check.Parameters.AddWithValue("@QuestionId", questionId);
                check.Parameters.AddWithValue("@SelectedOptionId", selectedOptionId);

                using (var r = check.ExecuteReader())
                {
                    if (!r.Read())
                        return new PopQuizResult { IsCorrect = false, Message = "Invalid answer selected." };

                    quizId = Convert.ToInt32(r["QuizId"]);
                    moduleId = Convert.ToInt32(r["ModuleId"]);
                    isCorrect = Convert.ToInt32(r["IsCorrect"]) == 1;
                }

                if (!LearnerCanAccessModule(userId, moduleId, conn))
                    return new PopQuizResult { IsCorrect = false, Message = "Unable to submit this answer." };

                using (var tx = conn.BeginTransaction())
                {
                    var attempt = new SqlCommand(@"
                        INSERT INTO QuizAttempts (UserId, QuizId, Score, Passed, IsPopQuiz)
                        OUTPUT INSERTED.AttemptId
                        VALUES (@UserId, @QuizId, @Score, @Passed, 1)", conn, tx);
                    attempt.Parameters.AddWithValue("@UserId", userId);
                    attempt.Parameters.AddWithValue("@QuizId", quizId);
                    attempt.Parameters.AddWithValue("@Score", isCorrect ? 100m : 0m);
                    attempt.Parameters.AddWithValue("@Passed", isCorrect);
                    int attemptId = Convert.ToInt32(attempt.ExecuteScalar());

                    var answer = new SqlCommand(@"
                        INSERT INTO AttemptAnswers (AttemptId, QuestionId, SelectedOptionId, IsCorrect)
                        VALUES (@AttemptId, @QuestionId, @SelectedOptionId, @IsCorrect)", conn, tx);
                    answer.Parameters.AddWithValue("@AttemptId", attemptId);
                    answer.Parameters.AddWithValue("@QuestionId", questionId);
                    answer.Parameters.AddWithValue("@SelectedOptionId", selectedOptionId);
                    answer.Parameters.AddWithValue("@IsCorrect", isCorrect);
                    answer.ExecuteNonQuery();

                    if (isCorrect)
                        LeagueService.AddPoints(userId, 2, conn, tx);

                    tx.Commit();
                }
            }

            if (isCorrect)
                return new PopQuizResult { IsCorrect = true, Message = "Correct. You earned 2 league points." };

            return new PopQuizResult { IsCorrect = false, Message = "Not quite. Keep going." };
        }

        private static bool LearnerCanAccessModule(int userId, int moduleId, SqlConnection conn)
        {
            var cmd = new SqlCommand(@"
                SELECT COUNT(*)
                FROM Modules m
                WHERE m.ModuleId=@ModuleId
                  AND m.Status='Published'
                  AND m.IsDeleted=0
                  AND EXISTS (
                      SELECT 1
                      FROM Enrollments e
                      WHERE e.UserId=@UserId
                        AND e.ModuleId=m.ModuleId
                  )", conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@ModuleId", moduleId);
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }

        public class PopQuizQuestion
        {
            public int QuestionId { get; set; }
            public int QuizId { get; set; }
            public string QuestionText { get; set; }
            public List<PopQuizOption> Options { get; set; }
        }

        public class PopQuizOption
        {
            public int OptionId { get; set; }
            public string OptionText { get; set; }
        }

        public class PopQuizResult
        {
            public bool IsCorrect { get; set; }
            public string Message { get; set; }
        }
    }
}
