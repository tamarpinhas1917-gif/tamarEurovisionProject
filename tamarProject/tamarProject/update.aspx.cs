using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class update : System.Web.UI.Page
    {
        public string msg      = "";
        public string editUser = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Write("<body dir='rtl'><strong>אין גישה - יש להתחבר תחילה</strong></body>");
                Response.End();
            }
            else
            {
                string fileName = "db.mdf";
                string idnum    = (string)Session["idnum"];

                if (Request.Form["submit"] != null)
                {
                    string fname = Request.Form["fname"];
                    string lname = Request.Form["lname"];
                    string pass  = Request.Form["pass"];
                    string area  = Request.Form["area"];

                    string sql = "UPDATE personalData SET fname=N'" + fname + "',lname=N'" + lname +
                                 "',pass=N'" + pass + "',area=N'" + area +
                                 "' WHERE idnum='" + idnum + "'";
                    MyAdoHelper.DoQuery(fileName, sql);

                    // Update session name
                    Session["user"] = fname + " " + lname;
                    msg = "פרטים עודכנו בהצלחה ✓";
                }

                // Always show current data from DB
                string selectQuery = "SELECT * FROM personalData WHERE idnum='" + idnum + "'";
                DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectQuery);

                if (table.Rows.Count > 0)
                {
                    editUser += "<form action='' id='edit' method='post'>";
                    editUser += "<table border='1' style='border-color:rgba(255,255,255,0.2)'>";

                    editUser += "<tr><td>ת.ז</td><td>";
                    editUser += "<input type='text' name='idnum' readonly value='" + (string)table.Rows[0]["idnum"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td>שם פרטי</td><td>";
                    editUser += "<input type='text' name='fname' value='" + (string)table.Rows[0]["fname"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td>שם משפחה</td><td>";
                    editUser += "<input type='text' name='lname' value='" + (string)table.Rows[0]["lname"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td>סיסמה</td><td>";
                    editUser += "<input type='text' name='pass' value='" + (string)table.Rows[0]["pass"] + "'/>";
                    editUser += "</td></tr>";

                    editUser += "<tr><td>אזור מגורים</td><td><select name='area'>";
                    string[] areas = { "מרכז", "צפון", "דרום", "ירושלים", "שרון" };
                    string currentArea = table.Rows[0]["area"].ToString().Trim();
                    // Show current area first
                    editUser += "<option value='" + currentArea + "'>" + currentArea + "</option>";
                    foreach (string a in areas)
                    {
                        if (a != currentArea)
                            editUser += "<option value='" + a + "'>" + a + "</option>";
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
