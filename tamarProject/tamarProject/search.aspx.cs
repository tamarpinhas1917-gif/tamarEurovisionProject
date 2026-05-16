using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace tamarProject
{
    public partial class search : System.Web.UI.Page
    {
        public string usersList = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isAdmin"] == null)
            {
                Response.Write("<body dir='rtl'><strong>Admin access only</strong></body>");
                Response.End();
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            string selectQuery = "";
            string paramName   = "";
            string paramValue  = "";

            if (Request.Form["printAll"] != null)
                selectQuery = "SELECT * FROM personalData";
            else if (Request.Form["submit_fname"] != null)
            {
                selectQuery = "SELECT * FROM personalData WHERE fname=@param";
                paramName   = "@param";
                paramValue  = Request.Form["fname"];
            }
            else if (Request.Form["submit_area"] != null)
            {
                selectQuery = "SELECT * FROM personalData WHERE area=@param";
                paramName   = "@param";
                paramValue  = Request.Form["area"];
            }

            if (!string.IsNullOrEmpty(selectQuery))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                    {
                        if (!string.IsNullOrEmpty(paramName))
                            cmd.Parameters.AddWithValue(paramName, paramValue);

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable table = new DataTable();
                            adapter.Fill(table);

                            if (table.Rows.Count > 0)
                            {
                                usersList += "<table border=5>";
                                usersList += "<tr><th>ID Number</th><th>First Name</th><th>Last Name</th><th>Area</th></tr>";
                                for (int i = 0; i < table.Rows.Count; i++)
                                {
                                    usersList += "<tr>";
                                    usersList += "<td>" + table.Rows[i]["idnum"] + "</td>";
                                    usersList += "<td>" + table.Rows[i]["fname"] + "</td>";
                                    usersList += "<td>" + table.Rows[i]["lname"] + "</td>";
                                    usersList += "<td>" + table.Rows[i]["area"]  + "</td>";
                                    usersList += "</tr>";
                                }
                                usersList += "</table>";
                            }
                            else
                                usersList = "<p>לא נמצאו תוצאות</p>";
                        }
                    }
                }
            }
        }
    }
}
