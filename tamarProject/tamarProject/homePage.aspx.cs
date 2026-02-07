using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tamarProject
{
    /// <summary>
    /// עמוד הבית של אתר האירוויזיון
    /// מציג מבוא כללי ונקודות כניסה לתכנים השונים
    /// </summary>
    public partial class homePage : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// כותרת העמוד
        /// </summary>
        private string _pageTitle;

        /// <summary>
        /// הודעת ברוכים הבאים
        /// </summary>
        private string _welcomeMessage;

        #endregion

        #region Page Lifecycle - מחזור חיי העמוד

        /// <summary>
        /// אירוע טעינת עמוד הבית
        /// </summary>
        /// <param name="sender">האובייקט ששלח את האירוע</param>
        /// <param name="e">מידע על האירוע</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // טעינה ראשונית של העמוד
                InitializeHomePage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד הבית
        /// </summary>
        private void InitializeHomePage()
        {
            // הגדרת כותרת וטקסט
            _pageTitle = "המסע של ישראל באירוויזיון";
            _welcomeMessage = "ברוכים הבאים לאתר המקיף על ישראל באירוויזיון";

            // אתחולים נוספים לפי הצורך
            LoadWelcomeContent();
        }

        /// <summary>
        /// טוענת את תוכן ההקדמה
        /// </summary>
        private void LoadWelcomeContent()
        {
            // כאן ניתן לטעון תוכן דינמי
            LogMessage("LoadWelcomeContent", "טעינת תוכן הבית");
        }

        #endregion

        #region Display Methods - מתודות תצוגה

        /// <summary>
        /// מחזירה את כותרת העמוד
        /// </summary>
        /// <returns>כותרת העמוד</returns>
        public string GetPageTitle()
        {
            return _pageTitle ?? "ישראל באירוויזיון";
        }

        /// <summary>
        /// מחזירה את הודעת הברכה
        /// </summary>
        /// <returns>הודעת ברוכים הבאים</returns>
        public string GetWelcomeMessage()
        {
            return _welcomeMessage ?? "ברוכים הבאים";
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// מחזירה את שנת ההשתתפות הראשונה
        /// </summary>
        /// <returns>1973 - השנה הראשונה</returns>
        public int GetFirstYearOfParticipation()
        {
            return 1973;
        }

        /// <summary>
        /// מחזירה את מספר הניצחונות הכולל
        /// </summary>
        /// <returns>מספר הניצחונות (4)</returns>
        public int GetTotalVictories()
        {
            // ישראל זכתה 4 פעמים: 1978, 1979, 1998, 2018
            return 4;
        }

        /// <summary>
        /// מחזירה את מספר ההשתתפויות הכולל
        /// </summary>
        /// <returns>מספר ההשתתפויות</returns>
        public int GetTotalParticipations()
        {
            // מ-1973 עד 2026 (למעט שנים שלא השתתפנו)
            int totalYears = 2026 - 1973 + 1;
            int missedYears = 5; // שנים שלא השתתפנו
            return totalYears - missedYears;
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

        #endregion
    }
}