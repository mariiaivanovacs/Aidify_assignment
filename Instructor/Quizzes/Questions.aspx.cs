using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class Questions : InstructorBasePage
    {

        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string quizIdText = Request.QueryString["quizId"];

                if (string.IsNullOrWhiteSpace(quizIdText) || !int.TryParse(quizIdText, out int quizId))
                {
                    Response.Redirect("List.aspx");
                    return;
                }

                if (!InstructorOwnsQuiz(quizId))
                {
                    Response.Redirect("List.aspx");
                    return;
                }

                hfQuizId.Value = quizId.ToString();
                LoadQuizTitle(quizId);
                LoadQuestions();
            }
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            ClearMessage();

            if (!int.TryParse(hfQuizId.Value, out int quizId))
            {
                ShowMessage("Invalid quiz.", false);
                return;
            }

            string questionText = txtQuestionText.Text.Trim();
            string questionType = ddlQuestionType.SelectedValue;

            if (string.IsNullOrWhiteSpace(questionText))
            {
                ShowMessage("Please enter the question text.", false);
                return;
            }

            if (!int.TryParse(txtPoints.Text.Trim(), out int points) || points <= 0)
            {
                ShowMessage("Please enter valid points.", false);
                return;
            }

            string option1 = txtOption1.Text.Trim();
            string option2 = txtOption2.Text.Trim();
            string option3 = txtOption3.Text.Trim();
            string option4 = txtOption4.Text.Trim();

            if (questionType == "TrueFalse")
            {
                option1 = "True";
                option2 = "False";
                option3 = "";
                option4 = "";
            }

            if (questionType == "ShortAnswer")
            {
                option2 = "";
                option3 = "";
                option4 = "";
                rbCorrect1.Checked = true;
            }

            if (questionType == "ShortAnswer" && string.IsNullOrWhiteSpace(option1))
            {
                ShowMessage("Please enter the accepted short answer in option 1.", false);
                return;
            }

            if (questionType != "ShortAnswer" && (string.IsNullOrWhiteSpace(option1) || string.IsNullOrWhiteSpace(option2)))
            {
                ShowMessage("Please enter at least option 1 and option 2.", false);
                return;
            }

            try
            {
                int questionId = InsertQuestion(quizId, questionText, questionType, points);

                InsertOption(questionId, option1, rbCorrect1.Checked);

                if (!string.IsNullOrWhiteSpace(option2))
                {
                    InsertOption(questionId, option2, rbCorrect2.Checked);
                }

                if (!string.IsNullOrWhiteSpace(option3))
                {
                    InsertOption(questionId, option3, rbCorrect3.Checked);
                }

                if (!string.IsNullOrWhiteSpace(option4))
                {
                    InsertOption(questionId, option4, rbCorrect4.Checked);
                }

                AuditService.Log(InstructorUserId, "CreateQuestion", "Questions", questionId);
                ClearForm();
                LoadQuestions();
                ShowMessage("Question added successfully.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error while adding question: " + ex.Message, false);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            ShowMessage("Form cleared.", true);
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int questionId))
            {
                ShowMessage("Invalid question selected.", false);
                return;
            }

            try
            {
                DeleteQuestion(questionId);
                AuditService.Log(InstructorUserId, "DeleteQuestion", "Questions", questionId);
                LoadQuestions();
                ShowMessage("Question deleted successfully.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error while deleting question: " + ex.Message, false);
            }
        }

        private void LoadQuizTitle(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "SELECT Title FROM dbo.Quizzes WHERE QuizId = @QuizId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    lblQuizTitle.Text = result == null ? "-" : Convert.ToString(result);
                }
            }
        }

        private void LoadQuestions()
        {
            int quizId = Convert.ToInt32(hfQuizId.Value);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT QuestionId, QuestionText, QuestionType, Points
                    FROM dbo.Questions
                    WHERE QuizId = @QuizId
                    ORDER BY QuestionId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptQuestions.DataSource = table;
                        rptQuestions.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                    }
                }
            }
        }

        protected DataTable GetOptions(object questionIdValue)
        {
            int questionId = Convert.ToInt32(questionIdValue);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT OptionText, IsCorrect
                    FROM dbo.Options
                    WHERE QuestionId = @QuestionId
                    ORDER BY OptionId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuestionId", questionId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        return table;
                    }
                }
            }
        }

        private int InsertQuestion(int quizId, string questionText, string questionType, int points)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Questions
                        (QuizId, QuestionText, QuestionType, Points)
                    VALUES
                        (@QuizId, @QuestionText, @QuestionType, @Points);

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@QuestionText", questionText);
                    cmd.Parameters.AddWithValue("@QuestionType", questionType);
                    cmd.Parameters.AddWithValue("@Points", points);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void InsertOption(int questionId, string optionText, bool isCorrect)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Options
                        (QuestionId, OptionText, IsCorrect)
                    VALUES
                        (@QuestionId, @OptionText, @IsCorrect);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuestionId", questionId);
                    cmd.Parameters.AddWithValue("@OptionText", optionText);
                    cmd.Parameters.AddWithValue("@IsCorrect", isCorrect);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteQuestion(int questionId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE o
                    FROM dbo.Options o
                    INNER JOIN dbo.Questions q ON o.QuestionId = q.QuestionId
                    INNER JOIN dbo.Quizzes z ON q.QuizId = z.QuizId
                    INNER JOIN dbo.Modules m ON z.ModuleId = m.ModuleId
                    WHERE q.QuestionId = @QuestionId AND m.CreatedBy = @CreatedBy;

                    DELETE q
                    FROM dbo.Questions q
                    INNER JOIN dbo.Quizzes z ON q.QuizId = z.QuizId
                    INNER JOIN dbo.Modules m ON z.ModuleId = m.ModuleId
                    WHERE q.QuestionId = @QuestionId AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuestionId", questionId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool InstructorOwnsQuiz(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE q.QuizId = @QuizId
                      AND m.CreatedBy = @CreatedBy
                      AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }

        private void ClearForm()
        {
            txtQuestionText.Text = "";
            ddlQuestionType.SelectedValue = "MCQ";
            txtPoints.Text = "1";
            txtOption1.Text = "";
            txtOption2.Text = "";
            txtOption3.Text = "";
            txtOption4.Text = "";
            rbCorrect1.Checked = true;
            rbCorrect2.Checked = false;
            rbCorrect3.Checked = false;
            rbCorrect4.Checked = false;
        }

        private void ShowMessage(string message, bool success)
        {
            lblQuestionStatus.Visible = true;
            lblQuestionStatus.Text = message;
            lblQuestionStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblQuestionStatus.Visible = false;
            lblQuestionStatus.Text = "";
            lblQuestionStatus.CssClass = "";
        }
    }
}
