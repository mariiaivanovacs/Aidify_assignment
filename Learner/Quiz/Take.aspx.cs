using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Quiz
{
    public partial class Take : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy data
                lblQuizTitle.Text = "C# Fundamentals Quiz";
                lblQuizDescription.Text = "Test your knowledge of C# basics.";
                hfQuizId.Value = "1";
                hfTimeLimitSec.Value = "600";

                var questions = new[]
                {
                    new { QuestionId = 1, QuestionText = "What is the correct way to declare an integer in C#?",
                        Option1 = "int x = 5;", Option2 = "integer x = 5;",
                        Option3 = "var x = 5.0;", Option4 = "Int x = 5;" },
                    new { QuestionId = 2, QuestionText = "Which keyword is used to define a class in C#?",
                        Option1 = "define", Option2 = "struct",
                        Option3 = "class", Option4 = "object" },
                    new { QuestionId = 3, QuestionText = "What does 'bool' store?",
                        Option1 = "Numbers", Option2 = "Text",
                        Option3 = "True or False", Option4 = "Decimal values" },
                };

                rptQuestions.DataSource = questions;
                rptQuestions.DataBind();
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Learner/Quiz/Result.aspx?attemptId=1");
        }
    }
}