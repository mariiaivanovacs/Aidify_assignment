using System;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Lessons
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblLessonStatus.Text = string.Empty;
                int id;
                if (int.TryParse(Request.QueryString["lessonId"], out id) && id > 0)
                    LoadLesson(id);
            }
        }

        private void LoadLesson(int id)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT Title, BodyHtml, SequenceOrder, EstimatedMinutes, ModuleId FROM Lessons WHERE LessonId=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                using (var r = cmd.ExecuteReader())
                {
                    if (!r.Read()) return;
                    hfLessonId.Value          = id.ToString();
                    hfModuleId.Value          = r["ModuleId"].ToString();
                    txtLessonTitle.Text       = r["Title"].ToString();
                    txtLessonBody.Text        = r["BodyHtml"] == DBNull.Value ? "" : r["BodyHtml"].ToString();
                    txtSequenceOrder.Text     = r["SequenceOrder"].ToString();
                    txtEstimatedMinutes.Text  = r["EstimatedMinutes"] == DBNull.Value ? "" : r["EstimatedMinutes"].ToString();
                }
            }
        }

        protected void btnSaveLesson_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int userId   = AuthHelper.GetUserId();
            string title = txtLessonTitle.Text.Trim();
            string body  = txtLessonBody.Text.Trim();
            int seq = 0, mins = 0;
            int.TryParse(txtSequenceOrder.Text,    out seq);
            int.TryParse(txtEstimatedMinutes.Text, out mins);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    int lessonId;
                    if (int.TryParse(hfLessonId.Value, out lessonId) && lessonId > 0)
                    {
                        var cmd = new SqlCommand(
                            "UPDATE Lessons SET Title=@T, BodyHtml=@B, SequenceOrder=@S, EstimatedMinutes=@M WHERE LessonId=@Id",
                            conn, tx);
                        cmd.Parameters.AddWithValue("@T",  title);
                        cmd.Parameters.AddWithValue("@B",  body);
                        cmd.Parameters.AddWithValue("@S",  seq);
                        cmd.Parameters.AddWithValue("@M",  mins);
                        cmd.Parameters.AddWithValue("@Id", lessonId);
                        cmd.ExecuteNonQuery();
                        AuditService.Log(userId, "UpdateLesson", "Lessons", lessonId, conn, tx);
                    }
                    else
                    {
                        int moduleId;
                        int.TryParse(hfModuleId.Value, out moduleId);
                        var cmd = new SqlCommand(
                            "INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) " +
                            "OUTPUT INSERTED.LessonId VALUES (@Mid, @T, @B, @S, @M)", conn, tx);
                        cmd.Parameters.AddWithValue("@Mid", moduleId > 0 ? (object)moduleId : DBNull.Value);
                        cmd.Parameters.AddWithValue("@T",   title);
                        cmd.Parameters.AddWithValue("@B",   body);
                        cmd.Parameters.AddWithValue("@S",   seq);
                        cmd.Parameters.AddWithValue("@M",   mins);
                        lessonId = (int)cmd.ExecuteScalar();
                        hfLessonId.Value = lessonId.ToString();
                        AuditService.Log(userId, "CreateLesson", "Lessons", lessonId, conn, tx);
                    }
                    tx.Commit();
                }
            }

            lblLessonStatus.CssClass = "text-success d-block";
            lblLessonStatus.Text     = "Lesson saved successfully.";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Instructor/Dashboard.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
