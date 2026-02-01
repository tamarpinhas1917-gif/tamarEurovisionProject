using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

namespace tamarProject
{
    public partial class data_manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic
        }

        /// <summary>
        /// קורא את קובץ ה-JSON ומחזיר אותו כמחרוזת JSON
        /// Reads the JSON file and returns it as a JSON string
        /// </summary>
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
                return "[]";
            }
        }

        /// <summary>
        /// קורא את הנתונים ומחזיר אותם כרשימה של EurovisionYear
        /// Reads the data and returns it as a List of EurovisionYear objects
        /// </summary>
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
                return new List<EurovisionYear>();
            }
        }

        /// <summary>
        /// שומר נתונים חדשים לקובץ JSON (לשימוש עתידי)
        /// Saves new data to the JSON file (for future use)
        /// </summary>
        protected bool SaveEurovisionData(List<EurovisionYear> data)
        {
            try
            {
                string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
                
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string jsonContent = serializer.Serialize(data);
                
                File.WriteAllText(filePath, jsonContent);
                
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
