using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor
{
    public partial class Discussions : InstructorBasePage
    {

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();
                LoadModuleFilter();
                LoadThreads();
                LoadDiscussionStats();
            }
        }

        protected void btnCreateThread_Click(object sender, EventArgs e)
        {
            ClearMessage();

            if (string.IsNullOrWhiteSpace(ddlModule.SelectedValue))
            {
                ShowMessage("Please select a module.", false);
                return;
            }

            string title = txtThreadTitle.Text.Trim();
            string body = txtThreadBody.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the thread title.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(body))
            {
                ShowMessage("Please enter the thread body.", false);
                return;
            }

            int moduleId = Convert.ToInt32(ddlModule.SelectedValue);

            if (!InstructorOwnsModule(moduleId))
            {
                ShowMessage("Invalid module selected.", false);
                return;
            }

            try
            {
                int threadId = InsertThread(moduleId, InstructorUserId, title, body);
                AuditService.Log(InstructorUserId, "CreateDiscussionThread", "DiscussionThreads", threadId);

                ClearThreadForm();
                LoadThreads();
                LoadDiscussionStats();

                ShowMessage("Discussion thread created successfully.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error while creating discussion: " + ex.Message, false);
            }
        }

        protected void btnClearThread_Click(object sender, EventArgs e)
        {
            ClearThreadForm();
            ShowMessage("Form cleared.", true);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            ClearMessage();

            LoadModules();
            LoadModuleFilter();

            if (ddlModuleFilter.Items.FindByValue("All") != null)
            {
                ddlModuleFilter.SelectedValue = "All";
            }

            LoadThreads();
            LoadDiscussionStats();

            ShowMessage("Discussions refreshed successfully.", true);
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            ClearMessage();
            LoadThreads();
            LoadDiscussionStats();
        }

        protected void rptThreads_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int threadId))
            {
                ShowMessage("Invalid thread selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "AddReply")
                {
                    TextBox txtReplyBody = e.Item.FindControl("txtReplyBody") as TextBox;

                    if (txtReplyBody == null || string.IsNullOrWhiteSpace(txtReplyBody.Text.Trim()))
                    {
                        ShowMessage("Please write a reply before submitting.", false);
                        return;
                    }

                    if (!InstructorOwnsThread(threadId))
                    {
                        ShowMessage("Invalid thread selected.", false);
                        return;
                    }

                    int replyId = InsertReply(threadId, InstructorUserId, txtReplyBody.Text.Trim());
                    AuditService.Log(InstructorUserId, "CreateDiscussionReply", "DiscussionReplies", replyId);

                    LoadThreads();
                    LoadDiscussionStats();

                    ShowMessage("Reply added successfully.", true);
                }
                else if (e.CommandName == "DeleteThread")
                {
                    DeleteThread(threadId);

                    LoadThreads();
                    LoadDiscussionStats();

                    ShowMessage("Thread deleted successfully.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing discussion: " + ex.Message, false);
            }
        }

        protected void rptReplies_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int replyId))
            {
                ShowMessage("Invalid reply selected.", false);
                return;
            }

            try
            {
                DeleteReply(replyId);

                LoadThreads();
                LoadDiscussionStats();

                ShowMessage("Reply deleted successfully.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error while deleting reply: " + ex.Message, false);
            }
        }

        private void LoadModules()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT ModuleId, Title
                    FROM dbo.Modules
                    WHERE CreatedBy = @CreatedBy AND IsDeleted = 0
                    ORDER BY Title;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        ddlModule.Items.Clear();
                        ddlModule.Items.Add(new ListItem("Select Module", ""));

                        foreach (DataRow row in table.Rows)
                        {
                            ddlModule.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["ModuleId"])
                            ));
                        }
                    }
                }
            }
        }

        private void LoadModuleFilter()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT ModuleId, Title
                    FROM dbo.Modules
                    WHERE CreatedBy = @CreatedBy AND IsDeleted = 0
                    ORDER BY Title;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        ddlModuleFilter.Items.Clear();
                        ddlModuleFilter.Items.Add(new ListItem("All Modules", "All"));

                        foreach (DataRow row in table.Rows)
                        {
                            ddlModuleFilter.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["ModuleId"])
                            ));
                        }
                    }
                }
            }
        }

        private void LoadThreads()
        {
            string moduleFilter = "All";

            if (ddlModuleFilter.Items.Count > 0 && !string.IsNullOrWhiteSpace(ddlModuleFilter.SelectedValue))
            {
                moduleFilter = ddlModuleFilter.SelectedValue;
            }

            int moduleId = moduleFilter == "All" ? 0 : Convert.ToInt32(moduleFilter);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        t.ThreadId,
                        t.ModuleId,
                        t.UserId,
                        ISNULL(t.Title, '-') AS Title,
                        ISNULL(t.Body, '-') AS Body,
                        t.CreatedAt,
                        ISNULL(m.Title, '-') AS ModuleTitle,
                        ISNULL(u.FullName, 'Instructor') AS UserName,
                        (
                            SELECT COUNT(*)
                            FROM dbo.DiscussionReplies r
                            WHERE r.ThreadId = t.ThreadId
                        ) AS ReplyCount
                    FROM dbo.DiscussionThreads t
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    LEFT JOIN dbo.Users u ON t.UserId = u.UserId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@ModuleId = 0 OR t.ModuleId = @ModuleId)
                    ORDER BY t.CreatedAt DESC, t.ThreadId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptThreads.DataSource = table;
                        rptThreads.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                    }
                }
            }
        }

        private void LoadDiscussionStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(DISTINCT t.ThreadId) AS TotalThreads,
                        COUNT(r.ReplyId) AS TotalReplies,
                        COUNT(DISTINCT t.ModuleId) AS ModulesDiscussed
                    FROM dbo.DiscussionThreads t
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    LEFT JOIN dbo.DiscussionReplies r ON t.ThreadId = r.ThreadId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalThreads.Text = Convert.ToString(reader["TotalThreads"] == DBNull.Value ? 0 : reader["TotalThreads"]);
                            lblTotalReplies.Text = Convert.ToString(reader["TotalReplies"] == DBNull.Value ? 0 : reader["TotalReplies"]);
                            lblModulesDiscussed.Text = Convert.ToString(reader["ModulesDiscussed"] == DBNull.Value ? 0 : reader["ModulesDiscussed"]);
                        }
                    }
                }
            }
        }

        protected DataTable GetReplies(object threadIdValue)
        {
            int threadId = Convert.ToInt32(threadIdValue);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        r.ReplyId,
                        r.ThreadId,
                        r.UserId,
                        ISNULL(r.Body, '-') AS Body,
                        r.CreatedAt,
                        ISNULL(u.FullName, 'Instructor') AS UserName
                    FROM dbo.DiscussionReplies r
                    LEFT JOIN dbo.Users u ON r.UserId = u.UserId
                    WHERE r.ThreadId = @ThreadId
                    ORDER BY r.CreatedAt ASC, r.ReplyId ASC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ThreadId", threadId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        return table;
                    }
                }
            }
        }

        private int InsertThread(int moduleId, int userId, string title, string body)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.DiscussionThreads
                        (ModuleId, UserId, Title, Body, CreatedAt)
                    VALUES
                        (@ModuleId, @UserId, @Title, @Body, GETDATE());

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Body", body);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private int InsertReply(int threadId, int userId, string body)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.DiscussionReplies
                        (ThreadId, UserId, Body, CreatedAt)
                    VALUES
                        (@ThreadId, @UserId, @Body, GETDATE());

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ThreadId", threadId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Body", body);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void DeleteThread(int threadId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE r
                    FROM dbo.DiscussionReplies r
                    INNER JOIN dbo.DiscussionThreads t ON r.ThreadId = t.ThreadId
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    WHERE t.ThreadId = @ThreadId
                      AND m.CreatedBy = @CreatedBy;

                    DELETE t
                    FROM dbo.DiscussionThreads t
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    WHERE t.ThreadId = @ThreadId
                      AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ThreadId", threadId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteReply(int replyId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    DELETE r
                    FROM dbo.DiscussionReplies r
                    INNER JOIN dbo.DiscussionThreads t ON r.ThreadId = t.ThreadId
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    WHERE r.ReplyId = @ReplyId
                      AND m.CreatedBy = @CreatedBy;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ReplyId", replyId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool InstructorOwnsModule(int moduleId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.Modules
                    WHERE ModuleId = @ModuleId
                      AND CreatedBy = @CreatedBy
                      AND IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }

        private bool InstructorOwnsThread(int threadId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.DiscussionThreads t
                    INNER JOIN dbo.Modules m ON t.ModuleId = m.ModuleId
                    WHERE t.ThreadId = @ThreadId
                      AND m.CreatedBy = @CreatedBy
                      AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ThreadId", threadId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }

        private void ClearThreadForm()
        {
            if (ddlModule.Items.Count > 0)
            {
                ddlModule.SelectedIndex = 0;
            }

            txtThreadTitle.Text = "";
            txtThreadBody.Text = "";
        }

        private void ShowMessage(string message, bool success)
        {
            lblDiscussionStatus.Visible = true;
            lblDiscussionStatus.Text = message;
            lblDiscussionStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblDiscussionStatus.Visible = false;
            lblDiscussionStatus.Text = "";
            lblDiscussionStatus.CssClass = "";
        }

        protected string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "-";
            }

            DateTime date = Convert.ToDateTime(value);
            return date.ToString("yyyy-MM-dd HH:mm");
        }
    }
}
