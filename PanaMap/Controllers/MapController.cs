using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Dapper;

using PanaMap.Models;

namespace PanaMap.Controllers
{
    public class MapController : ApiController
    {
        public IHttpActionResult Get(double lat1, double lon1, double lat2, double lon2)
        {
            int y = 9;
            int x = 9;
            int limit = 5;
            double h = (lat2 - lat1) / y;
            double w = (lon2 - lon1) / x;

            using (var con = Model.GetDB())
            {
                var sql = "";
                for (int j = 0; j < y; j++)
                {
                    for (int i = 0; i < x; i++) 
                    {
                        if (sql != "")
                        {
                            sql += " union all \n";
                        }

                        var latA = lat1 + (h * (j + 0));
                        var lonA = lon1 + (w * (i + 0));
                        var latB = lat1 + (h * (j + 1));
                        var lonB = lon1 + (w * (i + 1));
                        sql += "(select node_id, google_latlon, address, address_fix from panama_addresses";
                        sql += " where google_latlon <@ box(point(" + latA + "," + lonA + "),point(" + latB + "," + lonB + "))";
                        sql += " limit " + limit + ")";
                     }
                }

                Console.WriteLine(sql);
                var rows = con.Query<object>(sql);
                                             
                return Json<object>(rows);
            }
        }

    }
}
