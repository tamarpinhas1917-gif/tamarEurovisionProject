using System;
using System.Data;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class homePage : System.Web.UI.Page
{
    public string Link = "";//תפריט דינמי
    public string userMsg = "";
    public string userCounter = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string counter;
        //יצירת תפריט דינמי (משתנה) בהתאם לסוג המשתמש 
        if (Session["user"] == null)     // נכנס אורח
        {
            Link += "<a href='login.aspx' > התחברות</a> &nbsp;&nbsp;";
            Link += "<a href='signUp.aspx' >הרשמה</a>&nbsp;&nbsp;";
        }
        else                                  //נכנס משתמש רשום
        {
            if (Session["isAdmin"] != null)    // התחבר המנהל
            {

                Link += "<a href='admin.aspx'> פאנל ניהול </a>&nbsp;&nbsp;&nbsp;&nbsp;";
                Link += "<a href='search.aspx'> חיפוש </a>&nbsp;&nbsp;&nbsp;&nbsp;";
                Link += "<a href='logout.aspx'> התנתק  </a>&nbsp;&nbsp;";
            }
            else    //משתמש רשום
            {
                Link += "<a href='update.aspx'> עדכן פרטים אישיים </a>&nbsp;&nbsp;&nbsp;&nbsp;";
                Link += "<a href='logout.aspx'> התנתק  </a>";

            }
        }

        Application.Lock();//נעילת גישה למשתמשים אחרים
        if (Application["mycount"] == null)//  אם האובייקט ריק
        {
            Application["mycount"] = 0;
        }

        if (Session["firstLog"] == null && Session["user"] != null)//   מספר משתמשים רשומים שנכנסו לאתר בפעם הראשונה
        {
            Application["mycount"] = (int)Application["mycount"] + 1;
            Session["firstLog"] = "no";   // המונה יקודם  פעם אחת עבור כל כניסת משתמש רשום
        }
        Application.UnLock();    //שחרור הנעילה

        counter = Application["mycount"].ToString();

        if (Session["user"] != null)
        {
            userMsg = " משתמש מחובר :  <strong>" + Session["user"] + "</strong>";

        }
        userCounter += " מספר כניסות : " + counter;

    }
}
