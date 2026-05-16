using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            string idnum = (string)Session["idnum"];

            if (Request.Form["submit"] != null)
            {
                string fname = Request.Form["fname"];
                string lname = Request.Form["lname"];
                string pass  = Request.Form["pass"];
                string area  = Request.Form["area"];

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = "UPDATE personalData SET fname=@fname,lname=@lname,pass=@pass,area=@area WHERE idnum=@idnum";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@fname", fname);
                        cmd.Parameters.AddWithValue("@lname", lname);
                        cmd.Parameters.AddWithValue("@pass",  pass);
                        cmd.Parameters.AddWithValue("@area",  area);
                        cmd.Parameters.AddWithValue("@idnum", idnum);
                        cmd.ExecuteNonQuery();
                    }
                }
                Session["user"] = fname + " " + lname;
                msg = "פרטים עודכנו בהצלחה ✓";
            }

            // Always reload current data from DB
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string selectQuery = "SELECT * FROM personalData WHERE idnum=@idnum";
                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@idnum", idnum);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        if (table.Rows.Count > 0)
                        {
                            editUser += "<form action='' id='edit' method='post'>";
                            editUser += "<table border='1' style='border-color:rgba(255,255,255,0.2)'>";
                            editUser += "<tr><td>ת.ז</td><td><input type='text' name='idnum' readonly value='" + table.Rows[0]["idnum"] + "'/></td></tr>";
                            editUser += "<tr><td>שם פרטי</td><td><input type='text' name='fname' value='" + table.Rows[0]["fname"] + "'/></td></tr>";
                            editUser += "<tr><td>שם משפחה</td><td><input type='text' name='lname' value='" + table.Rows[0]["lname"] + "'/></td></tr>";
                            editUser += "<tr><td>סיסמה</td><td><input type='text' name='pass' value='" + table.Rows[0]["pass"] + "'/></td></tr>";
                            editUser += "<tr><td>אזור מגורים</td><td><select name='area'>";
                            string[] areas = { "מרכז", "צפון", "דרום", "ירושלים", "שרון" };
                            string currentArea = table.Rows[0]["area"].ToString().Trim();
                            editUser += "<option value='" + currentArea + "'>" + currentArea + "</option>";
                            foreach (string a in areas)
                                if (a != currentArea)
                                    editUser += "<option value='" + a + "'>" + a + "</option>";
                            editUser += "</select></td></tr>";
                            editUser += "</table><br/>";
                            editUser += "<input type='submit' name='submit' value='עדכן'/>";
                            editUser += "</form>";
                        }
                    }
                }
            }
        }
    }
}
