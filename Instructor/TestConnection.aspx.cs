using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Aidify_assigment.Instructor
{
    public partial class TestConnection : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager
                    .ConnectionStrings["AidifyDB"]
                    .ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string query = "SELECT COUNT(*) FROM dbo.Events";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        int count = Convert.ToInt32(cmd.ExecuteScalar());

                        lblResult.ForeColor = System.Drawing.Color.Green;
                        lblResult.Text = "Database connected successfully. Events count: " + count;
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.ForeColor = System.Drawing.Color.Red;
                lblResult.Text = "Database connection failed: " + ex.Message;
            }
        }
    }
}