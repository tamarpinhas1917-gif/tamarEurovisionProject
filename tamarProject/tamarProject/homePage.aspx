<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="tamarProject.homePage" ContentType="text/html; charset=utf-8" %>

﻿<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision Song Contest | Israel</title>
    <style>
        /* הגדרות צבעים ופונטים של הEurovision */
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-yellow: #fdf200;
            --euro-blue: #00b1ea;
            --deep-navy: #050514;
            --glass: rgba(255, 255, 255, 0.1);
        }

        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Montserrat', 'Segoe UI', sans-serif;
            background: #14052d;
            color: white;
            overflow-x: hidden;
            position: relative;
        }

        /* Floating Eurovision Heart/Circle Shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            animation: float 20s infinite ease-in-out;
            pointer-events: none;
            z-index: 1;
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

        /* Israel Flag */
        .carousel-winner-flag {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 100;
            animation: flagFloat 6s infinite ease-in-out;
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.3));
        }

        @keyframes flagFloat {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        /* GIF Background */
        .gif-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .gif-background img {
            position: absolute;
            top: 50%;
            left: 50%;
            min-width: 100%;
            min-height: 100%;
            width: auto;
            height: auto;
            transform: translate(-50%, -50%);
            object-fit: cover;
        }

        /* Video overlay to darken */
        .video-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(20, 5, 45, 0.5);
            z-index: 1;
            pointer-events: none;
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

        /* User Display - BELOW LOGO ON RIGHT */
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

        /* אזור Hero עם רקע עוצמתי */
        .hero {
            position: relative;
            height: 100vh;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            z-index: 10;
        }

        /* טקסט United By Music בסגנון המקורי */
        .hero h1 {
            font-size: 4.5rem;
            font-weight: 800;
            text-transform: uppercase;
            margin: 0;
            margin-top: -1rem;
            padding: 0 1rem;
            letter-spacing: 1px;
            line-height: 1.1;
            background: linear-gradient(to bottom, #fff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.6));
        }

        .hero h1 .subtitle {
            display: block;
            font-size: 2.5rem;
            font-weight: 600;
            margin-top: 0.5rem;
            letter-spacing: 2px;
        }

        .hero p {
            font-size: 1.8rem;
            margin-top: 10px;
            font-weight: 300;
            color: var(--euro-yellow);
            letter-spacing: 4px;
            text-transform: uppercase;
        }

        /* כפתור Sign Up "וואו" */
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
    
    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag" width="50">
    
    <!-- GIF Background -->
    <div class="gif-background">
        <img src="images/eurovision/יובל רפאלי_קצר.gif" alt="Eurovision Background">
    </div>
    <div class="video-overlay"></div>
    
    <!-- Floating Shapes -->
    <div class="floating-shape shape1"></div>
    <div class="floating-shape shape2"></div>
    <div class="floating-shape shape3"></div>
    <div class="floating-shape shape4"></div>

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

    <section class="hero">
        <h1 style="font-size: 3rem; font-weight: bold; text-transform: uppercase;">Voices of Israel</h1>
        <p style="font-size: 1.5rem; font-style: italic; color: #fdf200;">The Eurovision Journey</p>
        <p>Israel 2026</p>
        
        <a href="login.aspx" class="btn-main" id="ctaButton">Join the Celebration</a>

        <div class="neon-line"></div>
    </section>
    
    <script>
        // Display logged-in user and update CTA
        window.addEventListener('DOMContentLoaded', function() {
            const currentUser = JSON.parse(localStorage.getItem('euroUser') || 'null');
            const ctaButton = document.getElementById('ctaButton');
            
            if (currentUser) {
                // Change CTA button for signed-in users
                if (ctaButton) {
                    ctaButton.href = 'timeline.aspx';
                    ctaButton.textContent = `Welcome ${currentUser.name}! Discover Our Journey`;
                }
            }
        });

        function logout() {
            localStorage.removeItem('euroUser');
            alert('Logoutת בהצלחה / Successfully logged out');
            window.location.reload();
        }
    </script>
</body>
</html>