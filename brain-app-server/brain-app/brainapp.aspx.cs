using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace brain_app_server
{
    public partial class brainapp : System.Web.UI.Page
    {
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
            this.button_submit_file.Click += new System.EventHandler(this.SubmitFileButtonClick);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void SubmitFileButtonClick(object sender, System.EventArgs e)
        {
            if ((input_select_file.PostedFile != null) && (input_select_file.PostedFile.ContentLength > 0))
            {
                string fn = System.IO.Path.GetFileName(input_select_file.PostedFile.FileName);
                string SaveLocation = Server.MapPath("Data") + "\\" + fn;
                try
                {
                    input_select_file.PostedFile.SaveAs(SaveLocation);
                    //Response.Write("The file has been uploaded.");
                }
                catch (Exception ex)
                {
                    //Response.Write("Error: " + ex.Message);
                    //Note: Exception.Message returns a detailed message that describes the current exception. 
                    //For security reasons, we do not recommend that you return Exception.Message to end users in 
                    //production environments. It would be better to return a generic error message. 
                }
            }
            else
            {
                //Response.Write("Please select a file to upload.");
            }
        }
    }
}