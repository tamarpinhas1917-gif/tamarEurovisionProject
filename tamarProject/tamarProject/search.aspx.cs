using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class search : System.Web.UI.Page
    {
        public string usersList = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isAdmin"] == null)
            {
                Response.Write("<body dir='rtl'><strong>הכניסה למנהל בלבד</strong></body>");
                Response.End();
            }
            else
            {
                string fileName    = "db.mdf";
                string tableName   = "personalData";
                string selectQuery = "";

                if (Request.Form["printAll"] != null)
                {
                    selectQuery = "SELECT * FROM " + tableName;
                }
                else if (Request.Form["submit_fname"] != null)
                {
                    selectQuery = "SELECT * FROM " + tableName + " WHERE fname=N'" + Request.Form["fname"] + "'";
                }
                else if (Request.Form["submit_area"] != null)
                {
                    selectQuery = "SELECT * FROM " + tableName + " WHERE area=N'" + Request.Form["area"] + "'";
                }

                if (!string.IsNullOrEmpty(selectQuery))
                {
                    DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectQuery);
                    int length = table.Rows.Count;

                    if (length > 0)
                    {
                        usersList += "<table border=5>";
                        usersList += "<tr><th>תעודת זהות</th><th>שם פרטי</th><th>שם משפחה</th><th>אזור מגורים</th></tr>";
                        for (int i = 0; i < length; i++)
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
                    {
                        usersList = "<p>לא נמצאו תוצאות</p>";
                    }
                }
            }
        }
    }
}
