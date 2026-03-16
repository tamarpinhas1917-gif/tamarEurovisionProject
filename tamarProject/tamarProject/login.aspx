<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="tamarProject.login" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <title>Eurovision | Sign Up / Login</title>
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
            overflow-x: hidden;
            position: relative;
        }

        /* Navigation Menu - LEFT SIDE */
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

        /* Eurovision 70 Logo - RIGHT SIDE */
        .euro-logo {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 150px;
            height: auto;
            z-index: 1000;
            filter: drop-shadow(0 0 20px rgba(255, 0, 133, 0.3));
        }

        /* User Display */
        .user-display {
            position: fixed;
            top: 115px;
            right: 30px;
            color: var(--euro-yellow);
            font-weight: 600;
            z-index: 1001;
            font-size: 0.9rem;
            background: rgba(20, 5, 45, 0.7);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-display a {
            color: var(--euro-yellow);
            text-decoration: none;
            transition: 0.3s;
        }

        .user-display a:hover {
            color: #fff;
            text-shadow: 0 0 8px var(--euro-yellow);
        }

        /* Floating gradient shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.6;
            animation: float 20s infinite ease-in-out;
            z-index: 0;
            pointer-events: none;
        }

        .shape1 { width: 400px; height: 400px; background: radial-gradient(circle, var(--euro-pink), transparent); top: -10%; left: -10%; animation-delay: 0s; }
        .shape2 { width: 350px; height: 350px; background: radial-gradient(circle, var(--euro-blue), transparent); top: 40%; right: -5%; animation-delay: 5s; }
        .shape3 { width: 300px; height: 300px; background: radial-gradient(circle, var(--euro-yellow), transparent); bottom: -10%; left: 20%; animation-delay: 10s; }
        .shape4 { width: 250px; height: 250px; background: radial-gradient(circle, var(--euro-pink), transparent); bottom: 30%; right: 30%; animation-delay: 15s; }
        .shape5 { width: 200px; height: 200px; background: radial-gradient(circle, var(--euro-blue), transparent); top: 20%; left: 50%; animation-delay: 8s; }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            25% { transform: translate(30px, -30px) scale(1.1); }
            50% { transform: translate(-20px, 20px) scale(0.9); }
            75% { transform: translate(20px, 30px) scale(1.05); }
        }

        /* Eurovision Heart Decoration */
        .euro-heart-decoration {
            position: fixed;
            top: 15%;
            right: 10%;
            width: 200px;
            opacity: 0.4;
            filter: blur(3px);
            pointer-events: none;
            z-index: 0;
            animation: heartPulse 4s infinite ease-in-out;
        }

        /* Israel Flag */
        .carousel-winner-flag {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 100;
            animation: float 6s infinite ease-in-out;
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.3));
        }

        @keyframes heartPulse {
            0%, 100% { transform: scale(1); opacity: 0.4; }
            50% { transform: scale(1.05); opacity: 0.5; }
        }

        /* Auth Container */
        .auth-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 100px 20px 50px;
            position: relative;
            z-index: 1;
        }

        .auth-box {
            background: rgba(20, 5, 45, 0.7);
            backdrop-filter: blur(20px);
            padding: 50px 40px;
            border-radius: 30px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            width: 100%;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }

        .auth-tabs {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }

        .tab-button {
            flex: 1;
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.5);
            font-size: 1.2rem;
            font-weight: 600;
            padding: 15px;
            cursor: pointer;
            transition: all 0.3s;
            border-bottom: 3px solid transparent;
        }

        .tab-button.active {
            color: var(--euro-pink);
            border-bottom-color: var(--euro-pink);
        }

        .tab-content { display: none; }
        .tab-content.active { display: block; }

        h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 10px;
            background: linear-gradient(45deg, var(--euro-pink), var(--euro-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .subtitle {
            text-align: center;
            color: var(--euro-yellow);
            font-size: 0.9rem;
            margin-bottom: 30px;
            letter-spacing: 2px;
        }

        .input-group { margin-bottom: 25px; }

        label {
            display: block;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 8px;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: var(--euro-pink);
            background: rgba(255, 255, 255, 0.08);
        }

        input::placeholder { color: rgba(255, 255, 255, 0.3); }

        .btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(255, 0, 133, 0.4);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: var(--euro-yellow);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }

        .back-link:hover { color: white; }

        .already-signed-in {
            text-align: center;
            padding: 30px;
            background: rgba(0, 177, 234, 0.1);
            border-radius: 15px;
            border: 2px solid var(--euro-blue);
        }

        .already-signed-in h3 { color: var(--euro-blue); margin-bottom: 15px; }
        .already-signed-in p { margin-bottom: 20px; font-size: 1.1rem; }
        .btn-secondary { background: linear-gradient(135deg, var(--euro-blue), var(--euro-purple)); }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag" width="50">

    <!-- Floating Shapes -->
    <div class="floating-shape shape1"></div>
    <div class="floating-shape shape2"></div>
    <div class="floating-shape shape3"></div>
    <div class="floating-shape shape4"></div>
    <div class="floating-shape shape5"></div>

    <!-- Eurovision Heart Decoration -->
    <img class="euro-heart-decoration" src="https://www.eurovision.com/static/images/70-heart.f6c629bcf5dd.webp" alt="Eurovision Heart">

    <!-- User Display -->
    <div class="user-display" id="userDisplay">
        <a href="login.aspx">Sign Up / Login</a>
    </div>

    <!-- Eurovision 70 Logo - RIGHT SIDE -->
    <a href="homePage.aspx" style="text-decoration: none;">
        <img src="images/eurovision/eurovision-70-logo.png" alt="Eurovision 70" class="euro-logo">
    </a>

    <!-- Navigation Menu - LEFT SIDE -->
    <nav class="top-nav">
        <ul>
            <li><a href="homePage.aspx">Home</a></li>
            <li><a href="timeline.aspx">Timeline</a></li>
            <li><a href="fashion.aspx">Fashion</a></li>
            <li><a href="data-manager.aspx">Data Manager</a></li>
            <li><a href="gallery.aspx">Gallery</a></li>
            <li><a href="trivia.aspx">Trivia</a></li>
            <li><a href="login.aspx">Sign Up</a></li>
        </ul>
    </nav>

    <div class="auth-container">
        <div class="auth-box" id="authBox">
            <!-- Tab Buttons -->
            <div class="auth-tabs">
                <button type="button" class="tab-button active" onclick="switchTab('signup', this)">Sign Up</button>
                <button type="button" class="tab-button" onclick="switchTab('signin', this)">Login</button>
            </div>

            <!-- Sign Up Tab -->
            <div class="tab-content active" id="signupTab">
                <h2>Join the Celebration</h2>
                <p class="subtitle">UNITED BY MUSIC</p>

                <div class="input-group">
                    <label>FULL NAME</label>
                    <input type="text" id="signupName" placeholder="Enter your name">
                </div>

                <div class="input-group">
                    <label>EMAIL</label>
                    <input type="email" id="signupEmail" placeholder="example@eurovision.com">
                </div>

                <div class="input-group">
                    <label>PASSWORD</label>
                    <input type="password" id="signupPassword" placeholder="********">
                </div>

                <button type="button" class="btn" onclick="handleSignup()">JOIN THE PARTY</button>
                <a href="homePage.aspx" class="back-link">Back to Home</a>
            </div>

            <!-- Sign In Tab -->
            <div class="tab-content" id="signinTab">
                <h2>Welcome Back</h2>
                <p class="subtitle">WELCOME BACK</p>

                <div class="input-group">
                    <label>EMAIL</label>
                    <input type="email" id="signinEmail" placeholder="example@eurovision.com">
                </div>

                <div class="input-group">
                    <label>PASSWORD</label>
                    <input type="password" id="signinPassword" placeholder="********">
                </div>

                <button type="button" class="btn" onclick="handleSignin()">LOGIN</button>
                <a href="homePage.aspx" class="back-link">Back to Home</a>
            </div>
        </div>
    </div>

    </form>

    <script>
        window.addEventListener('DOMContentLoaded', function () {
            try {
                var currentUser = JSON.parse(localStorage.getItem('euroUser') || 'null');
                var userDisplay = document.getElementById('userDisplay');

                if (currentUser) {
                    userDisplay.innerHTML = '<span>Hello ' + currentUser.name + '!</span> | <a href="#" onclick="logout()">Logout</a>';
                    document.getElementById('authBox').innerHTML =
                        '<div class="already-signed-in">' +
                        '<h3>✨ Already Signed In ✨</h3>' +
                        '<p>Hello ' + currentUser.name + '!</p>' +
                        '<p>You\'re already part of the Eurovision family!</p>' +
                        '<button class="btn" onclick="window.location.href=\'homePage.aspx\'">Back to Home</button>' +
                        '<button class="btn btn-secondary" onclick="logout()" style="margin-top:15px;">Logout</button>' +
                        '</div>';
                }
            } catch (e) { }
        });

        function switchTab(tab, btn) {
            document.querySelectorAll('.tab-button').forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            document.getElementById('signupTab').classList.remove('active');
            document.getElementById('signinTab').classList.remove('active');
            document.getElementById(tab + 'Tab').classList.add('active');
        }

        function handleSignup() {
            var name = document.getElementById('signupName').value;
            var email = document.getElementById('signupEmail').value;
            var password = document.getElementById('signupPassword').value;

            if (!name || !email || !password) {
                alert('Please fill all fields');
                return;
            }

            var existingUsers = JSON.parse(localStorage.getItem('euroUsers') || '[]');
            var userExists = existingUsers.find(function (u) { return u.email === email; });

            if (userExists) {
                alert('User already registered! Please sign in.');
                return;
            }

            var newUser = { name: name, email: email, password: password };
            existingUsers.push(newUser);
            localStorage.setItem('euroUsers', JSON.stringify(existingUsers));
            localStorage.setItem('euroUser', JSON.stringify(newUser));

            alert('Welcome ' + name + '! Welcome to Eurovision!');
            window.location.href = 'homePage.aspx';
        }

        function handleSignin() {
            var email = document.getElementById('signinEmail').value;
            var password = document.getElementById('signinPassword').value;

            if (!email || !password) {
                alert('Please fill all fields');
                return;
            }

            var existingUsers = JSON.parse(localStorage.getItem('euroUsers') || '[]');
            var user = existingUsers.find(function (u) { return u.email === email && u.password === password; });

            if (!user) {
                alert('Invalid email or password');
                return;
            }

            localStorage.setItem('euroUser', JSON.stringify(user));
            alert('Welcome back ' + user.name + '!');
            window.location.href = 'homePage.aspx';
        }

        function logout() {
            localStorage.removeItem('euroUser');
            alert('Successfully logged out');
            window.location.reload();
        }
    </script>
</body>
</html>