using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    /// <summary>
    /// עמוד התחברות
    /// מאפשר למשתמשים להתחבר למערכת
    /// </summary>
    public partial class login : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ המשתמשים
        /// </summary>
        private string _usersFilePath;

        /// <summary>
        /// מספר מקסימלי של ניסיונות כושלים
        /// </summary>
        private const int MAX_LOGIN_ATTEMPTS = 3;

        /// <summary>
        /// זמן נעילה במילישניות (5 דקות)
        /// </summary>
        private const int LOCKOUT_TIME_MINUTES = 5;

        #endregion

        #region Page Lifecycle - מחזור חיי העמוד

        /// <summary>
        /// אירוע טעינת העמוד
        /// </summary>
        /// <param name="sender">האובייקט ששלח את האירוע</param>
        /// <param name="e">מידע על האירוע</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // טעינה ראשונית
                InitializeLoginPage();
                CheckIfAlreadyLoggedIn();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד ההתחברות
        /// </summary>
        private void InitializeLoginPage()
        {
            try
            {
                _usersFilePath = Server.MapPath("~/App_Data/users.json");
                
                // ניקוי הודעות קודמות
                ClearMessages();
                
                LogMessage("InitializeLoginPage", "עמוד ההתחברות נטען");
            }
            catch (Exception ex)
            {
                LogError("InitializeLoginPage", ex.Message);
            }
        }

        /// <summary>
        /// בודקת אם המשתמש כבר מחובר
        /// </summary>
        private void CheckIfAlreadyLoggedIn()
        {
            if (IsUserLoggedIn())
            {
                // ניתוב לעמוד הבית אם כבר מחובר
                Response.Redirect("homePage.aspx");
            }
        }

        #endregion

        #region Authentication Methods - מתודות אימות

        /// <summary>
        /// מנסה להתחבר עם שם משתמש וסיסמה
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <param name="password">הסיסמה</param>
        /// <returns>true אם ההתחברות הצליחה</returns>
        public bool AttemptLogin(string username, string password)
        {
            try
            {
                // ולידציה של קלט
                if (!ValidateLoginInput(username, password))
                {
                    return false;
                }

                // בדיקה אם החשבון נעול
                if (IsAccountLocked(username))
                {
                    ShowErrorMessage("החשבון נעול זמנית. נסה שוב מאוחר יותר.");
                    return false;
                }

                // אימות פרטי ההתחברות
                if (ValidateCredentials(username, password))
                {
                    // התחברות מוצלחת
                    CreateUserSession(username);
                    ResetLoginAttempts(username);
                    
                    LogMessage("AttemptLogin", $"משתמש {username} התחבר בהצלחה");
                    return true;
                }
                else
                {
                    // התחברות כושלת
                    IncrementLoginAttempts(username);
                    ShowErrorMessage("שם משתמש או סיסמה שגויים");
                    
                    LogMessage("AttemptLogin", $"ניסיון התחברות כושל עבור {username}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogError("AttemptLogin", ex.Message);
                ShowErrorMessage("אירעה שגיאה במהלך ההתחברות");
                return false;
            }
        }

        /// <summary>
        /// בודקת אם פרטי ההתחברות נכונים
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <param name="password">הסיסמה</param>
        /// <returns>true אם הפרטים נכונים</returns>
        private bool ValidateCredentials(string username, string password)
        {
            try
            {
                // קריאת משתמשים מהקובץ (לצורכי הדגמה בלבד)
                // במערכת אמיתית יש להשתמש בהצפנה ובסיסמאות מוצפנות
                
                // לדוגמה: בדיקה פשוטה
                // בפרויקט אמיתי צריך לקרוא מקובץ JSON או מסד נתונים
                
                if (username == "tamar" && password == "eurovision2024")
                {
                    return true;
                }
                
                // כאן אפשר להוסיף קריאה מקובץ משתמשים
                // var users = LoadUsersFromFile();
                // return users.Any(u => u.Username == username && u.Password == password);
                
                return false;
            }
            catch (Exception ex)
            {
                LogError("ValidateCredentials", ex.Message);
                return false;
            }
        }

        #endregion

        #region Session Management - ניהול סשן

        /// <summary>
        /// יוצרת סשן למשתמש מחובר
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        private void CreateUserSession(string username)
        {
            Session["IsLoggedIn"] = true;
            Session["Username"] = username;
            Session["LoginTime"] = DateTime.Now;
        }

        /// <summary>
        /// בודקת אם המשתמש מחובר
        /// </summary>
        /// <returns>true אם מחובר</returns>
        public bool IsUserLoggedIn()
        {
            return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
        }

        /// <summary>
        /// מנתקת את המשתמש
        /// </summary>
        public void LogoutUser()
        {
            Session.Clear();
            Session.Abandon();
            
            LogMessage("LogoutUser", "משתמש התנתק");
        }

        /// <summary>
        /// מחזירה את שם המשתמש המחובר
        /// </summary>
        /// <returns>שם המשתמש או null</returns>
        public string GetLoggedInUsername()
        {
            if (IsUserLoggedIn())
            {
                return Session["Username"]?.ToString();
            }
            return null;
        }

        #endregion

        #region Validation Methods - מתודות אימות

        /// <summary>
        /// מאמתת קלט התחברות
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <param name="password">הסיסמה</param>
        /// <returns>true אם הקלט תקין</returns>
        private bool ValidateLoginInput(string username, string password)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                ShowErrorMessage("נא להזין שם משתמש");
                return false;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                ShowErrorMessage("נא להזין סיסמה");
                return false;
            }

            if (username.Length < 3)
            {
                ShowErrorMessage("שם משתמש חייב להכיל לפחות 3 תווים");
                return false;
            }

            if (password.Length < 6)
            {
                ShowErrorMessage("סיסמה חייבת להכיל לפחות 6 תווים");
                return false;
            }

            return true;
        }

        #endregion

        #region Security Methods - מתודות אבטחה

        /// <summary>
        /// בודקת אם החשבון נעול
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <returns>true אם החשבון נעול</returns>
        private bool IsAccountLocked(string username)
        {
            if (Session[$"Locked_{username}"] != null)
            {
                DateTime lockTime = (DateTime)Session[$"Locked_{username}"];
                
                if (DateTime.Now.Subtract(lockTime).TotalMinutes < LOCKOUT_TIME_MINUTES)
                {
                    return true;
                }
                else
                {
                    // הזמן עבר, נסיר את הנעילה
                    Session.Remove($"Locked_{username}");
                    Session.Remove($"Attempts_{username}");
                }
            }
            
            return false;
        }

        /// <summary>
        /// מגדילה את מונה ניסיונות ההתחברות
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        private void IncrementLoginAttempts(string username)
        {
            int attempts = 0;
            
            if (Session[$"Attempts_{username}"] != null)
            {
                attempts = (int)Session[$"Attempts_{username}"];
            }
            
            attempts++;
            Session[$"Attempts_{username}"] = attempts;
            
            if (attempts >= MAX_LOGIN_ATTEMPTS)
            {
                Session[$"Locked_{username}"] = DateTime.Now;
                ShowErrorMessage($"חרגת ממספר הניסיונות המותר. החשבון ננעל ל-{LOCKOUT_TIME_MINUTES} דקות.");
            }
        }

        /// <summary>
        /// מאפסת את מונה ניסיונות ההתחברות
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        private void ResetLoginAttempts(string username)
        {
            Session.Remove($"Attempts_{username}");
            Session.Remove($"Locked_{username}");
        }

        #endregion

        #region UI Methods - מתודות ממשק משתמש

        /// <summary>
        /// מציגה הודעת שגיאה למשתמש
        /// </summary>
        /// <param name="message">ההודעה להצגה</param>
        private void ShowErrorMessage(string message)
        {
            // במימוש מלא, זה יעדכן Label או Literal בעמוד
            ViewState["ErrorMessage"] = message;
            System.Diagnostics.Debug.WriteLine($"[ERROR] {message}");
        }

        /// <summary>
        /// מציגה הודעת הצלחה למשתמש
        /// </summary>
        /// <param name="message">ההודעה להצגה</param>
        private void ShowSuccessMessage(string message)
        {
            ViewState["SuccessMessage"] = message;
            System.Diagnostics.Debug.WriteLine($"[SUCCESS] {message}");
        }

        /// <summary>
        /// מנקה הודעות קודמות
        /// </summary>
        private void ClearMessages()
        {
            ViewState.Remove("ErrorMessage");
            ViewState.Remove("SuccessMessage");
        }

        #endregion

        #region Helper Methods - מתודות עזר

        /// <summary>
        /// רושמת הודעה ללוג
        /// </summary>
        /// <param name="methodName">שם המתודה</param>
        /// <param name="message">ההודעה</param>
        private void LogMessage(string methodName, string message)
        {
            System.Diagnostics.Debug.WriteLine($"[INFO] {methodName}: {message}");
        }

        /// <summary>
        /// רושמת שגיאה ללוג
        /// </summary>
        /// <param name="methodName">שם המתודה</param>
        /// <param name="errorMessage">הודעת השגיאה</param>
        private void LogError(string methodName, string errorMessage)
        {
            System.Diagnostics.Debug.WriteLine($"[ERROR] {methodName}: {errorMessage}");
        }

        #endregion
    }
}