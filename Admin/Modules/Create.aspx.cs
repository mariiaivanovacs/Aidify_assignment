using System;
using System.Data.SqlClient;
using System.Web;

namespace Aidify_assigment.Admin.Modules
{
    public partial class Create : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string difficulty = ddlDifficulty.SelectedValue;
            string status = "Published";
            bool isPreview = chkPreview.Checked;

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowError("Module title is required.");
                return;
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                ShowError("Module description is required.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtLessonTitle.Text) ||
                string.IsNullOrWhiteSpace(txtLessonContent.Text))
            {
                ShowError("Lesson 1 title and content are required.");
                return;
            }

            int createdBy = Convert.ToInt32(
                HttpContext.Current.Session[Constants.SessionUserId]);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                int newModuleId;

                SqlCommand moduleCmd = new SqlCommand(@"
                    INSERT INTO Modules
                    (
                        Title, Description, DifficultyLevel, CoverImagePath,
                        Status, IsPreview, CreatedBy, CreatedAt, IsDeleted
                    )
                    OUTPUT INSERTED.ModuleId
                    VALUES
                    (
                        @Title, @Description, @DifficultyLevel, NULL,
                        @Status, @IsPreview, @CreatedBy, GETDATE(), 0
                    )", conn);

                moduleCmd.Parameters.AddWithValue("@Title", title);
                moduleCmd.Parameters.AddWithValue("@Description", description);
                moduleCmd.Parameters.AddWithValue("@DifficultyLevel", difficulty);
                moduleCmd.Parameters.AddWithValue("@Status", status);
                moduleCmd.Parameters.AddWithValue("@IsPreview", isPreview);
                moduleCmd.Parameters.AddWithValue("@CreatedBy", createdBy);

                newModuleId = Convert.ToInt32(moduleCmd.ExecuteScalar());

                InsertLesson(conn, newModuleId, txtLessonTitle.Text, txtLessonContent.Text, txtEstimatedMinutes.Text, 1);
                InsertOptionalLesson(conn, newModuleId, txtLesson2Title.Text, txtLesson2Content.Text, txtLesson2Minutes.Text, 2);
                InsertOptionalLesson(conn, newModuleId, txtLesson3Title.Text, txtLesson3Content.Text, txtLesson3Minutes.Text, 3);
                InsertOptionalLesson(conn, newModuleId, txtLesson4Title.Text, txtLesson4Content.Text, txtLesson4Minutes.Text, 4);

                AuditService.Log(createdBy, "CreateModule", "Modules", newModuleId, conn);
            }

            lblMessage.CssClass = "alert alert-success d-block mb-3";
            lblMessage.Text = "Module and lessons created successfully.";

            ClearForm();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblMessage.Text = "";
        }
        private void InsertOptionalLesson(SqlConnection conn, int moduleId, string lessonTitle, string lessonContent, string minutesText, int sequenceOrder)
        {
            if (string.IsNullOrWhiteSpace(lessonTitle) && string.IsNullOrWhiteSpace(lessonContent))
                return;

            if (string.IsNullOrWhiteSpace(lessonTitle) || string.IsNullOrWhiteSpace(lessonContent))
                throw new Exception("Optional lesson " + sequenceOrder + " must have both title and content.");

            InsertLesson(conn, moduleId, lessonTitle, lessonContent, minutesText, sequenceOrder);
        }

        private void InsertLesson(SqlConnection conn, int moduleId, string lessonTitle, string lessonContent, string minutesText, int sequenceOrder)
        {
            int estimatedMinutes;
            if (!int.TryParse(minutesText, out estimatedMinutes) || estimatedMinutes <= 0)
                estimatedMinutes = 5;

            SqlCommand lessonCmd = new SqlCommand(@"
                INSERT INTO Lessons
                (
                    ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes
                )
                VALUES
                (
                    @ModuleId, @LessonTitle, @BodyHtml, @SequenceOrder, @EstimatedMinutes
                )", conn);

            lessonCmd.Parameters.AddWithValue("@ModuleId", moduleId);
            lessonCmd.Parameters.AddWithValue("@LessonTitle", lessonTitle.Trim());
            lessonCmd.Parameters.AddWithValue("@BodyHtml", lessonContent.Trim());
            lessonCmd.Parameters.AddWithValue("@SequenceOrder", sequenceOrder);
            lessonCmd.Parameters.AddWithValue("@EstimatedMinutes", estimatedMinutes);

            lessonCmd.ExecuteNonQuery();
        }

        private void ClearForm()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            chkPreview.Checked = false;

            txtLessonTitle.Text = "";
            txtLessonContent.Text = "";
            txtEstimatedMinutes.Text = "";

            txtLesson2Title.Text = "";
            txtLesson2Content.Text = "";
            txtLesson2Minutes.Text = "";

            txtLesson3Title.Text = "";
            txtLesson3Content.Text = "";
            txtLesson3Minutes.Text = "";

            txtLesson4Title.Text = "";
            txtLesson4Content.Text = "";
            txtLesson4Minutes.Text = "";
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "alert alert-danger d-block mb-3";
            lblMessage.Text = message;
        }
    }
}
