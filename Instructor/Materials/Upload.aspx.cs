using System;
using System.Collections.Generic;

namespace Aidify_assigment.Instructor.Materials
{
    public partial class Upload : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}