using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class signUp : System.Web.UI.Page
    {
        public string RegStatus = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["submit"] != null)
            {
                string idnum = Request.Form["idnum"];
                string fname = Request.Form["fname"];
                string lname = Request.Form["lname"];
                string pass  = Request.Form["pass"];
                string area  = Request.Form["area"];

                bool isAdmin = false;

                if (string.IsNullOrEmpty(idnum) || string.IsNullOrEmpty(fname) ||
                    string.IsNullOrEmpty(lname) || string.IsNullOrEmpty(pass))
                {
                    RegStatus = "לא מולאו נתונים כנדרש";
                }
                else
                {
                    string fileName  = "db.mdf";
                    string selectSql = "SELECT * FROM personalData WHERE idnum='" + idnum + "'";

                    if (MyAdoHelper.IsExist(fileName, selectSql))
                    {
                        RegStatus = "מספר תעודת הזהות קיים";
                    }
                    else
                    {
                        string sql = "INSERT INTO personalData(idnum,fname,lname,pass,area,isAdmin) " +
                                     "VALUES('" + idnum + "',N'" + fname + "',N'" + lname + "',N'" +
                                     pass + "',N'" + area + "','" + isAdmin + "')";
                        MyAdoHelper.DoQuery(fileName, sql);
                        RegStatus = "ההרשמה בוצעה בהצלחה נא להתחבר";
                        Response.Redirect("login.aspx?status=" + RegStatus);
                    }
                }
            }
        }
    }
}
