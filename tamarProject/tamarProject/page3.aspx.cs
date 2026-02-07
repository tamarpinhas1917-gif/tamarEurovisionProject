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
    /// עמוד תוכן 3 - ניתוח תגיות ומצב רוח
    /// מציג ניתוח של התגיות, הנושאים והמצב הרגשי של השירים
    /// </summary>
    public partial class page3 : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ הנתונים
        /// </summary>
        private string _dataFilePath;

        /// <summary>
        /// רשימת כל השנים
        /// </summary>
        private List<EurovisionYear> _tagsData;

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
                InitializeTagsPage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את עמוד התגיות
        /// </summary>
        private void InitializeTagsPage()
        {
            try
            {
                _dataFilePath = Server.MapPath("~/App_Data/eurovision-data.json");
                _tagsData = LoadTagsData();
                
                LogMessage("InitializeTagsPage", $"נטענו {_tagsData.Count} שנים");
            }
            catch (Exception ex)
            {
                LogError("InitializeTagsPage", ex.Message);
            }
        }

        #endregion

        #region Data Loading Methods - מתודות קריאת נתונים

        /// <summary>
        /// טוענת נתוני תגיות
        /// </summary>
        /// <returns>רשימת שנים</returns>
        private List<EurovisionYear> LoadTagsData()
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
                LogError("LoadTagsData", ex.Message);
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
                return serializer.Serialize(_tagsData);
            }
            catch
            {
                return "[]";
            }
        }

        #endregion

        #region Tags Analysis Methods - מתודות ניתוח תגיות

        /// <summary>
        /// מחזירה שנים לפי תגית
        /// </summary>
        /// <param name="tag">התגית</param>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetYearsByTag(string tag)
        {
            if (string.IsNullOrEmpty(tag))
            {
                return new List<EurovisionYear>();
            }

            return _tagsData
                .Where(y => y.Tags != null && y.Tags.Contains(tag))
                .ToList();
        }

        /// <summary>
        /// מחזירה את כל התגיות הייחודיות
        /// </summary>
        /// <returns>רשימת תגיות</returns>
        public List<string> GetAllUniqueTags()
        {
            return _tagsData
                .Where(y => y.Tags != null)
                .SelectMany(y => y.Tags)
                .Distinct()
                .OrderBy(t => t)
                .ToList();
        }

        /// <summary>
        /// מחזירה את התגית הפופולרית ביותר
        /// </summary>
        /// <returns>התגית הנפוצה ביותר</returns>
        public string GetMostPopularTag()
        {
            if (_tagsData.Count == 0) return string.Empty;

            var allTags = _tagsData
                .Where(y => y.Tags != null)
                .SelectMany(y => y.Tags);

            var tagGroups = allTags
                .GroupBy(t => t)
                .OrderByDescending(g => g.Count())
                .FirstOrDefault();

            return tagGroups?.Key ?? string.Empty;
        }

        /// <summary>
        /// מונה שירים לפי תגית
        /// </summary>
        /// <returns>מילון של תגית ומספר שירים</returns>
        public Dictionary<string, int> CountSongsByTag()
        {
            var allTags = _tagsData
                .Where(y => y.Tags != null)
                .SelectMany(y => y.Tags);

            return allTags
                .GroupBy(t => t)
                .ToDictionary(g => g.Key, g => g.Count());
        }

        #endregion

        #region Mood Analysis Methods - מתודות ניתוח מצב רוח

        /// <summary>
        /// מחזירה שנים לפי מצב רוח
        /// </summary>
        /// <param name="mood">מצב הרוח</param>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetYearsByMood(string mood)
        {
            if (string.IsNullOrEmpty(mood))
            {
                return new List<EurovisionYear>();
            }

            return _tagsData
                .Where(y => !string.IsNullOrEmpty(y.Mood) && 
                            y.Mood.Contains(mood))
                .ToList();
        }

        /// <summary>
        /// מחזירה את כל מצבי הרוח הייחודיים
        /// </summary>
        /// <returns>רשימת מצבי רוח</returns>
        public List<string> GetUniqueMoods()
        {
            return _tagsData
                .Where(y => !string.IsNullOrEmpty(y.Mood))
                .Select(y => y.Mood)
                .Distinct()
                .OrderBy(m => m)
                .ToList();
        }

        /// <summary>
        /// מחזירה שירים עם מצב רוח עצוב
        /// </summary>
        /// <returns>רשימת שנים עצובות</returns>
        public List<EurovisionYear> GetSadMoodYears()
        {
            return _tagsData
                .Where(y => !string.IsNullOrEmpty(y.Mood) && 
                            (y.Mood.Contains("עצוב") || 
                             y.Mood.Contains("מלנכולי") ||
                             y.Mood.Contains("נוסטלגי")))
                .ToList();
        }

        /// <summary>
        /// מחזירה שירים עם מצב רוח שמח
        /// </summary>
        /// <returns>רשימת שנים שמחות</returns>
        public List<EurovisionYear> GetHappyMoodYears()
        {
            return _tagsData
                .Where(y => !string.IsNullOrEmpty(y.Mood) && 
                            (y.Mood.Contains("שמח") || 
                             y.Mood.Contains("אופטימי") ||
                             y.Mood.Contains("חגיגי")))
                .ToList();
        }

        /// <summary>
        /// מונה שירים לפי מצב רוח
        /// </summary>
        /// <returns>מילון של מצב רוח ומספר שירים</returns>
        public Dictionary<string, int> CountSongsByMood()
        {
            return _tagsData
                .Where(y => !string.IsNullOrEmpty(y.Mood))
                .GroupBy(y => y.Mood)
                .ToDictionary(g => g.Key, g => g.Count());
        }

        #endregion

        #region Special Themes Methods - מתודות נושאים מיוחדים

        /// <summary>
        /// מחזירה שירים עם נושא LGBTQ
        /// </summary>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetLGBTQThemeYears()
        {
            return GetYearsByTag("LGBTQ");
        }

        /// <summary>
        /// מחזירה שירים עם נושא פוליטי
        /// </summary>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetPoliticalThemeYears()
        {
            return GetYearsByTag("Political");
        }

        /// <summary>
        /// מחזירה שירים שהשפיעו לאחר התחרות
        /// </summary>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetAftershockYears()
        {
            return GetYearsByTag("Aftershock");
        }

        /// <summary>
        /// מחזירה שירים שזכו במקום ראשון
        /// </summary>
        /// <returns>רשימת השנים שזכו</returns>
        public List<EurovisionYear> GetWinnerYears()
        {
            return GetYearsByTag("Winner");
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// מחזירה את מספר השירים עם תגיות
        /// </summary>
        /// <returns>מספר שירים</returns>
        public int CountYearsWithTags()
        {
            return _tagsData
                .Count(y => y.Tags != null && y.Tags.Count > 0);
        }

        /// <summary>
        /// מחזירה את מספר התגיות הממוצע לשיר
        /// </summary>
        /// <returns>ממוצע תגיות</returns>
        public double GetAverageTagsPerSong()
        {
            var songsWithTags = _tagsData
                .Where(y => y.Tags != null && y.Tags.Count > 0)
                .ToList();

            if (songsWithTags.Count == 0) return 0;

            int totalTags = songsWithTags.Sum(y => y.Tags.Count);
            return (double)totalTags / songsWithTags.Count;
        }

        /// <summary>
        /// מחזירה את השנה עם הכי הרבה תגיות
        /// </summary>
        /// <returns>השנה</returns>
        public int GetYearWithMostTags()
        {
            var yearWithMostTags = _tagsData
                .Where(y => y.Tags != null)
                .OrderByDescending(y => y.Tags.Count)
                .FirstOrDefault();

            return yearWithMostTags?.Year ?? 0;
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