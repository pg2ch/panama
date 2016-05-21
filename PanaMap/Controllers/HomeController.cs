using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace PanaMap.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index(double lat = 35.658099222222, double lon = 139.74135441667, int zoom = 5)
        {
            //var mvcName = typeof(Controller).Assembly.GetName();
            //var isMono = Type.GetType("Mono.Runtime") != null;

            //ViewData["Version"] = mvcName.Version.Major + "." + mvcName.Version.Minor;
            //ViewData["Runtime"] = isMono ? "Mono" : ".NET";

            ViewBag.Lon = lon;
            ViewBag.Lat = lat;
            ViewBag.Zoom = zoom;
            return View();
        }
    }
}

