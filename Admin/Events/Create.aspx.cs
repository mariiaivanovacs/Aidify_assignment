using System;
using System.Data.SqlClient;

namespace Aidify_assigment.Admin.Events
{
    public partial class Create : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string location = txtLocation.Text.Trim();
            string meetingUrl = txtMeetingUrl.Text.Trim();

            DateTime eventDate;

            if (string.IsNullOrWhiteSpace(title))
            {
                ShowError("Event title is required.");
                return;
            }

            if (string.IsNullOrWhiteSpace(description))
            {
                ShowError("Event description is required.");
                return;
            }

            if (!DateTime.TryParse(txtEventDate.Text, out eventDate))
            {
                ShowError("Please select a valid event date and time.");
                return;
            }

            if (string.IsNullOrWhiteSpace(location))
            {
                ShowError("Event location is required.");
                return;
            }

            int createdBy = AuthHelper.GetUserId();

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Events
                    (
                        Title,
                        Description,
                        EventDate,
                        Location,
                        MeetingUrl,
                        CreatedBy,
                        Status
                    )
                    OUTPUT INSERTED.EventId
                    VALUES
                    (
                        @Title,
                        @Description,
                        @EventDate,
                        @Location,
                        @MeetingUrl,
                        @CreatedBy,
                        'Published'
                    )", conn);

                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@EventDate", eventDate);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@MeetingUrl", string.IsNullOrWhiteSpace(meetingUrl) ? (object)DBNull.Value : meetingUrl);
                cmd.Parameters.AddWithValue("@CreatedBy", createdBy);

                int newEventId = Convert.ToInt32(cmd.ExecuteScalar());
                AuditService.Log(createdBy, "CreateEvent", "Events", newEventId, conn);
            }

            lblMessage.CssClass = "alert alert-success d-block mb-3";
            lblMessage.Text = "Event created successfully.";

            ClearForm();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblMessage.Text = "";
        }

        private void ClearForm()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtEventDate.Text = "";
            txtLocation.Text = "";
            txtMeetingUrl.Text = "";
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "alert alert-danger d-block mb-3";
            lblMessage.Text = message;
        }
    }
}
