using System;
using System.Collections.Generic;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblQuizStatus.Text = string.Empty;
                BindModules();
                BindQuestions();
            }
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            lblQuizStatus.CssClass = "text-success d-block";
            lblQuizStatus.Text = "Quiz saved (temporary).";
        }

        protected void btnSaveQuestion_Click(object sender, EventArgs e)
        {
            lblQuizStatus.CssClass = "text-success d-block";
            lblQuizStatus.Text = "Question saved (temporary).";
        }

        private void BindModules()
        {
            ddlLinkedModule.Items.Clear();
            ddlLinkedModule.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select a module --", string.Empty));
            ddlLinkedModule.Items.Add(new System.Web.UI.WebControls.ListItem("Foundations of Health", "1"));
            ddlLinkedModule.Items.Add(new System.Web.UI.WebControls.ListItem("Advanced Nutrition", "2"));
        }

        private void BindQuestions()
        {
            var questions = new List<QuestionItem>
            {
                new QuestionItem
                {
                    QuestionText = "What is the recommended daily water intake?",
                    Detail = "Type: MCQ · Correct: Option 2",
                    Points = 5
                },
                new QuestionItem
                {
                    QuestionText = "True or False: Fiber aids digestion.",
                    Detail = "Type: True/False · Correct: True",
                    Points = 3
                }
            };

            rptQuestions.DataSource = questions;
            rptQuestions.DataBind();
        }

        private class QuestionItem
        {
            public string QuestionText { get; set; }
            public string Detail { get; set; }
            public int Points { get; set; }
        }
    }
}
