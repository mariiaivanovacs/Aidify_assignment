using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Materials
{
    public partial class Upload : InstructorBasePage
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
                LoadModuleFilter();
                LoadLessonsForSelectedModule();
                LoadMaterials();
                LoadMaterialStats();
            }
        }

        protected void ddlModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadLessonsForSelectedModule();
        }

        protected void btnUploadMaterial_Click(object sender, EventArgs e)
        {
            ClearMessage();

            if (string.IsNullOrWhiteSpace(ddlModule.SelectedValue))
            {
                ShowMessage("Please select a module.", false);
                return;
            }

            string title = txtMaterialTitle.Text.Trim();
            string type = ddlType.SelectedValue;
            string caption = txtCaption.Text.Trim();
            string externalUrl = txtExternalUrl.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the material title.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(type))
            {
                ShowMessage("Please select the material type.", false);
                return;
            }

            int moduleId = Convert.ToInt32(ddlModule.SelectedValue);
            int? lessonId = null;

            if (!string.IsNullOrWhiteSpace(ddlLesson.SelectedValue))
            {
                lessonId = Convert.ToInt32(ddlLesson.SelectedValue);
            }

            if (!InstructorOwnsModule(moduleId))
            {
                ShowMessage("Invalid module selected.", false);
                return;
            }

            if (lessonId.HasValue && !LessonBelongsToModule(lessonId.Value, moduleId))
            {
                ShowMessage("Invalid lesson selected for this module.", false);
                return;
            }

            string filePath = "";

            if (type == "Link")
            {
                if (string.IsNullOrWhiteSpace(externalUrl))
                {
                    ShowMessage("Please enter an external URL for Link type.", false);
                    return;
                }

                filePath = externalUrl;
            }
            else
            {
                if (!fuMaterial.HasFile)
                {
                    ShowMessage("Please upload a file or choose Link type.", false);
                    return;
                }

                filePath = SaveUploadedFile(type);

                if (string.IsNullOrWhiteSpace(filePath))
                {
                    return;
                }
            }

            string captionToSave = title;

            if (!string.IsNullOrWhiteSpace(caption))
            {
                captionToSave = title + " - " + caption;
            }

            try
            {
                int materialId = InsertMaterial(moduleId, lessonId, type, filePath, captionToSave);
                AuditService.Log(InstructorUserId, "UploadMaterial", "LearningMaterials", materialId);

                ShowMessage("Material uploaded successfully.", true);
                ClearForm();
                LoadMaterials();
                LoadMaterialStats();
            }
            catch (Exception ex)
            {
                ShowMessage("Error while uploading material: " + ex.Message, false);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            ShowMessage("Form cleared.", true);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            ClearMessage();

            LoadModules();
            LoadModuleFilter();

            if (ddlModuleFilter.Items.FindByValue("All") != null)
            {
                ddlModuleFilter.SelectedValue = "All";
            }

            if (ddlModule.Items.Count > 0)
            {
                ddlModule.SelectedIndex = 0;
            }

            LoadLessonsForSelectedModule();
            LoadMaterials();
            LoadMaterialStats();

            ShowMessage("Materials refreshed successfully.", true);
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            ClearMessage();
            LoadMaterials();
            LoadMaterialStats();
        }

        protected void rptMaterials_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int materialId))
            {
                ShowMessage("Invalid material selected.", false);
                return;
            }

            try
            {
                DataRow material = GetMaterialById(materialId);

                if (material == null)
                {
                    ShowMessage("Material not found.", false);
                    return;
                }

                string filePath = Convert.ToString(material["FilePath"]);

                if (e.CommandName == "ViewMaterial")
                {
                    if (string.IsNullOrWhiteSpace(filePath))
                    {
                        ShowMessage("No file path found for this material.", false);
                        return;
                    }

                    Response.Redirect(filePath, false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else if (e.CommandName == "DownloadMaterial")
                {
                    DownloadMaterial(filePath);
                }
                else if (e.CommandName == "DeleteMaterial")
                {
                    DeleteMaterial(materialId);
                    LoadMaterials();
                    LoadMaterialStats();
                    ShowMessage("Material deleted successfully.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing material: " + ex.Message, false);
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

        private void LoadLessonsForSelectedModule()
        {
            ddlLesson.Items.Clear();
            ddlLesson.Items.Add(new ListItem("No specific lesson", ""));

            if (string.IsNullOrWhiteSpace(ddlModule.SelectedValue))
            {
                return;
            }

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT LessonId, Title
                    FROM dbo.Lessons
                    WHERE ModuleId = @ModuleId
                    ORDER BY SequenceOrder, LessonId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", Convert.ToInt32(ddlModule.SelectedValue));

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        foreach (DataRow row in table.Rows)
                        {
                            ddlLesson.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["LessonId"])
                            ));
                        }
                    }
                }
            }
        }

        private void LoadMaterials()
        {
            string moduleFilter = "All";

            if (ddlModuleFilter.Items.Count > 0 && !string.IsNullOrWhiteSpace(ddlModuleFilter.SelectedValue))
            {
                moduleFilter = ddlModuleFilter.SelectedValue;
            }

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        lm.MaterialId,
                        lm.ModuleId,
                        lm.LessonId,
                        ISNULL(NULLIF(lm.Caption, ''), lm.FilePath) AS DisplayTitle,
                        lm.Type,
                        lm.FilePath,
                        lm.Caption,
                        ISNULL(m.Title, '-') AS ModuleTitle,
                        ISNULL(l.Title, '-') AS LessonTitle
                    FROM dbo.LearningMaterials lm
                    LEFT JOIN dbo.Modules m ON lm.ModuleId = m.ModuleId
                    LEFT JOIN dbo.Lessons l ON lm.LessonId = l.LessonId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@ModuleId = 0 OR lm.ModuleId = @ModuleId)
                    ORDER BY lm.MaterialId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    int moduleId = moduleFilter == "All" ? 0 : Convert.ToInt32(moduleFilter);

                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptMaterials.DataSource = table;
                        rptMaterials.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblMaterialCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void LoadMaterialStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(lm.MaterialId) AS TotalMaterials,
                        SUM(CASE WHEN lm.Type = 'Link' THEN 0 ELSE 1 END) AS FileMaterials,
                        SUM(CASE WHEN lm.Type = 'Link' THEN 1 ELSE 0 END) AS LinkMaterials
                    FROM dbo.LearningMaterials lm
                    INNER JOIN dbo.Modules m ON lm.ModuleId = m.ModuleId
                    WHERE m.CreatedBy = @CreatedBy AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalMaterials.Text = Convert.ToString(reader["TotalMaterials"] == DBNull.Value ? 0 : reader["TotalMaterials"]);
                            lblFileMaterials.Text = Convert.ToString(reader["FileMaterials"] == DBNull.Value ? 0 : reader["FileMaterials"]);
                            lblLinkMaterials.Text = Convert.ToString(reader["LinkMaterials"] == DBNull.Value ? 0 : reader["LinkMaterials"]);
                        }
                    }
                }
            }
        }

        private int InsertMaterial(int moduleId, int? lessonId, string type, string filePath, string caption)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.LearningMaterials
                        (ModuleId, LessonId, Type, FilePath, Caption)
                    VALUES
                        (@ModuleId, @LessonId, @Type, @FilePath, @Caption);

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@LessonId", lessonId.HasValue ? (object)lessonId.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Type", type);
                    cmd.Parameters.AddWithValue("@FilePath", filePath);
                    cmd.Parameters.AddWithValue("@Caption", string.IsNullOrWhiteSpace(caption) ? (object)DBNull.Value : caption);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private DataRow GetMaterialById(int materialId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        lm.MaterialId,
                        lm.FilePath
                    FROM dbo.LearningMaterials lm
                    INNER JOIN dbo.Modules m ON lm.ModuleId = m.ModuleId
                    WHERE
                        lm.MaterialId = @MaterialId
                        AND m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MaterialId", materialId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count == 0)
                        {
                            return null;
                        }

                        return table.Rows[0];
                    }
                }
            }
        }

        private void DeleteMaterial(int materialId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE lm
                    FROM dbo.LearningMaterials lm
                    INNER JOIN dbo.Modules m ON lm.ModuleId = m.ModuleId
                    WHERE
                        lm.MaterialId = @MaterialId
                        AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MaterialId", materialId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private string SaveUploadedFile(string type)
        {
            string extension = Path.GetExtension(fuMaterial.FileName).ToLower();

            if (!IsAllowedExtension(type, extension))
            {
                ShowMessage("This file extension is not allowed for the selected material type.", false);
                return "";
            }

            string folderVirtualPath = "~/Uploads/LearningMaterials/";
            string folderPhysicalPath = Server.MapPath(folderVirtualPath);

            if (!Directory.Exists(folderPhysicalPath))
            {
                Directory.CreateDirectory(folderPhysicalPath);
            }

            string fileName = "material_" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + extension;
            string filePhysicalPath = Path.Combine(folderPhysicalPath, fileName);

            fuMaterial.SaveAs(filePhysicalPath);

            return ResolveUrl(folderVirtualPath + fileName);
        }

        private bool IsAllowedExtension(string type, string extension)
        {
            if (type == "PDF")
            {
                return extension == ".pdf";
            }

            if (type == "Image")
            {
                return extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".gif";
            }

            if (type == "Video")
            {
                return extension == ".mp4" || extension == ".mov" || extension == ".avi";
            }

            if (type == "Document")
            {
                return extension == ".doc" || extension == ".docx" || extension == ".ppt" || extension == ".pptx" || extension == ".txt";
            }

            return false;
        }

        private void DownloadMaterial(string filePath)
        {
            if (string.IsNullOrWhiteSpace(filePath))
            {
                ShowMessage("No file path found for this material.", false);
                return;
            }

            if (filePath.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
                filePath.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect(filePath, false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string physicalPath = Server.MapPath(filePath);

            if (!File.Exists(physicalPath))
            {
                ShowMessage("File not found on server.", false);
                return;
            }

            string fileName = Path.GetFileName(physicalPath);

            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.TransmitFile(physicalPath);
            Response.Flush();
            Context.ApplicationInstance.CompleteRequest();
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

        private bool LessonBelongsToModule(int lessonId, int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.Lessons
                    WHERE LessonId = @LessonId
                      AND ModuleId = @ModuleId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@LessonId", lessonId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    return count > 0;
                }
            }
        }

        private void ClearForm()
        {
            if (ddlModule.Items.Count > 0)
            {
                ddlModule.SelectedIndex = 0;
            }

            LoadLessonsForSelectedModule();

            txtMaterialTitle.Text = "";
            ddlType.SelectedIndex = 0;
            txtExternalUrl.Text = "";
            txtCaption.Text = "";
        }

        private void ShowMessage(string message, bool success)
        {
            lblMaterialStatus.Visible = true;
            lblMaterialStatus.Text = message;
            lblMaterialStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblMaterialStatus.Visible = false;
            lblMaterialStatus.Text = "";
            lblMaterialStatus.CssClass = "";
        }

        protected string ShortText(object value)
        {
            string text = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(text))
            {
                return "-";
            }

            if (text.Length <= 70)
            {
                return text;
            }

            return text.Substring(0, 70) + "...";
        }

        protected string GetTypeIcon(object value)
        {
            string type = Convert.ToString(value);

            if (type == "PDF")
            {
                return "bi bi-file-earmark-pdf";
            }

            if (type == "Image")
            {
                return "bi bi-image";
            }

            if (type == "Video")
            {
                return "bi bi-camera-video";
            }

            if (type == "Link")
            {
                return "bi bi-link-45deg";
            }

            return "bi bi-file-earmark";
        }
    }
}
