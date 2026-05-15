using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class admin : System.Web.UI.Page
    {
        public string st = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isAdmin"] == null)
            {
                st = "<div style='color:#ff0085;font-size:1.4rem;text-align:center;margin-top:80px;'>אין גישה לדף זה</div>";
            }
            else
            {
                string fileName = "db.mdf";
                string selectQuery = "SELECT * FROM personalData";
                DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectQuery);
                int length = table.Rows.Count;

                if (length > 0)
                {
                    st += "<table border=5>";
                    st += "<tr>";
                    st += "<th>תעודת זהות</th>";
                    st += "<th>שם פרטי</th>";
                    st += "<th>שם משפחה</th>";
                    st += "<th>אזור מגורים</th>";
                    st += "<th>מנהל?</th>";
                    st += "<th>עדכן</th>";
                    st += "<th>מחק</th>";
                    st += "</tr>";

                    for (int i = 0; i < length; i++)
                    {
                        st += "<tr>";
                        st += "<form method='post' action='adminEditUser.aspx'>";
                        st += "<input type='hidden' name='idnum' value='" + table.Rows[i]["idnum"] + "'/>";
                        st += "<td>" + table.Rows[i]["idnum"] + "</td>";
                        st += "<td><input type='text' name='fname' value='" + table.Rows[i]["fname"] + "'/></td>";
                        st += "<td><input type='text' name='lname' value='" + table.Rows[i]["lname"] + "'/></td>";
                        st += "<td><input type='text' name='area'  value='" + table.Rows[i]["area"] + "'/></td>";

                        if ((bool)table.Rows[i]["isAdmin"] == true)
                            st += "<td><input type='checkbox' name='isAdmin' value='true' checked/></td>";
                        else
                            st += "<td><input type='checkbox' name='isAdmin' value='true'/></td>";

                        st += "<td><input type='submit' name='submit' value='עדכן'/></td>";
                        st += "<td><input type='button' onclick='window.location.href=\"DeleteUser.aspx?idnum=" + table.Rows[i]["idnum"] + "\"' value='מחק'/></td>";
                        st += "</form>";
                        st += "</tr>";
                    }
                    st += "</table>";
                }
                else
                {
                    st = "<p>אין משתמשים רשומים במערכת</p>";
                }
            }
        }
    }
}
