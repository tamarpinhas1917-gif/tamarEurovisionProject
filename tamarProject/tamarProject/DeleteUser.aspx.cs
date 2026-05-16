using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace tamarProject
{
    public partial class DeleteUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isAdmin"] != null)
            {
                if (Request.QueryString["idnum"] != null)
                {
                    string idnum = Request.QueryString["idnum"];
                    string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string sql = "DELETE FROM personalData WHERE idnum=@idnum";
                        using (SqlCommand cmd = new SqlCommand(sql, conn))
                        {
                            cmd.Parameters.AddWithValue("@idnum", idnum);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                Response.Redirect("admin.aspx");
            }
            else
            {
                Response.Write("<body dir='rtl'><strong>הכניסה למנהל בלבד</strong></body>");
                Response.End();
            }
        }
    }
}
