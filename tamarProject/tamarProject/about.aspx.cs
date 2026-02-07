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
    /// עמוד אודות
    /// מציג מידע על הפרויקט ועל היסטוריית האירוויזיון של ישראל
    /// </summary>
    public partial class about : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// כותרת העמוד
        /// </summary>
        private string _pageTitle;

        /// <summary>
        /// תיאור הפרויקט
        /// </summary>
        private string _projectDescription;

        /// <summary>
        /// שנת תחילת השתתפות ישראל באירוויזיון
        /// </summary>
        private const int FIRST_PARTICIPATION_YEAR = 1973;

        /// <summary>
        /// מספר הניצחונות של ישראל
        /// </summary>
        private const int TOTAL_VICTORIES = 4;

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
                InitializeAboutPage();
                LoadProjectInformation();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד האודות
        /// </summary>
        private void InitializeAboutPage()
        {
            try
            {
                _pageTitle = "אודות הפרויקט";
                _projectDescription = "פרויקט גמר בקורס C# - היסטוריית האירוויזיון של ישראל";
                
                LogMessage("InitializeAboutPage", "עמוד אודות נטען");
            }
            catch (Exception ex)
            {
                LogError("InitializeAboutPage", ex.Message);
            }
        }

        /// <summary>
        /// טוענת את מידע הפרויקט
        /// </summary>
        private void LoadProjectInformation()
        {
            try
            {
                // טעינת נתונים נוספים אם נדרש
                LogMessage("LoadProjectInformation", "מידע הפרויקט נטען");
            }
            catch (Exception ex)
            {
                LogError("LoadProjectInformation", ex.Message);
            }
        }

        #endregion

        #region Project Information Methods - מתודות מידע על הפרויקט

        /// <summary>
        /// מחזירה את כותרת העמוד
        /// </summary>
        /// <returns>כותרת העמוד</returns>
        public string GetPageTitle()
        {
            return _pageTitle ?? "אודות הפרויקט";
        }

        /// <summary>
        /// מחזירה את תיאור הפרויקט
        /// </summary>
        /// <returns>תיאור הפרויקט</returns>
        public string GetProjectDescription()
        {
            return _projectDescription ?? "פרויקט גמר בקורס C#";
        }

        /// <summary>
        /// מחזירה מידע על המפתחת
        /// </summary>
        /// <returns>מידע על המפתחת</returns>
        public string GetDeveloperInfo()
        {
            return "פרויקט גמר של תמר - כיתה י\"א - קורס C#";
        }

        /// <summary>
        /// מחזירה את מטרת הפרויקט
        /// </summary>
        /// <returns>מטרת הפרויקט</returns>
        public string GetProjectPurpose()
        {
            return "פרויקט זה נועד להציג את היסטוריית ההשתתפות של ישראל בתחרות האירוויזיון " +
                   "מאז 1973 ועד היום, תוך הצגה אינטראקטיבית של השירים, האמנים, האופנה והכוריאוגרפיה.";
        }

        /// <summary>
        /// מחזירה רשימת טכנולוגיות בשימוש
        /// </summary>
        /// <returns>רשימת טכנולוגיות</returns>
        public List<string> GetTechnologiesUsed()
        {
            return new List<string>
            {
                "ASP.NET Web Forms",
                "C# (.NET Framework 4.7.2)",
                "HTML5 & CSS3",
                "JavaScript (Vanilla)",
                "JSON Data Storage",
                "IIS Express"
            };
        }

        #endregion

        #region Eurovision Information Methods - מתודות מידע על האירוויזיון

        /// <summary>
        /// מחזירה את שנת תחילת השתתפות ישראל
        /// </summary>
        /// <returns>שנת ההשתתפות הראשונה</returns>
        public int GetFirstParticipationYear()
        {
            return FIRST_PARTICIPATION_YEAR;
        }

        /// <summary>
        /// מחזירה את מספר הניצחונות של ישראל
        /// </summary>
        /// <returns>מספר הניצחונות</returns>
        public int GetTotalVictories()
        {
            return TOTAL_VICTORIES;
        }

        /// <summary>
        /// מחזירה רשימת שנות הניצחון
        /// </summary>
        /// <returns>רשימת שנים</returns>
        public List<int> GetVictoryYears()
        {
            return new List<int> { 1978, 1979, 1998, 2018 };
        }

        /// <summary>
        /// מחזירה מידע על ניצחונות ישראל
        /// </summary>
        /// <returns>רשימת מידע על הניצחונות</returns>
        public List<string> GetVictoryDetails()
        {
            return new List<string>
            {
                "1978 - יזהר כהן - 'א-בא-ני-בי' - ירושלים",
                "1979 - גלי עטרי ומילק אנד האני - 'הללויה' - ירושלים",
                "1998 - דנה אינטרנשיונל - 'דיווה' - ברמינגהאם",
                "2018 - נטע ברזילי - 'טוי' - ליסבון"
            };
        }

        /// <summary>
        /// מחזירה את מספר ההשתתפויות הכולל
        /// </summary>
        /// <returns>מספר השתתפויות</returns>
        public int GetTotalParticipations()
        {
            int currentYear = DateTime.Now.Year;
            int totalYears = currentYear - FIRST_PARTICIPATION_YEAR + 1;
            
            // ישראל לא השתתפה ב: 2014, 2015, 2016 (3 שנים)
            // וגם 2020 בוטל בגלל COVID, 1983 לא השתתפה
            int missedYears = 5;
            
            return totalYears - missedYears;
        }

        /// <summary>
        /// מחזירה שנים שבהן ישראל לא השתתפה
        /// </summary>
        /// <returns>רשימת שנים</returns>
        public List<int> GetMissedYears()
        {
            return new List<int> { 1983, 2014, 2015, 2016, 2020 };
        }

        /// <summary>
        /// מחזירה סיבות לאי-השתתפות
        /// </summary>
        /// <returns>מילון של שנה וסיבה</returns>
        public Dictionary<int, string> GetMissedYearsReasons()
        {
            return new Dictionary<int, string>
            {
                { 1983, "החרמה ערבית" },
                { 2014, "קשיים תקציביים" },
                { 2015, "קשיים תקציביים" },
                { 2016, "קשיים תקציביים" },
                { 2020, "ביטול התחרות בגלל COVID-19" }
            };
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// מחזירה אחוז הצלחה (ניצחונות מתוך השתתפויות)
        /// </summary>
        /// <returns>אחוז הצלחה</returns>
        public double GetSuccessRate()
        {
            int participations = GetTotalParticipations();
            if (participations == 0) return 0;
            
            return (double)TOTAL_VICTORIES / participations * 100;
        }

        /// <summary>
        /// מחזירה את הדירוג הממוצע של ישראל
        /// </summary>
        /// <returns>דירוג ממוצע (מדומה לדוגמה)</returns>
        public double GetAverageRanking()
        {
            // בפרויקט אמיתי נקרא מהנתונים
            // זו דוגמה פשוטה
            return 12.5;
        }

        /// <summary>
        /// מחזירה את מספר הפעמים שישראל הגיעה ל-Top 10
        /// </summary>
        /// <returns>מספר פעמים ב-Top 10</returns>
        public int GetTop10Appearances()
        {
            // בפרויקט אמיתי נקרא מהנתונים
            return 25; // דוגמה
        }

        #endregion

        #region Features Information - מתודות מידע על פיצ'רים

        /// <summary>
        /// מחזירה רשימת תכונות האתר
        /// </summary>
        /// <returns>רשימת תכונות</returns>
        public List<string> GetWebsiteFeatures()
        {
            return new List<string>
            {
                "ציר זמן אינטראקטיבי של כל ההשתתפויות",
                "מידע מפורט על כל שנה: אמן, שיר, דירוג",
                "ניתוח אופנה וסגנון לאורך השנים",
                "מידע על צליל, שפה, וכוריאוגרפיה",
                "תמונות מכל ההופעות",
                "סינון לפי תגיות: ז'אנר, הצלחה, נושאים מיוחדים",
                "מערכת התחברות והרשמה למשתמשים",
                "ניהול נתונים דינמי"
            };
        }

        /// <summary>
        /// מחזירה מידע על דפי האתר
        /// </summary>
        /// <returns>מילון של שם דף ותיאור</returns>
        public Dictionary<string, string> GetPagesInfo()
        {
            return new Dictionary<string, string>
            {
                { "דף בית", "סקירה כללית על הפרויקט" },
                { "ציר זמן", "תצוגה אינטראקטיבית של כל ההשתתפויות" },
                { "אופנה", "ניתוח טרנדים באופנה לאורך השנים" },
                { "התחברות", "כניסה למשתמשים רשומים" },
                { "הרשמה", "יצירת חשבון חדש" },
                { "אודות", "מידע על הפרויקט והמפתחת" },
                { "ניהול נתונים", "צפייה ועריכת נתוני האירוויזיון" }
            };
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