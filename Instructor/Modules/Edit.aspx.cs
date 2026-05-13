using System;
using System.Web.UI;

namespace Aidify_assigment.Instructor.Modules
{
    public partial class Edit : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imgCoverPreview.Visible = false;
                ddlModuleStatus.SelectedValue = "Draft";
                lblModuleStatus.Text = string.Empty;
            }
        }

        protected void btnSaveModule_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                lblModuleStatus.CssClass = "text-danger d-block";
                lblModuleStatus.Text = "Please fix the highlighted errors.";
                return;
            }

            lblModuleStatus.CssClass = "text-success d-block";
            lblModuleStatus.Text = "Module saved (temporary).";
        }

        protected void btnSaveAndAddLesson_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                lblModuleStatus.CssClass = "text-danger d-block";
                lblModuleStatus.Text = "Please fix the highlighted errors.";
                return;
            }

            Response.Redirect("~/Instructor/Lessons/Edit.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/Dashboard.aspx");
        }
    }
}
