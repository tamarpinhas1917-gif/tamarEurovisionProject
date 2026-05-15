using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class login : System.Web.UI.Page
    {
        public string errors = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string fileName = "db.mdf";
            if (Request.Form["submit"] != null)
            {
                string idnum = Request.Form["idnum"];
                string pass = Request.Form["pass"];

                string selectSql = "SELECT * FROM personalData WHERE idnum='" + idnum + "' and pass='" + pass + "'";
                if (MyAdoHelper.IsExist(fileName, selectSql))
                {
                    DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectSql);
                    Session["idnum"] = table.Rows[0]["idnum"];
                    Session["user"] = (string)table.Rows[0]["fname"] + " " + (string)table.Rows[0]["lname"];
                    Session["isAdmin"] = null;
                    if ((bool)table.Rows[0]["isAdmin"] == true)
                    {
                        Session["isAdmin"] = "yes";
                    }
                    Response.Redirect("homePage.aspx");
                }
                else
                {
                    errors = "ת.ז או סיסמה לא קיימים במערכת";
                }
            }
        }
    }
}
