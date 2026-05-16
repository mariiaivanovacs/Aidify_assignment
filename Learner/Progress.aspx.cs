using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Progress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // dummy data
                var modules = new[]
                {
                    new { ModuleName = "Intro to C#", Completed = 3, Total = 4, Pct = 75 },
                    new { ModuleName = "ASP.NET Web Forms", Completed = 2, Total = 5, Pct = 40 },
                    new { ModuleName = "SQL Basics", Completed = 1, Total = 4, Pct = 25 },
                };
                rptModuleProgress.DataSource = modules;
                rptModuleProgress.DataBind();

                var badges = new[]
                {
                    new { Icon = "⭐", BadgeName = "First Lesson", AwardedDate = "Jan 2026" },
                    new { Icon = "🔥", BadgeName = "On a Roll", AwardedDate = "Feb 2026" },
                    new { Icon = "🏆", BadgeName = "Quiz Master", AwardedDate = "Mar 2026" },
                };
                rptBadges.DataSource = badges;
                rptBadges.DataBind();
                lblNoBadges.Visible = badges.Length == 0;

                // Certification dummy data
                var certs = new[]
                {
                    new { ModuleName = "Intro to C#", IssueDate = "March 2026",
                          DownloadUrl = "~/Learner/Certificate.aspx?moduleId=1" },
                };
                rptCertificates.DataSource = certs;
                rptCertificates.DataBind();
                lblNoCertificates.Visible = certs.Length == 0;
            }
        }
    }
}