using System.Configuration;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public static class DbHelper
    {
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(
                ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString);
        }
    }
}
