using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class GenerateWithAI : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mvWizard.ActiveViewIndex = 0;
                BindQuizDropdown();
                SetDoneLinks();
                fuKnowledge.Attributes["accept"] = ".txt,.md";
            }
        }

        // ── Step 1 → 2/3: user clicks "Initiate AI Generation" ──────────────

        protected void btnGenerateAI_Click(object sender, EventArgs e)
        {
            // Rate limit: max 20 AI calls per hour per session
            var count       = (int)(Session["AiCallCount"]        ?? 0);
            var windowStart = (Session["AiCallWindowStart"] as DateTime?) ?? DateTime.UtcNow;
            if (DateTime.UtcNow - windowStart > TimeSpan.FromHours(1))
            {
                count       = 0;
                windowStart = DateTime.UtcNow;
                Session["AiCallWindowStart"] = windowStart;
            }
            if (count >= 20)
            {
                ShowGeneratingError("AI rate limit reached (20 calls/hour). Please try again later.");
                return;
            }
            Session["AiCallCount"] = count + 1;

            // Validate file
            if (!fuKnowledge.HasFile)
            {
                ShowGeneratingError("Please upload a knowledge file (.txt or .md).");
                return;
            }

            // Validate question count
            int questionCount;
            if (!int.TryParse(txtNumQuestions.Text, out questionCount) ||
                questionCount < 1 || questionCount > 20)
                questionCount = 5;

            // Validate quiz selection
            var quizIdStr = ddlTargetQuiz.SelectedValue;
            int quizId    = 0;
            if (!string.IsNullOrEmpty(quizIdStr) && !int.TryParse(quizIdStr, out quizId))
                quizId = 0;

            if (quizId <= 0)
            {
                ShowGeneratingError("Please select a target quiz before generating.");
                return;
            }

            var difficulty = ddlAIDifficulty.SelectedValue;

            // Show "generating" spinner view while working
            mvWizard.ActiveViewIndex = 1;

            // Read uploaded file (cap at 30 000 chars to stay within token limits)
            string text;
            using (var reader = new StreamReader(
                fuKnowledge.PostedFile.InputStream, Encoding.UTF8))
                text = reader.ReadToEnd();

            if (string.IsNullOrWhiteSpace(text))
            {
                ShowGeneratingError("The uploaded file is empty.");
                return;
            }
            if (text.Length > 30000) text = text.Substring(0, 30000);

            // Call Gemini synchronously — Task.Run avoids the ASP.NET sync-context deadlock
            var service   = new AIContentService();
            var questions = Task.Run(() =>
                service.GenerateQuestionsAsync(text, questionCount, difficulty)
            ).GetAwaiter().GetResult();

            if (questions == null || questions.Count == 0)
            {
                ShowGeneratingError(
                    "AI returned no questions. Check your Gemini API key in Web.config or try a shorter file.");
                return;
            }

            // Store in session so save handler can read them
            Session["GeneratedQuestions"] = questions;
            Session["GeneratedFileName"]  = fuKnowledge.FileName;
            Session["GeneratedQuizId"]    = quizId;

            // Bind preview repeater and advance to review step
            rptGeneratedQuestions.DataSource = questions;
            rptGeneratedQuestions.DataBind();
            mvWizard.ActiveViewIndex = 2;
        }

        // ── Step 3 → 4: save all previewed questions to the DB ───────────────

        protected void btnSaveKeptQuestions_Click(object sender, EventArgs e)
        {
            var questions = Session["GeneratedQuestions"] as List<GeneratedQuestion>;
            var fileName  = Session["GeneratedFileName"]  as string ?? "";
            var quizId    = Session["GeneratedQuizId"] is int qId ? qId : 0;

            if (questions == null || questions.Count == 0)
            {
                lblSaveSuccess.Text = "No questions to save.";
                mvWizard.ActiveViewIndex = 3;
                return;
            }

            if (quizId <= 0)
            {
                lblSaveSuccess.Text = "No target quiz was selected — questions were not saved.";
                mvWizard.ActiveViewIndex = 3;
                return;
            }

            int userId = AuthHelper.GetUserId();
            var repo   = new QuizRepository();
            int saved  = 0;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    try
                    {
                        foreach (var q in questions)
                        {
                            if (string.IsNullOrWhiteSpace(q.Question)) continue;

                            int questionId = repo.AddQuestion(quizId, q.Question, conn, tx);

                            if (q.Options != null)
                                foreach (var opt in q.Options)
                                    repo.AddOption(questionId, opt.Text, opt.IsCorrect, conn, tx);

                            saved++;
                        }

                        AuditService.Log(userId, "AIGenerateQuestions", "Quizzes", quizId,
                                         conn, tx);
                        tx.Commit();
                    }
                    catch
                    {
                        tx.Rollback();
                        lblSaveSuccess.Text = "A database error occurred. Questions were not saved.";
                        mvWizard.ActiveViewIndex = 3;
                        return;
                    }
                }
            }

            // Write audit row for AI task (outside the question transaction)
            repo.SaveAITask(quizId, fileName,
                "(QuizGenerator.txt prompt)",
                JsonConvert.SerializeObject(questions),
                userId);

            Session.Remove("GeneratedQuestions");
            Session.Remove("GeneratedFileName");
            Session.Remove("GeneratedQuizId");

            lblSaveSuccess.Text = saved + " question(s) saved to your quiz successfully.";
            mvWizard.ActiveViewIndex = 3;
        }

        // ── Step 3 → 4: discard everything ──────────────────────────────────

        protected void btnDiscardAll_Click(object sender, EventArgs e)
        {
            Session.Remove("GeneratedQuestions");
            Session.Remove("GeneratedFileName");
            Session.Remove("GeneratedQuizId");

            lblSaveSuccess.Text = "All generated questions were discarded.";
            mvWizard.ActiveViewIndex = 3;
        }

        // ── Helpers ──────────────────────────────────────────────────────────

        private void BindQuizDropdown()
        {
            ddlTargetQuiz.Items.Clear();
            ddlTargetQuiz.Items.Add(new ListItem("— Select a quiz —", ""));

            int userId = AuthHelper.GetUserId();
            if (userId > 0)
            {
                var quizzes = new QuizRepository().GetByInstructor(userId);
                foreach (var q in quizzes)
                    ddlTargetQuiz.Items.Add(new ListItem(q.Title, q.QuizId.ToString()));
            }
        }

        private void SetDoneLinks()
        {
            lnkEditQuiz.NavigateUrl        = "~/Instructor/Quizzes/Edit.aspx";
            lnkGenerateMore.NavigateUrl    = "~/Instructor/Quizzes/GenerateWithAI.aspx";
            lnkDashboard.NavigateUrl       = "~/Instructor/Dashboard.aspx";
            lnkDashboardFooter.NavigateUrl = "~/Instructor/Dashboard.aspx";
        }

        // Shows error in the "generating" spinner view
        private void ShowGeneratingError(string message)
        {
            lblGenerating.Text       = message;
            mvWizard.ActiveViewIndex = 1;
        }
    }
}
