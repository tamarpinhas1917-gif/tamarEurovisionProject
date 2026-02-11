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
    /// עמוד ציר הזמן של ישראל באירוויזיון
    /// מציג היסטוריה אינטראקטיבית של כל ההשתתפויות (1973-2026)
    /// </summary>
    public partial class timeline : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ ה-JSON עם כל נתוני האירוויזיון
        /// </summary>
        private string _dataFilePath;

        /// <summary>
        /// רשימה של כל שנות האירוויזיון
        /// </summary>
        private List<EurovisionYear> _allYears;

        #endregion

        #region Page Lifecycle - מחזור חיי העמוד

        /// <summary>
        /// מתודה המופעלת בטעינת העמוד
        /// נקראת אוטומטית על ידי ASP.NET
        /// </summary>
        /// <param name="sender">האובייקט ששלח את האירוע</param>
        /// <param name="e">מידע נוסף על האירוע</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // טעינה ראשונה של העמוד - לא חזרה מהשרת
                InitializePage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את העמוד - קוראת את קובץ הנתונים
        /// </summary>
        private void InitializePage()
        {
            try
            {
                // קביעת מיקום קובץ הנתונים
                _dataFilePath = Server.MapPath("~/App_Data/eurovision-data.json");

                // טעינת כל הנתונים מהקובץ
                _allYears = LoadAllYearsFromFile();

                // בדיקה שהנתונים תקינים
                if (!ValidateLoadedData())
                {
                    ShowErrorMessage("שגיאה בטעינת הנתונים");
                }
            }
            catch (Exception ex)
            {
                // טיפול בשגיאות
                LogErrorToDebug("InitializePage", ex.Message);
                ShowErrorMessage("לא ניתן לטעון את נתוני האירוויזיון");
            }
        }

        #endregion

        #region Data Loading Methods - מתודות קריאת נתונים

        /// <summary>
        /// קוראת את כל השנים מקובץ ה-JSON
        /// </summary>
        /// <returns>רשימה של אובייקטי EurovisionYear</returns>
        private List<EurovisionYear> LoadAllYearsFromFile()
        {
            // בדיקה שהקובץ קיים
            if (!File.Exists(_dataFilePath))
            {
                LogErrorToDebug("LoadAllYearsFromFile", "הקובץ לא נמצא");
                return new List<EurovisionYear>();
            }

            // קריאת תוכן הקובץ כטקסט
            string jsonText = File.ReadAllText(_dataFilePath);

            // המרת ה-JSON לרשימת אובייקטים
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<EurovisionYear> years = serializer.Deserialize<List<EurovisionYear>>(jsonText);

            // אם הרשימה ריקה, החזר רשימה חדשה
            return years ?? new List<EurovisionYear>();
        }

        /// <summary>
        /// מוצאת את הנתונים של שנה מסוימת
        /// </summary>
        /// <param name="requestedYear">השנה שאותה מחפשים</param>
        /// <returns>אובייקט EurovisionYear או null אם לא נמצא</returns>
        public EurovisionYear FindYearData(int requestedYear)
        {
            // אם עדיין לא טענו את הנתונים, נטען אותם
            if (_allYears == null)
            {
                _allYears = LoadAllYearsFromFile();
            }

            // חיפוש השנה ברשימה באמצעות LINQ
            return _allYears.FirstOrDefault(y => y.Year == requestedYear);
        }

        /// <summary>
        /// מכינה את כל הנתונים בפורמט JSON לשימוש ב-JavaScript
        /// מתודה זו נקראת מה-ASPX עם <%= %>
        /// </summary>
        /// <returns>מחרוזת JSON עם כל הנתונים</returns>
        protected string GetEurovisionDataJson()
        {
            List<EurovisionYear> allData = GetAllEurovisionYears();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(allData);
        }

        /// <summary>
        /// קריאת נתוני אירוויזיון מקובץ JSON (שם ישן למתאימות לאחור)
        /// </summary>
        private List<EurovisionYear> GetAllEurovisionYears()
        {
            try
            {
                // קובץ ה-JSON ממוקם בתיקיית App_Data
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                
                if (!File.Exists(filePath))
                {
                    // אם הקובץ לא קיים, מחזירים רשימה ריקה
                    return new List<EurovisionYear>();
                }
                
                // קריאת התוכן מהקובץ
                string jsonContent = File.ReadAllText(filePath);
                
                // המרה מ-JSON לרשימה של אובייקטים
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                List<EurovisionYear> data = serializer.Deserialize<List<EurovisionYear>>(jsonContent);
                
                return data ?? new List<EurovisionYear>();
            }
            catch (Exception ex)
            {
                // במקרה של שגיאה, מחזירים רשימה ריקה
                LogErrorToDebug("GetAllEurovisionYears", ex.Message);
                return new List<EurovisionYear>();
            }
        }

        #endregion

        #region Filtering Methods - מתודות סינון

        /// <summary>
        /// מסננת שנים לפי מקום שהגיעו
        /// </summary>
        /// <param name="position">המקום (1, 2, 3 וכו')</param>
        /// <returns>רשימת שנים שהגיעו למקום הזה</returns>
        public List<EurovisionYear> FilterYearsByPosition(int position)
        {
            if (_allYears == null)
            {
                _allYears = LoadAllYearsFromFile();
            }

            // סינון באמצעות LINQ
            return _allYears.Where(y => y.Rank == position).ToList();
        }

        /// <summary>
        /// מחזירה את כל שנות הניצחון (מקום ראשון)
        /// </summary>
        /// <returns>רשימת השנים בהן ישראל זכתה</returns>
        public List<EurovisionYear> GetAllWinningYears()
        {
            // שימוש במתודת הסינון עם פרמטר 1
            return FilterYearsByPosition(1);
        }

        /// <summary>
        /// מסננת שנים לפי תג מסוים
        /// </summary>
        /// <param name="searchTag">התג לחיפוש (Winner, Disco, Political וכו')</param>
        /// <returns>רשימת שנים עם התג הזה</returns>
        public List<EurovisionYear> FilterYearsByTag(string searchTag)
        {
            if (_allYears == null)
            {
                _allYears = LoadAllYearsFromFile();
            }

            // חיפוש שנים שיש להן את התג
            return _allYears.Where(y => y.Tags != null && y.Tags.Contains(searchTag)).ToList();
        }

        /// <summary>
        /// מחזירה את כל השנים בטווח מסוים
        /// </summary>
        /// <param name="fromYear">שנת התחלה</param>
        /// <param name="toYear">שנת סיום</param>
        /// <returns>רשימת שנים בטווח</returns>
        public List<EurovisionYear> GetYearsInRange(int fromYear, int toYear)
        {
            if (_allYears == null)
            {
                _allYears = LoadAllYearsFromFile();
            }

            // סינון לפי טווח
            return _allYears.Where(y => y.Year >= fromYear && y.Year <= toYear).ToList();
        }

        #endregion

        #region Validation Methods - מתודות בדיקה

        /// <summary>
        /// בודקת שהנתונים שנטענו תקינים
        /// </summary>
        /// <returns>true אם תקין, false אם לא</returns>
        private bool ValidateLoadedData()
        {
            // בדיקה שיש נתונים
            if (_allYears == null || _allYears.Count == 0)
            {
                return false;
            }

            // בדיקת כל שנה
            foreach (EurovisionYear year in _allYears)
            {
                if (!IsYearValid(year.Year))
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// בודקת אם שנה נמצאת בטווח התקין
        /// </summary>
        /// <param name="year">השנה לבדיקה</param>
        /// <returns>true אם בטווח 1973-2026</returns>
        public bool IsYearValid(int year)
        {
            const int FIRST_YEAR = 1973;  // שנה ראשונה של ישראל באירוויזיון
            const int LAST_YEAR = 2026;   // שנה אחרונה במאגר

            return year >= FIRST_YEAR && year <= LAST_YEAR;
        }

        #endregion

        #region Counting Methods - מתודות ספירה

        /// <summary>
        /// סופרת כמה שנים יש במאגר
        /// </summary>
        /// <returns>מספר השנים הכולל</returns>
        public int CountTotalYears()
        {
            if (_allYears == null)
            {
                _allYears = LoadAllYearsFromFile();
            }

            return _allYears.Count;
        }

        /// <summary>
        /// סופרת כמה פעמים ישראל זכתה
        /// </summary>
        /// <returns>מספר הניצחונות</returns>
        public int CountVictories()
        {
            List<EurovisionYear> wins = GetAllWinningYears();
            return wins.Count;
        }

        #endregion

        #region Helper Methods - מתודות עזר

        /// <summary>
        /// כותבת שגיאה ללוג של המערכת (Debug Console)
        /// </summary>
        /// <param name="methodName">שם המתודה שבה קרתה השגיאה</param>
        /// <param name="errorMessage">הודעת השגיאה</param>
        private void LogErrorToDebug(string methodName, string errorMessage)
        {
            string fullMessage = string.Format("[ERROR] {0}: {1}", methodName, errorMessage);
            System.Diagnostics.Debug.WriteLine(fullMessage);
        }

        /// <summary>
        /// מציגה הודעת שגיאה למשתמש (כרגע רק ב-Debug)
        /// בעתיד ניתן להוסיף Label על העמוד להצגת הודעות
        /// </summary>
        /// <param name="message">ההודעה להצגה</param>
        private void ShowErrorMessage(string message)
        {
            // כרגע רק debug - אפשר להוסיף Label בעמוד
            System.Diagnostics.Debug.WriteLine("USER MESSAGE: " + message);
        }

        #endregion
    }
}
