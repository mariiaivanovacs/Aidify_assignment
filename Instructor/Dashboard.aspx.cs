using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Aidify_assigment;

namespace Aidify_assigment.Instructor
{
    public partial class Dashboard : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
    }
}
