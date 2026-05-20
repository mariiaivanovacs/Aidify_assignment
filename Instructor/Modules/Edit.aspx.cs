using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Modules
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        private int ModuleId
        {
            get { return hfModuleId.Value != "" ? int.Parse(hfModuleId.Value) : 0; }
            set { hfModuleId.Value = value.ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imgCoverPreview.Visible = false;
                lblModuleStatus.Text    = string.Empty;

                int id;
                if (int.TryParse(Request.QueryString["moduleId"], out id) && id > 0)
                    LoadModule(id);
                else
                    ddlModuleStatus.SelectedValue = "Draft";
            }
        }

        private void LoadModule(int id)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT Title, Description, DifficultyLevel, Status, CoverImagePath FROM Modules WHERE ModuleId=@Id AND IsDeleted=0", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return;
                    ModuleId = id;
                    txtModuleTitle.Text     = r["Title"].ToString();
                    txtModuleDescription.Text = r["Description"] == DBNull.Value ? "" : r["Description"].ToString();
                    if (r["DifficultyLevel"] != DBNull.Value)
                        ddlDifficulty.SelectedValue = r["DifficultyLevel"].ToString();
                    ddlModuleStatus.SelectedValue = r["Status"].ToString();
                    if (r["CoverImagePath"] != DBNull.Value)
                    {
                        imgCoverPreview.ImageUrl = ResolveUrl(r["CoverImagePath"].ToString());
                        imgCoverPreview.Visible  = true;
                    }
                }
            }
        }

        protected void btnSaveModule_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int    userId = AuthHelper.GetUserId();
            string title  = txtModuleTitle.Text.Trim();
            string desc   = txtModuleDescription.Text.Trim();
            string diff   = ddlDifficulty.SelectedValue;
            string status = ddlModuleStatus.SelectedValue;
            string cover  = null;

            if (fuCoverImage.HasFile)
            {
                string[] exts = { ".jpg", ".jpeg", ".png", ".gif" };
                string ext    = Path.GetExtension(fuCoverImage.FileName).ToLower();
                if (Array.IndexOf(exts, ext) < 0)
                { lblModuleStatus.CssClass = "text-danger d-block"; lblModuleStatus.Text = "Image files only (.jpg/.png/.gif)."; return; }

                string dir = Server.MapPath("~/Uploads/Covers/");
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                cover = "~/Uploads/Covers/" + Guid.NewGuid() + ext;
                fuCoverImage.SaveAs(Server.MapPath(cover));
                imgCoverPreview.ImageUrl = ResolveUrl(cover);
                imgCoverPreview.Visible  = true;
            }

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    if (ModuleId == 0)
                    {
                        // INSERT new module
                        var sql = "INSERT INTO Modules (Title, Description, DifficultyLevel, Status, CoverImagePath, CreatedBy) " +
                                  "OUTPUT INSERTED.ModuleId " +
                                  "VALUES (@T, @D, @Diff, @Status, @Cover, @By)";
                        var cmd = new SqlCommand(sql, conn, tx);
                        cmd.Parameters.AddWithValue("@T",      title);
                        cmd.Parameters.AddWithValue("@D",      desc);
                        cmd.Parameters.AddWithValue("@Diff",   diff);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Cover",  (object)cover ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@By",     userId);
                        ModuleId = (int)cmd.ExecuteScalar();
                        AuditService.Log(userId, "CreateModule", "Modules", ModuleId, conn, tx);
                    }
                    else
                    {
                        string sql = cover != null
                            ? "UPDATE Modules SET Title=@T, Description=@D, DifficultyLevel=@Diff, Status=@Status, CoverImagePath=@Cover WHERE ModuleId=@Id"
                            : "UPDATE Modules SET Title=@T, Description=@D, DifficultyLevel=@Diff, Status=@Status WHERE ModuleId=@Id";
                        var cmd = new SqlCommand(sql, conn, tx);
                        cmd.Parameters.AddWithValue("@T",      title);
                        cmd.Parameters.AddWithValue("@D",      desc);
                        cmd.Parameters.AddWithValue("@Diff",   diff);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Id",     ModuleId);
                        if (cover != null) cmd.Parameters.AddWithValue("@Cover", cover);
                        cmd.ExecuteNonQuery();
                        AuditService.Log(userId, "UpdateModule", "Modules", ModuleId, conn, tx);
                    }
                    tx.Commit();
                }
            }

            lblModuleStatus.CssClass = "text-success d-block";
            lblModuleStatus.Text     = "Module saved successfully.";
        }

        protected void btnSaveAndAddLesson_Click(object sender, EventArgs e)
        {
            btnSaveModule_Click(sender, e);
            if (ModuleId > 0 && lblModuleStatus.Text.Contains("successfully"))
                Response.Redirect("~/Instructor/Lessons/Edit.aspx?moduleId=" + ModuleId, false);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/Dashboard.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
