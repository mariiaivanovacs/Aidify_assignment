using System;
using System.Collections.Generic;

namespace Aidify_assigment.Instructor.Materials
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUploadStatus.Text = string.Empty;
                BindModules();
                BindLessons();
                BindMaterials();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                lblUploadStatus.CssClass = "text-danger d-block";
                lblUploadStatus.Text = "Please fix the highlighted errors.";
                return;
            }

            lblUploadStatus.CssClass = "text-success d-block";
            lblUploadStatus.Text = "Upload successful.";
        }

        private void BindModules()
        {
            ddlTargetModule.Items.Clear();
            ddlTargetModule.Items.Add(new System.Web.UI.WebControls.ListItem("Select a module", string.Empty));
            ddlTargetModule.Items.Add(new System.Web.UI.WebControls.ListItem("Foundations of Health", "1"));
            ddlTargetModule.Items.Add(new System.Web.UI.WebControls.ListItem("Advanced Nutrition", "2"));
        }

        private void BindLessons()
        {
            ddlTargetLesson.Items.Clear();
            ddlTargetLesson.Items.Add(new System.Web.UI.WebControls.ListItem("Module-level", string.Empty));
            ddlTargetLesson.Items.Add(new System.Web.UI.WebControls.ListItem("Lesson 1: Intro", "101"));
            ddlTargetLesson.Items.Add(new System.Web.UI.WebControls.ListItem("Lesson 2: Practice", "102"));
        }

        private void BindMaterials()
        {
            var materials = new List<MaterialItem>
            {
                new MaterialItem { Title = "Starter Guide.pdf", Detail = "Foundations of Health · Module-level", Status = "Published" },
                new MaterialItem { Title = "Lesson Worksheet.docx", Detail = "Lesson 1: Intro", Status = "Draft" }
            };

            rptUploadedMaterials.DataSource = materials;
            rptUploadedMaterials.DataBind();
        }

        private class MaterialItem
        {
            public string Title { get; set; }
            public string Detail { get; set; }
            public string Status { get; set; }
        }
    }
}
