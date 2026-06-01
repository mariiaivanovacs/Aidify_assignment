using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class Edit : InstructorBasePage
    {

        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();

                string id = Request.QueryString["id"];

                if (!string.IsNullOrWhiteSpace(id) && int.TryParse(id, out int quizId))
                {
                    LoadQuiz(quizId);
                }
            }
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            int quizId = SaveQuiz();

            if (quizId > 0)
            {
                ShowMessage("Quiz saved successfully.", true);
                LoadQuiz(quizId);
            }
        }

        protected void btnSaveAndAddQuestions_Click(object sender, EventArgs e)
        {
            int quizId = SaveQuiz();

            if (quizId > 0)
            {
                Response.Redirect("Questions.aspx?quizId=" + quizId);
            }
        }

        private void LoadModules()
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

                        ddlModule.Items.Clear();
                        ddlModule.Items.Add(new ListItem("Select Module", ""));

                        foreach (DataRow row in table.Rows)
                        {
                            ddlModule.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["ModuleId"])
                            ));
                        }
                    }
                }
            }
        }

        private int SaveQuiz()
        {
            ClearMessage();

            if (string.IsNullOrWhiteSpace(ddlModule.SelectedValue))
            {
                ShowMessage("Please select a module.", false);
                return 0;
            }

            string title = txtQuizTitle.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the quiz title.", false);
                return 0;
            }

            if (!int.TryParse(txtTimeLimitMinutes.Text.Trim(), out int minutes) || minutes <= 0)
            {
                ShowMessage("Please enter a valid time limit.", false);
                return 0;
            }

            if (!int.TryParse(txtPassingPct.Text.Trim(), out int passingPct) || passingPct < 1 || passingPct > 100)
            {
                ShowMessage("Please enter a passing score between 1 and 100.", false);
                return 0;
            }

            int moduleId = Convert.ToInt32(ddlModule.SelectedValue);

            if (!InstructorOwnsModule(moduleId))
            {
                ShowMessage("Invalid module selected.", false);
                return 0;
            }

            int timeLimitSec = minutes * 60;
            bool isPreview = chkIsPreview.Checked;

            try
            {
                if (string.IsNullOrWhiteSpace(hfQuizId.Value))
                {
                    int newId = InsertQuiz(moduleId, title, description, timeLimitSec, passingPct, isPreview);
                    hfQuizId.Value = newId.ToString();
                    AuditService.Log(InstructorUserId, "CreateQuiz", "Quizzes", newId);
                    return newId;
                }
                else
                {
                    int quizId = Convert.ToInt32(hfQuizId.Value);
                    UpdateQuiz(quizId, moduleId, title, description, timeLimitSec, passingPct, isPreview);
                    AuditService.Log(InstructorUserId, "UpdateQuiz", "Quizzes", quizId);
                    return quizId;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving quiz: " + ex.Message, false);
                return 0;
            }
        }

        private int InsertQuiz(int moduleId, string title, string description, int timeLimitSec, int passingPct, bool isPreview)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Quizzes
                        (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
                    VALUES
                        (@ModuleId, @Title, @Description, @TimeLimitSec, @PassingPct, @IsPreview);

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);
                    cmd.Parameters.AddWithValue("@TimeLimitSec", timeLimitSec);
                    cmd.Parameters.AddWithValue("@PassingPct", passingPct);
                    cmd.Parameters.AddWithValue("@IsPreview", isPreview);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void UpdateQuiz(int quizId, int moduleId, string title, string description, int timeLimitSec, int passingPct, bool isPreview)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE q
                    SET
                        q.ModuleId = @ModuleId,
                        q.Title = @Title,
                        q.Description = @Description,
                        q.TimeLimitSec = @TimeLimitSec,
                        q.PassingPct = @PassingPct,
                        q.IsPreview = @IsPreview
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);
                    cmd.Parameters.AddWithValue("@TimeLimitSec", timeLimitSec);
                    cmd.Parameters.AddWithValue("@PassingPct", passingPct);
                    cmd.Parameters.AddWithValue("@IsPreview", isPreview);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadQuiz(int quizId)
        {
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
                        q.IsPreview
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId AND m.CreatedBy = @CreatedBy AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count == 0)
                        {
                            ShowMessage("Quiz not found.", false);
                            return;
                        }

                        DataRow row = table.Rows[0];

                        hfQuizId.Value = Convert.ToString(row["QuizId"]);
                        ddlModule.SelectedValue = Convert.ToString(row["ModuleId"]);
                        txtQuizTitle.Text = Convert.ToString(row["Title"]);
                        txtDescription.Text = Convert.ToString(row["Description"]);
                        txtTimeLimitMinutes.Text = (Convert.ToInt32(row["TimeLimitSec"]) / 60).ToString();
                        txtPassingPct.Text = Convert.ToString(row["PassingPct"]);
                        chkIsPreview.Checked = Convert.ToBoolean(row["IsPreview"]);

                        lblPageTitle.Text = "Edit Quiz";
                        btnSaveQuiz.Text = "Update Quiz";
                    }
                }
            }
        }

        private bool InstructorOwnsModule(int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.Modules
                    WHERE ModuleId = @ModuleId
                      AND CreatedBy = @CreatedBy
                      AND IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
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

        private void ClearMessage()
        {
            lblQuizStatus.Visible = false;
            lblQuizStatus.Text = "";
            lblQuizStatus.CssClass = "";
        }
    }
}
