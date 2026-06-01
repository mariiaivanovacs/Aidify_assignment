using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Learner
{
    public partial class Certificates : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleLearner;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindCertificates();
        }

        private void BindCertificates()
        {
            var certs = new List<CertRow>();
            int userId = AuthHelper.GetUserId();

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT m.Title, c.IssuedAt, c.PdfPath
                    FROM   Certificates c
                    JOIN   Modules m ON m.ModuleId = c.ModuleId
                    WHERE  c.UserId = @UserId
                    ORDER BY c.IssuedAt DESC", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        certs.Add(new CertRow
                        {
                            Title = r["Title"].ToString(),
                            IssuedAt = (DateTime)r["IssuedAt"],
                            PdfPath = r["PdfPath"] != DBNull.Value ? r["PdfPath"].ToString() : ""
                        });
            }

            rptCertificates.DataSource = certs;
            rptCertificates.DataBind();
            lblNoCerts.Visible = certs.Count == 0;
        }

        private class CertRow
        {
            public string Title { get; set; }
            public string PdfPath { get; set; }
            public DateTime IssuedAt { get; set; }
        }
    }
}
