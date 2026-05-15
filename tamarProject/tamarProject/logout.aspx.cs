using System;
using System.Web;
using System.Web.UI;

namespace tamarProject
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("homePage.aspx");
        }
    }
}
