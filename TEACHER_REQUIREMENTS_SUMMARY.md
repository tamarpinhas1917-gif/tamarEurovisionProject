# 📊 Teacher Requirements Summary

## Files Provided by Teacher

### Folder 1: Code Implementation Files
**Path:** `קבצי הפרויקט ביצוע בפרויקט שלכם לפי הסדר המוצג-20260502`

#### Files Included:
1. **admin.aspx.cs** (2,735 bytes)
   - Displays all users in a table
   - Edit/Delete buttons for each user
   - Admin-only access
   
2. **adminEditUser.aspx.cs** (1,245 bytes)
   - Updates user information
   - Toggles admin status
   
3. **DeleteUser.aspx.cs** (1,299 bytes)
   - Deletes user by ID
   - Admin-only access
   
4. **homePage.aspx.cs** (2,447 bytes)
   - Dynamic navigation based on user role
   - Guest → Login/SignUp links
   - Registered user → Logout/Edit profile
   - Admin → Admin panel/Search/Logout
   - Visitor counter
   
5. **login.aspx.cs** (1,445 bytes)
   - Validates credentials against database
   - Sets Session variables
   - Redirects to home page
   
6. **signUp.aspx.cs** (2,169 bytes)
   - User registration form
   - Duplicate ID check
   - INSERT into database
   
7. **search.aspx** (2,299 bytes)
   - Search form markup
   - Print all users
   - Search by first name
   - Search by region
   
8. **search.aspx.cs** (2,919 bytes)
   - Executes search queries
   - Displays results in table
   - Admin-only access
   
9. **update.aspx.cs** (4,410 bytes)
   - Edit personal profile
   - Pre-populates user data
   - Updates in database

---

### Folder 2: Documentation Files (Requirements Specs)
**Path:** `קבצי הסבר לצד שרת בפרויקט-20260502`

#### Files Included (in Hebrew):
1. **דף הבית צד שרת.docx** - Home Page Server Requirements
2. **התחברות.docx** - Login Page Requirements
3. **עדכני קובץ הרשמה ללא כפילויות לפי שדה ייחודי.docx** - SignUp with Duplicate Prevention
4. **קובץ עריכת פרטים אישיים צד שרת.docx** - Profile Edit Page Requirements
5. **קובץ חיפוש צד לקוח ושרת.docx** - Search Functionality
6. **פאנל ניהול מלא.docx** - Admin Panel Requirements

---

## Database Requirements

### Table: personalData
```sql
CREATE TABLE personalData (
    idnum VARCHAR(20) PRIMARY KEY,      -- ID Number
    fname NVARCHAR(50),                 -- First Name (Hebrew support)
    lname NVARCHAR(50),                 -- Last Name (Hebrew support)
    pass VARCHAR(50),                   -- Password (plain text in this code)
    area NVARCHAR(50),                  -- Region (North/Center/South in Hebrew)
    isAdmin BIT                         -- Admin flag (0=user, 1=admin)
)
```

### Database File: db.mdf
- Location: Project root directory
- Type: SQL Server local database

---

## Session Variables Required

| Variable | When Set | Value | Used For |
|----------|----------|-------|----------|
| `Session["user"]` | Login success | FirstName + LastName | Display username, Check if logged in |
| `Session["idnum"]` | Login success | User's ID number | Profile updates, Data context |
| `Session["isAdmin"]` | Login success | "yes" or null | Admin page access, Menu display |
| `Session["firstLog"]` | First login | "no" | Visitor counter increment |

---

## Authentication Flow

```
1. User visits login.aspx
2. Enters ID number + password
3. Query: SELECT * FROM personalData WHERE idnum=? AND pass=?
4. If found:
   - Set Session variables
   - Redirect to homePage.aspx
5. If not found:
   - Show error message
```

### Registration Flow
```
1. User visits signUp.aspx
2. Enters: ID, First Name, Last Name, Password, Region
3. Check: SELECT * FROM personalData WHERE idnum=?
4. If exists: Show "ID already exists"
5. If not:
   - INSERT new user (isAdmin = false)
   - Redirect to login.aspx
```

---

## Authorization Pattern

### For User Pages (update.aspx):
```csharp
if (Session["user"] == null)
    Response.Write("No access");
```

### For Admin Pages (admin.aspx, search.aspx, etc):
```csharp
if (Session["isAdmin"] != null)
    // Show admin content
else
    Response.Write("Admin only");
```

---

## Key Features to Implement

✅ **Must Have:**
- [x] User authentication (Login/SignUp)
- [x] Session management
- [x] User database with 6 fields
- [x] Admin role system
- [x] Admin panel for user management
- [x] Profile edit page
- [x] Search functionality
- [x] Dynamic navigation menu

✅ **Should Have:**
- [x] Delete user functionality
- [x] Duplicate ID prevention
- [x] Visitor counter
- [x] Authorization checks on all pages

---

## Current vs. Required

### Current Pages (Eurovision focused)
- homePage.aspx
- timeline.aspx
- fashion.aspx
- gallery.aspx
- trivia.aspx
- data-manager.aspx
- login.aspx (empty)
- signUp.aspx (empty)

### Missing Pages (User Management)
- ❌ logout.aspx
- ❌ update.aspx
- ❌ admin.aspx
- ❌ adminEditUser.aspx
- ❌ DeleteUser.aspx
- ❌ search.aspx (for users, not Eurovision)

---

## Implementation Order

### Phase 1: Database (CRITICAL)
1. Create db.mdf file
2. Create personalData table
3. Create MyAdoHelper.cs class

### Phase 2: Authentication (CRITICAL)
1. Update login.aspx.cs
2. Update signUp.aspx.cs
3. Create logout.aspx

### Phase 3: User Management
1. Create update.aspx
2. Create admin.aspx
3. Create adminEditUser.aspx
4. Create DeleteUser.aspx

### Phase 4: Search & Extras
1. Create search.aspx
2. Update homePage.aspx.cs (dynamic menu)
3. Add visitor counter

---

**Total Implementation Effort:** High - Requires complete user management system

