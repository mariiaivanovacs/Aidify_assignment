using System;
using Aidify_assigment;

namespace Aidify_assigment.Admin
{
    public partial class Analytics : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }
    }
}
