<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="tamarProject.login" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Eurovision | Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #14052d; /* סגול כהה של האירוויזיון */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            padding: 40px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            width: 350px;
            text-align: center;
        }

        h2 { text-transform: uppercase; letter-spacing: 2px; margin-bottom: 5px; }
        p.subtitle { color: #00b1ea; font-size: 0.8rem; margin-bottom: 30px; }

        .input-group { text-align: left; margin-bottom: 20px; }
        label { font-size: 0.7rem; color: #ccc; text-transform: uppercase; display: block; margin-bottom: 5px; }
        
        input {
            width: 100%;
            padding: 12px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            color: white;
            box-sizing: border-box;
        }

        .btn {
            background: #ff0085; /* ורוד ניאון */
            color: white;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 50px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            text-transform: uppercase;
        }

        .back-link { display: block; margin-top: 20px; color: #fdf200; text-decoration: none; font-size: 0.8rem; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <h2>Sign Up</h2>
            <p class="subtitle">UNITED BY MUSIC</p>
            
            <div class="input-group">
                <label>Full Name</label>
                <input type="text" placeholder="Enter your name">
            </div>

            <div class="input-group">
                <label>Email</label>
                <input type="email" placeholder="example@eurovision.com">
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" placeholder="********">
            </div>

            <button type="button" class="btn">Join the Party</button>
            
            <a href="homePage.aspx" class="back-link">Back to Home</a>
        </div>
    </form>
</body>
</html>