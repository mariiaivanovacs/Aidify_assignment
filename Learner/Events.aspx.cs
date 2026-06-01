using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Events : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindEvents();
        }

        private void BindEvents()
        {
            var events = new List<EventRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT ev.EventId, ev.Title, ev.Description,
                           ev.EventDate, ev.Location, ev.MeetingUrl,
                           CASE WHEN EXISTS (
                               SELECT 1 FROM EventRegistrations
                               WHERE EventId = ev.EventId AND UserId = @UserId
                           ) THEN 1 ELSE 0 END AS AlreadyRegistered
                    FROM   Events ev
                    WHERE  Status = 'Published'
                      AND  (EventDate IS NULL OR EventDate > GETUTCDATE())
                    ORDER BY EventDate", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        events.Add(new EventRow
                        {
                            EventId = (int)r["EventId"],
                            Title = r["Title"].ToString(),
                            Description = r["Description"] != DBNull.Value ? r["Description"].ToString() : "",
                            EventDate = (DateTime)r["EventDate"],
                            Location = r["Location"] != DBNull.Value ? r["Location"].ToString() : "",
                            MeetingUrl = r["MeetingUrl"] != DBNull.Value ? r["MeetingUrl"].ToString() : "",
                            AlreadyRegistered = (int)r["AlreadyRegistered"] == 1
                        });
            }

            rptEvents.DataSource = events;
            rptEvents.DataBind();
            lblNoEvents.Visible = events.Count == 0;
        }

        protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Register") return;

            int userId = AuthHelper.GetUserId();
            int eventId = Convert.ToInt32(e.CommandArgument);

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var chk = new SqlCommand(@"
                    SELECT COUNT(*) FROM EventRegistrations
                    WHERE EventId = @E AND UserId = @U", conn);
                chk.Parameters.AddWithValue("@E", eventId);
                chk.Parameters.AddWithValue("@U", userId);
                if ((int)chk.ExecuteScalar() == 0)
                {
                    var ins = new SqlCommand(@"
                        INSERT INTO EventRegistrations (EventId, UserId)
                        VALUES (@E, @U)", conn);
                    ins.Parameters.AddWithValue("@E", eventId);
                    ins.Parameters.AddWithValue("@U", userId);
                    ins.ExecuteNonQuery();

                    SendEventConfirmation(userId, eventId, conn);
                }
            }

            BindEvents();
        }

        private static void SendEventConfirmation(int userId, int eventId, SqlConnection conn)
        {
            string email = "", name = "Aidify learner";
            var userCmd = new SqlCommand("SELECT Email, FullName FROM Users WHERE UserId=@UserId", conn);
            userCmd.Parameters.AddWithValue("@UserId", userId);
            using (var r = userCmd.ExecuteReader())
            {
                if (r.Read())
                {
                    email = r["Email"].ToString();
                    name = r["FullName"] == DBNull.Value ? name : r["FullName"].ToString();
                }
            }

            string title = "", when = "", location = "";
            var eventCmd = new SqlCommand(@"
                SELECT Title, EventDate, Location, MeetingUrl
                FROM Events
                WHERE EventId=@EventId", conn);
            eventCmd.Parameters.AddWithValue("@EventId", eventId);
            using (var r = eventCmd.ExecuteReader())
            {
                if (r.Read())
                {
                    title = r["Title"].ToString();
                    when = r["EventDate"] == DBNull.Value ? "To be announced" : Convert.ToDateTime(r["EventDate"]).ToString("dd MMM yyyy HH:mm");
                    location = r["MeetingUrl"] != DBNull.Value && !string.IsNullOrWhiteSpace(r["MeetingUrl"].ToString())
                        ? r["MeetingUrl"].ToString()
                        : r["Location"].ToString();
                }
            }

            NotificationService.Push(userId, "Event Registration Confirmed", "You are registered for " + title + ".", "~/Learner/Events.aspx");

            if (string.IsNullOrWhiteSpace(email)) return;

            try
            {
                EmailService.Send(
                    email,
                    "Aidify event registration: " + title,
                    "<p>Hello " + System.Web.HttpUtility.HtmlEncode(name) + ",</p>"
                    + "<p>You are registered for <strong>" + System.Web.HttpUtility.HtmlEncode(title) + "</strong>.</p>"
                    + "<p><strong>When:</strong> " + System.Web.HttpUtility.HtmlEncode(when) + "<br/>"
                    + "<strong>Where:</strong> " + System.Web.HttpUtility.HtmlEncode(location) + "</p>");
            }
            catch
            {
                NotificationService.Push(userId, "Event Email Not Sent", "Your event registration was saved, but email delivery is not available right now.", "~/Learner/Events.aspx");
            }
        }

        private class EventRow
        {
            public int EventId { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public string Location { get; set; }
            public string MeetingUrl { get; set; }
            public DateTime EventDate { get; set; }
            public bool AlreadyRegistered { get; set; }
        }
    }
}
