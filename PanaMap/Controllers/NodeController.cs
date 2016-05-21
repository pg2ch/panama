using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dapper;

namespace PanaMap.Controllers
{
    public class NodeController : Controller
    {
        public ActionResult Index(int id)
        {
            using (var con = Models.Model.GetDB())
            {
                var rows = con.Query<object>(@"
                    select * from panama_addresses where node_id = @ID limit 1
                    ", new { ID = id});
                if (rows.Count() <= 0)
                {
                    return HttpNotFound();
                }

                this.ViewBag.data = rows.FirstOrDefault();
                return View();
            }
        }
    }
}
