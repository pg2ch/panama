using System.Web.Mvc;
using System.Web.Routing;

namespace PanaMap
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "homeWithCenter",
                url: "map/{lat},{lon},{zoom}",
                defaults: new
                {
                    controller = "Home",
                    action = "Index",
                    lat = UrlParameter.Optional,
                    lon = UrlParameter.Optional,
                    zoom = UrlParameter.Optional,
                }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}

