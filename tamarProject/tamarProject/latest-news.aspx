<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="latest-news.aspx.cs" Inherits="tamarProject.latest_news" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>חדשות אחרונות</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #14052d;
            color: white;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #000066;
            padding: 10px;
            text-align: center;
        }
        header h1 {
            margin: 0;
            font-size: 2rem;
        }
        .news-container {
            padding: 20px;
        }
        .news-item {
            margin-bottom: 20px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        .news-item h2 {
            margin: 0 0 10px;
            font-size: 1.5rem;
        }
        .news-item p {
            margin: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <h1>חדשות אחרונות</h1>
        </header>
        <div class="news-container">
            <div class="news-item">
                <h2>כותרת חדשות 1</h2>
                <p>תוכן חדשות 1...</p>
            </div>
            <div class="news-item">
                <h2>כותרת חדשות 2</h2>
                <p>תוכן חדשות 2...</p>
            </div>
        </div>
    </form>
</body>
</html>