using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Http;
using System.Configuration;
using System.Data;
using Dapper;
using Npgsql;

namespace PanaMap.Models
{
    public class Model
    {
        public static NpgsqlConnection GetDB()
        {
            var cs = ConfigurationManager.ConnectionStrings["default"].ConnectionString;
            var con = new NpgsqlConnection(cs);
            con.Open();
            return con;
        }
    }
}

