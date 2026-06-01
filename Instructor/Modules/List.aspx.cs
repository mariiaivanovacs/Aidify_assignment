using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Modules
{
    public partial class List : InstructorBasePage
    {

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();
                LoadModuleStats();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlDifficulty.SelectedValue = "All";
            ddlStatus.SelectedValue = "All";

            LoadModules();
            LoadModuleStats();

            ShowMessage("Module list refreshed.", true);
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            LoadModules();
            LoadModuleStats();
        }

        protected void rptModules_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int moduleId))
            {
                ShowMessage("Invalid module selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "EditModule")
                {
                    Response.Redirect("Edit.aspx?id=" + moduleId);
                }
                else if (e.CommandName == "AddLesson")
                {
                    Response.Redirect("../Lessons/Edit.aspx?moduleId=" + moduleId);
                }
                else if (e.CommandName == "SubmitReview")
                {
                    SubmitModuleForReview(moduleId);
                    AuditService.Log(InstructorUserId, "SubmitModuleForReview", "Modules", moduleId);
                    LoadModules();
                    LoadModuleStats();
                    ShowMessage("Module submitted for review.", true);
                }
                else if (e.CommandName == "DeleteModule")
                {
                    SoftDeleteModule(moduleId);
                    AuditService.Log(InstructorUserId, "DeleteModule", "Modules", moduleId);
                    LoadModules();
                    LoadModuleStats();
                    ShowMessage("Module deleted successfully.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing module: " + ex.Message, false);
            }
        }

        private void LoadModules()
        {
            string search = txtSearch.Text.Trim();
            string difficulty = ddlDifficulty.SelectedValue;
            string status = ddlStatus.SelectedValue;

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        m.ModuleId,
                        m.Title,
                        m.Description,
                        ISNULL(m.DifficultyLevel, 'Intermediate') AS DifficultyLevel,
                        m.CoverImagePath,
                        ISNULL(m.Status, 'Draft') AS Status,
                        m.IsPreview,
                        m.CreatedAt,
                        (
                            SELECT COUNT(*)
                            FROM dbo.Lessons l
                            WHERE l.ModuleId = m.ModuleId
                        ) AS LessonCount
                    FROM dbo.Modules m
                    WHERE
                        m.IsDeleted = 0
                        AND m.CreatedBy = @CreatedBy
                        AND (@Search = '' OR m.Title LIKE '%' + @Search + '%')
                        AND (@Difficulty = 'All' OR m.DifficultyLevel = @Difficulty)
                        AND (@Status = 'All' OR m.Status = @Status)
                    ORDER BY m.CreatedAt DESC, m.ModuleId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@Search", search);
                    cmd.Parameters.AddWithValue("@Difficulty", difficulty);
                    cmd.Parameters.AddWithValue("@Status", status);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptModules.DataSource = table;
                        rptModules.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblModuleCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void LoadModuleStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalModules,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'Draft' THEN 1 ELSE 0 END) AS DraftModules,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'PendingReview' THEN 1 ELSE 0 END) AS PendingModules,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'Published' THEN 1 ELSE 0 END) AS PublishedModules
                    FROM dbo.Modules
                    WHERE IsDeleted = 0 AND CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalModules.Text = Convert.ToString(reader["TotalModules"]);
                            lblDraftModules.Text = Convert.ToString(reader["DraftModules"] == DBNull.Value ? 0 : reader["DraftModules"]);
                            lblPendingModules.Text = Convert.ToString(reader["PendingModules"] == DBNull.Value ? 0 : reader["PendingModules"]);
                            lblPublishedModules.Text = Convert.ToString(reader["PublishedModules"] == DBNull.Value ? 0 : reader["PublishedModules"]);
                        }
                    }
                }
            }
        }

        private void SubmitModuleForReview(int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE dbo.Modules
                    SET Status = 'PendingReview'
                    WHERE ModuleId = @ModuleId AND CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void SoftDeleteModule(int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE dbo.Modules
                    SET IsDeleted = 1
                    WHERE ModuleId = @ModuleId AND CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblModuleStatus.Visible = true;
            lblModuleStatus.Text = message;
            lblModuleStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        protected string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "-";
            }

            DateTime date = Convert.ToDateTime(value);
            return date.ToString("yyyy-MM-dd");
        }

        protected string ShortDescription(object value)
        {
            string text = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(text))
            {
                return "No description provided.";
            }

            if (text.Length <= 70)
            {
                return text;
            }

            return text.Substring(0, 70) + "...";
        }

        protected string GetCoverImage(object value)
        {
            string cover = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(cover))
            {
                return "https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=120&q=80";
            }

            return cover;
        }

        protected string GetDifficultyCss(object value)
        {
            string difficulty = Convert.ToString(value);

            if (difficulty == "Beginner")
            {
                return "badge-easy";
            }

            if (difficulty == "Advanced")
            {
                return "badge-hard";
            }

            return "badge-medium";
        }

        protected string GetStatusCss(object value)
        {
            string status = Convert.ToString(value);

            if (status == "Published")
            {
                return "badge-published";
            }

            if (status == "PendingReview")
            {
                return "badge-pending";
            }

            return "badge-draft";
        }

        protected string FormatStatus(object value)
        {
            string status = Convert.ToString(value);

            if (status == "PendingReview")
            {
                return "Pending Review";
            }

            return status;
        }
    }
}
