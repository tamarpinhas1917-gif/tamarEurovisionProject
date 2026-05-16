<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="tamarProject.signUp" ContentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision | Sign Up</title>
    <style>
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-blue: #00b1ea;
            --euro-yellow: #fdf200;
            --deep-navy: #050514;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .auth-container { width: 100%; max-width: 450px; padding: 20px; }
        .auth-box {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 20px;
            padding: 40px;
            backdrop-filter: blur(10px);
        }
        .auth-box h2 {
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 8px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .subtitle { text-align: center; color: rgba(255,255,255,0.5); font-size: 0.8rem; letter-spacing: 2px; margin-bottom: 30px; }
        .input-group { margin-bottom: 20px; }
        .input-group label { display: block; font-size: 0.75rem; font-weight: 700; letter-spacing: 2px; color: rgba(255,255,255,0.7); margin-bottom: 8px; text-transform: uppercase; }
        .auth-input {
            width: 100%; padding: 14px 18px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 10px; color: white; font-size: 1rem;
            transition: 0.3s;
        }
        .auth-input:focus { outline: none; border-color: var(--euro-pink); background: rgba(255,0,133,0.1); }
        select.auth-input option { background: #14052d; color: white; }
        .btn {
            width: 100%; padding: 15px; margin-top: 10px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            border: none; border-radius: 10px; color: white;
            font-size: 1rem; font-weight: 700; letter-spacing: 2px;
            cursor: pointer; text-transform: uppercase; transition: 0.3s;
        }
        .btn:hover { opacity: 0.85; transform: translateY(-2px); }
        .msg-error { color: #ff0085; background: rgba(255,0,133,0.1); border: 1px solid #ff0085; padding: 12px; border-radius: 8px; margin-bottom: 15px; text-align: center; }
        .msg-success { color: #00ff88; background: rgba(0,255,136,0.1); border: 1px solid #00ff88; padding: 12px; border-radius: 8px; margin-bottom: 15px; text-align: center; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.85rem; transition: 0.3s; }
        .back-link:hover { color: var(--euro-pink); }
    </style>
</head>
<body>
    <form id="form1" runat="server" method="post">
        <div class="auth-container">
            <div class="auth-box">
                <h2>Join Eurovision</h2>
                <p class="subtitle">UNITED BY MUSIC</p>

                <% if (!string.IsNullOrEmpty(RegStatus)) { %>
                    <% if (RegStatus.Contains("בהצלחה") || RegStatus.Contains("successful")) { %>
                    <div class="msg-success"><%= RegStatus %></div>
                    <% } else { %>
                    <div class="msg-error"><%= RegStatus %></div>
                    <% } %>
                <% } %>

                <div class="input-group">
                    <label>ID NUMBER (ID Number)</label>
                    <input type="text" name="idnum" placeholder="e.g. 123456789" class="auth-input" maxlength="20" required>
                </div>
                <div class="input-group">
                    <label>FIRST NAME (First Name)</label>
                    <input type="text" name="fname" placeholder="First Name" class="auth-input" maxlength="50" required>
                </div>
                <div class="input-group">
                    <label>LAST NAME (Last Name)</label>
                    <input type="text" name="lname" placeholder="Last Name" class="auth-input" maxlength="50" required>
                </div>
                <div class="input-group">
                    <label>PASSWORD (Password)</label>
                    <input type="password" name="pass" placeholder="********" class="auth-input" maxlength="50" required>
                </div>
                <div class="input-group">
                    <label>AREA</label>
                    <select name="area" class="auth-input">
                        <option value="">-- Select Area --</option>
                        <option value="מרכז">מרכז</option>
                        <option value="צפון">צפון</option>
                        <option value="דרום">דרום</option>
                        <option value="ירושלים">ירושלים</option>
                        <option value="שרון">שרון</option>
                    </select>
                </div>

                <button type="submit" name="submit" value="signup" class="btn">SIGN UP</button>
                <a href="login.aspx" class="back-link">Already have an account? Login</a>
                <a href="homePage.aspx" class="back-link">Back to Home</a>
            </div>
        </div>
    </form>
</body>
</html>
