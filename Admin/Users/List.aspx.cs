using System;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin.Users
{
    public partial class List : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Returns the full user list as a JSON-serialisable array.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetUsers()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetAllUsers()
                .Select(u => new
                {
                    userId      = u.UserId,
                    fullName    = u.FullName,
                    email       = u.Email,
                    roleName    = u.RoleName,
                    roleBadgeCss= u.RoleBadgeCss,
                    isActive    = u.IsActive,
                    initials    = u.Initials,
                    lastActive  = u.LastActive
                })
                .ToList();
        }

        // Enables or disables a user account. Writes to AuditLogs inside the same transaction.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static void SetUserActive(int userId, bool active)
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return;
            new AdminRepository().SetUserActive(userId, active);
        }
    }
}
