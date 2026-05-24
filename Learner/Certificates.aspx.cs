using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Certificates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCertificates();
            }
        }

        private void BindCertificates()
        {
            //string sql = @"
            //    SELECT m.Title, c.IssuedAt, c.PdfPath
            //    FROM   Certificates c
            //    JOIN   Modules m ON m.ModuleId = c.ModuleId
            //    WHERE  c.UserId = @UserId
            //    ORDER BY c.IssuedAt DESC
            //    ";
            var certs = new[]
            {
                // Dummy data
                new { Title = "Intro to C#",        IssuedAt = new DateTime(2026, 3, 1),  PdfPath = "" },
                new { Title = "SQL Basics",          IssuedAt = new DateTime(2026, 4, 10), PdfPath = "" },
            };

            rptCertificates.DataSource = certs;
            rptCertificates.DataBind();
            lblNoCerts.Visible = certs.Length == 0;
        }
    }
}