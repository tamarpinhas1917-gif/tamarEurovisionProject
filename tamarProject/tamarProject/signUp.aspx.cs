using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    /// <summary>
    /// עמוד הרשמה
    /// מאפשר למשתמשים חדשים להירשם למערכת
    /// </summary>
    public partial class signUp : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ המשתמשים
        /// </summary>
        private string _usersFilePath;

        /// <summary>
        /// אורך מינימלי לשם משתמש
        /// </summary>
        private const int MIN_USERNAME_LENGTH = 3;

        /// <summary>
        /// אורך מינימלי לסיסמה
        /// </summary>
        private const int MIN_PASSWORD_LENGTH = 6;

        /// <summary>
        /// אורך מקסימלי לשם משתמש
        /// </summary>
        private const int MAX_USERNAME_LENGTH = 20;

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
                InitializeSignUpPage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד ההרשמה
        /// </summary>
        private void InitializeSignUpPage()
        {
            try
            {
                _usersFilePath = Server.MapPath("~/App_Data/users.json");
                
                // יצירת תיקייה אם לא קיימת
                string directory = Path.GetDirectoryName(_usersFilePath);
                if (!Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }
                
                // יצירת קובץ ריק אם לא קיים
                if (!File.Exists(_usersFilePath))
                {
                    File.WriteAllText(_usersFilePath, "[]");
                }
                
                ClearMessages();
                LogMessage("InitializeSignUpPage", "עמוד ההרשמה נטען");
            }
            catch (Exception ex)
            {
                LogError("InitializeSignUpPage", ex.Message);
            }
        }

        #endregion

        #region Registration Methods - מתודות הרשמה

        /// <summary>
        /// מנסה לרשום משתמש חדש
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <param name="password">הסיסמה</param>
        /// <param name="email">כתובת אימייל</param>
        /// <param name="fullName">שם מלא</param>
        /// <returns>true אם ההרשמה הצליחה</returns>
        public bool RegisterNewUser(string username, string password, string email, string fullName)
        {
            try
            {
                // ולידציה של כל השדות
                if (!ValidateRegistrationInput(username, password, email, fullName))
                {
                    return false;
                }

                // בדיקה אם שם המשתמש כבר קיים
                if (IsUsernameExists(username))
                {
                    ShowErrorMessage("שם המשתמש כבר קיים במערכת");
                    return false;
                }

                // בדיקה אם האימייל כבר קיים
                if (IsEmailExists(email))
                {
                    ShowErrorMessage("כתובת האימייל כבר רשומה במערכת");
                    return false;
                }

                // יצירת משתמש חדש
                var newUser = CreateUserObject(username, password, email, fullName);
                
                // שמירה לקובץ
                if (SaveNewUser(newUser))
                {
                    ShowSuccessMessage("ההרשמה הושלמה בהצלחה!");
                    LogMessage("RegisterNewUser", $"משתמש חדש נרשם: {username}");
                    
                    // ניתוב לעמוד התחברות
                    Response.Redirect("login.aspx?registered=true");
                    return true;
                }
                else
                {
                    ShowErrorMessage("אירעה שגיאה בשמירת הנתונים");
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogError("RegisterNewUser", ex.Message);
                ShowErrorMessage("אירעה שגיאה במהלך ההרשמה");
                return false;
            }
        }

        /// <summary>
        /// יוצרת אובייקט משתמש חדש
        /// </summary>
        /// <param name="username">שם משתמש</param>
        /// <param name="password">סיסמה</param>
        /// <param name="email">אימייל</param>
        /// <param name="fullName">שם מלא</param>
        /// <returns>אובייקט משתמש</returns>
        private object CreateUserObject(string username, string password, string email, string fullName)
        {
            return new
            {
                Username = username,
                Password = password, // בפרויקט אמיתי יש להצפין!
                Email = email,
                FullName = fullName,
                RegistrationDate = DateTime.Now,
                IsActive = true
            };
        }

        /// <summary>
        /// שומרת משתמש חדש לקובץ
        /// </summary>
        /// <param name="newUser">המשתמש החדש</param>
        /// <returns>true אם הצליח</returns>
        private bool SaveNewUser(object newUser)
        {
            try
            {
                // קריאת משתמשים קיימים
                List<object> users = LoadAllUsers();
                
                // הוספת משתמש חדש
                users.Add(newUser);
                
                // שמירה לקובץ
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string jsonContent = serializer.Serialize(users);
                File.WriteAllText(_usersFilePath, jsonContent);
                
                return true;
            }
            catch (Exception ex)
            {
                LogError("SaveNewUser", ex.Message);
                return false;
            }
        }

        /// <summary>
        /// טוענת את כל המשתמשים מהקובץ
        /// </summary>
        /// <returns>רשימת משתמשים</returns>
        private List<object> LoadAllUsers()
        {
            try
            {
                if (!File.Exists(_usersFilePath))
                {
                    return new List<object>();
                }

                string jsonContent = File.ReadAllText(_usersFilePath);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                List<object> users = serializer.Deserialize<List<object>>(jsonContent);
                
                return users ?? new List<object>();
            }
            catch
            {
                return new List<object>();
            }
        }

        #endregion

        #region Validation Methods - מתודות אימות

        /// <summary>
        /// מאמתת את כל שדות ההרשמה
        /// </summary>
        /// <param name="username">שם משתמש</param>
        /// <param name="password">סיסמה</param>
        /// <param name="email">אימייל</param>
        /// <param name="fullName">שם מלא</param>
        /// <returns>true אם כל השדות תקינים</returns>
        private bool ValidateRegistrationInput(string username, string password, string email, string fullName)
        {
            // בדיקת שם משתמש
            if (!ValidateUsername(username))
            {
                return false;
            }

            // בדיקת סיסמה
            if (!ValidatePassword(password))
            {
                return false;
            }

            // בדיקת אימייל
            if (!ValidateEmail(email))
            {
                return false;
            }

            // בדיקת שם מלא
            if (!ValidateFullName(fullName))
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// מאמתת שם משתמש
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <returns>true אם תקין</returns>
        private bool ValidateUsername(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                ShowErrorMessage("נא להזין שם משתמש");
                return false;
            }

            if (username.Length < MIN_USERNAME_LENGTH)
            {
                ShowErrorMessage($"שם משתמש חייב להכיל לפחות {MIN_USERNAME_LENGTH} תווים");
                return false;
            }

            if (username.Length > MAX_USERNAME_LENGTH)
            {
                ShowErrorMessage($"שם משתמש לא יכול להכיל יותר מ-{MAX_USERNAME_LENGTH} תווים");
                return false;
            }

            // בדיקה שהשם מכיל רק אותיות ומספרים
            if (!Regex.IsMatch(username, @"^[a-zA-Z0-9]+$"))
            {
                ShowErrorMessage("שם משתמש יכול להכיל רק אותיות ומספרים באנגלית");
                return false;
            }

            return true;
        }

        /// <summary>
        /// מאמתת סיסמה
        /// </summary>
        /// <param name="password">הסיסמה</param>
        /// <returns>true אם תקינה</returns>
        private bool ValidatePassword(string password)
        {
            if (string.IsNullOrWhiteSpace(password))
            {
                ShowErrorMessage("נא להזין סיסמה");
                return false;
            }

            if (password.Length < MIN_PASSWORD_LENGTH)
            {
                ShowErrorMessage($"סיסמה חייבת להכיל לפחות {MIN_PASSWORD_LENGTH} תווים");
                return false;
            }

            // בדיקת חוזק סיסמה - לפחות אות אחת ומספר אחד
            if (!Regex.IsMatch(password, @"^(?=.*[A-Za-z])(?=.*\d).+$"))
            {
                ShowErrorMessage("סיסמה חייבת להכיל לפחות אות אחת ומספר אחד");
                return false;
            }

            return true;
        }

        /// <summary>
        /// מאמתת כתובת אימייל
        /// </summary>
        /// <param name="email">כתובת האימייל</param>
        /// <returns>true אם תקינה</returns>
        private bool ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                ShowErrorMessage("נא להזין כתובת אימייל");
                return false;
            }

            // ביטוי רגולרי לאימות אימייל
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                ShowErrorMessage("כתובת אימייל לא תקינה");
                return false;
            }

            return true;
        }

        /// <summary>
        /// מאמתת שם מלא
        /// </summary>
        /// <param name="fullName">השם המלא</param>
        /// <returns>true אם תקין</returns>
        private bool ValidateFullName(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowErrorMessage("נא להזין שם מלא");
                return false;
            }

            if (fullName.Length < 2)
            {
                ShowErrorMessage("שם מלא חייב להכיל לפחות 2 תווים");
                return false;
            }

            return true;
        }

        #endregion

        #region Check Existence Methods - מתודות בדיקת קיום

        /// <summary>
        /// בודקת אם שם המשתמש כבר קיים
        /// </summary>
        /// <param name="username">שם המשתמש</param>
        /// <returns>true אם קיים</returns>
        private bool IsUsernameExists(string username)
        {
            try
            {
                List<object> users = LoadAllUsers();
                
                // בפרויקט אמיתי נשתמש ב-LINQ על אובייקטים מוגדרים
                // כאן זה דוגמה פשוטה
                
                return false; // לצורכי הדגמה
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// בודקת אם האימייל כבר קיים
        /// </summary>
        /// <param name="email">כתובת האימייל</param>
        /// <returns>true אם קיים</returns>
        private bool IsEmailExists(string email)
        {
            try
            {
                List<object> users = LoadAllUsers();
                
                // בפרויקט אמיתי נשתמש ב-LINQ על אובייקטים מוגדרים
                
                return false; // לצורכי הדגמה
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #region UI Methods - מתודות ממשק משתמש

        /// <summary>
        /// מציגה הודעת שגיאה למשתמש
        /// </summary>
        /// <param name="message">ההודעה להצגה</param>
        private void ShowErrorMessage(string message)
        {
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