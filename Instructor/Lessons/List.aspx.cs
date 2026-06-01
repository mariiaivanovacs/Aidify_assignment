using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Lessons
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
                LoadModuleFilter();
                LoadLessons();
                LoadLessonStats();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlModuleFilter.SelectedValue = "All";

            LoadLessons();
            LoadLessonStats();

            ShowMessage("Lesson list refreshed.", true);
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            LoadLessons();
            LoadLessonStats();
        }

        protected void rptLessons_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int lessonId))
            {
                ShowMessage("Invalid lesson selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "EditLesson")
                {
                    Response.Redirect("Edit.aspx?id=" + lessonId);
                }
                else if (e.CommandName == "DeleteLesson")
                {
                    DeleteLesson(lessonId);
                    AuditService.Log(InstructorUserId, "DeleteLesson", "Lessons", lessonId);
                    LoadLessons();
                    LoadLessonStats();
                    ShowMessage("Lesson deleted successfully.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing lesson: " + ex.Message, false);
            }
        }

        private void LoadModuleFilter()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT ModuleId, Title
                    FROM dbo.Modules
                    WHERE CreatedBy = @CreatedBy AND IsDeleted = 0
                    ORDER BY Title;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        ddlModuleFilter.Items.Clear();
                        ddlModuleFilter.Items.Add(new ListItem("All Modules", "All"));

                        foreach (DataRow row in table.Rows)
                        {
                            ddlModuleFilter.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["ModuleId"])
                            ));
                        }
                    }
                }
            }
        }

        private void LoadLessons()
        {
            string search = txtSearch.Text.Trim();
            string moduleFilter = ddlModuleFilter.SelectedValue;

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        l.LessonId,
                        l.ModuleId,
                        l.Title,
                        l.BodyHtml,
                        l.SequenceOrder,
                        ISNULL(l.EstimatedMinutes, 0) AS EstimatedMinutes,
                        m.Title AS ModuleTitle
                    FROM dbo.Lessons l
                    INNER JOIN dbo.Modules m ON l.ModuleId = m.ModuleId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@Search = '' OR l.Title LIKE '%' + @Search + '%')
                        AND (@ModuleId = 0 OR l.ModuleId = @ModuleId)
                    ORDER BY m.Title, l.SequenceOrder, l.LessonId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    int moduleId = moduleFilter == "All" ? 0 : Convert.ToInt32(moduleFilter);

                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@Search", search);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptLessons.DataSource = table;
                        rptLessons.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblLessonCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void LoadLessonStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(l.LessonId) AS TotalLessons,
                        SUM(ISNULL(l.EstimatedMinutes, 0)) AS TotalMinutes,
                        COUNT(DISTINCT l.ModuleId) AS ModulesWithLessons
                    FROM dbo.Lessons l
                    INNER JOIN dbo.Modules m ON l.ModuleId = m.ModuleId
                    WHERE m.CreatedBy = @CreatedBy AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalLessons.Text = Convert.ToString(reader["TotalLessons"] == DBNull.Value ? 0 : reader["TotalLessons"]);
                            lblTotalMinutes.Text = Convert.ToString(reader["TotalMinutes"] == DBNull.Value ? 0 : reader["TotalMinutes"]);
                            lblModulesWithLessons.Text = Convert.ToString(reader["ModulesWithLessons"] == DBNull.Value ? 0 : reader["ModulesWithLessons"]);
                        }
                    }
                }
            }
        }

        private void DeleteLesson(int lessonId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE l
                    FROM dbo.Lessons l
                    INNER JOIN dbo.Modules m ON l.ModuleId = m.ModuleId
                    WHERE l.LessonId = @LessonId
                      AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@LessonId", lessonId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblLessonStatus.Visible = true;
            lblLessonStatus.Text = message;
            lblLessonStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        protected string ShortText(object value)
        {
            string text = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(text))
            {
                return "No content.";
            }

            text = Regex.Replace(text, "<.*?>", "");
            text = text.Replace("&nbsp;", " ").Trim();

            if (text.Length <= 80)
            {
                return text;
            }

            return text.Substring(0, 80) + "...";
        }
    }
}
