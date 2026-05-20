using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Materials
{
    public partial class Upload : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUploadStatus.Text = string.Empty;
                BindModules();
                BindMaterials();
            }
        }

        private void BindModules()
        {
            int userId = AuthHelper.GetUserId();
            ddlTargetModule.Items.Clear();
            ddlTargetModule.Items.Add(new ListItem("— Select a module —", ""));
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT ModuleId, Title FROM Modules WHERE CreatedBy=@U AND IsDeleted=0 ORDER BY Title", conn);
                cmd.Parameters.AddWithValue("@U", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        ddlTargetModule.Items.Add(
                            new ListItem(r["Title"].ToString(), r["ModuleId"].ToString()));
            }
        }

        protected void ddlTargetModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindLessons();
        }

        private void BindLessons()
        {
            ddlTargetLesson.Items.Clear();
            ddlTargetLesson.Items.Add(new ListItem("Module-level (no specific lesson)", ""));
            int moduleId;
            if (!int.TryParse(ddlTargetModule.SelectedValue, out moduleId) || moduleId == 0) return;
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT LessonId, Title FROM Lessons WHERE ModuleId=@M ORDER BY SequenceOrder", conn);
                cmd.Parameters.AddWithValue("@M", moduleId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        ddlTargetLesson.Items.Add(
                            new ListItem(r["Title"].ToString(), r["LessonId"].ToString()));
            }
        }

        private void BindMaterials()
        {
            int userId = AuthHelper.GetUserId();
            var rows   = new List<MaterialItem>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT lm.FilePath, lm.Type, m.Title AS ModuleTitle,
                           l.Title AS LessonTitle
                    FROM   LearningMaterials lm
                    JOIN   Modules m  ON m.ModuleId  = lm.ModuleId
                    LEFT JOIN Lessons l ON l.LessonId = lm.LessonId
                    WHERE  m.CreatedBy = @U AND m.IsDeleted = 0
                    ORDER BY lm.MaterialId DESC", conn);
                cmd.Parameters.AddWithValue("@U", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                    {
                        string lessonTitle = r["LessonTitle"] == DBNull.Value ? "" : r["LessonTitle"].ToString();
                        rows.Add(new MaterialItem {
                            Title  = r["FilePath"] == DBNull.Value ? "(no file)" : Path.GetFileName(r["FilePath"].ToString()),
                            Detail = r["ModuleTitle"] + (lessonTitle != "" ? " · " + lessonTitle : " · Module-level"),
                            Status = "Published"
                        });
                    }
            }
            rptUploadedMaterials.DataSource = rows;
            rptUploadedMaterials.DataBind();
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int moduleId;
            if (!int.TryParse(ddlTargetModule.SelectedValue, out moduleId) || moduleId == 0)
            { ShowError("Please select a module."); return; }

            if (!fuMaterial.HasFile)
            { ShowError("Please choose a file to upload."); return; }

            string[] allowed = { ".pdf", ".jpg", ".jpeg", ".png", ".mp4", ".mov" };
            string ext = Path.GetExtension(fuMaterial.FileName).ToLower();
            if (Array.IndexOf(allowed, ext) < 0)
            { ShowError("Allowed types: PDF, JPG, PNG, MP4, MOV."); return; }
            if (fuMaterial.PostedFile.ContentLength > 50 * 1024 * 1024)
            { ShowError("File must be under 50 MB."); return; }

            string dir  = Server.MapPath("~/Uploads/Materials/" + moduleId + "/");
            if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
            string path = "~/Uploads/Materials/" + moduleId + "/" + Guid.NewGuid() + ext;
            fuMaterial.SaveAs(Server.MapPath(path));

            string type = ext == ".pdf" ? "PDF" : (ext == ".mp4" || ext == ".mov") ? "Video" : "Image";

            int lessonId;
            bool hasLesson = int.TryParse(ddlTargetLesson.SelectedValue, out lessonId) && lessonId > 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var ins = new SqlCommand(@"
                    INSERT INTO LearningMaterials (ModuleId, LessonId, Type, FilePath, Caption)
                    VALUES (@M, @L, @T, @P, @C)", conn);
                ins.Parameters.AddWithValue("@M", moduleId);
                ins.Parameters.AddWithValue("@L", hasLesson ? (object)lessonId : DBNull.Value);
                ins.Parameters.AddWithValue("@T", type);
                ins.Parameters.AddWithValue("@P", path);
                ins.Parameters.AddWithValue("@C",
                    !string.IsNullOrEmpty(txtCaption.Text) ? (object)txtCaption.Text.Trim() : DBNull.Value);
                ins.ExecuteNonQuery();
            }

            txtCaption.Text          = "";
            lblUploadStatus.CssClass = "text-success d-block";
            lblUploadStatus.Text     = "File uploaded successfully.";
            BindMaterials();
        }

        private void ShowError(string msg)
        { lblUploadStatus.CssClass = "text-danger d-block"; lblUploadStatus.Text = msg; }

        private class MaterialItem { public string Title, Detail, Status; }
    }
}
