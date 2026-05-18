using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Optimization;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace LearnerDash.Learner.Courses
{
    public partial class Lesson : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy data 
                lblLessonTitle.Text = "Variables & Types";
                lblModuleBreadcrumb.Text = "Intro to C#";

                litLessonBody.Text = @"
                    <h5>What are Variables?</h5>
                    <p> A variable is a container for storing data values.In C#, each variable 
                    has a specific type which determines the size and layout of the variable's memory.</p>
                    <h5> Common Data Types </h5>
                    <ul>
                        <li><strong> int </strong> — stores integers e.g. 42 </li>
                        <li><strong> string </strong> — stores text e.g. ""Hello"" </li>
                        <li><strong> bool </strong> — stores true or false </li>
                        <li><strong> double </strong> — stores decimal numbers e.g. 3.14 </li>
                    </ul>
                    <h5> Example </h5>
                    <pre style = 'background:#f4f4f4; padding:12px; border-radius:8px;'>

                int age = 25;
                string name = ""Manoj"";
                bool isEnrolled = true;</Pre>
                        ";

                hfModuleId.Value = "1";
                hfLessonId.Value = "1";

                bool isCompleted = false;
                if (isCompleted)
                {
                    lblAlreadyComplete.Visible = true;
                    pnlMarkComplete.Visible = false;
                    pnlAfterComplete.Visible = true;
                    lnkNextLesson.NavigateUrl = "~/Learner/Courses/Lesson.aspx?lessonId=2";
                    lnkStartQuiz.NavigateUrl = "~/Learner/Quiz/Take.aspx?quizId=1";
                }
            }
        }

        protected void btnMarkComplete_Click(object sender, EventArgs e)
        {
            pnlMarkComplete.Visible = false;
            lblAlreadyComplete.Visible = true;
            pnlAfterComplete.Visible = true;
            lnkNextLesson.NavigateUrl = "~/Learner/Courses/Lesson.aspx?lessonId=2";
            lnkStartQuiz.NavigateUrl = "~/Learner/Quiz/Take.aspx?quizId=1";
        }
    }
}