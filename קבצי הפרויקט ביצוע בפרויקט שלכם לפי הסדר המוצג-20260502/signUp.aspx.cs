using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace projectIris
{
    public partial class signUp : System.Web.UI.Page
    {
        public string RegStatus = "";//משתנה גלובלי לשמירת הודעות שיוצגו בטופס ההרשמה או בדף הבית

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["submit"] != null)
            {
                // קבלת נתוני המשתמשים מהטופס
                string idnum = Request.Form["idnum"];
                string fname = Request.Form["fname"];
                string lname = Request.Form["lname"];
                string pass = Request.Form["pass"];
                string area = Request.Form["area"];

                bool isAdmin = false;//  יכנס אוטומטית  שקר למשתמש רגיל שאינו מנהל

                if ((idnum == "") || (idnum == null) || (fname == "") || (fname == null) || (lname == "") || (lname == null) || (pass == "") || (pass == null))
                    RegStatus = "לא מולאו נתונים כנדרש";
                else
                {
                    string fileName = "db.mdf"; //שם קובץ ה-data base
                    string selectSql = "SELECT * FROM personalData WHERE idnum='" + idnum + "'";
                    if (MyAdoHelper.IsExist(fileName, selectSql))
                        RegStatus = "מספר תעודת הזהות קיים";
                    else
                    {
                        string sql = "INSERT INTO personalData(idnum,fname,lname,pass,area,isAdmin) VALUES('" + idnum + "',N'" + fname + "',N'" + lname + "',N'" + pass + "',N'" + area + "','" + isAdmin + "')";
                        MyAdoHelper.DoQuery(fileName, sql);
                        RegStatus = " ההרשמה בוצעה בהצלחה נא להתחבר";
                        Response.Redirect("login.aspx?status=" + RegStatus);


                    }
                }

            }
        }
    }

}
