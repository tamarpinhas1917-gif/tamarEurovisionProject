<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="tamarProject.search" ContentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head runat="server">
    <meta charset="UTF-8">
    <title>Eurovision | Search Users</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #050514; color: white; padding: 40px; }
        h1 { color: #ff0085; margin-bottom: 20px; }
        .search-forms { display: flex; gap: 20px; flex-wrap: wrap; margin-bottom: 30px; }
        .search-box { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; padding: 20px; min-width: 200px; }
        .search-box h3 { color: #00b1ea; margin-bottom: 12px; font-size: 0.9rem; letter-spacing: 1px; text-transform: uppercase; }
        input[type='text'] { background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 12px; border-radius: 6px; width: 160px; display: block; margin-bottom: 10px; }
        select { background: #14052d; border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 12px; border-radius: 6px; width: 180px; display: block; margin-bottom: 10px; }
        input[type='submit'] { background: linear-gradient(135deg, #ff0085, #00b1ea); border: none; color: white; padding: 8px 18px; border-radius: 6px; cursor: pointer; }
        table { border-collapse: collapse; width: 100%; }
        th { background: #ff0085; padding: 12px; text-align: center; }
        td { padding: 10px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .nav-links { margin-bottom: 25px; }
        .nav-links a { color: #00b1ea; margin-left: 20px; text-decoration: none; }
        .nav-links a:hover { color: #ff0085; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="nav-links">
            <a href="homePage.aspx">🏠 Home</a>
            <a href="admin.aspx">🛡️ Admin Panel</a>
            <a href="logout.aspx">🚪 Logout</a>
        </div>
        <h1>🔍 Search Users - חיפוש משתמשים</h1>

        <div class="search-forms">
            <!-- Form 1: Show All -->
            <div class="search-box">
                <h3>הצג הכל</h3>
                <input type="submit" name="printAll" value="הצג כל המשתמשים" />
            </div>

            <!-- Form 2: Search by First Name -->
            <div class="search-box">
                <h3>חפש לפי שם פרטי</h3>
                <input type="text" name="fname" placeholder="שם פרטי" />
                <input type="submit" name="submit_fname" value="חפש" />
            </div>

            <!-- Form 3: Search by Area -->
            <div class="search-box">
                <h3>חפש לפי אזור</h3>
                <select name="area">
                    <option value="מרכז">מרכז</option>
                    <option value="צפון">צפון</option>
                    <option value="דרום">דרום</option>
                    <option value="ירושלים">ירושלים</option>
                    <option value="שרון">שרון</option>
                </select>
                <input type="submit" name="submit_area" value="חפש" />
            </div>
        </div>

        <%= usersList %>
    </form>
</body>
</html>
