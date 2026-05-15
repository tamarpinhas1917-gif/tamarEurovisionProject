using System;
using System.Web;
using System.Web.UI;

namespace tamarProject
{
    public partial class DeleteUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isAdmin"] != null)
            {
                string fileName = "db.mdf";
                if (Request.QueryString["idnum"] != null)
                {
                    string idnum = Request.QueryString["idnum"];
                    string sql = "DELETE FROM personalData WHERE idnum='" + idnum + "'";
                    MyAdoHelper.DoQuery(fileName, sql);
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
