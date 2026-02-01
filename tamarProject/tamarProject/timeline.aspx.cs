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
    public partial class timeline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic here if needed
        }

        /// <summary>
        /// Returns all Eurovision data for Israel from JSON file
        /// This method is called from the ASPX page to populate JavaScript data
        /// </summary>
        protected string GetEurovisionDataJson()
        {
            List<EurovisionYear> data = GetAllEurovisionYears();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(data);
        }

        /// <summary>
        /// Reads Eurovision data from JSON file
        /// קריאת נתוני אירוויזיון מקובץ JSON
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
                // ניתן גם לרשום ל-log או להציג הודעת שגיאה למשתמש
                return new List<EurovisionYear>();
            }
        }
    }
}
