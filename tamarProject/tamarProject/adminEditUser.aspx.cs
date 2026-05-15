using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class adminEditUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fileName = "db.mdf";
            if (Request.Form["submit"] != null)
            {
                string idnum = Request.Form["idnum"];
                string fname = Request.Form["fname"];
                string lname = Request.Form["lname"];
                string area  = Request.Form["area"];
                int isAdmin  = 0;

                if (Request.Form["isAdmin"] != null)
                    isAdmin = 1;

                string sql = "UPDATE personalData SET fname=N'" + fname + "',lname=N'" + lname +
                             "',area=N'" + area + "',isAdmin='" + isAdmin +
                             "' WHERE idnum='" + idnum + "'";
                MyAdoHelper.DoQuery(fileName, sql);
                Response.Redirect("admin.aspx");
            }
        }
    }
}
