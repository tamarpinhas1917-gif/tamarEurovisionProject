using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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
                string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string selectQuery = "SELECT * FROM personalData";
                    using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        int length = table.Rows.Count;

                        if (length > 0)
                        {
                            st += "<table border=5>";
                            st += "<tr><th>תעודת זהות</th><th>שם פרטי</th><th>שם משפחה</th><th>אזור מגורים</th><th>מנהל?</th><th>עדכן</th><th>מחק</th></tr>";
                            for (int i = 0; i < length; i++)
                            {
                                st += "<tr>";
                                st += "<form method='post' action='adminEditUser.aspx'>";
                                st += "<input type='hidden' name='idnum' value='" + table.Rows[i]["idnum"] + "'/>";
                                st += "<td>" + table.Rows[i]["idnum"] + "</td>";
                                st += "<td><input type='text' name='fname' value='" + table.Rows[i]["fname"] + "'/></td>";
                                st += "<td><input type='text' name='lname' value='" + table.Rows[i]["lname"] + "'/></td>";
                                st += "<td><input type='text' name='area'  value='" + table.Rows[i]["area"] + "'/></td>";
                                if (table.Rows[i]["isAdmin"] != DBNull.Value && (bool)table.Rows[i]["isAdmin"] == true)
                                    st += "<td><input type='checkbox' name='isAdmin' value='true' checked/></td>";
                                else
                                    st += "<td><input type='checkbox' name='isAdmin' value='true'/></td>";
                                st += "<td><input type='submit' name='submit' value='עדכן'/></td>";
                                st += "<td><input type='button' onclick='window.location.href=\"DeleteUser.aspx?idnum=" + table.Rows[i]["idnum"] + "\"' value='מחק'/></td>";
                                st += "</form></tr>";
                            }
                            st += "</table>";
                        }
                        else
                            st = "<p>אין משתמשים רשומים במערכת</p>";
                    }
                }
            }
        }
    }
}
