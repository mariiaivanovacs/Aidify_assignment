using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Instructor
{
    public partial class Dashboard : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = AuthHelper.GetUserId();
                lblWelcomeInstructor.Text = "Welcome back, " + AuthHelper.GetName() + "! Here is your latest activity.";
                lnkCreateModule.NavigateUrl    = "~/Instructor/Modules/Edit.aspx";
                lnkGenerateWithAI.NavigateUrl  = "~/Instructor/Quizzes/GenerateWithAI.aspx";
                BindModules(userId);
            }
        }

        private void BindModules(int userId)
        {
            var rows = new List<ModuleSummary>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT  m.ModuleId, m.Title, m.Description, m.DifficultyLevel, m.Status,
                            (SELECT COUNT(*) FROM Lessons  l WHERE l.ModuleId = m.ModuleId)           AS LessonCount,
                            (SELECT COUNT(*) FROM Enrollments e WHERE e.ModuleId = m.ModuleId)        AS LearnerCount,
                            m.CreatedAt
                    FROM    Modules m
                    WHERE   m.CreatedBy = @UserId AND m.IsDeleted = 0
                    ORDER BY m.CreatedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new ModuleSummary {
                            ModuleId     = (int)r["ModuleId"],
                            Title        = r["Title"].ToString(),
                            Description  = r["Description"] == DBNull.Value ? "" : r["Description"].ToString(),
                            Level        = r["DifficultyLevel"] == DBNull.Value ? "—" : r["DifficultyLevel"].ToString(),
                            Status       = r["Status"].ToString(),
                            LessonCount  = (int)r["LessonCount"],
                            LearnerCount = (int)r["LearnerCount"],
                            LastUpdated  = ((DateTime)r["CreatedAt"]).ToString("dd MMM yyyy")
                        });
            }
            rptMyModules.DataSource = rows.Count > 0 ? (object)rows : new[] {
                new ModuleSummary { Title = "No modules yet — create your first one!", Status = "Draft", Level = "—", LessonCount = 0, LearnerCount = 0, LastUpdated = "—" }
            };
            rptMyModules.DataBind();
        }

        private class ModuleSummary
        {
            public int    ModuleId, LessonCount, LearnerCount;
            public string Title, Description, Level, Status, LastUpdated;
        }
    }
}
