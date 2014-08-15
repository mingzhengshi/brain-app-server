using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace brain_app_server.brain_app
{
    public partial class upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ip = Request.UserHostAddress;
            string filename = Guid.NewGuid().ToString();
            if ((ip != null) && (!ip.Contains("::"))) filename += ("_" + ip);

            string fileText = Request.Form["fileText"];
            string type = Request.Form["type"];

            filename += ("_" + type);

            string path = Server.MapPath("save") + "\\" + filename + ".txt";

            try
            {
                System.IO.File.WriteAllText(path, fileText);
            }
            catch
            {
            }

            Response.Write(filename);
        }
    }
}