using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace tamarProject
{
    public partial class adminEditUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["submit"] != null)
            {
                string idnum  = Request.Form["idnum"];
                string fname  = Request.Form["fname"];
                string lname  = Request.Form["lname"];
                string area   = Request.Form["area"];
                int isAdmin   = Request.Form["isAdmin"] != null ? 1 : 0;

                string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = "UPDATE personalData SET fname=@fname,lname=@lname,area=@area,isAdmin=@isAdmin WHERE idnum=@idnum";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@fname",   fname);
                        cmd.Parameters.AddWithValue("@lname",   lname);
                        cmd.Parameters.AddWithValue("@area",    area);
                        cmd.Parameters.AddWithValue("@isAdmin", isAdmin);
                        cmd.Parameters.AddWithValue("@idnum",   idnum);
                        cmd.ExecuteNonQuery();
                    }
                }
                Response.Redirect("admin.aspx");
            }
        }
    }
}
