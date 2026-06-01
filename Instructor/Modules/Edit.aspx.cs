using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Aidify_assigment.Instructor.Modules
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
                string id = Request.QueryString["id"];

                if (!string.IsNullOrWhiteSpace(id) && int.TryParse(id, out int moduleId))
                {
                    LoadModule(moduleId);
                }
                else
                {
                    lblPageTitle.Text = "Create Module";
                    lblCurrentStatus.Text = "Draft";
                }
            }
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            SaveModuleAndStay("Draft");
        }

        protected void btnSubmitForReview_Click(object sender, EventArgs e)
        {
            SaveModuleAndStay("PendingReview");
        }

        protected void btnSaveAndAddLesson_Click(object sender, EventArgs e)
        {
            int moduleId = SaveModule("Draft");

            if (moduleId > 0)
            {
                Response.Redirect("../Lessons/Edit.aspx?moduleId=" + moduleId);
            }
        }

        private void SaveModuleAndStay(string status)
        {
            int moduleId = SaveModule(status);

            if (moduleId > 0)
            {
                ShowMessage(status == "PendingReview"
                    ? "Module saved and submitted for review successfully."
                    : "Module draft saved successfully.", true);

                LoadModule(moduleId);
            }
        }

        private int SaveModule(string status)
        {
            ClearMessage();

            string title = txtModuleTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string difficulty = ddlDifficulty.SelectedValue;
            bool isPreview = chkIsPreview.Checked;

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the module title.", false);
                return 0;
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                ShowMessage("Please enter the module description.", false);
                return 0;
            }

            if (string.IsNullOrWhiteSpace(difficulty))
            {
                ShowMessage("Please select the difficulty level.", false);
                return 0;
            }

            string coverImagePath = SaveCoverImageIfUploaded();

            if (string.IsNullOrWhiteSpace(coverImagePath))
            {
                coverImagePath = hfExistingCoverImage.Value;
            }

            try
            {
                if (string.IsNullOrWhiteSpace(hfModuleId.Value))
                {
                    int newId = InsertModule(title, description, difficulty, coverImagePath, status, isPreview);
                    hfModuleId.Value = newId.ToString();
                    AuditService.Log(InstructorUserId, status == "PendingReview" ? "SubmitModuleForReview" : "CreateModule", "Modules", newId);
                    return newId;
                }
                else
                {
                    int moduleId = Convert.ToInt32(hfModuleId.Value);
                    UpdateModule(moduleId, title, description, difficulty, coverImagePath, status, isPreview);
                    AuditService.Log(InstructorUserId, status == "PendingReview" ? "SubmitModuleForReview" : "UpdateModule", "Modules", moduleId);
                    return moduleId;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving module: " + ex.Message, false);
                return 0;
            }
        }

        private int InsertModule(string title, string description, string difficulty, string coverImagePath, string status, bool isPreview)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Modules
                        (Title, Description, DifficultyLevel, CoverImagePath, Status, IsPreview, CreatedBy, CreatedAt, IsDeleted)
                    VALUES
                        (@Title, @Description, @DifficultyLevel, @CoverImagePath, @Status, @IsPreview, @CreatedBy, GETDATE(), 0);

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@DifficultyLevel", difficulty);
                    cmd.Parameters.AddWithValue("@CoverImagePath", string.IsNullOrWhiteSpace(coverImagePath) ? (object)DBNull.Value : coverImagePath);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@IsPreview", isPreview);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void UpdateModule(int moduleId, string title, string description, string difficulty, string coverImagePath, string status, bool isPreview)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE dbo.Modules
                    SET
                        Title = @Title,
                        Description = @Description,
                        DifficultyLevel = @DifficultyLevel,
                        CoverImagePath = @CoverImagePath,
                        Status = @Status,
                        IsPreview = @IsPreview
                    WHERE
                        ModuleId = @ModuleId
                        AND CreatedBy = @CreatedBy
                        AND IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@DifficultyLevel", difficulty);
                    cmd.Parameters.AddWithValue("@CoverImagePath", string.IsNullOrWhiteSpace(coverImagePath) ? (object)DBNull.Value : coverImagePath);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@IsPreview", isPreview);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadModule(int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        ModuleId,
                        Title,
                        Description,
                        DifficultyLevel,
                        CoverImagePath,
                        Status,
                        IsPreview
                    FROM dbo.Modules
                    WHERE
                        ModuleId = @ModuleId
                        AND CreatedBy = @CreatedBy
                        AND IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count == 0)
                        {
                            ShowMessage("Module not found or you do not have permission to edit it.", false);
                            return;
                        }

                        DataRow row = table.Rows[0];

                        hfModuleId.Value = Convert.ToString(row["ModuleId"]);
                        txtModuleTitle.Text = Convert.ToString(row["Title"]);
                        txtDescription.Text = Convert.ToString(row["Description"]);
                        ddlDifficulty.SelectedValue = Convert.ToString(row["DifficultyLevel"]);
                        chkIsPreview.Checked = Convert.ToBoolean(row["IsPreview"]);

                        string cover = row["CoverImagePath"] == DBNull.Value ? "" : Convert.ToString(row["CoverImagePath"]);
                        hfExistingCoverImage.Value = cover;

                        if (!string.IsNullOrWhiteSpace(cover))
                        {
                            imgCoverPreview.ImageUrl = cover;
                            imgCoverPreview.Visible = true;
                        }

                        string status = Convert.ToString(row["Status"]);
                        lblCurrentStatus.Text = FormatStatus(status);

                        lblPageTitle.Text = "Edit Module";
                        btnSaveDraft.Text = "Update Draft";
                    }
                }
            }
        }

        private string SaveCoverImageIfUploaded()
        {
            if (fuCover == null || !fuCover.HasFile)
            {
                return "";
            }

            string extension = Path.GetExtension(fuCover.FileName).ToLower();

            if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
            {
                ShowMessage("Only JPG and PNG cover images are allowed.", false);
                return "";
            }

            string folderVirtualPath = "~/Uploads/ModuleCovers/";
            string folderPhysicalPath = Server.MapPath(folderVirtualPath);

            if (!Directory.Exists(folderPhysicalPath))
            {
                Directory.CreateDirectory(folderPhysicalPath);
            }

            string fileName = "module_" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + extension;
            string filePhysicalPath = Path.Combine(folderPhysicalPath, fileName);

            fuCover.SaveAs(filePhysicalPath);

            return ResolveUrl(folderVirtualPath + fileName);
        }

        private void ShowMessage(string message, bool success)
        {
            lblModuleStatus.Visible = true;
            lblModuleStatus.Text = message;
            lblModuleStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblModuleStatus.Visible = false;
            lblModuleStatus.Text = "";
            lblModuleStatus.CssClass = "";
        }

        private string FormatStatus(string status)
        {
            if (status == "PendingReview")
            {
                return "Pending Review";
            }

            return status;
        }
    }
}
