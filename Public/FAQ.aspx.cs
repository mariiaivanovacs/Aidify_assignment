using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Public
{
    public partial class FAQ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetFAQs()
        {
            var faqs = new List<object>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(
                    "SELECT FaqId, Question, Answer, Category FROM FAQs ORDER BY SortOrder, FaqId", conn);
                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        faqs.Add(new {
                            faqId    = (int)r["FaqId"],
                            question = r["Question"].ToString(),
                            answer   = r["Answer"].ToString(),
                            category = r["Category"] != DBNull.Value ? r["Category"].ToString() : "General"
                        });
            }
            return faqs;
        }
    }
}
