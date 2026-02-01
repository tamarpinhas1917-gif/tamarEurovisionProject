using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace tamarProject
{
    public partial class fashion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic
        }

        /// <summary>
        /// Returns all Eurovision data as JSON for JavaScript
        /// </summary>
        protected string GetEurovisionDataJson()
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                string jsonContent = File.ReadAllText(filePath);
                return jsonContent;
            }
            catch (Exception)
            {
                return "[]";
            }
        }
    }
}
