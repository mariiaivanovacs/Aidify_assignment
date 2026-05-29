using System;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Instructor.Lessons
{
    public partial class Edit : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
