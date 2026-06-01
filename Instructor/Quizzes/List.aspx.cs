using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class List : Page
    {
        private const int InstructorUserId = 2;

        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModuleFilter();
                LoadQuizzes();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadModuleFilter();

            if (ddlModuleFilter.Items.FindByValue("All") != null)
            {
                ddlModuleFilter.SelectedValue = "All";
            }

            LoadQuizzes();
            ShowMessage("Quiz list refreshed.", true);
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            LoadQuizzes();
        }

        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int quizId))
            {
                ShowMessage("Invalid quiz selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "EditQuiz")
                {
                    Response.Redirect("Edit.aspx?id=" + quizId);
                }
                else if (e.CommandName == "ManageQuestions")
                {
                    Response.Redirect("Questions.aspx?quizId=" + quizId);
                }
                else if (e.CommandName == "DeleteQuiz")
                {
                    DeleteQuiz(quizId);
                    LoadQuizzes();
                    ShowMessage("Quiz deleted successfully.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing quiz: " + ex.Message, false);
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

        private void LoadQuizzes()
        {
            string search = txtSearch.Text.Trim();
            string moduleFilter = ddlModuleFilter.SelectedValue;

            if (string.IsNullOrWhiteSpace(moduleFilter))
            {
                moduleFilter = "All";
            }

            int moduleId = moduleFilter == "All" ? 0 : Convert.ToInt32(moduleFilter);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        q.QuizId,
                        q.ModuleId,
                        q.Title,
                        q.Description,
                        q.TimeLimitSec,
                        q.PassingPct,
                        q.IsPreview,
                        m.Title AS ModuleTitle,
                        (
                            SELECT COUNT(*)
                            FROM dbo.Questions qs
                            WHERE qs.QuizId = q.QuizId
                        ) AS QuestionCount
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@Search = '' OR q.Title LIKE '%' + @Search + '%')
                        AND (@ModuleId = 0 OR q.ModuleId = @ModuleId)
                    ORDER BY q.QuizId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@Search", search);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptQuizzes.DataSource = table;
                        rptQuizzes.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblQuizCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void DeleteQuiz(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE o
                    FROM dbo.Options o
                    INNER JOIN dbo.Questions qs ON o.QuestionId = qs.QuestionId
                    INNER JOIN dbo.Quizzes q ON qs.QuizId = q.QuizId
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId AND m.CreatedBy = @CreatedBy;

                    DELETE qs
                    FROM dbo.Questions qs
                    INNER JOIN dbo.Quizzes q ON qs.QuizId = q.QuizId
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId AND m.CreatedBy = @CreatedBy;

                    DELETE q
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblQuizStatus.Visible = true;
            lblQuizStatus.Text = message;
            lblQuizStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        protected string ShortText(object value)
        {
            string text = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(text))
            {
                return "No description.";
            }

            return text.Length <= 80 ? text : text.Substring(0, 80) + "...";
        }

        protected string FormatTime(object value)
        {
            int seconds = Convert.ToInt32(value);
            int minutes = seconds / 60;
            return minutes + " mins";
        }
    }
}