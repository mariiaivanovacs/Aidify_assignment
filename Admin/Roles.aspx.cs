using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class Roles : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Returns active user counts per role for the badge labels on each card.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetRoleCounts()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT r.RoleName, COUNT(u.UserId) AS UserCount
                    FROM   Roles r
                    LEFT JOIN Users u ON u.RoleId = r.RoleId AND u.IsActive = 1
                    GROUP BY r.RoleName", conn);

                int adminCount = 0, instructorCount = 0, learnerCount = 0;
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        var name  = reader["RoleName"].ToString();
                        var count = (int)reader["UserCount"];
                        if      (name == Constants.RoleAdmin)      adminCount      = count;
                        else if (name == Constants.RoleInstructor) instructorCount = count;
                        else if (name == Constants.RoleLearner)    learnerCount    = count;
                    }

                return new { adminCount, instructorCount, learnerCount };
            }
        }
    }
}
