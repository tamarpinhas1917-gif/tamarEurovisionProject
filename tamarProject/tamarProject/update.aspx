<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="update.aspx.cs" Inherits="tamarProject.update" ContentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Eurovision | Update Profile</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #050514; color: white; padding: 40px; }
        h1 { color: #ff0085; margin-bottom: 20px; }
        .msg-success { color: #00ff88; background: rgba(0,255,136,0.1); border: 1px solid #00ff88; padding: 12px; border-radius: 8px; margin-bottom: 15px; display: inline-block; }
        .nav-links { margin-bottom: 25px; }
        .nav-links a { color: #00b1ea; margin-left: 20px; text-decoration: none; }
        .nav-links a:hover { color: #ff0085; }
        table { border-collapse: collapse; }
        td { padding: 10px 15px; }
        input[type='text'] { background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 12px; border-radius: 6px; width: 200px; }
        input[type='submit'] { background: linear-gradient(135deg, #ff0085, #00b1ea); border: none; color: white; padding: 10px 25px; border-radius: 8px; cursor: pointer; font-size: 1rem; margin-top: 10px; }
        select { background: #14052d; border: 1px solid rgba(255,255,255,0.3); color: white; padding: 8px 12px; border-radius: 6px; width: 200px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="nav-links">
            <a href="homePage.aspx">🏠 Home</a>
            <a href="logout.aspx">🚪 Logout</a>
        </div>
        <h1>✏️ Update Profile</h1>
        <% if (!string.IsNullOrEmpty(msg)) { %>
        <div class="msg-success"><%= msg %></div>
        <% } %>
        <%= editUser %>
    </form>
</body>
</html>
