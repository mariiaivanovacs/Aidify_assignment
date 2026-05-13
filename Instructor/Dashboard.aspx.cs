using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblWelcomeInstructor.Text = "Welcome back, Instructor! Here is your latest activity.";
                // lblPendingDiscussions.Text = "5";

                var modules = new List<ModuleSummary>
                {
                    new ModuleSummary
                    {
                        Title = "CPR Fundamentals",
                        Description = "Core life-saving techniques for adult and pediatric CPR.",
                        Level = "Beginner",
                        Status = "Published",
                        LessonCount = 6,
                        LearnerCount = 124,
                        LastUpdated = "today"
                    },
                    new ModuleSummary
                    {
                        Title = "Choking & Airway Emergencies",
                        Description = "Assess and manage airway obstruction scenarios.",
                        Level = "Intermediate",
                        Status = "Pending Review",
                        LessonCount = 4,
                        LearnerCount = 76,
                        LastUpdated = "yesterday"
                    },
                    new ModuleSummary
                    {
                        Title = "Trauma Response",
                        Description = "Immediate care protocols for bleeding, fractures, and shock.",
                        Level = "Advanced",
                        Status = "Draft",
                        LessonCount = 8,
                        LearnerCount = 52,
                        LastUpdated = "2 days ago"
                    }
                };

                rptMyModules.DataSource = modules;
                rptMyModules.DataBind();
            }
        }

        private class ModuleSummary
        {
            public string Title { get; set; }
            public string Description { get; set; }
            public string Level { get; set; }
            public string Status { get; set; }
            public int LessonCount { get; set; }
            public int LearnerCount { get; set; }
            public string LastUpdated { get; set; }
        }
    }
}