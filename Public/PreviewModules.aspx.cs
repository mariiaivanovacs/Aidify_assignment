using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Public
{
    public partial class PreviewModules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetPreviewModules()
        {
            var modules = new List<object>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 3 ModuleId, Title, Description, DifficultyLevel
                    FROM   Modules
                    WHERE  Status = 'Published' AND IsDeleted = 0
                    ORDER BY CreatedAt DESC", conn);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        modules.Add(new {
                            moduleId    = (int)r["ModuleId"],
                            title       = r["Title"].ToString(),
                            description = r["Description"] != DBNull.Value ? r["Description"].ToString() : "",
                            difficulty  = r["DifficultyLevel"] != DBNull.Value ? r["DifficultyLevel"].ToString() : "Beginner"
                        });
            }
            return modules;
        }
    }
}
