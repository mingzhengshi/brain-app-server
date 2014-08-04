using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace brain_app_server.brain_app
{
    public partial class getapp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Server.MapPath("Data") + "\\" + "save_json.txt";
            string json = System.IO.File.ReadAllText(path);
            Response.Write(json);
        }
    }
}