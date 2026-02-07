using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace tamarProject
{
    /// <summary>
    /// עמוד ניהול נתונים
    /// מאפשר צפייה ועריכה של נתוני האירוויזיון
    /// </summary>
    public partial class data_manager : System.Web.UI.Page
    {
        #region Private Fields - שדות פרטיים

        /// <summary>
        /// נתיב קובץ הנתונים
        /// </summary>
        private string _dataPath;

        /// <summary>
        /// רשימת כל השנים
        /// </summary>
        private List<EurovisionYear> _allData;

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
                InitializeDataManager();
            }
        }

        #endregion

        #region Initialization Methods - מתודות אתחול

        /// <summary>
        /// מאתחלת את מנהל הנתונים
        /// </summary>
        private void InitializeDataManager()
        {
            try
            {
                _dataPath = Server.MapPath("~/App_Data/eurovision-data.json");
                _allData = LoadAllData();
                
                LogMessage("InitializeDataManager", $"נטענו {_allData.Count} שנים");
            }
            catch (Exception ex)
            {
                LogError("InitializeDataManager", ex.Message);
            }
        }

        #endregion

        #region Data Loading Methods - מתודות קריאת נתונים

        /// <summary>
        /// טוענת את כל הנתונים מהקובץ
        /// </summary>
        /// <returns>רשימת כל השנים</returns>
        private List<EurovisionYear> LoadAllData()
        {
            if (!File.Exists(_dataPath))
            {
                return new List<EurovisionYear>();
            }

            string jsonContent = File.ReadAllText(_dataPath);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<EurovisionYear> data = serializer.Deserialize<List<EurovisionYear>>(jsonContent);

            return data ?? new List<EurovisionYear>();
        }

        /// <summary>
        /// קורא את קובץ ה-JSON ומחזיר אותו כמחרוזת JSON
        /// </summary>
        /// <returns>מחרוזת JSON</returns>
        protected string GetEurovisionDataJson()
        {
            try
            {
                // קובץ ה-JSON ממוקם בתיקיית App_Data
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                
                // קריאת התוכן מהקובץ
                string jsonContent = File.ReadAllText(filePath);
                
                return jsonContent;
            }
            catch (Exception ex)
            {
                // במקרה של שגיאה, מחזירים מערך ריק
                LogError("GetEurovisionDataJson", ex.Message);
                return "[]";
            }
        }

        /// <summary>
        /// קורא את הנתונים ומחזיר אותם כרשימה של EurovisionYear
        /// </summary>
        /// <returns>רשימת אובייקטי EurovisionYear</returns>
        protected List<EurovisionYear> GetAllEurovisionYears()
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                string jsonContent = File.ReadAllText(filePath);
                
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                List<EurovisionYear> data = serializer.Deserialize<List<EurovisionYear>>(jsonContent);
                
                return data;
            }
            catch (Exception ex)
            {
                // במקרה של שגיאה, מחזירים רשימה ריקה
                LogError("GetAllEurovisionYears", ex.Message);
                return new List<EurovisionYear>();
            }
        }

        #endregion

        #region Data Saving Methods - מתודות שמירת נתונים

        /// <summary>
        /// שומר נתונים חדשים לקובץ JSON
        /// </summary>
        /// <param name="data">הנתונים לשמירה</param>
        /// <returns>true אם הצליח, false אם נכשל</returns>
        protected bool SaveEurovisionData(List<EurovisionYear> data)
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string jsonContent = serializer.Serialize(data);
                
                File.WriteAllText(filePath, jsonContent);
                
                LogMessage("SaveEurovisionData", "הנתונים נשמרו בהצלחה");
                return true;
            }
            catch (Exception ex)
            {
                LogError("SaveEurovisionData", ex.Message);
                return false;
            }
        }

        /// <summary>
        /// מעדכנת שנה ספציפית
        /// </summary>
        /// <param name="year">מספר השנה</param>
        /// <param name="updatedYear">הנתונים המעודכנים</param>
        /// <returns>true אם הצליח</returns>
        public bool UpdateYear(int year, EurovisionYear updatedYear)
        {
            List<EurovisionYear> allYears = GetAllEurovisionYears();
            
            // חיפוש השנה
            EurovisionYear existingYear = allYears.FirstOrDefault(y => y.Year == year);
            
            if (existingYear != null)
            {
                // עדכון הנתונים
                int index = allYears.IndexOf(existingYear);
                allYears[index] = updatedYear;
                
                // שמירה
                return SaveEurovisionData(allYears);
            }
            
            return false;
        }

        /// <summary>
        /// מוסיפה שנה חדשה
        /// </summary>
        /// <param name="newYear">השנה החדשה להוספה</param>
        /// <returns>true אם הצליח</returns>
        public bool AddNewYear(EurovisionYear newYear)
        {
            List<EurovisionYear> allYears = GetAllEurovisionYears();
            
            // בדיקה שהשנה לא קיימת כבר
            if (!allYears.Any(y => y.Year == newYear.Year))
            {
                allYears.Add(newYear);
                allYears = allYears.OrderBy(y => y.Year).ToList(); // מיון לפי שנה
                
                return SaveEurovisionData(allYears);
            }
            
            return false;
        }

        #endregion

        #region Validation Methods - מתודות אימות

        /// <summary>
        /// בודקת אם קובץ הנתונים תקין
        /// </summary>
        /// <returns>true אם תקין</returns>
        public bool ValidateDataFile()
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                
                if (!File.Exists(filePath))
                {
                    return false;
                }
                
                List<EurovisionYear> data = GetAllEurovisionYears();
                return data != null && data.Count > 0;
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #region Statistics Methods - מתודות סטטיסטיקה

        /// <summary>
        /// סופרת כמה שנים יש במאגר
        /// </summary>
        /// <returns>מספר השנים</returns>
        public int CountTotalYears()
        {
            List<EurovisionYear> data = GetAllEurovisionYears();
            return data.Count;
        }

        /// <summary>
        /// מחזירה סטטיסטיקה על השדות המלאים
        /// </summary>
        /// <returns>אחוז השדות המלאים</returns>
        public double GetDataCompletenessPercentage()
        {
            List<EurovisionYear> data = GetAllEurovisionYears();
            
            if (data.Count == 0) return 0;
            
            int totalFields = 0;
            int filledFields = 0;
            
            foreach (var year in data)
            {
                totalFields += 11; // מספר השדות בכל שנה
                
                if (year.Year > 0) filledFields++;
                if (!string.IsNullOrEmpty(year.Artist)) filledFields++;
                if (!string.IsNullOrEmpty(year.Song)) filledFields++;
                if (!string.IsNullOrEmpty(year.Sound)) filledFields++;
                if (!string.IsNullOrEmpty(year.Fashion)) filledFields++;
                if (!string.IsNullOrEmpty(year.Language)) filledFields++;
                if (!string.IsNullOrEmpty(year.Choreography)) filledFields++;
                if (!string.IsNullOrEmpty(year.Mood)) filledFields++;
                if (year.Rank.HasValue) filledFields++;
                if (year.Tags != null && year.Tags.Count > 0) filledFields++;
                if (!string.IsNullOrEmpty(year.ImageUrl)) filledFields++;
            }
            
            return totalFields > 0 ? (double)filledFields / totalFields * 100 : 0;
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
