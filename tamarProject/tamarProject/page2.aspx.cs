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
    /// עמוד תוכן 2 - ניתוח כוריאוגרפיה
    /// מציג ניתוח של הכוריאוגרפיה והביצוע הבימתי לאורך השנים
    /// </summary>
    public partial class page2 : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ הנתונים
        /// </summary>
        private string _dataFilePath;

        /// <summary>
        /// רשימת כל השנים
        /// </summary>
        private List<EurovisionYear> _choreographyData;

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
                InitializeChoreographyPage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד הכוריאוגרפיה
        /// </summary>
        private void InitializeChoreographyPage()
        {
            try
            {
                _dataFilePath = Server.MapPath("~/App_Data/eurovision-data.json");
                _choreographyData = LoadChoreographyData();
                
                LogMessage("InitializeChoreographyPage", $"נטענו {_choreographyData.Count} שנים");
            }
            catch (Exception ex)
            {
                LogError("InitializeChoreographyPage", ex.Message);
            }
        }

        #endregion

        #region Data Loading Methods - מתודות קריאת נתונים

        /// <summary>
        /// טוענת נתוני כוריאוגרפיה
        /// </summary>
        /// <returns>רשימת שנים</returns>
        private List<EurovisionYear> LoadChoreographyData()
        {
            try
            {
                if (!File.Exists(_dataFilePath))
                {
                    return new List<EurovisionYear>();
                }

                string jsonContent = File.ReadAllText(_dataFilePath);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                List<EurovisionYear> data = serializer.Deserialize<List<EurovisionYear>>(jsonContent);

                return data ?? new List<EurovisionYear>();
            }
            catch (Exception ex)
            {
                LogError("LoadChoreographyData", ex.Message);
                return new List<EurovisionYear>();
            }
        }

        /// <summary>
        /// מחזירה JSON לשימוש ב-JavaScript
        /// </summary>
        /// <returns>מחרוזת JSON</returns>
        protected string GetEurovisionDataJson()
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                return serializer.Serialize(_choreographyData);
            }
            catch
            {
                return "[]";
            }
        }

        #endregion

        #region Choreography Analysis Methods - מתודות ניתוח כוריאוגרפיה

        /// <summary>
        /// מחזירה שנים לפי סגנון כוריאוגרפיה
        /// </summary>
        /// <param name="style">סגנון הכוריאוגרפיה</param>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetYearsByChoreography(string style)
        {
            if (string.IsNullOrEmpty(style))
            {
                return new List<EurovisionYear>();
            }

            return _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography) && 
                            y.Choreography.Contains(style))
                .ToList();
        }

        /// <summary>
        /// מחזירה את כל סגנונות הכוריאוגרפיה הייחודיים
        /// </summary>
        /// <returns>רשימת סגנונות</returns>
        public List<string> GetUniqueChoreographyStyles()
        {
            return _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography))
                .Select(y => y.Choreography)
                .Distinct()
                .OrderBy(c => c)
                .ToList();
        }

        /// <summary>
        /// מחזירה שנים עם כוריאוגרפיה דינמית
        /// </summary>
        /// <returns>רשימת שנים עם ריקודים דינמיים</returns>
        public List<EurovisionYear> GetDynamicChoreographyYears()
        {
            return _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography) && 
                            (y.Choreography.Contains("דינמי") || 
                             y.Choreography.Contains("אנרגטי") ||
                             y.Choreography.Contains("מורכב")))
                .ToList();
        }

        /// <summary>
        /// מחזירה שנים עם כוריאוגרפיה סטטית
        /// </summary>
        /// <returns>רשימת שנים עם ביצוע סטטי</returns>
        public List<EurovisionYear> GetStaticChoreographyYears()
        {
            return _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography) && 
                            (y.Choreography.Contains("סטטי") || 
                             y.Choreography.Contains("מינימלי") ||
                             y.Choreography.Contains("עמידה")))
                .ToList();
        }

        /// <summary>
        /// מונה שירים לפי סגנון כוריאוגרפיה
        /// </summary>
        /// <returns>מילון של סגנון ומספר</returns>
        public Dictionary<string, int> CountByChoreographyStyle()
        {
            return _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography))
                .GroupBy(y => y.Choreography)
                .ToDictionary(g => g.Key, g => g.Count());
        }

        #endregion

        #region Performance Analysis Methods - מתודות ניתוח ביצוע

        /// <summary>
        /// מחזירה את אחוז ההופעות עם ריקודים
        /// </summary>
        /// <returns>אחוז ההופעות עם כוריאוגרפיה</returns>
        public double GetPercentageWithChoreography()
        {
            int total = _choreographyData.Count;
            if (total == 0) return 0;

            int withChoreography = _choreographyData
                .Count(y => !string.IsNullOrEmpty(y.Choreography));

            return (double)withChoreography / total * 100;
        }

        /// <summary>
        /// מחזירה את העשור עם הכי הרבה כוריאוגרפיה
        /// </summary>
        /// <returns>העשור</returns>
        public int GetMostChoreographedDecade()
        {
            if (_choreographyData.Count == 0) return 0;

            var decades = new[] { 1970, 1980, 1990, 2000, 2010, 2020 };
            
            return decades
                .OrderByDescending(d => _choreographyData
                    .Count(y => y.Year >= d && 
                                y.Year < d + 10 && 
                                !string.IsNullOrEmpty(y.Choreography)))
                .FirstOrDefault();
        }

        /// <summary>
        /// בודקת האם לשנה מסוימת יש כוריאוגרפיה
        /// </summary>
        /// <param name="year">השנה</param>
        /// <returns>true אם יש כוריאוגרפיה</returns>
        public bool HasChoreography(int year)
        {
            var yearData = _choreographyData.FirstOrDefault(y => y.Year == year);
            return yearData != null && !string.IsNullOrEmpty(yearData.Choreography);
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// מחזירה מספר שנים עם כוריאוגרפיה
        /// </summary>
        /// <returns>מספר השנים</returns>
        public int CountYearsWithChoreography()
        {
            return _choreographyData
                .Count(y => !string.IsNullOrEmpty(y.Choreography));
        }

        /// <summary>
        /// מחזירה את הסגנון הפופולרי ביותר
        /// </summary>
        /// <returns>הסגנון הנפוץ ביותר</returns>
        public string GetMostPopularChoreographyStyle()
        {
            if (_choreographyData.Count == 0) return string.Empty;

            var styleGroups = _choreographyData
                .Where(y => !string.IsNullOrEmpty(y.Choreography))
                .GroupBy(y => y.Choreography)
                .OrderByDescending(g => g.Count())
                .FirstOrDefault();

            return styleGroups?.Key ?? string.Empty;
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