using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner.Quiz
{
    public partial class Take : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadQuiz();
        }

        private void LoadQuiz()
        {
            int quizId;
            if (!int.TryParse(Request.QueryString["quizId"], out quizId)) return;

            var questions = new List<QuizRow>();
            var correctMap = new Dictionary<int, int>();
            var optionIdMap = new Dictionary<int, int[]>();
            var questionTypeMap = new Dictionary<int, string>();
            var shortAnswerMap = new Dictionary<int, string>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();

                var qc = new SqlCommand(
                    "SELECT Title, Description, TimeLimitSec FROM Quizzes WHERE QuizId = @Id", conn);
                qc.Parameters.AddWithValue("@Id", quizId);
                using (var r = qc.ExecuteReader())
                {
                    if (!r.Read()) return;
                    lblQuizTitle.Text = r["Title"].ToString();
                    lblQuizDescription.Text = r["Description"] == DBNull.Value ? "" : r["Description"].ToString();
                    hfQuizId.Value = quizId.ToString();
                    int tl = r["TimeLimitSec"] != DBNull.Value ? (int)r["TimeLimitSec"] : 0;
                    hfTimeLimitSec.Value = tl.ToString();
                }

                var oc = new SqlCommand(@"
                    SELECT q.QuestionId, q.QuestionText, q.QuestionType,
                           MAX(CASE WHEN rn=1 THEN o.OptionText END) AS Option1,
                           MAX(CASE WHEN rn=2 THEN o.OptionText END) AS Option2,
                           MAX(CASE WHEN rn=3 THEN o.OptionText END) AS Option3,
                           MAX(CASE WHEN rn=4 THEN o.OptionText END) AS Option4,
                           MAX(CASE WHEN rn=1 THEN o.OptionId END) AS OptionId1,
                           MAX(CASE WHEN rn=2 THEN o.OptionId END) AS OptionId2,
                           MAX(CASE WHEN rn=3 THEN o.OptionId END) AS OptionId3,
                           MAX(CASE WHEN rn=4 THEN o.OptionId END) AS OptionId4,
                           MAX(CASE WHEN o.IsCorrect=1 THEN rn END)-1 AS CorrectIdx,
                           MAX(CASE WHEN o.IsCorrect=1 THEN o.OptionText END) AS CorrectText
                    FROM   Questions q
                    CROSS APPLY (
                        SELECT OptionId, OptionText, IsCorrect,
                               ROW_NUMBER() OVER (ORDER BY OptionId) AS rn
                        FROM   Options WHERE QuestionId = q.QuestionId
                    ) o
                    WHERE  q.QuizId = @QuizId
                    GROUP BY q.QuestionId, q.QuestionText, q.QuestionType
                    ORDER BY q.QuestionId", conn);
                oc.Parameters.AddWithValue("@QuizId", quizId);
                using (var r = oc.ExecuteReader())
                    while (r.Read())
                    {
                        int qid = (int)r["QuestionId"];
                        int ci = r["CorrectIdx"] != DBNull.Value ? (int)(long)r["CorrectIdx"] : 0;
                        questions.Add(new QuizRow
                        {
                            QuestionId = qid,
                            QuestionText = r["QuestionText"].ToString(),
                            QuestionType = r["QuestionType"] == DBNull.Value ? "MCQ" : r["QuestionType"].ToString(),
                            Option1 = r["Option1"]?.ToString() ?? "",
                            Option2 = r["Option2"]?.ToString() ?? "",
                            Option3 = r["Option3"]?.ToString() ?? "",
                            Option4 = r["Option4"]?.ToString() ?? ""
                        });
                        correctMap[qid] = ci;
                        questionTypeMap[qid] = questions[questions.Count - 1].QuestionType;
                        shortAnswerMap[qid] = r["CorrectText"] == DBNull.Value ? "" : r["CorrectText"].ToString();
                        optionIdMap[qid] = new[]
                        {
                            r["OptionId1"] != DBNull.Value ? Convert.ToInt32(r["OptionId1"]) : 0,
                            r["OptionId2"] != DBNull.Value ? Convert.ToInt32(r["OptionId2"]) : 0,
                            r["OptionId3"] != DBNull.Value ? Convert.ToInt32(r["OptionId3"]) : 0,
                            r["OptionId4"] != DBNull.Value ? Convert.ToInt32(r["OptionId4"]) : 0
                        };
                    }
            }

            Session["QuizCorrectMap"] = correctMap;
            Session["QuizOptionIdMap"] = optionIdMap;
            Session["QuizQuestionIds"] = questions.ConvertAll(q => q.QuestionId);
            Session["QuizQuestionTypeMap"] = questionTypeMap;
            Session["QuizShortAnswerMap"] = shortAnswerMap;

            rptQuestions.DataSource = questions;
            rptQuestions.DataBind();
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            int userId = AuthHelper.GetUserId();
            int quizId;
            if (!int.TryParse(hfQuizId.Value, out quizId)) return;

            var correctMap = Session["QuizCorrectMap"] as Dictionary<int, int>;
            var optionIdMap = Session["QuizOptionIdMap"] as Dictionary<int, int[]>;
            var questionTypeMap = Session["QuizQuestionTypeMap"] as Dictionary<int, string>;
            var shortAnswerMap = Session["QuizShortAnswerMap"] as Dictionary<int, string>;
            var questionIds = Session["QuizQuestionIds"] as List<int>;
            if (correctMap == null || optionIdMap == null || questionTypeMap == null || shortAnswerMap == null || questionIds == null) return;

            int correct = 0, total = 0;
            var answers = new List<AnswerRow>();

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                if (item.ItemIndex >= questionIds.Count) continue;
                int questionId = questionIds[item.ItemIndex];

                var rb0 = (RadioButton)item.FindControl("rbOption_0");
                var rb1 = (RadioButton)item.FindControl("rbOption_1");
                var rb2 = (RadioButton)item.FindControl("rbOption_2");
                var rb3 = (RadioButton)item.FindControl("rbOption_3");
                var txtShortAnswer = (TextBox)item.FindControl("txtShortAnswer");

                string questionType = questionTypeMap.ContainsKey(questionId) ? questionTypeMap[questionId] : "MCQ";
                string answerText = txtShortAnswer == null ? "" : txtShortAnswer.Text.Trim();
                bool isShortAnswer = string.Equals(questionType, "ShortAnswer", StringComparison.OrdinalIgnoreCase);
                int selected = !isShortAnswer && rb0.Checked ? 0 : !isShortAnswer && rb1.Checked ? 1 : !isShortAnswer && rb2.Checked ? 2 : !isShortAnswer && rb3.Checked ? 3 : -1;
                int expectedCorrect = correctMap.ContainsKey(questionId) ? correctMap[questionId] : -1;
                bool ok = isShortAnswer
                    ? NormalizeAnswer(answerText) == NormalizeAnswer(shortAnswerMap.ContainsKey(questionId) ? shortAnswerMap[questionId] : "")
                    : selected >= 0 && selected == expectedCorrect;
                int selectedOptionId = 0;
                int[] optionIds;
                if (selected >= 0 && optionIdMap.TryGetValue(questionId, out optionIds) && selected < optionIds.Length)
                    selectedOptionId = optionIds[selected];

                if (ok) correct++;
                total++;
                answers.Add(new AnswerRow
                {
                    QuestionId = questionId,
                    SelectedOptionId = selectedOptionId,
                    AnswerText = answerText,
                    IsCorrect = ok
                });
            }

            decimal score = total > 0 ? Math.Round(correct * 100m / total, 2) : 0;

            int passingPct = 70;
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var pc = new SqlCommand("SELECT PassingPct FROM Quizzes WHERE QuizId=@Id", conn);
                pc.Parameters.AddWithValue("@Id", quizId);
                var pv = pc.ExecuteScalar();
                if (pv != null) passingPct = (int)pv;
            }

            bool passed = score >= passingPct;
            int attemptId;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var ins = new SqlCommand(@"
                        INSERT INTO QuizAttempts (UserId, QuizId, Score, Passed, IsPopQuiz)
                        OUTPUT INSERTED.AttemptId
                        VALUES (@U, @Q, @S, @P, 0)", conn, tx);
                    ins.Parameters.AddWithValue("@U", userId);
                    ins.Parameters.AddWithValue("@Q", quizId);
                    ins.Parameters.AddWithValue("@S", score);
                    ins.Parameters.AddWithValue("@P", passed);
                    attemptId = (int)ins.ExecuteScalar();

                    foreach (var answer in answers)
                    {
                        var ai = new SqlCommand(@"
                            INSERT INTO AttemptAnswers (AttemptId, QuestionId, SelectedOptionId, AnswerText, IsCorrect)
                            VALUES (@A, @Q, @O, @T, @C)", conn, tx);
                        ai.Parameters.AddWithValue("@A", attemptId);
                        ai.Parameters.AddWithValue("@Q", answer.QuestionId);
                        ai.Parameters.AddWithValue("@O", answer.SelectedOptionId > 0 ? (object)answer.SelectedOptionId : DBNull.Value);
                        ai.Parameters.AddWithValue("@T", string.IsNullOrWhiteSpace(answer.AnswerText) ? (object)DBNull.Value : answer.AnswerText);
                        ai.Parameters.AddWithValue("@C", answer.IsCorrect);
                        ai.ExecuteNonQuery();
                    }

                    if (passed)
                        LeagueService.AddPoints(userId, 10, conn, tx);

                    tx.Commit();
                }
            }

            Session.Remove("QuizCorrectMap");
            Session.Remove("QuizOptionIdMap");
            Session.Remove("QuizQuestionIds");
            Session.Remove("QuizQuestionTypeMap");
            Session.Remove("QuizShortAnswerMap");

            try { new BadgeService().Evaluate(userId); } catch { /* badge failure must never block redirect */ }
            if (passed)
                try { new CertificateService().EnsureForCompletedModule(userId, GetQuizModuleId(quizId)); } catch { /* certificate failure must never block redirect */ }

            Response.Redirect("~/Learner/Quiz/Results.aspx?attemptId=" + attemptId, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private static int GetQuizModuleId(int quizId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT ModuleId FROM Quizzes WHERE QuizId=@QuizId", conn);
                cmd.Parameters.AddWithValue("@QuizId", quizId);
                var result = cmd.ExecuteScalar();
                return result == null || result == DBNull.Value ? 0 : Convert.ToInt32(result);
            }
        }

        private class QuizRow
        {
            public int QuestionId { get; set; }
            public string QuestionText { get; set; }
            public string QuestionType { get; set; }
            public string Option1 { get; set; }
            public string Option2 { get; set; }
            public string Option3 { get; set; }
            public string Option4 { get; set; }
        }

        private class AnswerRow
        {
            public int QuestionId { get; set; }
            public int SelectedOptionId { get; set; }
            public string AnswerText { get; set; }
            public bool IsCorrect { get; set; }
        }

        public bool IsShortAnswer(object value)
        {
            return string.Equals(Convert.ToString(value), "ShortAnswer", StringComparison.OrdinalIgnoreCase);
        }

        private static string NormalizeAnswer(string value)
        {
            return (value ?? string.Empty).Trim().ToLowerInvariant();
        }
    }
}
