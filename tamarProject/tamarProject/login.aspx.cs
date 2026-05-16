using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class login : System.Web.UI.Page
    {
        public string errors = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["submit"] != null)
            {
                string idnum = Request.Form["idnum"];
                string pass = Request.Form["pass"];

                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string selectSql = "SELECT * FROM personalData WHERE idnum=@idnum AND pass=@pass";
                        using (SqlCommand cmd = new SqlCommand(selectSql, conn))
                        {
                            cmd.Parameters.AddWithValue("@idnum", idnum);
                            cmd.Parameters.AddWithValue("@pass", pass);

                            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                            {
                                DataTable table = new DataTable();
                                adapter.Fill(table);

                                if (table.Rows.Count > 0)
                                {
                                    Session["idnum"] = table.Rows[0]["idnum"];
                                    Session["user"] = (string)table.Rows[0]["fname"] + " " + (string)table.Rows[0]["lname"];
                                    Session["isAdmin"] = null;
                                    if (table.Rows[0]["isAdmin"] != DBNull.Value && (bool)table.Rows[0]["isAdmin"] == true)
                                    {
                                        Session["isAdmin"] = "yes";
                                    }
                                    Response.Redirect("homePage.aspx");
                                }
                                else
                                {
                                    errors = "ת.ז או סיסמה לא קיימים במערכת";
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    errors = "שגיאה בעת ההתחברות: " + ex.Message;
                }
            }
        }
    }
}
