using System;
using System.Collections;
using System.Configuration;
using System.Data;
//using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
//using System.Xml.Linq;

public partial class search : System.Web.UI.Page
{
    public string usersList="";//עבור תוצאות החיפו
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["isAdmin"] != null) //הגנה על הדף
        {
            string fileName = "db.mdf";
            string tableName = "personalData";
            string selectQuery = "";
            if (Request.Form["printAll"] != null)     //טיפול בטופס 1
            {
                selectQuery = "SELECT * FROM " + tableName;
            }
            else
                if (Request.Form["submit_fname"] != null)   //טיפול בטופס 2
                {
                    selectQuery = "SELECT * FROM " + tableName + " WHERE fname=N'" + Request.Form["fname"] + "'";
                }
                else

                    if (Request.Form["submit_area"] != null)   //טיפול בטופס 3            
                    {
                        selectQuery = "SELECT * FROM " + tableName + " WHERE area=N'" + Request.Form["area"] + "'";
                    }


            if (selectQuery != "")
            {
                DataTable table = MyAdoHelper.ExecuteDataTable(fileName, selectQuery);
                int length = table.Rows.Count;
                if (length > 0)
                {
                    usersList += "<table border=5>";
                    usersList += "<tr>";
                    usersList += "<th>תעודת זהות</th>";
                    usersList += "<th>שם פרטי</th>";
                    usersList += "<th>שם משפחה</th>";
                    usersList += "<th>איזור מגורים</th>";
                    usersList += "</tr>";
                    for (int i = 0; i < length; i++)
                    {
                        usersList += "<tr>";
                        usersList += "<td>" + table.Rows[i]["idnum"] + "</td>";
                        usersList += "<td>" + table.Rows[i]["fname"] + "</td>";
                        usersList += "<td>" + table.Rows[i]["lname"] + "</td>";
                        usersList += "<td>" + table.Rows[i]["area"] + "</td>";
                        usersList += "</tr>";
                    }
                    usersList += "</table>";
                   
                }
            }
        }
        else
        {
            Response.Write("<body dir='rtl'><strong>" + "הכניסה למנהל בלבד " + "</strong></body>");
            Response.End();
            
        }
    }
}
             
