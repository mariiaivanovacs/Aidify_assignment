using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Learner
{
    public partial class Discussions : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModules();
                ApplyModuleFromQueryString();
                LoadThreads();
            }
        }

        protected void btnCreateThread_Click(object sender, EventArgs e)
        {
            int moduleId;
            if (!int.TryParse(ddlModule.SelectedValue, out moduleId) || !ModuleIsPublished(moduleId))
            {
                ShowMessage("Please select a valid published module.", false);
                return;
            }

            string title = txtThreadTitle.Text.Trim();
            string body = txtThreadBody.Text.Trim();

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(body))
            {
                ShowMessage("Please enter a title and question.", false);
                return;
            }

            if (ContainsMarkup(title) || ContainsMarkup(body))
            {
                ShowMessage("HTML or script tags are not allowed in discussions.", false);
                return;
            }

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO DiscussionThreads (ModuleId, UserId, Title, Body)
                    VALUES (@ModuleId, @UserId, @Title, @Body)", conn);
                cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                cmd.Parameters.AddWithValue("@UserId", AuthHelper.GetUserId());
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Body", body);
                cmd.ExecuteNonQuery();
            }

            txtThreadTitle.Text = "";
            txtThreadBody.Text = "";
            ddlModuleFilter.SelectedValue = moduleId.ToString();
            LoadThreads();
            ShowMessage("Discussion thread posted.", true);
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            LoadThreads();
        }

        protected void rptThreads_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "AddReply") return;

            int threadId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out threadId) || !ThreadBelongsToPublishedModule(threadId))
            {
                ShowMessage("Invalid discussion thread.", false);
                return;
            }

            var txtReplyBody = e.Item.FindControl("txtReplyBody") as TextBox;
            string body = txtReplyBody == null ? "" : txtReplyBody.Text.Trim();

            if (string.IsNullOrWhiteSpace(body))
            {
                ShowMessage("Please write a reply first.", false);
                return;
            }

            if (ContainsMarkup(body))
            {
                ShowMessage("HTML or script tags are not allowed in replies.", false);
                return;
            }

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO DiscussionReplies (ThreadId, UserId, Body)
                    VALUES (@ThreadId, @UserId, @Body)", conn);
                cmd.Parameters.AddWithValue("@ThreadId", threadId);
                cmd.Parameters.AddWithValue("@UserId", AuthHelper.GetUserId());
                cmd.Parameters.AddWithValue("@Body", body);
                cmd.ExecuteNonQuery();
            }

            LoadThreads();
            ShowMessage("Reply added.", true);
        }

        protected void rptThreads_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var thread = e.Item.DataItem as ThreadRow;
            var replies = e.Item.FindControl("rptReplies") as Repeater;
            if (thread == null || replies == null) return;

            replies.DataSource = LoadReplies(thread.ThreadId);
            replies.DataBind();
        }

        private void LoadModules()
        {
            var modules = new List<ModuleRow>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT ModuleId, Title
                    FROM Modules
                    WHERE Status='Published'
                      AND IsDeleted=0
                    ORDER BY Title", conn);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        modules.Add(new ModuleRow
                        {
                            ModuleId = Convert.ToInt32(r["ModuleId"]),
                            Title = r["Title"].ToString()
                        });
            }

            ddlModule.DataSource = modules;
            ddlModule.DataTextField = "Title";
            ddlModule.DataValueField = "ModuleId";
            ddlModule.DataBind();

            ddlModuleFilter.Items.Clear();
            ddlModuleFilter.Items.Add(new ListItem("All modules", "All"));
            foreach (var module in modules)
                ddlModuleFilter.Items.Add(new ListItem(module.Title, module.ModuleId.ToString()));
        }

        private void ApplyModuleFromQueryString()
        {
            int moduleId;
            if (!int.TryParse(Request.QueryString["moduleId"], out moduleId)) return;

            var moduleValue = moduleId.ToString();
            if (ddlModule.Items.FindByValue(moduleValue) != null)
                ddlModule.SelectedValue = moduleValue;
            if (ddlModuleFilter.Items.FindByValue(moduleValue) != null)
                ddlModuleFilter.SelectedValue = moduleValue;
        }

        private void LoadThreads()
        {
            var threads = new List<ThreadRow>();
            int moduleId;
            bool hasModuleFilter = int.TryParse(ddlModuleFilter.SelectedValue, out moduleId);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT t.ThreadId, t.Title, t.Body, t.CreatedAt,
                           m.Title AS ModuleTitle,
                           ISNULL(u.FullName, 'Aidify user') AS AuthorName
                    FROM DiscussionThreads t
                    JOIN Modules m ON m.ModuleId = t.ModuleId
                    LEFT JOIN Users u ON u.UserId = t.UserId
                    WHERE m.Status='Published'
                      AND m.IsDeleted=0
                      AND (@ModuleId IS NULL OR t.ModuleId=@ModuleId)
                    ORDER BY t.CreatedAt DESC, t.ThreadId DESC", conn);
                cmd.Parameters.AddWithValue("@ModuleId", hasModuleFilter ? (object)moduleId : DBNull.Value);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        threads.Add(new ThreadRow
                        {
                            ThreadId = Convert.ToInt32(r["ThreadId"]),
                            Title = r["Title"] == DBNull.Value ? "" : r["Title"].ToString(),
                            Body = r["Body"] == DBNull.Value ? "" : r["Body"].ToString(),
                            CreatedAt = Convert.ToDateTime(r["CreatedAt"]),
                            ModuleTitle = r["ModuleTitle"].ToString(),
                            AuthorName = r["AuthorName"].ToString()
                        });
            }

            rptThreads.DataSource = threads;
            rptThreads.DataBind();
            lblNoThreads.Visible = threads.Count == 0;
        }

        private static List<ReplyRow> LoadReplies(int threadId)
        {
            var replies = new List<ReplyRow>();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT r.Body, r.CreatedAt,
                           ISNULL(u.FullName, 'Aidify user') AS AuthorName
                    FROM DiscussionReplies r
                    LEFT JOIN Users u ON u.UserId = r.UserId
                    WHERE r.ThreadId=@ThreadId
                    ORDER BY r.CreatedAt ASC, r.ReplyId ASC", conn);
                cmd.Parameters.AddWithValue("@ThreadId", threadId);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        replies.Add(new ReplyRow
                        {
                            Body = r["Body"] == DBNull.Value ? "" : r["Body"].ToString(),
                            CreatedAt = Convert.ToDateTime(r["CreatedAt"]),
                            AuthorName = r["AuthorName"].ToString()
                        });
            }

            return replies;
        }

        private static bool ModuleIsPublished(int moduleId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT COUNT(*)
                    FROM Modules
                    WHERE ModuleId=@ModuleId
                      AND Status='Published'
                      AND IsDeleted=0", conn);
                cmd.Parameters.AddWithValue("@ModuleId", moduleId);
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        private static bool ThreadBelongsToPublishedModule(int threadId)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT COUNT(*)
                    FROM DiscussionThreads t
                    JOIN Modules m ON m.ModuleId=t.ModuleId
                    WHERE t.ThreadId=@ThreadId
                      AND m.Status='Published'
                      AND m.IsDeleted=0", conn);
                cmd.Parameters.AddWithValue("@ThreadId", threadId);
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblDiscussionStatus.Visible = true;
            lblDiscussionStatus.Text = message;
            lblDiscussionStatus.CssClass = success
                ? "alert alert-success d-block mb-3"
                : "alert alert-danger d-block mb-3";
        }

        private static bool ContainsMarkup(string value)
        {
            return !string.IsNullOrEmpty(value) &&
                   (value.IndexOf("<", StringComparison.Ordinal) >= 0 ||
                    value.IndexOf(">", StringComparison.Ordinal) >= 0);
        }

        private class ModuleRow
        {
            public int ModuleId { get; set; }
            public string Title { get; set; }
        }

        private class ThreadRow
        {
            public int ThreadId { get; set; }
            public string Title { get; set; }
            public string Body { get; set; }
            public string ModuleTitle { get; set; }
            public string AuthorName { get; set; }
            public DateTime CreatedAt { get; set; }
        }

        private class ReplyRow
        {
            public string Body { get; set; }
            public string AuthorName { get; set; }
            public DateTime CreatedAt { get; set; }
        }
    }
}
