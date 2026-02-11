# 🎵 פרויקט אירוויזיון - הוראות הרצה במעבדה

## 📋 לפני שמגיעים למעבדה

### ✅ מה שצריך להיות מותקן במחשב:
1. **Visual Studio 2019/2022** (Community Edition)
2. **ASP.NET and web development workload**
3. **.NET Framework 4.7.2** (בדרך כלל כבר מותקן)

---

## 🚀 שלבים להרצת הפרויקט במעבדה

### שלב 1: שכפול הפרויקט מ-GitHub

פתחו Command Prompt או Git Bash והריצו:

```bash
cd C:\Users\[YOUR_NAME]\Documents
git clone https://github.com/tamarpinhas1917-gif/tamarEurovisionProject.git
cd tamarEurovisionProject
```

או הורידו ZIP מ-GitHub:
1. לכו ל-https://github.com/tamarpinhas1917-gif/tamarEurovisionProject
2. לחצו על Code → Download ZIP
3. חלצו את הקובץ לתיקייה

---

### שלב 2: בדיקה מהירה (אופציונלי)

**הריצו את הסקריפט לבדיקה:**
```bash
test-windows.bat
```

הסקריפט יבדוק:
- ✅ שכל הקבצים במקום
- ✅ שהקונפיגורציה תקינה
- ✅ שקובץ הנתונים קיים

---

### שלב 3: פתיחת הפרויקט ב-Visual Studio

1. **פתחו Visual Studio**

2. **פתחו את הפרויקט:**
   - File → Open → Project/Solution
   - בחרו: `tamarProject.sln`

3. **המתינו ל-NuGet Package Restore** (אוטומטי)
   - Visual Studio יוריד את החבילות הנדרשות
   - תראו הודעה בתחתית: "Restoring packages..."

4. **Build הפרויקט:**
   - לחצו `Ctrl+Shift+B` או
   - Build → Build Solution
   - וודאו שאין שגיאות (Errors: 0)

---

### שלב 4: הרצת האפליקציה

**פשוט לחצו F5!** 🎉

או:
- Debug → Start Debugging
- IIS Express יעלה אוטומטית
- הדפדפן ייפתח אוטומטית

**כתובת ברירת המחדל:**
```
https://localhost:44341/
```

---

## 📄 העמודים הראשיים להצגה למורה

### עמודי ה-ASP.NET (לבדיקת המורה):

1. **login.aspx** - עמוד התחברות
   ```
   https://localhost:44341/login.aspx
   ```

2. **homePage.aspx** - דף הבית
   ```
   https://localhost:44341/homePage.aspx
   ```

3. **timeline.aspx** - ציר זמן אינטראקטיבי
   ```
   https://localhost:44341/timeline.aspx
   ```

4. **fashion.aspx** - ניתוח אופנה
   ```
   https://localhost:44341/fashion.aspx
   ```

5. **data-manager.aspx** - ניהול נתונים
   ```
   https://localhost:44341/data-manager.aspx
   ```

6. **about.aspx** - אודות
   ```
   https://localhost:44341/about.aspx
   ```

7. **page1.aspx** - ניתוח מוזיקלי
   ```
   https://localhost:44341/page1.aspx
   ```

8. **page2.aspx** - ניתוח כוריאוגרפיה
   ```
   https://localhost:44341/page2.aspx
   ```

9. **page3.aspx** - תגיות והלך רוח
   ```
   https://localhost:44341/page3.aspx
   ```

---

## 🎨 עמודי HTML לתצוגה (אופציונלי)

אלו עמודי עיצוב לבדיקה בלבד. **לא חובה להראות למורה**.

אם רוצים להציג:
1. וודאו ש-IIS Express רץ (F5)
2. גשו לכתובות:
   - `https://localhost:44341/home-preview.html`
   - `https://localhost:44341/timeline-preview-splitview.html`
   - `https://localhost:44341/fashion-preview.html`
   - `https://localhost:44341/choreography-preview.html`
   - `https://localhost:44341/national-mood-preview.html`
   - `https://localhost:44341/data-manager-preview.html`

---

## 🐛 פתרון בעיות נפוצות

### בעיה 1: "Cannot connect to localhost:44341"

**פתרון:**
1. בדקו ש-IIS Express רץ (צריך להיות אייקון בסרגל המשימות)
2. עצרו את IIS Express (Debug → Stop Debugging)
3. הריצו שוב (F5)

---

### בעיה 2: "File not found: App_Data/eurovision-data.json"

**פתרון:**
1. בדקו שהתיקייה `App_Data` קיימת
2. בדקו שהקובץ `eurovision-data.json` בתוך התיקייה
3. אם חסר, העתיקו אותו מ-GitHub

**בדיקה:**
```
tamarProject/
  └── tamarProject/
       └── App_Data/
            └── eurovision-data.json  ← חייב להיות פה!
```

---

### בעיה 3: "Build failed" - שגיאות קומפילציה

**פתרון:**
1. בדקו את חלון **Error List** (View → Error List)
2. אם יש שגיאות NuGet:
   - Tools → NuGet Package Manager → Package Manager Console
   - הריצו: `Update-Package -reinstall`
3. נקו ובנו מחדש:
   - Build → Clean Solution
   - Build → Rebuild Solution

---

### בעיה 4: טקסט עברית לא מוצג נכון (gibberish)

**פתרון:**
זה **לא אמור לקרות** כי `Web.config` מוגדר ל-UTF-8, אבל אם זה קורה:

1. **בדקו את Web.config:**
   - פתחו `tamarProject/Web.config`
   - וודאו שיש את השורות:
   ```xml
   <globalization 
       requestEncoding="utf-8" 
       responseEncoding="utf-8" 
       fileEncoding="utf-8" />
   ```

2. **בדקו encoding של הקבצים:**
   - File → Advanced Save Options
   - בחרו: UTF-8 with signature

---

### בעיה 5: IIS Express לא מתחיל

**פתרון:**
1. סגרו את Visual Studio לגמרי
2. מחקו את התיקייה:
   ```
   C:\Users\[YOUR_NAME]\Documents\IISExpress\
   ```
3. פתחו את Visual Studio מחדש
4. פתחו את הפרויקט
5. F5

---

## 📝 מה להראות למורה

### 1. **מבנה קוד מקצועי** (הכי חשוב!)

פתחו קובץ `.aspx.cs` כלשהו (למשל `timeline.aspx.cs`) והראו:

✅ **Regions** - ארגון הקוד לאזורים:
```csharp
#region Private Fields - שדות פרטיים
#region Page Lifecycle - מחזור חיי העמוד
#region Initialization Methods - מתודות אתחול
```

✅ **תיעוד עברי** - XML documentation:
```csharp
/// <summary>
/// מאתחלת את העמוד - קוראת את קובץ הנתונים
/// </summary>
```

✅ **שדות פרטיים** - עם קידומת underscore:
```csharp
private string _dataFilePath;
private List<EurovisionYear> _allYears;
```

✅ **שמות מתודות ברורים**:
```csharp
private void InitializePage()
private List<EurovisionYear> LoadAllYearsFromFile()
private bool ValidateLoadedData()
```

---

### 2. **פונקציונליות עובדת**

הדגימו:
- ✅ טעינת נתונים מקובץ JSON
- ✅ הצגת 54 שנות אירוויזיון
- ✅ ניווט בין עמודים
- ✅ תצוגה תקינה של עברית
- ✅ עיצוב אירוויזיון (צבעים, אפקטים)

---

### 3. **ארכיטקטורה נכונה**

הראו את המבנה:
```
tamarProject/
  ├── timeline.aspx           ← UI markup
  ├── timeline.aspx.cs        ← C# code-behind
  ├── timeline.aspx.designer.cs  ← Auto-generated
  ├── App_Data/
  │   └── eurovision-data.json   ← נתונים
  └── Web.config              ← קונפיגורציה
```

---

## ⏱️ תזמון ביום ההצגה

### 10 דקות לפני:
1. הגיעו למעבדה מוקדם
2. הריצו `test-windows.bat` לבדיקה
3. פתחו Visual Studio
4. Build את הפרויקט (Ctrl+Shift+B)
5. בדקו שאין Errors

### 5 דקות לפני:
1. הריצו F5
2. וודאו ש-IIS Express עלה
3. בדקו עמוד אחד במהירות
4. השאירו Visual Studio פתוח

### בזמן ההצגה:
1. **עמוד 1:** פתחו קובץ `.aspx.cs` - הראו מבנה קוד
2. **עמוד 2:** הריצו את האפליקציה - הדגימו פונקציונליות
3. **עמוד 3:** הראו את קובץ JSON - הסבירו מבנה נתונים

---

## 📞 עזרה חירום

### אם משהו לא עובד:

**צ'קליסט מהיר:**
- [ ] Visual Studio פתוח?
- [ ] פתחתם את tamarProject.sln?
- [ ] Build הצליח (0 Errors)?
- [ ] לחצתם F5?
- [ ] IIS Express רץ?
- [ ] הדפדפן פתח ל-localhost:44341?

**אם עדיין לא עובד:**
1. סגרו Visual Studio
2. הריצו `test-windows.bat`
3. קראו את הודעות השגיאה
4. פתחו Visual Studio מחדש

---

## ✅ רשימת בדיקות סופית

לפני שיוצאים מהמעבדה:

- [ ] הפרויקט נפתח ב-Visual Studio ללא שגיאות
- [ ] Build מצליח (0 Errors)
- [ ] IIS Express עולה בלחיצה על F5
- [ ] לפחות 3 עמודים נבדקו ועובדים
- [ ] עברית מוצגת תקין
- [ ] נתוני אירוויזיון נטענים
- [ ] המורה רואה את מבנה הקוד המקצועי

---

## 🎯 מטרת הפרויקט

**הראו למורה:**
1. ✅ C# מקצועי עם Regions, תיעוד, ושדות
2. ✅ ASP.NET WebForms עובד ותקין
3. ✅ טעינת נתונים מ-JSON
4. ✅ עיצוב אירוויזיון מרשים
5. ✅ תמיכה בעברית מלאה

**זה הכל!** 🎉

---

**בהצלחה! 🎵🇮🇱**

