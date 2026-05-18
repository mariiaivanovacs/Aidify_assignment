using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Courses
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy code
                lblModuleTitle.Text = "Intro to C#";
                lblModuleTitleMain.Text = "Intro to C#";
                lblDifficulty.Text = "Beginner";
                lblModuleDescription.Text = "Learn the fundamentals of C# programming from scratch.";
                lblProgressPct.Text = "60% complete";
                progressBar.Style["width"] = "60%";
                imgModuleCover.ImageUrl = "https://placehold.co/600x220?text=Intro+to+C%23";

                // used to show or hide the enrol button
                bool isEnrolled = true;
                pnlEnrolCTA.Visible = !isEnrolled;

                // Dummy lessons
                var lessons = new[]
                {
                    new { LessonId = 1, LessonTitle = "Variables & Types", EstimatedMinutes = 10, IsCompleted = true },
                    new { LessonId = 2, LessonTitle = "Control Flow", EstimatedMinutes = 15, IsCompleted = true },
                    new { LessonId = 3, LessonTitle = "Methods & Functions", EstimatedMinutes = 20, IsCompleted = false },
                    new { LessonId = 4, LessonTitle = "Classes & Objects", EstimatedMinutes = 25, IsCompleted = false },
                };

                rptLessons.DataSource = lessons;
                rptLessons.DataBind();
            }
        }

        protected void btnEnrolFromDetails_Click(object sender, EventArgs e)
        {
            // what to add: save the enrollmet into the data base
            pnlEnrolCTA.Visible = false;
        }
    }
}