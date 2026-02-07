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
    /// עמוד תוכן 1 - ניתוח מוזיקלי
    /// מציג ניתוח של הסאונד והמוזיקה לאורך השנים
    /// </summary>
    public partial class page1 : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ הנתונים
        /// </summary>
        private string _dataFilePath;

        /// <summary>
        /// רשימת כל השנים
        /// </summary>
        private List<EurovisionYear> _allYears;

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
                InitializePage();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את העמוד
        /// </summary>
        private void InitializePage()
        {
            try
            {
                _dataFilePath = Server.MapPath("~/App_Data/eurovision-data.json");
                _allYears = LoadAllYearsFromFile();
                
                LogMessage("InitializePage", $"נטענו {_allYears.Count} שנים");
            }
            catch (Exception ex)
            {
                LogError("InitializePage", ex.Message);
            }
        }

        #endregion

        #region Data Loading Methods - מתודות קריאת נתונים

        /// <summary>
        /// טוענת את כל הנתונים מהקובץ
        /// </summary>
        /// <returns>רשימת כל השנים</returns>
        private List<EurovisionYear> LoadAllYearsFromFile()
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
                LogError("LoadAllYearsFromFile", ex.Message);
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
                return serializer.Serialize(_allYears);
            }
            catch
            {
                return "[]";
            }
        }

        #endregion

        #region Musical Analysis Methods - מתודות ניתוח מוזיקלי

        /// <summary>
        /// מחזירה שנים לפי סגנון מוזיקלי
        /// </summary>
        /// <param name="soundStyle">סגנון הסאונד</param>
        /// <returns>רשימת שנים מתאימות</returns>
        public List<EurovisionYear> GetYearsBySound(string soundStyle)
        {
            if (string.IsNullOrEmpty(soundStyle))
            {
                return new List<EurovisionYear>();
            }

            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Sound) && 
                            y.Sound.Contains(soundStyle))
                .ToList();
        }

        /// <summary>
        /// מחזירה את כל הסגנונות המוזיקליים הייחודיים
        /// </summary>
        /// <returns>רשימת סגנונות</returns>
        public List<string> GetUniqueSoundStyles()
        {
            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Sound))
                .Select(y => y.Sound)
                .Distinct()
                .OrderBy(s => s)
                .ToList();
        }

        /// <summary>
        /// מחזירה את הסגנון המוזיקלי הפופולרי ביותר
        /// </summary>
        /// <returns>הסגנון הנפוץ ביותר</returns>
        public string GetMostPopularSoundStyle()
        {
            if (_allYears.Count == 0) return string.Empty;

            var soundGroups = _allYears
                .Where(y => !string.IsNullOrEmpty(y.Sound))
                .GroupBy(y => y.Sound)
                .OrderByDescending(g => g.Count())
                .FirstOrDefault();

            return soundGroups?.Key ?? string.Empty;
        }

        /// <summary>
        /// מונה כמה שירים בכל סגנון מוזיקלי
        /// </summary>
        /// <returns>מילון של סגנון ומספר שירים</returns>
        public Dictionary<string, int> CountSongsBySound()
        {
            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Sound))
                .GroupBy(y => y.Sound)
                .ToDictionary(g => g.Key, g => g.Count());
        }

        #endregion

        #region Language Analysis Methods - מתודות ניתוח שפה

        /// <summary>
        /// מחזירה שנים לפי שפה
        /// </summary>
        /// <param name="language">השפה</param>
        /// <returns>רשימת שנים</returns>
        public List<EurovisionYear> GetYearsByLanguage(string language)
        {
            if (string.IsNullOrEmpty(language))
            {
                return new List<EurovisionYear>();
            }

            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Language) && 
                            y.Language.Contains(language))
                .ToList();
        }

        /// <summary>
        /// מחזירה את כל השפות הייחודיות
        /// </summary>
        /// <returns>רשימת שפות</returns>
        public List<string> GetUniqueLanguages()
        {
            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Language))
                .Select(y => y.Language)
                .Distinct()
                .OrderBy(l => l)
                .ToList();
        }

        /// <summary>
        /// מונה שירים לפי שפה
        /// </summary>
        /// <returns>מילון של שפה ומספר שירים</returns>
        public Dictionary<string, int> CountSongsByLanguage()
        {
            return _allYears
                .Where(y => !string.IsNullOrEmpty(y.Language))
                .GroupBy(y => y.Language)
                .ToDictionary(g => g.Key, g => g.Count());
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// מחזירה את מספר השירים בעשור מסוים
        /// </summary>
        /// <param name="decade">העשור (למשל: 1970, 1980)</param>
        /// <returns>מספר השירים</returns>
        public int CountSongsInDecade(int decade)
        {
            return _allYears
                .Count(y => y.Year >= decade && y.Year < decade + 10);
        }

        /// <summary>
        /// מחזירה את העשור עם הכי הרבה שירים
        /// </summary>
        /// <returns>העשור הפופולרי ביותר</returns>
        public int GetMostProductiveDecade()
        {
            if (_allYears.Count == 0) return 0;

            var decades = new[] { 1970, 1980, 1990, 2000, 2010, 2020 };
            
            return decades
                .OrderByDescending(d => CountSongsInDecade(d))
                .FirstOrDefault();
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