using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor
{
    public partial class Events : Page
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
                LoadEvents();
                LoadEventStats();
            }
        }

        protected void btnCreateEvent_Click(object sender, EventArgs e)
        {
            ClearMessage();

            string title = txtEventTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string eventDateText = txtEventDate.Text.Trim();
            string location = txtLocation.Text.Trim();
            string meetingUrl = txtMeetingUrl.Text.Trim();

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowMessage("Please enter the event title.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                ShowMessage("Please enter the event description.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(eventDateText))
            {
                ShowMessage("Please select the event date.", false);
                return;
            }

            if (!DateTime.TryParse(eventDateText, out DateTime eventDate))
            {
                ShowMessage("Please enter a valid event date.", false);
                return;
            }

            if (string.IsNullOrWhiteSpace(location))
            {
                ShowMessage("Please enter the event location.", false);
                return;
            }

            try
            {
                if (string.IsNullOrWhiteSpace(hfEventId.Value))
                {
                    InsertEvent(title, description, eventDate, location, meetingUrl);
                    ShowMessage("Event created successfully and saved as Draft.", true);
                }
                else
                {
                    int eventId = Convert.ToInt32(hfEventId.Value);
                    UpdateEvent(eventId, title, description, eventDate, location, meetingUrl);
                    ShowMessage("Event updated successfully.", true);
                }

                ClearForm();
                LoadEvents();
                LoadEventStats();
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving event: " + ex.Message, false);
            }
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
            ShowMessage("Form cleared.", true);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadEvents();
            LoadEventStats();
            ShowMessage("Event list refreshed.", true);
        }

        protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ClearMessage();

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out int eventId))
            {
                ShowMessage("Invalid event selected.", false);
                return;
            }

            try
            {
                if (e.CommandName == "ViewEvent")
                {
                    DataRow row = GetEventById(eventId);

                    if (row == null)
                    {
                        ShowMessage("Event not found.", false);
                        return;
                    }

                    string details =
                        "Event Details\\n\\n" +
                        "Title: " + row["Title"] + "\\n" +
                        "Description: " + row["Description"] + "\\n" +
                        "Event Date: " + FormatDate(row["EventDate"]) + "\\n" +
                        "Location: " + row["Location"] + "\\n" +
                        "Meeting URL: " + FormatMeetingUrl(row["MeetingUrl"]) + "\\n" +
                        "Status: " + row["Status"];

                    ShowAlert(details);
                }
                else if (e.CommandName == "EditEvent")
                {
                    LoadEventIntoForm(eventId);
                }
                else if (e.CommandName == "PublishEvent")
                {
                    PublishEvent(eventId);
                    ShowMessage("Event published successfully.", true);
                    LoadEvents();
                    LoadEventStats();
                }
                else if (e.CommandName == "OpenLink")
                {
                    DataRow row = GetEventById(eventId);

                    if (row == null)
                    {
                        ShowMessage("Event not found.", false);
                        return;
                    }

                    string url = Convert.ToString(row["MeetingUrl"]).Trim();

                    if (string.IsNullOrWhiteSpace(url))
                    {
                        ShowMessage("No meeting URL is available for this event.", false);
                        return;
                    }

                    string script = "window.open('" + EscapeJavaScript(url) + "', '_blank');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "openEventLink", script, true);
                }
                else if (e.CommandName == "DeleteEvent")
                {
                    DeleteEvent(eventId);
                    ShowMessage("Event deleted successfully.", true);
                    LoadEvents();
                    LoadEventStats();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while processing event: " + ex.Message, false);
            }
        }

        private void InsertEvent(string title, string description, DateTime eventDate, string location, string meetingUrl)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.Events
                        (Title, Description, EventDate, Location, MeetingUrl, CreatedBy, Status)
                    VALUES
                        (@Title, @Description, @EventDate, @Location, @MeetingUrl, @CreatedBy, @Status);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@EventDate", eventDate);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@MeetingUrl", string.IsNullOrWhiteSpace(meetingUrl) ? (object)DBNull.Value : meetingUrl);
                    cmd.Parameters.AddWithValue("@CreatedBy", DBNull.Value);
                    cmd.Parameters.AddWithValue("@Status", "Draft");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void UpdateEvent(int eventId, string title, string description, DateTime eventDate, string location, string meetingUrl)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE dbo.Events
                    SET
                        Title = @Title,
                        Description = @Description,
                        EventDate = @EventDate,
                        Location = @Location,
                        MeetingUrl = @MeetingUrl
                    WHERE EventId = @EventId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EventId", eventId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@EventDate", eventDate);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@MeetingUrl", string.IsNullOrWhiteSpace(meetingUrl) ? (object)DBNull.Value : meetingUrl);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void PublishEvent(int eventId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "UPDATE dbo.Events SET Status = 'Published' WHERE EventId = @EventId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EventId", eventId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteEvent(int eventId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "DELETE FROM dbo.Events WHERE EventId = @EventId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EventId", eventId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void LoadEvents()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        EventId,
                        Title,
                        Description,
                        EventDate,
                        Location,
                        MeetingUrl,
                        ISNULL(Status, 'Draft') AS Status
                    FROM dbo.Events
                    ORDER BY EventDate DESC, EventId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptEvents.DataSource = table;
                        rptEvents.DataBind();

                        pnlEmptyState.Visible = table.Rows.Count == 0;
                        lblEventCount.Text = table.Rows.Count + " Records";
                    }
                }
            }
        }

        private void LoadEventStats()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalEvents,
                        SUM(CASE WHEN EventDate >= CAST(GETDATE() AS date) THEN 1 ELSE 0 END) AS UpcomingEvents,
                        SUM(CASE WHEN ISNULL(Status, 'Draft') = 'Draft' THEN 1 ELSE 0 END) AS DraftEvents,
                        SUM(CASE WHEN MeetingUrl IS NOT NULL AND LTRIM(RTRIM(MeetingUrl)) <> '' THEN 1 ELSE 0 END) AS OnlineEvents
                    FROM dbo.Events;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalEvents.Text = Convert.ToString(reader["TotalEvents"]);
                            lblUpcomingEvents.Text = Convert.ToString(reader["UpcomingEvents"] == DBNull.Value ? 0 : reader["UpcomingEvents"]);
                            lblDraftEvents.Text = Convert.ToString(reader["DraftEvents"] == DBNull.Value ? 0 : reader["DraftEvents"]);
                            lblOnlineEvents.Text = Convert.ToString(reader["OnlineEvents"] == DBNull.Value ? 0 : reader["OnlineEvents"]);
                        }
                    }
                }
            }
        }

        private DataRow GetEventById(int eventId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        EventId,
                        Title,
                        Description,
                        EventDate,
                        Location,
                        MeetingUrl,
                        ISNULL(Status, 'Draft') AS Status
                    FROM dbo.Events
                    WHERE EventId = @EventId;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EventId", eventId);

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

        private void LoadEventIntoForm(int eventId)
        {
            DataRow row = GetEventById(eventId);

            if (row == null)
            {
                ShowMessage("Event not found.", false);
                return;
            }

            hfEventId.Value = Convert.ToString(row["EventId"]);
            txtEventTitle.Text = Convert.ToString(row["Title"]);
            txtDescription.Text = Convert.ToString(row["Description"]);
            txtLocation.Text = Convert.ToString(row["Location"]);
            txtMeetingUrl.Text = row["MeetingUrl"] == DBNull.Value ? "" : Convert.ToString(row["MeetingUrl"]);

            if (row["EventDate"] != DBNull.Value)
            {
                DateTime date = Convert.ToDateTime(row["EventDate"]);
                txtEventDate.Text = date.ToString("yyyy-MM-dd");
            }
            else
            {
                txtEventDate.Text = "";
            }

            lblFormTitle.Text = "Edit Event";
            btnCreateEvent.Text = "Update Event";

            ShowMessage("Event loaded for editing.", true);
        }

        private void ClearForm()
        {
            hfEventId.Value = "";
            txtEventTitle.Text = "";
            txtDescription.Text = "";
            txtEventDate.Text = "";
            txtLocation.Text = "";
            txtMeetingUrl.Text = "";
            lblFormTitle.Text = "Create Event";
            btnCreateEvent.Text = "Create Event";
        }

        private void ShowMessage(string message, bool success)
        {
            lblEventStatus.Visible = true;
            lblEventStatus.Text = message;
            lblEventStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblEventStatus.Visible = false;
            lblEventStatus.Text = "";
            lblEventStatus.CssClass = "";
        }

        private void ShowAlert(string message)
        {
            string script = "alert('" + EscapeJavaScript(message) + "');";
            ScriptManager.RegisterStartupScript(this, GetType(), "eventAlert", script, true);
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

        protected string FormatMeetingUrl(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "-";
            }

            string url = Convert.ToString(value);

            if (string.IsNullOrWhiteSpace(url))
            {
                return "-";
            }

            return url;
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