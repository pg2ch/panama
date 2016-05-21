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
            int y = 5;
            int x = 5;
            double h = (lat2 - lat1) / y;
            double w = (lon2 - lon1) / x;

            using (var con = Model.GetDB())
            {
                var sql = @"
                    select 
                        node_id,
                        address,
                        google_latlon,
                        address_fix
                    from 
                        panama_addresses 
                    where
                        google_latlon is not null
                        and google_latlon @ box(point(@Lat1,@Lon1),point(@Lat2,@Lon2))
                    limit 10
                ";

                var ret = new List<object>();

                for (int j = 0; j < y; j++)
                {
                    for (int i = 0; i < x; i++)
                    {
                        var rows = con.Query<object>(sql, new
                        {
                            Lat1 = lat1 + (h * (j + 0)),
                            Lon1 = lon1 + (w * (i + 0)),
                            Lat2 = lat1 + (h * (j + 1)),
                            Lon2 = lon1 + (w * (i + 1)),
                        });
                        ret.AddRange(rows);
                    }
                }

                return Json<object>(ret);
            }
        }

    }
}
