using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Courses
{
    public partial class Details : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadModule();
        }

        private void LoadModule()
        {
            int moduleId, userId = AuthHelper.GetUserId();
            if (!int.TryParse(Request.QueryString["moduleId"], out moduleId)) return;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Module details
                var mc = new SqlCommand(@"
                    SELECT Title, Description, DifficultyLevel, CoverImagePath
                    FROM   Modules
                    WHERE  ModuleId = @Id AND IsDeleted = 0", conn);
                mc.Parameters.AddWithValue("@Id", moduleId);
                using (var r = mc.ExecuteReader())
                {
                    if (!r.Read()) return;
                    string title = r["Title"].ToString();
                    lblModuleTitle.Text     = title;
                    lblModuleTitleMain.Text = title;
                    lblDifficulty.Text      = r["DifficultyLevel"] == DBNull.Value ? "—" : r["DifficultyLevel"].ToString();
                    lblModuleDescription.Text = r["Description"] == DBNull.Value ? "" : r["Description"].ToString();
                    imgModuleCover.ImageUrl  = r["CoverImagePath"] != DBNull.Value
                        ? ResolveUrl(r["CoverImagePath"].ToString())
                        : "https://placehold.co/600x220?text=" + Uri.EscapeDataString(title);
                }

                // Enrolment + progress
                int enrolId = 0;
                var ec = new SqlCommand(
                    "SELECT EnrolId FROM Enrollments WHERE UserId=@U AND ModuleId=@M", conn);
                ec.Parameters.AddWithValue("@U", userId);
                ec.Parameters.AddWithValue("@M", moduleId);
                var enrolResult = ec.ExecuteScalar();
                bool enrolled = enrolResult != null;
                if (enrolled) enrolId = (int)enrolResult;
                pnlEnrolCTA.Visible = !enrolled;

                if (enrolled)
                {
                    var pc = new SqlCommand(@"
                        SELECT COUNT(DISTINCT l.LessonId)  AS Total,
                               COUNT(DISTINCT p.LessonId)  AS Done
                        FROM   Lessons l
                        LEFT JOIN Progress p ON p.LessonId = l.LessonId AND p.EnrolId = @EnrolId
                        WHERE  l.ModuleId = @ModuleId", conn);
                    pc.Parameters.AddWithValue("@EnrolId",  enrolId);
                    pc.Parameters.AddWithValue("@ModuleId", moduleId);
                    using (var r = pc.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            int total = (int)r["Total"], done = (int)r["Done"];
                            int pct   = total > 0 ? done * 100 / total : 0;
                            lblProgressPct.Text        = pct + "% complete";
                            progressBar.Style["width"] = pct + "%";
                        }
                    }
                }

                // Lessons list
                var lessons = new List<LessonRow>();
                var lc = new SqlCommand(@"
                    SELECT l.LessonId, l.Title, l.EstimatedMinutes,
                           CASE WHEN p.LessonId IS NOT NULL THEN 1 ELSE 0 END AS IsCompleted
                    FROM   Lessons l
                    LEFT JOIN Progress p ON p.LessonId = l.LessonId
                                       AND p.EnrolId   = @EnrolId
                    WHERE  l.ModuleId = @ModuleId
                    ORDER BY l.SequenceOrder", conn);
                lc.Parameters.AddWithValue("@EnrolId",  enrolId);
                lc.Parameters.AddWithValue("@ModuleId", moduleId);
                using (var r = lc.ExecuteReader())
                    while (r.Read())
                        lessons.Add(new LessonRow {
                            LessonId         = (int)r["LessonId"],
                            LessonTitle      = r["Title"].ToString(),
                            EstimatedMinutes = r["EstimatedMinutes"] != DBNull.Value ? (int)r["EstimatedMinutes"] : 0,
                            IsCompleted      = (int)r["IsCompleted"] == 1
                        });

                rptLessons.DataSource = lessons;
                rptLessons.DataBind();
            }
        }

        protected void btnEnrolFromDetails_Click(object sender, EventArgs e)
        {
            int userId = AuthHelper.GetUserId();
            int moduleId;
            if (!int.TryParse(Request.QueryString["moduleId"], out moduleId)) return;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var ins = new SqlCommand(
                        "INSERT INTO Enrollments (UserId, ModuleId) VALUES (@U, @M)", conn, tx);
                    ins.Parameters.AddWithValue("@U", userId);
                    ins.Parameters.AddWithValue("@M", moduleId);
                    ins.ExecuteNonQuery();

                    var lchk = new SqlCommand(
                        "SELECT COUNT(*) FROM League WHERE UserId=@U", conn, tx);
                    lchk.Parameters.AddWithValue("@U", userId);
                    if ((int)lchk.ExecuteScalar() == 0)
                    {
                        var lins = new SqlCommand(
                            "INSERT INTO League (UserId, Tier, Points) VALUES (@U,'Bronze',0)", conn, tx);
                        lins.Parameters.AddWithValue("@U", userId);
                        lins.ExecuteNonQuery();
                    }
                    tx.Commit();
                }
            }
            pnlEnrolCTA.Visible = false;
            Response.Redirect(Request.RawUrl, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private class LessonRow
        {
            public int    LessonId, EstimatedMinutes;
            public string LessonTitle;
            public bool   IsCompleted;
        }
    }
}
