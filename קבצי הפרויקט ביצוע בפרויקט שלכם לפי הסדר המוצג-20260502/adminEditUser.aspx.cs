using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class adminEditUser : System.Web.UI.Page
{
    //קובץ זה מופעל ע"י קישור מהקובץ
    // שבפאנל הניהול  admin.aspx 
    //הקובץ מוגדר כיעד בשליחת טופס. הקובץ מופעל על טופס הרשומה שכפתור השליחה שייך לה
    protected void Page_Load(object sender, EventArgs e)
    {
        string fileName = "db.mdf";
        if (Request.Form["submit"] != null)
        {
            string idnum = Request.Form["idnum"];
            int isAdmin = 0;
            string fname = Request.Form["fname"];
            string lname = Request.Form["lname"];
            string area = Request.Form["area"];

            if (Request.Form["isAdmin"] != null)
                isAdmin = 1;

            string sql = "UPDATE personalData SET fname=N'" + fname + "',lname=N'" + lname + "',area=N'" + area + "' ,isAdmin='" + isAdmin + "' WHERE idnum='" + idnum + "'";
            MyAdoHelper.DoQuery(fileName, sql);
          
           Response.Redirect("admin.aspx");

        }
    }
}