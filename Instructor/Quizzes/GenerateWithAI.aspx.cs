using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class GenerateWithAI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mvWizard.ActiveViewIndex = 0;
                BindQuizzes();
                BindGeneratedQuestions();
                SetLinks();
                fuKnowledge.Attributes["accept"] = ".txt,.md";
            }
        }

        protected void btnGenerateAI_Click(object sender, EventArgs e)
        {
            mvWizard.ActiveViewIndex = 1;
            BindGeneratedQuestions();
            mvWizard.ActiveViewIndex = 2;
        }

        protected void btnSaveKeptQuestions_Click(object sender, EventArgs e)
        {
            lblSaveSuccess.Text = "Questions saved successfully.";
            mvWizard.ActiveViewIndex = 3;
        }

        protected void btnDiscardAll_Click(object sender, EventArgs e)
        {
            lblSaveSuccess.Text = "All generated questions were discarded.";
            mvWizard.ActiveViewIndex = 3;
        }

        private void BindQuizzes()
        {
            ddlTargetQuiz.Items.Clear();
            ddlTargetQuiz.Items.Add(new ListItem("Select a quiz", string.Empty));
            ddlTargetQuiz.Items.Add(new ListItem("Nutrition Basics Quiz", "1"));
            ddlTargetQuiz.Items.Add(new ListItem("Wellness Check-In Quiz", "2"));
        }

        private void BindGeneratedQuestions()
        {
            var questions = new List<GeneratedQuestion>
            {
                new GeneratedQuestion { QuestionText = "What is the main role of protein in the body?", Keep = true },
                new GeneratedQuestion { QuestionText = "Name one benefit of daily hydration.", Keep = true },
                new GeneratedQuestion { QuestionText = "True or False: Fiber helps digestion.", Keep = false }
            };

            rptGeneratedQuestions.DataSource = questions;
            rptGeneratedQuestions.DataBind();
        }

        private void SetLinks()
        {
            lnkEditQuiz.NavigateUrl = "~/Instructor/Quizzes/Edit.aspx";
            lnkGenerateMore.NavigateUrl = "~/Instructor/Quizzes/GenerateWithAI.aspx";
            lnkDashboard.NavigateUrl = "~/Instructor/Dashboard.aspx";
            lnkDashboardFooter.NavigateUrl = "~/Instructor/Dashboard.aspx";
        }

        private class GeneratedQuestion
        {
            public string QuestionText { get; set; }
            public bool Keep { get; set; }
        }
    }
}
