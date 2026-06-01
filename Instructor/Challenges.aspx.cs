using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor
{
    public partial class Challenges : Page
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
                LoadChallenges();
                LoadChallengeStats();
            }
        }

        protected void btnSaveChallenge_Click(object sender, EventArgs e)
        {
            ClearMessage();

            string title = txtChallengeTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string startDateText = txtStartDate.Text.Trim();
            string endDateText = txtEndDate.Text.Trim();
            string pointsText = txtPointsReward.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the challenge title.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                ShowMessage("Please enter the challenge description.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(startDateText))
            {
                ShowMessage("Please select the start date.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(endDateText))
            {
                ShowMessage("Please select the end date.", false);
                return;
            }

            if (!DateTime.TryParse(startDateText, out DateTime startDate))
            {
                ShowMessage("Please enter a valid start date.", false);
                return;
            }

            if (!DateTime.TryParse(endDateText, out DateTime endDate))
            {
                ShowMessage("Please enter a valid end date.", false);
                return;
            }

            if (endDate < startDate)
            {
                ShowMessage("End date cannot be earlier than start date.", false);
                return;
            }

            if (!int.TryParse(pointsText, out int pointsReward) || pointsReward <= 0)
            {
                ShowMessage("Please enter valid reward points.", false);
                return;
            }

            try
            {
                if (string.IsNullOrWhiteSpace(hfChallengeId.Value))
                {
                    InsertChallenge(title, description, startDate, endDate, pointsReward);
                    ShowMessage("Challenge created successfully and saved as Draft.", true);
                }
                else
                {
                    int challengeId = Convert.ToInt32(hfChallengeId.Value);
                    UpdateChallenge(challengeId, title, description, startDate, endDate, pointsReward);
                    ShowMessage("Challenge updated successfully.", true);
                }

                ClearForm();
                LoadChallenges();
                LoadChallengeStats();
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving challenge: " + ex.Message, false);
            }
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
            ShowMessage("Form cleared.", true);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadChallenges();
            LoadChallengeStats();
            ShowMessage("Challenge list refreshed.", true);
        }

        protected void rptChallenges_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ClearMessage();

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int challengeId))
            {
                ShowMessage("Invalid challenge selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "ViewChallenge")
                {
                    DataRow row = GetChallengeById(challengeId);

                    if (row == null)
                    {
                        ShowMessage("Challenge not found.", false);
                        return;
                    }

                    string details =
                        "Challenge Details\\n\\n" +
                        "Title: " + row["Title"] + "\\n" +
                        "Description: " + row["Description"] + "\\n" +
                        "Start Date: " + FormatDate(row["StartDate"]) + "\\n" +
                        "End Date: " + FormatDate(row["EndDate"]) + "\\n" +
                        "Points Reward: " + row["PointsReward"] + "\\n" +
                        "Status: " + row["Status"];

                    ShowAlert(details);
                }
                else if (e.CommandName == "EditChallenge")
                {
                    LoadChallengeIntoForm(challengeId);
                }
                else if (e.CommandName == "PublishChallenge")
                {
                    PublishChallenge(challengeId);
                    ShowMessage("Challenge published successfully.", true);
                    LoadChallenges();
                    LoadChallengeStats();
                }
                else if (e.CommandName == "DeleteChallenge")
                {
                    DeleteChallenge(challengeId);
                    ShowMessage("Challenge deleted successfully.", true);
                    LoadChallenges();
                    LoadChallengeStats();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing challenge: " + ex.Message, false);
            }
        }

        private void InsertChallenge(string title, string description, DateTime startDate, DateTime endDate, int pointsReward)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Challenges
                        (Title, Description, StartDate, EndDate, PointsReward, BadgeRewardId, Status)
                    VALUES
                        (@Title, @Description, @StartDate, @EndDate, @PointsReward, @BadgeRewardId, @Status);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@StartDate", startDate);
                    cmd.Parameters.AddWithValue("@EndDate", endDate);
                    cmd.Parameters.AddWithValue("@PointsReward", pointsReward);
                    cmd.Parameters.AddWithValue("@BadgeRewardId", DBNull.Value);
                    cmd.Parameters.AddWithValue("@Status", "Draft");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void UpdateChallenge(int challengeId, string title, string description, DateTime startDate, DateTime endDate, int pointsReward)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE dbo.Challenges
                    SET
                        Title = @Title,
                        Description = @Description,
                        StartDate = @StartDate,
                        EndDate = @EndDate,
                        PointsReward = @PointsReward
                    WHERE ChallengeId = @ChallengeId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ChallengeId", challengeId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@StartDate", startDate);
                    cmd.Parameters.AddWithValue("@EndDate", endDate);
                    cmd.Parameters.AddWithValue("@PointsReward", pointsReward);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void PublishChallenge(int challengeId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "UPDATE dbo.Challenges SET Status = 'Published' WHERE ChallengeId = @ChallengeId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ChallengeId", challengeId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteChallenge(int challengeId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "DELETE FROM dbo.Challenges WHERE ChallengeId = @ChallengeId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ChallengeId", challengeId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadChallenges()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        ChallengeId,
                        Title,
                        Description,
                        StartDate,
                        EndDate,
                        PointsReward,
                        ISNULL(Status, 'Draft') AS Status
                    FROM dbo.Challenges
                    ORDER BY StartDate DESC, ChallengeId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptChallenges.DataSource = table;
                        rptChallenges.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblChallengeCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void LoadChallengeStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalChallenges,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'Draft' THEN 1 ELSE 0 END) AS DraftChallenges,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'Published' THEN 1 ELSE 0 END) AS PublishedChallenges,
                        SUM(ISNULL(PointsReward, 0)) AS TotalPoints
                    FROM dbo.Challenges;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalChallenges.Text = Convert.ToString(reader["TotalChallenges"]);
                            lblDraftChallenges.Text = Convert.ToString(reader["DraftChallenges"] == DBNull.Value ? 0 : reader["DraftChallenges"]);
                            lblPublishedChallenges.Text = Convert.ToString(reader["PublishedChallenges"] == DBNull.Value ? 0 : reader["PublishedChallenges"]);
                            lblTotalPoints.Text = Convert.ToString(reader["TotalPoints"] == DBNull.Value ? 0 : reader["TotalPoints"]);
                        }
                    }
                }
            }
        }

        private DataRow GetChallengeById(int challengeId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        ChallengeId,
                        Title,
                        Description,
                        StartDate,
                        EndDate,
                        PointsReward,
                        ISNULL(Status, 'Draft') AS Status
                    FROM dbo.Challenges
                    WHERE ChallengeId = @ChallengeId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ChallengeId", challengeId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count == 0)
                        {
                            return null;
                        }

                        return table.Rows[0];
                    }
                }
            }
        }

        private void LoadChallengeIntoForm(int challengeId)
        {
            DataRow row = GetChallengeById(challengeId);

            if (row == null)
            {
                ShowMessage("Challenge not found.", false);
                return;
            }

            hfChallengeId.Value = Convert.ToString(row["ChallengeId"]);
            txtChallengeTitle.Text = Convert.ToString(row["Title"]);
            txtDescription.Text = Convert.ToString(row["Description"]);
            txtPointsReward.Text = Convert.ToString(row["PointsReward"]);

            if (row["StartDate"] != DBNull.Value)
            {
                DateTime startDate = Convert.ToDateTime(row["StartDate"]);
                txtStartDate.Text = startDate.ToString("yyyy-MM-dd");
            }
            else
            {
                txtStartDate.Text = "";
            }

            if (row["EndDate"] != DBNull.Value)
            {
                DateTime endDate = Convert.ToDateTime(row["EndDate"]);
                txtEndDate.Text = endDate.ToString("yyyy-MM-dd");
            }
            else
            {
                txtEndDate.Text = "";
            }

            lblFormTitle.Text = "Edit Challenge";
            btnSaveChallenge.Text = "Update Challenge";

            ShowMessage("Challenge loaded for editing.", true);
        }

        private void ClearForm()
        {
            hfChallengeId.Value = "";
            txtChallengeTitle.Text = "";
            txtDescription.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtPointsReward.Text = "";
            lblFormTitle.Text = "Create Challenge";
            btnSaveChallenge.Text = "Save Challenge";
        }

        private void ShowMessage(string message, bool success)
        {
            lblChallengeStatus.Visible = true;
            lblChallengeStatus.Text = message;
            lblChallengeStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblChallengeStatus.Visible = false;
            lblChallengeStatus.Text = "";
            lblChallengeStatus.CssClass = "";
        }

        private void ShowAlert(string message)
        {
            string script = "alert('" + EscapeJavaScript(message) + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "challengeAlert", script, true);
        }

        protected string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "-";
            }

            DateTime date = Convert.ToDateTime(value);
            return date.ToString("yyyy-MM-dd");
        }

        protected string GetStatusCss(object value)
        {
            string status = Convert.ToString(value);

            if (status == "Published")
            {
                return "badge-published";
            }

            return "badge-draft";
        }

        private string EscapeJavaScript(string value)
        {
            if (value == null)
            {
                return "";
            }

            return value
                .Replace("\\", "\\\\")
                .Replace("'", "\\'")
                .Replace("\"", "\\\"")
                .Replace("\r", "")
                .Replace("\n", "\\n");
        }
    }
}