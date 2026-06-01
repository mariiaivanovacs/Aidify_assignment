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
                }
            }

            BindEvents();
        }

        private class EventRow
        {
            public int EventId;
            public string Title, Description, Location, MeetingUrl;
            public DateTime EventDate;
            public bool AlreadyRegistered;
        }
    }
}