using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class update : System.Web.UI.Page
{
    public string msg;
    public string editUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
            Response.Write(" אין גישה");
        else
        {
            string fileName = "db.mdf";
            string idnum = (string)Session["idnum"];
            if (Request.Form["submit"] != null)
            {
                string fname = Request.Form["fname"]; //קבלת נתוני העדכון מהטופס
                string lname = Request.Form["lname"];
                string pass = Request.Form["pass"];
                string area = Request.Form["area"];


                string sql = "UPDATE personalData SET fname=N'" + fname + "',lname=N'" + lname + "',pass=N'" + pass + "',area=N'" + area + "' WHERE idnum='" + idnum + "'";
                MyAdoHelper.DoQuery(fileName, sql);
                msg = " עודכנו פרטים";

            }
            else  //יש להציג את פרטי המשתמש הנוכחי מהטופס
            {
                string selectQuery = "SELECT * FROM  personalData WHERE idnum='" + idnum + "'";
                DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectQuery);// אובייקט DataTable שומר עותק נתונים של תוצאות השאילתה
                int length = table.Rows.Count;            // מספר הרשומות בטבלה
                if (length > 0)
                {
                    editUser += "<form action='' id='edit' method='post'>";
                    editUser += "<table border='1' style='margin-right:500px' width=30%>";
                    editUser += "<tr><td> ת.ז </td><td>";
                    editUser += "<input type='text' name='idnum' id='idnum' readonly value='" + (string)table.Rows[0]["idnum"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td> שם פרטי </td><td>";
                    editUser += "<input type='text' name='fname' id='fname' value='" + (string)table.Rows[0]["fname"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td> שם משפחה </td><td>";
                    editUser += "<input type='text' name='lname' id='lname' value='" + (string)table.Rows[0]["lname"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td> סיסמה </td><td>";
                    editUser += "<input type='text' name='pass' id='pass' value='" + (string)table.Rows[0]["pass"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td> אזור מגורים </td><td><select name='area' id='area'>";
                    if (table.Rows[0]["area"].ToString().Trim().Equals("מרכז"))
                    {
                        editUser += "<option value='מרכז'>מרכז</option>";
                        editUser += "<option value='צפון'>צפון</option>";
                        editUser += "<option value='דרום'>דרום</option>";
                    }
                    if (table.Rows[0]["area"].ToString().Trim().Equals("צפון"))
                    {
                        editUser += "<option value='צפון'>צפון</option>";
                        editUser += "<option value='מרכז'>מרכז</option>";
                        editUser += "<option value='דרום'>דרום</option>";
                    }
                    if (table.Rows[0]["area"].ToString().Trim().Equals("דרום"))
                    {
                        editUser += "<option value='דרום'>דרום</option>";
                        editUser += "<option value='מרכז'>מרכז</option>";
                        editUser += "<option value='צפון'>צפון</option>";

                    }
                    editUser += "</select></td></tr>";


                    editUser += "</table><br/>";
                    editUser += "<input type='submit' name='submit' value='עדכן'/>";
                    editUser += "</form>";

                }

            }

        }
    }
}


