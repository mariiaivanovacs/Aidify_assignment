using System;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Lessons
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblLessonStatus.Text = string.Empty;
            }
        }

        protected void btnSaveLesson_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                lblLessonStatus.CssClass = "text-danger d-block";
                lblLessonStatus.Text = "Please fix the highlighted errors.";
                return;
            }

            lblLessonStatus.CssClass = "text-success d-block";
            lblLessonStatus.Text = "Lesson saved (temporary).";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/Dashboard.aspx");
        }
    }
}
