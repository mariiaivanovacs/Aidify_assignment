using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEvents();
            }
        }

        private void BindEvents()
        {
            //string sql = @"
            //    SELECT EventId, Title, Description, EventDate, Location, MeetingUrl, Status
            //    FROM   Events
            //    WHERE  Status = 'Published' AND (EventDate IS NULL OR EventDate > GETUTCDATE())
            //    ORDER BY EventDate
            //    ";
            var events = new[]
            {
                // Dummy data
                new { EventId = 1, Title = "C# Workshop",
                      Description = "A hands-on workshop covering C# fundamentals.",
                      EventDate = new DateTime(2026, 6, 10, 10, 0, 0),
                      Location = "Room 3B", MeetingUrl = "",
                      AlreadyRegistered = false },
                new { EventId = 2, Title = "SQL Masterclass",
                      Description = "Deep dive into advanced SQL queries and performance.",
                      EventDate = new DateTime(2026, 6, 20, 14, 0, 0),
                      Location = "", MeetingUrl = "https://meet.example.com/sql-masterclass",
                      AlreadyRegistered = true },
            };

            rptEvents.DataSource = events;
            rptEvents.DataBind();
            lblNoEvents.Visible = events.Length == 0;
        }

        protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Register") return;

            int eventId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserId"]);

            string connStr = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString;

            using (var conn = new System.Data.SqlClient.SqlConnection(connStr))
            {
                conn.Open();

                string checkSql = @"
                    SELECT COUNT(*) FROM EventRegistrations
                    WHERE EventId = @EventId AND UserId = @UserId";

                using (var checkCmd = new System.Data.SqlClient.SqlCommand(checkSql, conn))
                {
                    checkCmd.Parameters.AddWithValue("@EventId", eventId);
                    checkCmd.Parameters.AddWithValue("@UserId", userId);

                    int alreadyRegistered = (int)checkCmd.ExecuteScalar();

                    if (alreadyRegistered == 0)
                    {
                        string insertSql = @"
                            INSERT INTO EventRegistrations (EventId, UserId)
                            VALUES (@EventId, @UserId)";

                        using (var insertCmd = new System.Data.SqlClient.SqlCommand(insertSql, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@EventId", eventId);
                            insertCmd.Parameters.AddWithValue("@UserId", userId);
                            insertCmd.ExecuteNonQuery();
                        }

                        // Uncomment this code when the EmailService is ready:
                        //EmailService.Send(userEmail,
                        //     "You're registered for: " + eventTitle,
                        //     "<p>You have successfully registered for the event on " + eventDate + ".</p>");
                    }
                }
            }

            BindEvents();
        }
    }
}