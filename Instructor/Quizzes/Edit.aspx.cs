using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        private int QuizId
        {
            get { int v; return int.TryParse(hfQuizId.Value, out v) ? v : 0; }
            set { hfQuizId.Value = value.ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblQuizStatus.Text = string.Empty;
                BindModules();
                int id;
                if (int.TryParse(Request.QueryString["quizId"], out id) && id > 0)
                {
                    QuizId = id;
                    LoadQuiz(id);
                    BindQuestions(id);
                }
            }
        }

        private void BindModules()
        {
            int userId = AuthHelper.GetUserId();
            ddlLinkedModule.Items.Clear();
            ddlLinkedModule.Items.Add(new ListItem("— Select a module —", ""));
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT ModuleId, Title FROM Modules WHERE CreatedBy=@U AND IsDeleted=0 ORDER BY Title", conn);
                cmd.Parameters.AddWithValue("@U", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        ddlLinkedModule.Items.Add(
                            new ListItem(r["Title"].ToString(), r["ModuleId"].ToString()));
            }
        }

        private void LoadQuiz(int id)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT Title, Description, ModuleId, TimeLimitSec, PassingPct FROM Quizzes WHERE QuizId=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return;
                    txtQuizTitle.Text       = r["Title"].ToString();
                    txtQuizDescription.Text = r["Description"] == DBNull.Value ? "" : r["Description"].ToString();
                    txtTimeLimitSec.Text    = r["TimeLimitSec"] == DBNull.Value ? "" : r["TimeLimitSec"].ToString();
                    txtPassingPct.Text      = r["PassingPct"].ToString();
                    if (r["ModuleId"] != DBNull.Value)
                    {
                        var item = ddlLinkedModule.Items.FindByValue(r["ModuleId"].ToString());
                        if (item != null) item.Selected = true;
                    }
                }
            }
        }

        private void BindQuestions(int quizId)
        {
            var rows = new List<QuestionItem>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT QuestionId, QuestionText, QuestionType, Points FROM Questions WHERE QuizId=@Q ORDER BY QuestionId", conn);
                cmd.Parameters.AddWithValue("@Q", quizId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        rows.Add(new QuestionItem {
                            QuestionText = r["QuestionText"].ToString(),
                            Detail       = "Type: " + r["QuestionType"],
                            Points       = (int)r["Points"]
                        });
            }
            rptQuestions.DataSource = rows;
            rptQuestions.DataBind();
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int userId = AuthHelper.GetUserId();
            string title  = txtQuizTitle.Text.Trim();
            string desc   = txtQuizDescription.Text.Trim();
            int timeLim = 0, passingPct = 70, moduleId = 0;
            int.TryParse(txtTimeLimitSec.Text, out timeLim);
            int.TryParse(txtPassingPct.Text,   out passingPct);
            int.TryParse(ddlLinkedModule.SelectedValue, out moduleId);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    if (QuizId == 0)
                    {
                        var ins = new SqlCommand(@"
                            INSERT INTO Quizzes (Title, Description, ModuleId, TimeLimitSec, PassingPct)
                            OUTPUT INSERTED.QuizId
                            VALUES (@T, @D, @M, @TL, @PP)", conn, tx);
                        ins.Parameters.AddWithValue("@T",  title);
                        ins.Parameters.AddWithValue("@D",  desc);
                        ins.Parameters.AddWithValue("@M",  moduleId > 0 ? (object)moduleId : DBNull.Value);
                        ins.Parameters.AddWithValue("@TL", timeLim > 0  ? (object)timeLim  : DBNull.Value);
                        ins.Parameters.AddWithValue("@PP", passingPct);
                        QuizId = (int)ins.ExecuteScalar();
                        AuditService.Log(userId, "CreateQuiz", "Quizzes", QuizId, conn, tx);
                    }
                    else
                    {
                        var upd = new SqlCommand(@"
                            UPDATE Quizzes SET Title=@T, Description=@D, ModuleId=@M,
                                TimeLimitSec=@TL, PassingPct=@PP WHERE QuizId=@Id", conn, tx);
                        upd.Parameters.AddWithValue("@T",  title);
                        upd.Parameters.AddWithValue("@D",  desc);
                        upd.Parameters.AddWithValue("@M",  moduleId > 0 ? (object)moduleId : DBNull.Value);
                        upd.Parameters.AddWithValue("@TL", timeLim > 0  ? (object)timeLim  : DBNull.Value);
                        upd.Parameters.AddWithValue("@PP", passingPct);
                        upd.Parameters.AddWithValue("@Id", QuizId);
                        upd.ExecuteNonQuery();
                        AuditService.Log(userId, "UpdateQuiz", "Quizzes", QuizId, conn, tx);
                    }
                    tx.Commit();
                }
            }

            lblQuizStatus.CssClass = "text-success d-block";
            lblQuizStatus.Text     = "Quiz saved successfully.";
            if (QuizId > 0) BindQuestions(QuizId);
        }

        protected void btnSaveQuestion_Click(object sender, EventArgs e)
        {
            if (QuizId == 0) { btnSaveQuiz_Click(sender, e); if (QuizId == 0) return; }

            int userId = AuthHelper.GetUserId();
            string qText = txtQuestionText.Text.Trim();
            string qType = ddlQuestionType.SelectedValue;
            int pts = 1;
            int.TryParse(txtPoints.Text, out pts);

            string[] options = {
                txtOption1.Text.Trim(),
                txtOption2.Text.Trim(),
                txtOption3.Text.Trim(),
                txtOption4.Text.Trim()
            };
            int correctIdx;
            int.TryParse(ddlCorrectOption.SelectedValue, out correctIdx);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    var qi = new SqlCommand(@"
                        INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points)
                        OUTPUT INSERTED.QuestionId
                        VALUES (@Q, @T, @Tp, @P)", conn, tx);
                    qi.Parameters.AddWithValue("@Q",  QuizId);
                    qi.Parameters.AddWithValue("@T",  qText);
                    qi.Parameters.AddWithValue("@Tp", qType);
                    qi.Parameters.AddWithValue("@P",  pts);
                    int questionId = (int)qi.ExecuteScalar();

                    for (int i = 0; i < options.Length; i++)
                    {
                        if (string.IsNullOrWhiteSpace(options[i])) continue;
                        var oi = new SqlCommand(
                            "INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES (@Q, @T, @C)",
                            conn, tx);
                        oi.Parameters.AddWithValue("@Q", questionId);
                        oi.Parameters.AddWithValue("@T", options[i]);
                        oi.Parameters.AddWithValue("@C", i == correctIdx);
                        oi.ExecuteNonQuery();
                    }

                    AuditService.Log(userId, "AddQuestion", "Questions", questionId, conn, tx);
                    tx.Commit();
                }
            }

            txtQuestionText.Text = "";
            txtOption1.Text = txtOption2.Text = txtOption3.Text = txtOption4.Text = "";
            txtPoints.Text  = "1";
            lblQuizStatus.CssClass = "text-success d-block";
            lblQuizStatus.Text     = "Question added successfully.";
            BindQuestions(QuizId);
        }

        private class QuestionItem { public string QuestionText, Detail; public int Points; }
    }
}
