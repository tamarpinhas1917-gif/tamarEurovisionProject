using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace tamarProject
{
    /// <summary>
    /// עמוד אופנת האירוויזיון
    /// מציג את האופנה והסגנון הבימתי לאורך השנים
    /// </summary>
    public partial class fashion : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב לקובץ נתוני האירוויזיון
        /// </summary>
        private string _fashionDataPath;

        /// <summary>
        /// רשימת כל שנות האירוויזיון עם מידע על האופנה
        /// </summary>
        private List<EurovisionYear> _fashionYears;

        #endregion

        #region Page Lifecycle - מחזור חיי העמוד

        /// <summary>
        /// אירוע טעינת העמוד
        /// </summary>
        /// <param name="sender">האובייקט ששלח את האירוע</param>
        /// <param name="e">מידע נוסף על האירוע</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // טעינה ראשונית
                InitializeFashionPage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד האופנה
        /// </summary>
        private void InitializeFashionPage()
        {
            try
            {
                // הגדרת נתיב הקובץ
                _fashionDataPath = Server.MapPath("~/App_Data/eurovision-data.json");

                // טעינת הנתונים
                _fashionYears = LoadFashionData();

                // בדיקת תקינות
                if (_fashionYears == null || _fashionYears.Count == 0)
                {
                    LogMessage("InitializeFashionPage", "לא נמצאו נתוני אופנה");
                }
            }
            catch (Exception ex)
            {
                LogError("InitializeFashionPage", ex.Message);
            }
        }

        #endregion

        #region Data Loading Methods - מתודות טעינת נתונים

        /// <summary>
        /// טוענת את כל נתוני האופנה מהקובץ
        /// </summary>
        /// <returns>רשימת שנים עם מידע על אופנה</returns>
        private List<EurovisionYear> LoadFashionData()
        {
            if (!File.Exists(_fashionDataPath))
            {
                return new List<EurovisionYear>();
            }

            string jsonText = File.ReadAllText(_fashionDataPath);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<EurovisionYear> data = serializer.Deserialize<List<EurovisionYear>>(jsonText);

            return data ?? new List<EurovisionYear>();
        }

        /// <summary>
        /// מחזירה את כל הנתונים כ-JSON לשימוש ב-JavaScript
        /// </summary>
        /// <returns>מחרוזת JSON</returns>
        protected string GetEurovisionDataJson()
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                string jsonContent = File.ReadAllText(filePath);
                return jsonContent;
            }
            catch (Exception ex)
            {
                LogError("GetEurovisionDataJson", ex.Message);
                return "[]";
            }
        }

        #endregion

        #region Fashion Filtering Methods - מתודות סינון אופנה

        /// <summary>
        /// מסננת שנים לפי תקופה (עשור)
        /// </summary>
        /// <param name="decade">העשור (70, 80, 90, 2000, 2010, 2020)</param>
        /// <returns>רשימת שנים מהעשור הזה</returns>
        public List<EurovisionYear> FilterByDecade(int decade)
        {
            if (_fashionYears == null)
            {
                _fashionYears = LoadFashionData();
            }

            // סינון לפי טווח שנים של העשור
            int startYear = decade;
            int endYear = decade + 9;

            return _fashionYears.Where(y => y.Year >= startYear && y.Year <= endYear).ToList();
        }

        /// <summary>
        /// מוצאת שנים עם סגנון אופנה דומה
        /// </summary>
        /// <param name="searchTerm">מונח חיפוש (למשל "דיסקו", "מינימליסטי")</param>
        /// <returns>רשימת שנים עם סגנון דומה</returns>
        public List<EurovisionYear> FindSimilarFashion(string searchTerm)
        {
            if (_fashionYears == null)
            {
                _fashionYears = LoadFashionData();
            }

            // חיפוש במידע האופנה
            return _fashionYears.Where(y => 
                !string.IsNullOrEmpty(y.Fashion) && 
                y.Fashion.Contains(searchTerm)
            ).ToList();
        }

        /// <summary>
        /// מחזירה את השנים הכי צבעוניות
        /// </summary>
        /// <returns>רשימת שנים עם אופנה צבעונית</returns>
        public List<EurovisionYear> GetColorfulYears()
        {
            // חיפוש שנים שיש בתיאור האופנה מילים כמו "צבעוני", "זוהר", "נוצץ"
            return FindSimilarFashion("צבעוני");
        }

        /// <summary>
        /// מחזירה את השנים עם סגנון מינימליסטי
        /// </summary>
        /// <returns>רשימת שנים מינימליסטיות</returns>
        public List<EurovisionYear> GetMinimalistYears()
        {
            return FindSimilarFashion("מינימליסטי");
        }

        #endregion

        #region Analysis Methods - מתודות ניתוח

        /// <summary>
        /// סופרת כמה שנים יש במאגר אופנה
        /// </summary>
        /// <returns>מספר השנים</returns>
        public int CountFashionYears()
        {
            if (_fashionYears == null)
            {
                _fashionYears = LoadFashionData();
            }

            return _fashionYears.Count;
        }

        /// <summary>
        /// מוצאת את העשור עם הכי הרבה שינויי אופנה
        /// </summary>
        /// <returns>מספר העשור</returns>
        public int GetMostDiverseDecade()
        {
            if (_fashionYears == null)
            {
                _fashionYears = LoadFashionData();
            }

            // ניתוח לפי עשורים
            var decades = new int[] { 1970, 1980, 1990, 2000, 2010, 2020 };
            int maxCount = 0;
            int mostDiverseDecade = 1970;

            foreach (int decade in decades)
            {
                int count = FilterByDecade(decade).Count;
                if (count > maxCount)
                {
                    maxCount = count;
                    mostDiverseDecade = decade;
                }
            }

            return mostDiverseDecade;
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
