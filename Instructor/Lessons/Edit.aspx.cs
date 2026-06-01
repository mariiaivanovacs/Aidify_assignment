using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Lessons
{
    public partial class Edit : InstructorBasePage
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

                string lessonIdText = Request.QueryString["id"];
                string moduleIdText = Request.QueryString["moduleId"];

                if (!string.IsNullOrWhiteSpace(lessonIdText) && int.TryParse(lessonIdText, out int lessonId))
                {
                    LoadLesson(lessonId);
                }
                else
                {
                    lblPageTitle.Text = "Create Lesson";

                    if (!string.IsNullOrWhiteSpace(moduleIdText) && ddlModule.Items.FindByValue(moduleIdText) != null)
                    {
                        ddlModule.SelectedValue = moduleIdText;
                    }

                    txtSequenceOrder.Text = GetNextSequenceOrder().ToString();
                }
            }
        }

        protected void btnSaveLesson_Click(object sender, EventArgs e)
        {
            int lessonId = SaveLesson();

            if (lessonId > 0)
            {
                ShowMessage("Lesson saved successfully.", true);
                LoadLesson(lessonId);
            }
        }

        protected void btnSaveAndNew_Click(object sender, EventArgs e)
        {
            int lessonId = SaveLesson();

            if (lessonId > 0)
            {
                string moduleId = ddlModule.SelectedValue;
                Response.Redirect("Edit.aspx?moduleId=" + moduleId);
            }
        }

        private int SaveLesson()
        {
            ClearMessage();

            if (string.IsNullOrWhiteSpace(ddlModule.SelectedValue))
            {
                ShowMessage("Please select a module.", false);
                return 0;
            }

            string title = txtLessonTitle.Text.Trim();
            string bodyHtml = txtBodyHtml.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the lesson title.", false);
                return 0;
            }

            if (string.IsNullOrWhiteSpace(bodyHtml))
            {
                ShowMessage("Please enter the lesson content.", false);
                return 0;
            }

            if (!int.TryParse(txtSequenceOrder.Text.Trim(), out int sequenceOrder) || sequenceOrder <= 0)
            {
                ShowMessage("Please enter a valid sequence order.", false);
                return 0;
            }

            int estimatedMinutes = 0;

            if (!string.IsNullOrWhiteSpace(txtEstimatedMinutes.Text.Trim()))
            {
                if (!int.TryParse(txtEstimatedMinutes.Text.Trim(), out estimatedMinutes) || estimatedMinutes < 0)
                {
                    ShowMessage("Please enter valid estimated minutes.", false);
                    return 0;
                }
            }

            int moduleId = Convert.ToInt32(ddlModule.SelectedValue);

            if (!InstructorOwnsModule(moduleId))
            {
                ShowMessage("Invalid module selected.", false);
                return 0;
            }

            try
            {
                if (string.IsNullOrWhiteSpace(hfLessonId.Value))
                {
                    int newLessonId = InsertLesson(moduleId, title, bodyHtml, sequenceOrder, estimatedMinutes);
                    hfLessonId.Value = newLessonId.ToString();
                    AuditService.Log(InstructorUserId, "CreateLesson", "Lessons", newLessonId);
                    return newLessonId;
                }
                else
                {
                    int lessonId = Convert.ToInt32(hfLessonId.Value);
                    UpdateLesson(lessonId, moduleId, title, bodyHtml, sequenceOrder, estimatedMinutes);
                    AuditService.Log(InstructorUserId, "UpdateLesson", "Lessons", lessonId);
                    return lessonId;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving lesson: " + ex.Message, false);
                return 0;
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

        private void LoadLesson(int lessonId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        l.LessonId,
                        l.ModuleId,
                        l.Title,
                        l.BodyHtml,
                        l.SequenceOrder,
                        ISNULL(l.EstimatedMinutes, 0) AS EstimatedMinutes
                    FROM dbo.Lessons l
                    INNER JOIN dbo.Modules m ON l.ModuleId = m.ModuleId
                    WHERE
                        l.LessonId = @LessonId
                        AND m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@LessonId", lessonId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count == 0)
                        {
                            ShowMessage("Lesson not found or you do not have permission to edit it.", false);
                            return;
                        }

                        DataRow row = table.Rows[0];

                        hfLessonId.Value = Convert.ToString(row["LessonId"]);
                        ddlModule.SelectedValue = Convert.ToString(row["ModuleId"]);
                        txtLessonTitle.Text = Convert.ToString(row["Title"]);
                        txtBodyHtml.Text = Convert.ToString(row["BodyHtml"]);
                        txtSequenceOrder.Text = Convert.ToString(row["SequenceOrder"]);
                        txtEstimatedMinutes.Text = Convert.ToString(row["EstimatedMinutes"]);

                        lblPageTitle.Text = "Edit Lesson";
                        btnSaveLesson.Text = "Update Lesson";
                    }
                }
            }
        }

        private int InsertLesson(int moduleId, string title, string bodyHtml, int sequenceOrder, int estimatedMinutes)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Lessons
                        (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes)
                    VALUES
                        (@ModuleId, @Title, @BodyHtml, @SequenceOrder, @EstimatedMinutes);

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@BodyHtml", bodyHtml);
                    cmd.Parameters.AddWithValue("@SequenceOrder", sequenceOrder);
                    cmd.Parameters.AddWithValue("@EstimatedMinutes", estimatedMinutes);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void UpdateLesson(int lessonId, int moduleId, string title, string bodyHtml, int sequenceOrder, int estimatedMinutes)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE l
                    SET
                        l.ModuleId = @ModuleId,
                        l.Title = @Title,
                        l.BodyHtml = @BodyHtml,
                        l.SequenceOrder = @SequenceOrder,
                        l.EstimatedMinutes = @EstimatedMinutes
                    FROM dbo.Lessons l
                    INNER JOIN dbo.Modules m ON l.ModuleId = m.ModuleId
                    WHERE
                        l.LessonId = @LessonId
                        AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@LessonId", lessonId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@BodyHtml", bodyHtml);
                    cmd.Parameters.AddWithValue("@SequenceOrder", sequenceOrder);
                    cmd.Parameters.AddWithValue("@EstimatedMinutes", estimatedMinutes);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
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
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    return count > 0;
                }
            }
        }

        private int GetNextSequenceOrder()
        {
            if (string.IsNullOrWhiteSpace(Request.QueryString["moduleId"]))
            {
                return 1;
            }

            if (!int.TryParse(Request.QueryString["moduleId"], out int moduleId))
            {
                return 1;
            }

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT ISNULL(MAX(SequenceOrder), 0) + 1
                    FROM dbo.Lessons
                    WHERE ModuleId = @ModuleId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
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

        private void ClearMessage()
        {
            lblLessonStatus.Visible = false;
            lblLessonStatus.Text = "";
            lblLessonStatus.CssClass = "";
        }
    }
}
