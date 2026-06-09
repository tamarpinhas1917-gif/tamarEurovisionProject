<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="tamarProject.admin" ContentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Eurovision | Admin Panel</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #050514; color: white; padding: 40px; }
        h1 { color: #ff0085; margin-bottom: 20px; }
        table { border-collapse: collapse; width: 100%; background: rgba(255,255,255,0.05); border-radius: 10px; overflow: hidden; }
        th { background: #ff0085; padding: 12px; text-align: center; }
        td { padding: 10px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        input[type='text'] { background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 6px 10px; border-radius: 5px; width: 120px; }
        input[type='submit'] { background: #00b1ea; border: none; color: white; padding: 6px 14px; border-radius: 5px; cursor: pointer; }
        input[type='button'] { background: #ff0085; border: none; color: white; padding: 6px 14px; border-radius: 5px; cursor: pointer; }
        .nav-links { margin-bottom: 25px; }
        .nav-links a { color: #00b1ea; margin-left: 20px; text-decoration: none; }
        .nav-links a:hover { color: #ff0085; }
        .no-access { color: #ff0085; font-size: 1.5rem; text-align: center; margin-top: 100px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="nav-links">
            <a href="homePage.aspx">🏠 Home</a>
            <a href="search.aspx">🔍 Search Users</a>
            <a href="logout.aspx">🚪 Logout</a>
        </div>
        <h1>🛡️ Admin Panel</h1>
        <%= st %>
    </form>
</body>
</html>
