using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class signUp : System.Web.UI.Page
    {
        public string RegStatus = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form["submit"] != null)
            {
                string idnum = Request.Form["idnum"];
                string fname = Request.Form["fname"];
                string lname = Request.Form["lname"];
                string pass  = Request.Form["pass"];
                string area  = Request.Form["area"];

                bool isAdmin = false;

                if (string.IsNullOrEmpty(idnum) || string.IsNullOrEmpty(fname) ||
                    string.IsNullOrEmpty(lname) || string.IsNullOrEmpty(pass))
                {
                    RegStatus = "לא מולאו נתונים כנדרש";
                }
                else
                {
                    try
                    {
                        string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();

                            // Check if user already exists
                            string selectSql = "SELECT * FROM personalData WHERE idnum=@idnum";
                            using (SqlCommand checkCmd = new SqlCommand(selectSql, conn))
                            {
                                checkCmd.Parameters.AddWithValue("@idnum", idnum);
                                using (SqlDataReader reader = checkCmd.ExecuteReader())
                                {
                                    if (reader.HasRows)
                                    {
                                        RegStatus = "מספר תעודת הזהות קיים";
                                        return;
                                    }
                                }
                            }

                            // Insert new user
                            string insertSql = "INSERT INTO personalData(idnum,fname,lname,pass,area,isAdmin) " +
                                             "VALUES(@idnum,@fname,@lname,@pass,@area,@isAdmin)";
                            using (SqlCommand insertCmd = new SqlCommand(insertSql, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@idnum", idnum);
                                insertCmd.Parameters.AddWithValue("@fname", fname);
                                insertCmd.Parameters.AddWithValue("@lname", lname);
                                insertCmd.Parameters.AddWithValue("@pass", pass);
                                insertCmd.Parameters.AddWithValue("@area", area);
                                insertCmd.Parameters.AddWithValue("@isAdmin", isAdmin);

                                insertCmd.ExecuteNonQuery();
                                RegStatus = "ההרשמה בוצעה בהצלחה נא להתחבר";
                                Response.Redirect("login.aspx?status=" + RegStatus);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        RegStatus = "שגיאה בעת ההרשמה: " + ex.Message;
                    }
                }
            }
        }
    }
}
