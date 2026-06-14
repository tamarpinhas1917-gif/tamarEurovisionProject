<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="update.aspx.cs" Inherits="tamarProject.update" ContentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision | Update Profile</title>
    <style>
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-blue: #00b1ea;
            --euro-yellow: #fdf200;
            --deep-navy: #050514;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            background-attachment: fixed;
            color: white;
            min-height: 100vh;
            padding: 40px 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Floating Shapes Background */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            animation: float 20s infinite ease-in-out;
            pointer-events: none;
            z-index: 0;
        }

        .shape1 {
            width: 300px;
            height: 300px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            top: 10%;
            left: -100px;
            animation-delay: 0s;
        }

        .shape2 {
            width: 400px;
            height: 400px;
            background: linear-gradient(135deg, var(--euro-blue), var(--euro-purple));
            top: 50%;
            right: -150px;
            animation-delay: 5s;
        }

        .shape3 {
            width: 250px;
            height: 250px;
            background: linear-gradient(135deg, var(--euro-pink), rgba(255, 0, 133, 0.5));
            bottom: 20%;
            left: 10%;
            animation-delay: 10s;
        }

        .shape4 {
            width: 350px;
            height: 350px;
            background: linear-gradient(135deg, var(--euro-blue), var(--euro-yellow));
            top: 30%;
            right: 20%;
            animation-delay: 7s;
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            25% {
                transform: translate(50px, -50px) scale(1.1);
            }
            50% {
                transform: translate(-30px, -100px) scale(0.9);
            }
            75% {
                transform: translate(30px, -50px) scale(1.05);
            }
        }

        /* Navigation Menu */
        .top-nav {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background: rgba(20, 5, 45, 0.8);
            backdrop-filter: blur(10px);
            padding: 15px 25px;
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .top-nav ul {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
            padding: 0;
        }

        .top-nav ul li a {
            text-decoration: none;
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .top-nav ul li a:hover {
            color: var(--euro-pink);
            text-shadow: 0 0 8px var(--euro-pink);
        }

        /* User Display */
        .user-display {
            position: fixed;
            top: 100px;
            right: 30px;
            color: var(--euro-yellow);
            font-weight: 600;
            z-index: 999;
            font-size: 0.9rem;
            background: rgba(20, 5, 45, 0.7);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(253, 242, 0, 0.3);
        }

        .user-display a {
            color: var(--euro-yellow);
            text-decoration: none;
            transition: 0.3s;
            margin-left: 10px;
        }

        .user-display a:hover {
            color: white;
            text-shadow: 0 0 8px var(--euro-yellow);
        }

        /* Main Content */
        .container {
            position: relative;
            z-index: 10;
            max-width: 800px;
            margin: 80px auto 40px;
            padding: 0 20px;
        }

        h1 {
            color: var(--euro-pink);
            margin-bottom: 30px;
            font-size: 2.5rem;
            text-shadow: 0 0 20px rgba(255, 0, 133, 0.3);
        }

        /* Success Message */
        .msg-success {
            color: #00ff88;
            background: rgba(0, 255, 136, 0.1);
            border: 1px solid #00ff88;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            display: inline-block;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Form Styling */
        .form-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(255, 0, 133, 0.2);
        }

        table {
            width: 100%;
        }

        td {
            padding: 15px 0;
            vertical-align: middle;
        }

        td:first-child {
            font-weight: 600;
            color: var(--euro-yellow);
            width: 30%;
            padding-right: 20px;
        }

        /* Input Fields */
        input[type='text'],
        input[type='password'],
        select {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            width: 100%;
            font-size: 0.95rem;
            transition: 0.3s;
        }

        input[type='text']::placeholder,
        input[type='password']::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        input[type='text']:focus,
        input[type='password']:focus,
        select:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--euro-pink);
            outline: none;
            box-shadow: 0 0 12px rgba(255, 0, 133, 0.4);
        }

        select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
            padding-right: 35px;
        }

        /* Submit Button */
        input[type='submit'] {
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            margin-top: 10px;
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        input[type='submit']:hover {
            box-shadow: 0 0 20px rgba(255, 0, 133, 0.6);
            transform: translateY(-2px);
        }

        input[type='submit']:active {
            transform: translateY(0);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .top-nav ul {
                gap: 20px;
                font-size: 0.8rem;
            }

            .top-nav ul li a {
                font-size: 0.75rem;
            }

            h1 {
                font-size: 1.8rem;
            }

            .form-container {
                padding: 20px;
            }

            td {
                padding: 12px 0;
                display: block;
            }

            td:first-child {
                width: 100%;
                margin-bottom: 5px;
            }

            input[type='text'],
            input[type='password'],
            select {
                width: 100%;
            }

            .user-display {
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Shapes Background -->
    <div class="floating-shape shape1"></div>
    <div class="floating-shape shape2"></div>
    <div class="floating-shape shape3"></div>
    <div class="floating-shape shape4"></div>

    <!-- Navigation Menu -->
    <nav class="top-nav">
        <ul>
            <li><a href="homePage.aspx">Home</a></li>
            <li><a href="timeline.aspx">Timeline</a></li>
            <li><a href="fashion.aspx">Fashion</a></li>
            <li><a href="data-manager.aspx">Data Manager</a></li>
            <li><a href="gallery.aspx">Gallery</a></li>
            <li><a href="trivia.aspx">Trivia</a></li>
            <% if (Session["user"] != null) { %>
                <li><a href="update.aspx">My Profile</a></li>
                <li><a href="logout.aspx">Logout</a></li>
                <% if (Session["isAdmin"] != null) { %>
                    <li><a href="admin.aspx" style="color:#fdf200;">Admin</a></li>
                <% } %>
            <% } else { %>
                <li><a href="signUp.aspx">Sign Up</a></li>
                <li><a href="login.aspx">Login</a></li>
            <% } %>
        </ul>
    </nav>

    <!-- User Display -->
    <div class="user-display">
        <% if (Session["user"] != null) { %>
            <span>� <%= Session["user"] %></span>
            | <a href="logout.aspx">Logout</a>
        <% } %>
    </div>

    <!-- Main Content -->
    <div class="container">
        <form id="form1" runat="server">
            <h1>✏️ Update Profile</h1>
            <% if (!string.IsNullOrEmpty(msg)) { %>
            <div class="msg-success"><%= msg %></div>
            <% } %>
            <div class="form-container">
                <%= editUser %>
            </div>
        </form>
    </div>
</body>
</html>
