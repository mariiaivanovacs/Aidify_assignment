using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Courses
{
    public partial class Catalogue : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindCourses();
        }

        private void BindCourses(string search = null, string difficulty = null)
        {
            var courses = new List<CourseRow>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT ModuleId, Title, DifficultyLevel, Description, CoverImagePath
                    FROM   Modules
                    WHERE  Status = 'Published' AND IsDeleted = 0
                      AND  (@Search IS NULL OR Title LIKE @Search OR Description LIKE @Search)
                      AND  (@Diff   IS NULL OR DifficultyLevel = @Diff)
                    ORDER BY Title", conn);
                cmd.Parameters.AddWithValue("@Search",
                    string.IsNullOrEmpty(search) ? (object)DBNull.Value : "%" + search + "%");
                cmd.Parameters.AddWithValue("@Diff",
                    string.IsNullOrEmpty(difficulty) ? (object)DBNull.Value : difficulty);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        courses.Add(new CourseRow {
                            ModuleId      = (int)r["ModuleId"],
                            ModuleTitle   = r["Title"].ToString(),
                            Difficulty    = r["DifficultyLevel"] == DBNull.Value ? "Beginner" : r["DifficultyLevel"].ToString(),
                            Description   = r["Description"] == DBNull.Value ? "" : r["Description"].ToString(),
                            CoverImageUrl = r["CoverImagePath"] == DBNull.Value ? "" : ResolveUrl(r["CoverImagePath"].ToString())
                        });
            }
            rptModules.DataSource  = courses;
            rptModules.DataBind();
            lblNoCourses.Visible   = courses.Count == 0;
        }

        protected void btnCatalogueSearch_Click(object sender, EventArgs e)
        {
            BindCourses(txtCatalogueSearch.Text.Trim(), ddlDifficultyFilter.SelectedValue);
        }

        protected void rptModules_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Enrol") return;

            int userId   = AuthHelper.GetUserId();
            int moduleId = Convert.ToInt32(e.CommandArgument);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    // INSERT only if not already enrolled
                    var chk = new SqlCommand(
                        "SELECT COUNT(*) FROM Enrollments WHERE UserId=@U AND ModuleId=@M",
                        conn, tx);
                    chk.Parameters.AddWithValue("@U", userId);
                    chk.Parameters.AddWithValue("@M", moduleId);
                    if ((int)chk.ExecuteScalar() == 0)
                    {
                        var ins = new SqlCommand(
                            "INSERT INTO Enrollments (UserId, ModuleId) VALUES (@U, @M)",
                            conn, tx);
                        ins.Parameters.AddWithValue("@U", userId);
                        ins.Parameters.AddWithValue("@M", moduleId);
                        ins.ExecuteNonQuery();

                        // Initialise League row on first enrolment
                        var lchk = new SqlCommand(
                            "SELECT COUNT(*) FROM League WHERE UserId=@U", conn, tx);
                        lchk.Parameters.AddWithValue("@U", userId);
                        if ((int)lchk.ExecuteScalar() == 0)
                        {
                            var lins = new SqlCommand(
                                "INSERT INTO League (UserId, Tier, Points) VALUES (@U,'Bronze',0)",
                                conn, tx);
                            lins.Parameters.AddWithValue("@U", userId);
                            lins.ExecuteNonQuery();
                        }
                    }
                    tx.Commit();
                }
            }
            Response.Redirect("~/Learner/Courses/Details.aspx?moduleId=" + moduleId, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        public string GetDifficultyBadge(string difficulty)
        {
            switch (difficulty)
            {
                case "Beginner":     return "bg-success";
                case "Intermediate": return "bg-warning text-dark";
                case "Advanced":     return "bg-danger";
                default:             return "bg-secondary";
            }
        }

        private class CourseRow
        {
            public int    ModuleId;
            public string ModuleTitle, Difficulty, Description, CoverImageUrl;
        }
    }
}
