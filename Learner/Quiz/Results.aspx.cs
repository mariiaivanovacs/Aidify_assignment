using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Quiz
{
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy data
                lblQuizTitle.Text = "C# Fundamentals Quiz";

                int score = 67;
                int passingPct = 70;

                lblScore.Text = score + "%";
                lblPassingPct.Text = "passing score: " + passingPct + "%";

                bool passeed = score >= passingPct;
                if (passeed)
                {
                    lblVerdict.Text = "PASSED!!!";
                    lblVerdict.CssClass += " bg-success";
                    pnlPassed.Visible = true;
                    lnkDownloadCert.NavigateUrl = "~/Learner/Certificate.aspx?moduleId=1";
                }

                else
                {
                    lblVerdict.Text = "FAILED";
                    lblVerdict.CssClass += " bg-danger";
                    pnlFailed.Visible = true;
                    lnkRetakeQuiz.NavigateUrl = "~/Learner/Quiz/Take.aspx?quizId=1";
                }

                lnkBackToLesson.NavigateUrl = "~/Learner/Courses/Lesson.aspx?lessonId=1";

                //Dummy feedback
                var feedback = new[]
                {
                    new { QuestionText = "What is the correct way to declare an integer in C#?",
                        YourAnswer = "integer x = 5;", CorrectAnswer = "int x = 5;",
                        IsCorrect = false, Explanation = "In C#, the correct keyword is 'int' not 'integer'." },
                    new { QuestionText = "Which keyword is used to define a class in C#?",
                        YourAnswer = "class", CorrectAnswer = "class",
                        IsCorrect = true, Explanation = "Correct! 'class' is the keyword used to define a class." },
                    new { QuestionText = "What does 'bool' store?",
                        YourAnswer = "True or False", CorrectAnswer = "True or False",
                        IsCorrect = true, Explanation = "Correct! A bool stores a true or false value." },
                };

                rptFeedback.DataSource = feedback;
                rptFeedback.DataBind();
            }
        }
    }
}