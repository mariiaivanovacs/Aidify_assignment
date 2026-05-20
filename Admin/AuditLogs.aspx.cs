using System;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Aidify_assigment.Admin
{
    public partial class AuditLogs : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleAdmin;

        protected void Page_Load(object sender, EventArgs e) { }

        // Returns the last 100 audit log entries (24-hour window) as JSON.
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false)]
        public static object GetAuditLogs()
        {
            if (HttpContext.Current.Session[Constants.SessionRole] as string != Constants.RoleAdmin)
                return null;

            return new AdminRepository()
                .GetAuditLogs(withinHours: 168)   // last 7 days
                .Select(l => new
                {
                    auditId      = l.AuditId,
                    action       = l.Action,
                    targetEntity = l.TargetEntity,
                    iPAddress    = l.IPAddress,
                    timestamp    = l.Timestamp,
                    actorName    = l.ActorName,
                    actorInitials= l.ActorInitials
                })
                .ToList();
        }
    }
}
