using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace Aidify_assigment
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();

            // IMPORTANT: Prevent FriendlyUrls from redirecting .aspx WebMethod calls
            settings.AutoRedirectMode = RedirectMode.Off;

            routes.EnableFriendlyUrls(settings);
        }
    }
}