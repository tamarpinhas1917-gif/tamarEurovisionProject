using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    public partial class homePage : System.Web.UI.Page
    {
        public string Link = "";       // dynamic navigation links
        public string userMsg = "";    // logged-in user message
        public string userCounter = ""; // visitor counter

        protected void Page_Load(object sender, EventArgs e)
        {
            string counter;

            // Build dynamic navigation based on session state
            if (Session["user"] == null)  // Guest
            {
                Link += "<a href='login.aspx'>Login</a>&nbsp;&nbsp;";
                Link += "<a href='signUp.aspx'>Sign Up</a>&nbsp;&nbsp;";
            }
            else  // Logged-in user
            {
                if (Session["isAdmin"] != null)  // Admin
                {
                    Link += "<a href='admin.aspx'>Admin Panel</a>&nbsp;&nbsp;";
                    Link += "<a href='search.aspx'>Search Users</a>&nbsp;&nbsp;";
                    Link += "<a href='update.aspx'>My Profile</a>&nbsp;&nbsp;";
                    Link += "<a href='logout.aspx'>Logout</a>&nbsp;&nbsp;";
                }
                else  // Regular user
                {
                    Link += "<a href='update.aspx'>My Profile</a>&nbsp;&nbsp;";
                    Link += "<a href='logout.aspx'>Logout</a>&nbsp;&nbsp;";
                }
            }

            // Application-level visitor counter (thread-safe)
            Application.Lock();
            if (Application["mycount"] == null)
                Application["mycount"] = 0;

            if (Session["firstLog"] == null && Session["user"] != null)
            {
                Application["mycount"] = (int)Application["mycount"] + 1;
                Session["firstLog"] = "no";  // count once per session
            }
            Application.UnLock();

            counter = Application["mycount"].ToString();

            if (Session["user"] != null)
                userMsg = "Logged in: <strong>" + Session["user"] + "</strong>";

            userCounter = "Visitors: " + counter;
        }
    }
}
