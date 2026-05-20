using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Learner
{
    public partial class Dashboard : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblWelcome.Text = "Welcome back, " + AuthHelper.GetName();

                var courses = new[]
                {
                    new {ModuleId = 1, ModuleTitle = "Intro to C#", ProgressPct = 75},
                    new {ModuleId = 2, ModuleTitle = "ASP.NET Web Forms", ProgressPct = 40},
                    new {ModuleId = 3, ModuleTitle = "SQL Basics", ProgressPct = 20 },
                };

                rptEnrolledCourses.DataSource = courses;
                rptEnrolledCourses.DataBind();

                lblLeagueTier.Text = "Bronze";
                lblLeaguePoints.Text = "320";

                lnkNextLesson.NavigateUrl = "~/Learner/Courses/Lesson.aspx?lessonId=1";
            }
        }
    }
}