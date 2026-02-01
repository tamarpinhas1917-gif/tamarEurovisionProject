<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="tamarProject.homePage" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision Song Contest | Israel</title>
    <style>
        /* הגדרות צבעים ופונטים של האירוויזיון */
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-yellow: #fdf200;
            --euro-blue: #00b1ea;
            --glass: rgba(255, 255, 255, 0.1);
        }

        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Montserrat', 'Segoe UI', sans-serif;
            background-color: var(--euro-purple);
            color: white;
            overflow-x: hidden;
        }

        /* סרגל ניווט שקוף ומודרני */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.8), transparent);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-sizing: border-box;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-container img {
            height: 60px;
            filter: drop-shadow(0 0 10px rgba(255,255,255,0.3));
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        nav ul li a:hover {
            color: var(--euro-pink);
            text-shadow: 0 0 8px var(--euro-pink);
        }

        /* אזור Hero עם רקע עוצמתי */
        .hero {
            position: relative;
            height: 100vh;
            width: 100%;
            background: linear-gradient(rgba(20, 5, 45, 0.4), var(--euro-purple)), 
                        url('https://static.eurovision.tv/hb-main/default/0001/05/ad7ca63546a362947d3419363065a396a804975e.jpeg') center/cover no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        /* טקסט United By Music בסגנון המקורי */
        .hero h1 {
            font-size: 7vw;
            font-weight: 900;
            text-transform: uppercase;
            margin: 0;
            letter-spacing: -2px;
            line-height: 0.9;
            background: linear-gradient(to bottom, #fff, #ccc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 5px 15px rgba(0,0,0,0.5));
        }

        .hero p {
            font-size: 1.8rem;
            margin-top: 10px;
            font-weight: 300;
            color: var(--euro-yellow);
            letter-spacing: 4px;
            text-transform: uppercase;
        }

        /* כפתור הרשמה "וואו" */
        .btn-main {
            margin-top: 40px;
            padding: 20px 60px;
            background: var(--euro-pink);
            color: white;
            text-decoration: none;
            font-size: 1.4rem;
            font-weight: 900;
            border-radius: 100px;
            box-shadow: 0 0 30px rgba(255, 0, 133, 0.6);
            transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 2px solid transparent;
            text-transform: uppercase;
        }

        .btn-main:hover {
            transform: scale(1.1);
            background: transparent;
            border-color: var(--euro-pink);
            box-shadow: 0 0 50px rgba(255, 0, 133, 0.8);
        }

        /* אלמנטים צפים של ניאון */
        .neon-line {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--euro-blue), var(--euro-pink), var(--euro-yellow));
            box-shadow: 0 -5px 20px rgba(255, 0, 133, 0.5);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div class="logo-container">
                <img src="https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Eurovision_Song_Contest_logo.svg/1200px-Eurovision_Song_Contest_logo.svg.png" alt="Eurovision Logo">
            </div>
            <nav>
                <ul>
                    <li><a href="homePage.aspx">Home</a></li>
                    <li><a href="timeline.aspx">Timeline</a></li>
                    <li><a href="fashion.aspx">Fashion</a></li>
                    <li><a href="data-manager.aspx">Data Manager</a></li>
                    <li><a href="login.aspx">Registration</a></li>
                    <li><a href="#">Latest News</a></li>
                    <li><a href="#">The Show</a></li>
                </ul>
            </nav>
        </header>

        <section class="hero">
            <h1>UNITED BY MUSIC</h1>
            <p>ISRAEL 2026</p>
            
            <a href="login.aspx" class="btn-main">Join the Party</a>

            <div class="neon-line"></div>
        </section>
    </form>
</body>
</html>