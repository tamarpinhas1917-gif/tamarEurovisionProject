<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="timeline.aspx.cs" Inherits="tamarProject.timeline" ContentType="text/html; charset=utf-8" %>

﻿<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Timeline של Israel in Eurovision</title>
    <style>
        /* Eurovision Color Palette */
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
            font-family: 'Segoe UI', 'Arial', sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            background-attachment: fixed;
            color: white;
            min-height: 100vh;
            padding: 20px;
            overflow-x: hidden;
            position: relative;
        }

        /* Floating Eurovision Heart/Circle Shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.6;
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

        .shape5 {
            width: 200px;
            height: 200px;
            background: linear-gradient(135deg, rgba(0, 177, 234, 0.6), rgba(255, 0, 133, 0.6));
            bottom: 10%;
            right: 10%;
            animation-delay: 3s;
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

        .container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
            padding-top: 100px;
        }

        header {
            text-align: center;
            margin-bottom: 40px;
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
            line-height: 1.2;
        }

        h1 .white-text {
            color: white;
            display: block;
        }

        h1 .pink-text {
            color: var(--euro-pink);
            display: block;
        }

        .subtitle {
            color: var(--euro-blue);
            font-size: 1.2rem;
            letter-spacing: 1px;
        }

        /* Timeline Slider Section */
        .timeline-section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
        }

        .year-display {
            text-align: center;
            font-size: 4rem;
            font-weight: 900;
            color: var(--euro-pink);
            text-shadow: 0 0 30px rgba(255, 0, 133, 0.5);
            margin-bottom: 80px;
        }

        /* Custom Range Slider */
        .slider-container {
            padding: 20px 0;
        }

        input[type="range"] {
            width: 100%;
            height: 8px;
            background: linear-gradient(to right, var(--euro-purple), var(--euro-pink), var(--euro-blue));
            border-radius: 10px;
            outline: none;
            -webkit-appearance: none;
        }

        input[type="range"]::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 30px;
            height: 30px;
            background: var(--euro-pink);
            border: 3px solid white;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(255, 0, 133, 0.8);
            transition: transform 0.2s;
        }

        input[type="range"]::-webkit-slider-thumb:hover {
            transform: scale(1.2);
        }

        input[type="range"]::-moz-range-thumb {
            width: 30px;
            height: 30px;
            background: var(--euro-pink);
            border: 3px solid white;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(255, 0, 133, 0.8);
        }

        .year-labels {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            font-size: 0.9rem;
            color: #ccc;
        }

        /* Year Markers on Timeline */
        .year-markers {
            position: absolute;
            width: 100%;
            top: 50%;
            left: 0;
            height: 0;
            pointer-events: none;
        }

        .year-marker {
            position: absolute;
            transform: translateX(-50%) translateY(-35px);
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            color: white;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            pointer-events: all;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 0, 133, 0.4);
            white-space: nowrap;
            z-index: 100;
        }

        .year-marker:hover {
            transform: translateX(-50%) translateY(-40px) scale(1.1);
            box-shadow: 0 6px 20px rgba(255, 0, 133, 0.6);
        }

        .year-marker.winner-year {
            background: linear-gradient(135deg, #ffd700, #ffed4e);
            color: #14052d;
        }

        .year-marker.first-year {
            background: linear-gradient(135deg, var(--euro-pink), #ff4d94);
        }

        .year-marker.iconic-year {
            background: linear-gradient(135deg, var(--euro-blue), #4dd4ff);
        }

        .year-marker:active {
            transform: translateX(-50%) translateY(-37px) scale(1.05);
        }

        .year-marker::before {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 6px solid transparent;
            border-right: 6px solid transparent;
            border-top: 8px solid currentColor;
        }

        .marker-top {
            transform: translateX(50%) translateY(-50px) !important;
        }

        .marker-top:hover {
            transform: translateX(50%) translateY(-55px) scale(1.1) !important;
        }

        .marker-bottom {
            transform: translateX(50%) translateY(-20px) !important;
        }

        .marker-bottom:hover {
            transform: translateX(50%) translateY(-25px) scale(1.1) !important;
        }

        /* Artist Image Container */
        .artist-image-container {
            width: 100%;
            max-width: 900px;
            height: 500px;
            margin: 30px auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(255, 0, 133, 0.4);
            position: relative;
            background: linear-gradient(135deg, rgba(255, 0, 133, 0.2), rgba(0, 177, 234, 0.2));
        }

        .artist-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: opacity 0.5s ease;
        }

        .image-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(0, 0, 0, 0.9));
            padding: 25px;
            color: white;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .artist-image-container:hover .image-overlay {
            opacity: 1;
        }

        .image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--euro-purple), var(--euro-pink));
            color: white;
            font-size: 1.5rem;
        }

        .image-placeholder .euro-star {
            font-size: 5rem;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.7; }
            50% { transform: scale(1.1); opacity: 1; }
        }

        /* Content Display Cards */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .main-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 30px;
            grid-column: 1 / -1;
        }

        .song-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--euro-yellow);
            margin-bottom: 10px;
        }

        .artist-name {
            font-size: 1.8rem;
            color: var(--euro-blue);
            margin-bottom: 15px;
        }

        .rank-badge {
            display: inline-block;
            background: var(--euro-pink);
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 25px;
        }

        .info-card h3 {
            color: var(--euro-pink);
            font-size: 1.3rem;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .info-card p {
            line-height: 1.6;
            color: #e0e0e0;
        }

        /* Split View Layout */
        .split-view-container {
            display: flex;
            gap: 25px;
            margin-bottom: 30px;
            flex-direction: row-reverse; /* RTL: Sidebar on right */
        }

        .quick-facts-sidebar {
            flex: 0 0 300px;
            background: linear-gradient(135deg, rgba(255,0,133,0.15), rgba(0,177,234,0.15));
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 32px rgba(255, 0, 133, 0.3);
        }

        .sidebar-header {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--euro-yellow);
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
        }

        .fact-item {
            margin-bottom: 20px;
        }

        .fact-label {
            font-size: 0.85rem;
            color: var(--euro-blue);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .fact-value {
            font-size: 1.2rem;
            color: white;
            font-weight: 600;
        }

        .fact-item .rank-badge {
            width: 100%;
            text-align: center;
            margin-top: 5px;
        }

        .main-content-area {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-card-large {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            padding: 25px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .info-card-large:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(255, 0, 133, 0.3);
        }

        .info-card-large h3 {
            color: var(--euro-pink);
            font-size: 1.4rem;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .info-card-large p {
            line-height: 1.8;
            color: #e0e0e0;
            font-size: 1.05rem;
        }

        /* Fifth card (Mood) spans full width */
        .info-card-large:nth-child(5) {
            grid-column: 1 / -1;
            background: linear-gradient(135deg, rgba(255,0,133,0.1), rgba(0,177,234,0.1));
        }

        /* Navigation Button */
        .back-btn {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-weight: 600;
        }

        .back-btn:hover {
            background: var(--euro-pink);
            border-color: var(--euro-pink);
            box-shadow: 0 0 20px rgba(255, 0, 133, 0.5);
        }

        /* Eurovision 70 Logo */
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
            color: #fdf200;
            font-weight: 600;
            z-index: 1001;
            font-size: 0.9rem;
            background: rgba(20, 5, 45, 0.7);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(253, 242, 0, 0.3);
        }

        .user-display a {
            color: #fdf200;
            text-decoration: none;
            transition: 0.3s;
        }

        .user-display a:hover {
            color: #fff;
            text-shadow: 0 0 8px #fdf200;
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
            color: #ff0085;
            text-shadow: 0 0 8px #ff0085;
        }

        /* Responsive */
        @media (max-width: 768px) {
            h1 { font-size: 2rem; }
            .year-display { font-size: 3rem; }
            .content-grid { grid-template-columns: 1fr; }
            .song-title { font-size: 1.8rem; }
            
            .artist-image-container {
                height: 300px;
                margin: 20px auto;
            }
            
            .image-placeholder .euro-star {
                font-size: 3rem;
            }

            /* Split View Responsive */
            .split-view-container {
                flex-direction: column;
            }

            .quick-facts-sidebar {
                flex: 1 1 auto;
                order: 1;
            }

            .main-content-area {
                order: 2;
                grid-template-columns: 1fr;
            }

            .info-card-large:nth-child(5) {
                grid-column: 1;
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
    </style>
</head>
<body>
    
    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag in a eurovision heart" width="50">
    
        <!-- Floating Eurovision Gradient Shapes -->
        <div class="floating-shape shape1"></div>
        <div class="floating-shape shape2"></div>
        <div class="floating-shape shape3"></div>
        <div class="floating-shape shape4"></div>
        <div class="floating-shape shape5"></div>
        
        <div class="user-display" id="userDisplay">
            <a href="login.aspx">Sign Up / Login</a>
        </div>
        
        <a href="homePage.aspx" style="text-decoration: none;">
        <img src="images/eurovision/eurovision-70-logo.png" alt="Eurovision 70" class="euro-logo">
        </a>
        
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
        
        <div class="container">
            <header>
                <h1>
                    <span class="white-text">Israel's Journey</span>
                    <span class="pink-text">in Eurovision</span>
                </h1>
                <p class="subtitle">1973 - Today</p>
            </header>

            <div class="timeline-section">
                <div class="year-display" id="yearDisplay">1978</div>
                
                <div class="slider-container">
                    <div class="year-markers">
                        <span class="year-marker first-year" style="left: 4%;" title="First participation">&#x1F6A9; 1973</span>
                        <span class="year-marker winner-year marker-top" style="left: 7%;" title="First Win - A-Ba-Ni-Bi">&#x1F3C6; 1978</span>
                        <span class="year-marker winner-year marker-bottom" style="left: 8.5%;" title="Second Win - Hallelujah">&#x1F3C6; 1979</span>
                        <span class="year-marker iconic-year" style="left: 21.5%;" title="2nd Place - Ofra Haza">&#x1F3C6; 1983</span>
                        <span class="year-marker winner-year" style="left: 48%;" title="Third Win - Diva">&#x1F3C6; 1998</span>
                        <span class="year-marker winner-year" style="left: 84%;" title="Fourth Win - Toy">&#x1F3C6; 2018</span>
                        <span class="year-marker iconic-year" style="left: 92.5%;" title="3rd Place - Noa Kirel">&#x1F3C6; 2023</span>
                    </div>
                    <input type="range" id="yearSlider" min="1973" max="2025" value="1978" step="1">
                    <div class="year-labels">
                        <span>1973</span>
                        <span>1990</span>
                        <span>2026</span>
                    </div>
                </div>
            </div>

            <!-- Artist Image Display -->
            <div class="artist-image-container" id="imageContainer">
                <img id="artistImage" class="artist-image" src="" alt="Eurovision Performance" style="display: none;">
                <div id="imagePlaceholder" class="image-placeholder">
                    <div class="euro-star">⭐</div>
                    <div>Eurovision Song Contest</div>
                </div>
                <div class="image-overlay">
                    <div style="font-size: 1.2rem; font-weight: 700;" id="imageYearText">1978</div>
                    <div style="font-size: 0.9rem; opacity: 0.9;" id="imageArtistText">יזהר כהן והאלפבטית</div>
                </div>
            </div>

            <!-- Split View Layout: Sidebar + Main Content -->
            <div class="split-view-container">
                <!-- Right Sidebar (Quick Facts) -->
                <div class="quick-facts-sidebar">
                    <div class="sidebar-header">Quick Facts</div>
                    
                    <div class="fact-item">
                        <div class="fact-label">Year</div>
                        <div class="fact-value" id="sidebarYear">1978</div>
                    </div>
                    
                    <div class="fact-item">
                        <div class="fact-label">Artist</div>
                        <div class="fact-value" id="sidebarArtist">יזהר כהן</div>
                    </div>
                    
                    <div class="fact-item">
                        <div class="fact-label">Song</div>
                        <div class="fact-value" id="sidebarSong">א-בה-ני-בי</div>
                    </div>
                    
                    <div class="fact-item">
                        <div class="fact-label">English Name</div>
                        <div class="fact-value" id="sidebarSongEnglish">A-Ba-Ni-Bi</div>
                    </div>
                    
                    <div class="fact-item">
                        <div class="fact-label">Position</div>
                        <div class="rank-badge" id="rankBadge">🏆 Place 1</div>
                    </div>
                </div>

                <!-- Main Content Area (Detailed Info Cards) -->
                <div class="main-content-area">
                    <div class="info-card-large">
                        <h3>🎵 Sound</h3>
                        <p id="soundInfo">פופ-דיסקו קצבי עם הברות עבריות שהפכו לאייקוניות בעולם.</p>
                    </div>

                    <div class="info-card-large">
                        <h3>👗 Fashion</h3>
                        <p id="fashionInfo">חולצות צבעוניות ומכנסיים מתרחבים - סגנון דיסקו קלאסי של שנות ה-70 המאוחרות.</p>
                    </div>

                    <div class="info-card-large">
                        <h3>🗣️ Language</h3>
                        <p id="languageInfo">Hebrew - Song משחק ילדים שובב שכבש את אירופה.</p>
                    </div>

                    <div class="info-card-large">
                        <h3>💃 Choreography</h3>
                        <p id="choreographyInfo">תנועות קבוצתיות פשוטות ושמחות עם מחיאות כפיים - נגיש ומהנה.</p>
                    </div>

                    <div class="info-card-large">
                        <h3>🌍 National Mood</h3>
                        <p id="moodInfo">אופוריה וגאווה לאומית - הניצחון הראשון של Israel.</p>
                    </div>
                </div>
            </div>

            <!-- Attribution Notice -->
            <div style="text-align: center; margin-top: 40px; padding: 20px; background: rgba(255,255,255,0.05); border-radius: 15px; font-size: 0.9rem; color: #ccc;">
                <p style="margin-bottom: 10px;">
                    📸 <strong>Image Placeholder Notice:</strong>
                </p>
                <p style="line-height: 1.6;">
                    This educational project uses color-coded placeholder images generated by 
                    <a href="https://placeholder.com" target="_blank" style="color: var(--euro-blue); text-decoration: none;">placeholder.com</a>.
                    <br>
                    🏆 <span style="color: #ffd700;">Gold</span> = 1st Place • 
                    🔵 <span style="color: #00b1ea;">Blue</span> = Top 5 • 
                    💗 <span style="color: #ff0085;">Pink</span> = Top 10 • 
                    💜 <span style="color: #14052d; background: #fff; padding: 2px 6px; border-radius: 3px;">Purple</span> = Other
                    <br>
                    <em style="font-size: 0.85rem; opacity: 0.8;">
                        For educational purposes only. Eurovision Song Contest is a trademark of the European Broadcasting Union (EBU).
                    </em>
                </p>
            </div>
        </div>
    

    <script>
        // Eurovision data will be populated from C# code-behind
        const eurovisionData = [
  {
    "Year": 1973,
    "Artist": "אילנית",
    "ArtistEnglish": "Ilanit",
    "Song": "איי שם",
    "SongEnglish": "Ey Sham",
    "Rank": 4,
    "Sound": "בלדה עממית רכה עם עיבוד תזמורתי, המשקפת את סגנון הEurovision של תחילת שנות ה-70",
    "Fashion": "שמלה ארוכה אלגנטית עם שרוולים זורמים - שיק בוהמייני",
    "Language": "Hebrew - מילים מסורתיות ופואטיות",
    "Choreography": "תנועה מינימלית, דגש על ביצוע ווקאלי - אופייני לEurovision המוקדם",
    "Tags": ["Folk", "Orchestra", "Classic"],
    "ImageUrl": ""
  },
  {
    "Year": 1974,
    "Artist": "כוורת",
    "ArtistEnglish": "Kaveret",
    "Song": "נתתי לה חיי",
    "SongEnglish": "Natati La Chayay",
    "Rank": 7,
    "Sound": "פופ-רוק Israelי עם אנרגיה של להקה צעירה",
    "Fashion": "מראה הלהקה: חולצות מכופתרות וג'ינס (יומיומי)",
    "Language": "Hebrew - טקסט רומנטי ויSong",
    "Choreography": "הופעה דינמית של להקת רוק עם תנועה טבעית",
    "Tags": ["Rock", "Youth", "Band"],
    "ImageUrl": ""
  },
  {
    "Year": 1975,
    "Artist": "שלמה ארצי",
    "ArtistEnglish": "Shlomo Artzi",
    "Song": "את ותו לא",
    "SongEnglish": "At Ve'oto Lo",
    "Rank": 11,
    "Sound": "פופ קלאסי עם גישה צעירה - אחד מהSongים המוקדמים של ארצי",
    "Fashion": "חליפת ספארי בהירה, מראה ה'צבר' האירופאי",
    "Language": "Hebrew - טקסט יSong ורגשי",
    "Choreography": "אנרגיה רוקנרולית על הבמה - תנועה חופשית",
    "Tags": ["Pop", "Israeli", "Debut"],
    "ImageUrl": ""
  },
  {
    "Year": 1976,
    "Artist": "שוקולד מנטה מסטיק",
    "ArtistEnglish": "Chocolate Menta Mastik",
    "Song": "אמור Hello",
    "SongEnglish": "Emor Shalom",
    "Rank": 6,
    "Sound": "פופ הרמוני (בנות) עם מנגינה מדבקת",
    "Fashion": "שמלות תואמות בגזרת A, מראה ה'דיילות'",
    "Language": "Hebrew - מסר של Hello ואופטימיות",
    "Choreography": "Choreography מסונכרנת של שלוש - הרמוניות מושלמות",
    "Tags": ["Harmony", "GirlGroup", "Peace"],
    "ImageUrl": ""
  },
  {
    "Year": 1977,
    "Artist": "אילנית",
    "ArtistEnglish": "Ilanit",
    "Song": "אהבה היא Song לשניים",
    "SongEnglish": "Ahava Hi Shir Lishnayim",
    "Rank": 11,
    "Sound": "בלדה אירופאית עם עיבוד אורקסטרלי עSong",
    "Fashion": "שמלת קטיפה כהה ואלגנטית",
    "Language": "Hebrew - Song אהבה פואטי",
    "Choreography": "ביצוע סטטי ממוקד - דגש על ווקאל",
    "Tags": ["Ballad", "Classic", "Romantic"],
    "ImageUrl": ""
  },
  {
    "Year": 1978,
    "Artist": "יזהר כהן והאלפבית",
    "ArtistEnglish": "Izhar Cohen & Alphabeta",
    "Song": "א-בה-ני-בי",
    "SongEnglish": "A-Ba-Ni-Bi",
    "Rank": 1,
    "Sound": "פופ-דיסקו קצבי עם הברות עבריות שהפכו לאייקוניות בעולם",
    "Fashion": "חולצות צבעוניות ומכנסיים מתרחבים - סגנון דיסקו קלאסי של שנות ה-70 המאוחרות",
    "Language": "Hebrew - Song משחק ילדים שובב שכבש את אירופה",
    "Choreography": "תנועות קבוצתיות פשוטות ושמחות עם מחיאות כפיים - נגיש ומהנה",
    "Tags": ["Winner", "Disco", "Iconic", "Aftershock"],
    "ImageUrl": ""
  },
  {
    "Year": 1979,
    "Artist": "גלי עטרי, חלב ודבש",
    "ArtistEnglish": "Gali Atari & Milk and Honey",
    "Song": "הללויה",
    "SongEnglish": "Hallelujah",
    "Rank": 1,
    "Sound": "פולק-פופ הרמוני עם גוון רוחני - מרומם ובלתי נשכח",
    "Fashion": "תלבושות לבנות זורמות וטבעיות המסמלות Hello ואחדות",
    "Language": "Hebrew - מסר אוניברסלי של חגיגה ושבח",
    "Choreography": "תנועות נדנוד עדינות ודינמיקה קבוצתית הרמונית - דגש על מיזוג ווקאלי",
    "Tags": ["Winner", "Harmony", "Spiritual", "Iconic"],
    "ImageUrl": ""
  },
  {
    "Year": 1980,
    "Artist": "-",
    "ArtistEnglish": "Did Not Participate",
    "Song": "-",
    "SongEnglish": "Did Not Participate",
    "Rank": null,
    "Sound": "Israel לא השתתפה - אירחה את התחרות בירושלים אחרי הזכייה ב-1979",
    "Fashion": "-",
    "Language": "-",
    "Choreography": "-",
    "Tags": ["DidNotParticipate", "HostCountry"],
    "ImageUrl": ""
  },
  {
    "Year": 1981,
    "Artist": "הכל עובר חביבי",
    "ArtistEnglish": "Hakol Over Habibi",
    "Song": "הלילה",
    "SongEnglish": "Halayla",
    "Rank": 7,
    "Sound": "פופ-ג'אז קברטי עם אווירה לילית",
    "Fashion": "שמלות נצנצים וחליפות טוקסידו - מראה קברט אלגנטי",
    "Language": "Hebrew - אווירה רומנטית ולילית",
    "Choreography": "תנועות קברטיות עם רקדנים",
    "Tags": ["Cabaret", "Jazz", "Night"],
    "ImageUrl": ""
  },
  {
    "Year": 1982,
    "Artist": "אבי טולדנו",
    "ArtistEnglish": "Avi Toledano",
    "Song": "הורה",
    "SongEnglish": "Hora",
    "Rank": 2,
    "Sound": "פופ-פולק (הורה) עם מקצבים מסורתיים",
    "Fashion": "לבן עם עיטורי כסף, מראה חגיגי",
    "Language": "Hebrew - חגיגית וקצבית",
    "Choreography": "ריקוד הורה ותנועות עממיות - חגיגי ואנרגטי",
    "Tags": ["Folk", "Dance", "Traditional"],
    "ImageUrl": ""
  },
  {
    "Year": 1983,
    "Artist": "עפרה חזה",
    "ArtistEnglish": "Ofra Haza",
    "Song": "חי",
    "SongEnglish": "Chai",
    "Rank": 2,
    "Sound": "פופ-פולק Israelי עם ווקאל תימני עוצמתי",
    "Fashion": "צהוב בוהק עם תכשיטים תימניים מסורתיים",
    "Language": "Hebrew - סגנון ביצוע דרמטי ותיאטרלי",
    "Choreography": "אלמנטים של ריקוד עממי מסורתי משולבים עם במה עכשווית",
    "Tags": ["Ethnic", "Yemenite", "Icon", "PowerVocal"],
    "ImageUrl": ""
  },
  {
    "Year": 1984,
    "Artist": "בני שני",
    "ArtistEnglish": "Beney Shney",
    "Song": "זמר נוגה",
    "SongEnglish": "Zemer Nogah",
    "Rank": 19,
    "Sound": "בלדה פואטית עם עיבוד קלאסי",
    "Fashion": "חליפה קלאסית בסגנון שנות ה-80",
    "Language": "Hebrew - מילים פואטיות",
    "Choreography": "ביצוע סטטי ממוקד",
    "Tags": ["Ballad", "Poetic"],
    "ImageUrl": ""
  },
  {
    "Year": 1985,
    "Artist": "יזהר כהן",
    "ArtistEnglish": "Izhar Cohen",
    "Song": "עולה עולה",
    "SongEnglish": "Olé Olé",
    "Rank": 5,
    "Sound": "פופ קצבי עם מנגינה אופטימית - Song המנון",
    "Fashion": "מראה ה'גל החדש': כריות כתפיים וצבעי פסטל",
    "Language": "Hebrew - מסר של תקווה ואחדות",
    "Choreography": "תנועות דינמיות עם אנרגיה חיובית",
    "Tags": ["80sPop", "Optimistic", "Anthem"],
    "ImageUrl": ""
  },
  {
    "Year": 1986,
    "Artist": "מוטי גלעדי ושרי צוריאל",
    "ArtistEnglish": "Moti Giladi & Sarai Tzuriel",
    "Song": "יבוא יום",
    "SongEnglish": "Yavo Yom",
    "Rank": 19,
    "Sound": "דואט פופ עם מסר של תקווה",
    "Fashion": "חליפות צבעוניות בסגנון שנות ה-80 המוקדמות",
    "Language": "Hebrew - Song על עתיד טוב יותר",
    "Choreography": "דואט עם תנועות מסונכרנות",
    "Tags": ["Duet", "Hope", "80s"],
    "ImageUrl": ""
  },
  {
    "Year": 1987,
    "Artist": "דטנר וקושניר (להקת הפרחים)",
    "ArtistEnglish": "Datner & Kushnir",
    "Song": "Song הCancelנים",
    "SongEnglish": "Shir Habatlanim",
    "Rank": 8,
    "Sound": "פופ-קומי עם הומור Israelי ייחודי",
    "Fashion": "חליפות 'האחים בלוז' (שחור-לבן, כובע ומשקפיים)",
    "Language": "Hebrew - טקסט הומוריסטי",
    "Choreography": "תנועות קומיות בסגנון קברט",
    "Tags": ["Comedy", "Cabaret", "Unique"],
    "ImageUrl": ""
  },
  {
    "Year": 1988,
    "Artist": "ירדנה ארזי",
    "ArtistEnglish": "Yardena Arazi",
    "Song": "בן אדם",
    "SongEnglish": "Ben Adam",
    "Rank": 7,
    "Sound": "פופ-צועני עם אלמנטים דרמטיים",
    "Fashion": "שמלת צוענייה עSongה בשכבות וצבעים",
    "Language": "Hebrew - מילים משמעותיות על אנושיות",
    "Choreography": "ביצוע רגשי ותיאטרלי",
    "Tags": ["Dramatic", "Gypsy", "Theatrical"],
    "ImageUrl": ""
  },
  {
    "Year": 1989,
    "Artist": "גילי וגלית",
    "ArtistEnglish": "Gili & Galit",
    "Song": "דרך המלך",
    "SongEnglish": "Derekh Hamelekh",
    "Rank": 12,
    "Sound": "בלדת פופ עם ווקאל ילדים",
    "Fashion": "בגדי ילדים חגיגיים (וסט ועניבת פרפר)",
    "Language": "Hebrew - פואטי ומהורהר",
    "Choreography": "דואט ילדים רגיש עם תנועה מינימלית",
    "Tags": ["Children", "Innocent", "Poetic"],
    "ImageUrl": ""
  },
  {
    "Year": 1990,
    "Artist": "ריטה",
    "ArtistEnglish": "Rita",
    "Song": "שרה בלילה",
    "SongEnglish": "Shara Balayla",
    "Rank": 18,
    "Sound": "בלדת פופ עם השפעות מזרח תיכוניות",
    "Fashion": "שמלת ערב אלגנטית",
    "Language": "Hebrew - רומנטי ולילי",
    "Choreography": "ביצוע רגשי עם תנועה מינימלית",
    "Tags": ["Ballad", "MiddleEastern", "Night"],
    "ImageUrl": ""
  },
  {
    "Year": 1991,
    "Artist": "דוד ד'אור",
    "ArtistEnglish": "Duo Datz",
    "Song": "כאן",
    "SongEnglish": "Kan",
    "Rank": 3,
    "Sound": "בלדת כוח עם קליימקס דרמטי - ווקאל מרשים",
    "Fashion": "חליפה שחורה אלגנטית",
    "Language": "Hebrew - מסר של נוכחות ומחויבות",
    "Choreography": "ביצוע סטטי עם דרמה ווקאלית",
    "Tags": ["PowerBallad", "Dramatic", "Top3"],
    "ImageUrl": ""
  },
  {
    "Year": 1992,
    "Artist": "דפנה דיאל",
    "ArtistEnglish": "Dafna Dekel",
    "Song": "זה הזמן",
    "SongEnglish": "Ze Hazman",
    "Rank": 6,
    "Sound": "פופ אופטימי עם אנרגיה חיובית",
    "Fashion": "שמלה צבעונית ומודרנית",
    "Language": "Hebrew - מסר של מימוש חלומות",
    "Choreography": "תנועות אנרגטיות וחיוביות",
    "Tags": ["Pop", "Optimistic", "Upbeat"],
    "ImageUrl": ""
  },
  {
    "Year": 1993,
    "Artist": "להקת הSound הרך",
    "ArtistEnglish": "Lehakat HaTzlil HaRach",
    "Song": "Song לHello",
    "SongEnglish": "Shir LaShalom",
    "Rank": 24,
    "Sound": "בלדת Hello מסורתית - Song המחאה המפורסם",
    "Fashion": "תלבושות פשוטות בלבן",
    "Language": "Hebrew - מסר של Hello ותקווה",
    "Choreography": "ביצוע פשוט וכן - דגש על המסר",
    "Tags": ["Peace", "Protest", "Historical"],
    "ImageUrl": ""
  },
  {
    "Year": 1994,
    "Artist": "כרמל",
    "ArtistEnglish": "Carmel",
    "Song": "צא לך",
    "SongEnglish": "Amen",
    "Rank": 15,
    "Sound": "פופ מזרח תיכוני עם אלמנטים אתניים",
    "Fashion": "שמלה מסורתית עם תכשיטים",
    "Language": "Hebrew - מסר של מסע ותקווה",
    "Choreography": "תנועות מסורתיות עם אנרגיה",
    "Tags": ["MiddleEastern", "Ethnic", "Journey"],
    "ImageUrl": ""
  },
  {
    "Year": 1995,
    "Artist": "ליאורה",
    "ArtistEnglish": "Liora",
    "Song": "לו יהיה לי",
    "SongEnglish": "Amen",
    "Rank": 8,
    "Sound": "בלדה רגשית עם ווקאל עוצמתי",
    "Fashion": "שמלת ערב אדומה מרשימה",
    "Language": "Hebrew - מילים רגשיות ואישיות",
    "Choreography": "ביצוע ממוקד עם רגש עמוק",
    "Tags": ["Ballad", "Emotional", "PowerVocal"],
    "ImageUrl": ""
  },
  {
    "Year": 1996,
    "Artist": "גלעד סגב",
    "ArtistEnglish": "Galit",
    "Song": "פתח לי את הלב",
    "SongEnglish": "Shalom Olam",
    "Rank": 17,
    "Sound": "בלדה אקוסטית עם מסר Hello",
    "Fashion": "תלבושת פשוטה וצנועה",
    "Language": "Hebrew - מסר אוניברסלי",
    "Choreography": "ביצוע אינטימי ופשוט",
    "Tags": ["Acoustic", "Peace", "Simple"],
    "ImageUrl": ""
  },
  {
    "Year": 1997,
    "Artist": "אופרה חזה",
    "ArtistEnglish": "Ofra Haza",
    "Song": "שמע Israel",
    "SongEnglish": "Shma Yisrael",
    "Rank": 12,
    "Sound": "פיוז'ן אתני-מודרני עם עוצמה ווקאלית",
    "Fashion": "תלבושת מסורתית עם נגיעות מודרניות",
    "Language": "Hebrew - תפילה מסורתית בעיבוד מודרני",
    "Choreography": "תנועות מסורתיות עם אנרגיה עכשווית",
    "Tags": ["Ethnic", "Fusion", "Prayer", "Icon"],
    "ImageUrl": ""
  },
  {
    "Year": 1998,
    "Artist": "דנה אינטרנשיונל",
    "ArtistEnglish": "Dana International",
    "Song": "דיווה",
    "SongEnglish": "Diva",
    "Rank": 1,
    "Sound": "טכנו-פופ אנרגטי עם השפעות מזרח תיכוניות - פורץ דרך ונועז",
    "Fashion": "שמלת ערב נוצצת - אנרגיה וביטחון של דיווה אמיתית",
    "Language": "Hebrew עם המילה הEnglish 'דיווה' - מגשרת על תרבויות ושוברת גבולות",
    "Choreography": "Choreography פופ מודרנית עם תנועות בטוחות ומעצימות - רגע AFTERSHOCK",
    "Tags": ["Winner", "Techno", "Groundbreaking", "Aftershock", "LGBTQ"],
    "ImageUrl": ""
  },
  {
    "Year": 1999,
    "Artist": "עדן",
    "ArtistEnglish": "Eden",
    "Song": "כולנו רוצים אהבה",
    "SongEnglish": "Yom Huledet (Happy Birthday)",
    "Rank": 5,
    "Sound": "פופ צעיר ואנרגטי - Song יום הולדת חגיגי",
    "Fashion": "תלבושות צעירות וצבעוניות",
    "Language": "Hebrew - מסר שמח וחגיגי",
    "Choreography": "Choreography אנרגטית עם רקדנים",
    "Tags": ["Pop", "Youth", "Celebration"],
    "ImageUrl": ""
  },
  {
    "Year": 2000,
    "Artist": "פינגווין",
    "ArtistEnglish": "Ping Pong",
    "Song": "שאלתי את הלב",
    "SongEnglish": "Sameach",
    "Rank": 22,
    "Sound": "פופ קליל עם מנגינה פשוטה",
    "Fashion": "תלבושות קז'ואל צעירות",
    "Language": "Hebrew - Song על שמחה",
    "Choreography": "תנועות פשוטות וידידותיות",
    "Tags": ["Pop", "Simple", "Happy"],
    "ImageUrl": ""
  },
  {
    "Year": 2001,
    "Artist": "טל ספקטור",
    "ArtistEnglish": "Tal Sondak",
    "Song": "כאילו בחלום",
    "SongEnglish": "En Davar",
    "Rank": 16,
    "Sound": "פופ קליל עם גישה אופטימית",
    "Fashion": "תלבושת צעירה ועכשווית",
    "Language": "Hebrew - מסר חיובי",
    "Choreography": "תנועות פשוטות ושמחות",
    "Tags": ["Pop", "Optimistic", "Light"],
    "ImageUrl": ""
  },
  {
    "Year": 2002,
    "Artist": "שרית חדד",
    "ArtistEnglish": "Sarit Hadad",
    "Song": "Light a Candle",
    "SongEnglish": "Light a Candle",
    "Rank": 12,
    "Sound": "בלדת פופ עם מסר של Hello",
    "Fashion": "שמלת ערב לבנה אלגנטית",
    "Language": "English - מסר אוניברסלי של תקווה",
    "Choreography": "ביצוע רגשי עם אנרגיה",
    "Tags": ["Ballad", "Peace", "Hope"],
    "ImageUrl": ""
  },
  {
    "Year": 2003,
    "Artist": "לירן דמארי (Lhasa)",
    "ArtistEnglish": "Lhasa",
    "Song": "חזור רעותי",
    "SongEnglish": "Words for Love",
    "Rank": 29,
    "Sound": "פופ-רוק עם אנרגיה מודרנית",
    "Fashion": "סגנון רוק צעיר עם עור",
    "Language": "Hebrew + English - רוק אנרגטי",
    "Choreography": "אנרגיה רוק עם רקדנים",
    "Tags": ["Rock", "Modern", "Edgy"],
    "ImageUrl": ""
  },
  {
    "Year": 2004,
    "Artist": "דיויד ד'אור",
    "ArtistEnglish": "David D'Or",
    "Song": "לאהוב אותך",
    "SongEnglish": "Leha'amin",
    "Rank": 11,
    "Sound": "בלדה רגשית עם ווקאל עוצמתי",
    "Fashion": "חליפה שחורה קלאסית",
    "Language": "Hebrew - מסר של אמונה",
    "Choreography": "ביצוע דרמטי ממוקד",
    "Tags": ["Ballad", "PowerVocal", "Belief"],
    "ImageUrl": ""
  },
  {
    "Year": 2005,
    "Artist": "Songי מימון",
    "ArtistEnglish": "Shiri Maimon",
    "Song": "השקט שנשאר",
    "SongEnglish": "HaSheket SheNishar",
    "Rank": 4,
    "Sound": "בלדה רגשית עם עיבוד דרמטי - ביצוע ווקאלי עוצמתי",
    "Fashion": "שמלת ערב אדומה אלגנטית - מתוחכמת ומודרנית",
    "Language": "Hebrew - מילים רגשיות ואינטרוספקטיביות עמוקות",
    "Choreography": "תנועה מינימלית עם דגש על חיבור רגשי וביצוע ווקאלי",
    "Tags": ["Ballad", "PowerVocal", "Emotional", "Top5"],
    "ImageUrl": ""
  },
  {
    "Year": 2006,
    "Artist": "אדי Cancelר",
    "ArtistEnglish": "Eddie Butler",
    "Song": "Together We Are One",
    "SongEnglish": "Together We Are One",
    "Rank": 23,
    "Sound": "בלדת פופ עם מסר של אחדות",
    "Fashion": "חליפה אלגנטית קלאסית",
    "Language": "English - מסר אוניברסלי",
    "Choreography": "ביצוע פשוט ורגשי",
    "Tags": ["Ballad", "Unity", "Simple"],
    "ImageUrl": ""
  },
  {
    "Year": 2007,
    "Artist": "טרף",
    "ArtistEnglish": "Teapacks",
    "Song": "Push The Button",
    "SongEnglish": "Push The Button",
    "Rank": 25,
    "Sound": "אלקטרו-פופ עם מסר פוליטי",
    "Fashion": "תלבושות אלקטרוניות עתידניות",
    "Language": "English - מסר נגד מלחמה",
    "Choreography": "Choreography מודרנית עם אפקטים",
    "Tags": ["Electro", "Political", "AntiWar"],
    "ImageUrl": ""
  },
  {
    "Year": 2008,
    "Artist": "בועז מעודה",
    "ArtistEnglish": "Boaz Mauda",
    "Song": "כאילו",
    "SongEnglish": "The Fire in Your Eyes",
    "Rank": 9,
    "Sound": "בלדה דרמטית עם ווקאל עוצמתי",
    "Fashion": "חליפה שחורה אלגנטית",
    "Language": "English - רגשי ועוצמתי",
    "Choreography": "ביצוע דרמטי עם נוכחות במה",
    "Tags": ["Ballad", "Dramatic", "PowerVocal"],
    "ImageUrl": ""
  },
  {
    "Year": 2009,
    "Artist": "נועה",
    "ArtistEnglish": "Noa & Mira Awad",
    "Song": "היא באה מהבלוג",
    "SongEnglish": "There Must Be Another Way",
    "Rank": 16,
    "Sound": "פופ-רוק עם מסר של דו-קיום - דואט עברי-ערבי",
    "Fashion": "תלבושות מודרניות בשחור-לבן",
    "Language": "Hebrew וערבית - מסר של Hello",
    "Choreography": "Choreography משותפת המסמלת אחדות",
    "Tags": ["Duet", "Peace", "Coexistence", "Political"],
    "ImageUrl": ""
  },
  {
    "Year": 2010,
    "Artist": "חראל סקעת",
    "ArtistEnglish": "Harel Skaat",
    "Song": "מילים",
    "SongEnglish": "Milim",
    "Rank": 14,
    "Sound": "פופ-רוק אנרגטי עם גיטרות חשמליות",
    "Fashion": "סגנון רוקר עם עור וג'ינס",
    "Language": "Hebrew - טקסט על כוח המילים",
    "Choreography": "אנרגיה רוק עם תנועה דינמית",
    "Tags": ["Rock", "Pop", "Words"],
    "ImageUrl": ""
  },
  {
    "Year": 2011,
    "Artist": "דנה אינטרנשיונל",
    "ArtistEnglish": "Dana International",
    "Song": "דינג דונג",
    "SongEnglish": "Ding Dong",
    "Rank": 15,
    "Sound": "פופ אנרגטי עם מנגינה מדבקת",
    "Fashion": "תלבושות צבעוניות וקצביות",
    "Language": "English - Song שמח ומרגיע",
    "Choreography": "Choreography אנרגטית עם רקדנים",
    "Tags": ["Pop", "Catchy", "Energetic"],
    "ImageUrl": ""
  },
  {
    "Year": 2012,
    "Artist": "איציק כהן",
    "ArtistEnglish": "Izabo",
    "Song": "אניני",
    "SongEnglish": "Time",
    "Rank": 23,
    "Sound": "בלדה רגשית עם ווקאל עמוק",
    "Fashion": "חליפה קלאסית שחורה",
    "Language": "English - רפלקטיבי ורגשי",
    "Choreography": "ביצוע סטטי עם עומק רגשי",
    "Tags": ["Ballad", "Reflective", "Deep"],
    "ImageUrl": ""
  },
  {
    "Year": 2013,
    "Artist": "מורן מזור",
    "ArtistEnglish": "Moran Mazor",
    "Song": "Rak bishvilo",
    "SongEnglish": "רק בשבילו",
    "Rank": 22,
    "Sound": "בלדה רגשית עם נוכחות ווקאלית",
    "Fashion": "שמלה פשוטה ואלגנטית",
    "Language": "Hebrew - אישי ורגשי",
    "Choreography": "ביצוע אינטימי ופשוט",
    "Tags": ["Ballad", "Intimate", "Personal"],
    "ImageUrl": ""
  },
  {
    "Year": 2014,
    "Artist": "מיי פיינגולד",
    "ArtistEnglish": "Mei Finegold",
    "Song": "Same Heart",
    "SongEnglish": "Same Heart",
    "Rank": null,
    "Sound": "פופ עדין עם מסר של אחדות - לא עבר חצי גמר",
    "Fashion": "תלבושת פשוטה ומודרנית",
    "Language": "English - מסר של חיבור",
    "Choreography": "ביצוע פשוט ורגשי",
    "Tags": ["Pop", "Unity", "DidNotQualify"],
    "ImageUrl": ""
  },
  {
    "Year": 2015,
    "Artist": "נדב גדג'",
    "ArtistEnglish": "Nadav Guedj",
    "Song": "גולדן בוי",
    "SongEnglish": "Golden Boy",
    "Rank": 9,
    "Sound": "פופ קצבי עם אווירה ים-תיכונית - המנון קיץ מרגיש טוב",
    "Fashion": "לוק טרנדי קז'ואל עם ג'קט ג'ינס - צעיר ורענן",
    "Language": "English - מכוון לקהל אירופי רחב יותר",
    "Choreography": "תנועות פופ מודרניות אנרגטיות עם רקדני רקע - סגנון Eurovision עכשווי",
    "Tags": ["Pop", "Summer", "Mediterranean", "FeelGood"],
    "ImageUrl": ""
  },
  {
    "Year": 2016,
    "Artist": "הוי",
    "ArtistEnglish": "Hovi Star",
    "Song": "Made of Stars",
    "SongEnglish": "Made of Stars",
    "Rank": 14,
    "Sound": "פופ אלקטרוני עם אנרגיה גבוהה",
    "Fashion": "תלבושות נוצצות בסגנון פופ",
    "Language": "English - Song על חלומות",
    "Choreography": "Choreography מודרנית עם אפקטי במה",
    "Tags": ["Electro", "Pop", "Dreams"],
    "ImageUrl": ""
  },
  {
    "Year": 2017,
    "Artist": "עמרי ועידן רייכל",
    "ArtistEnglish": "IMRI",
    "Song": "I Feel Alive",
    "SongEnglish": "I Feel Alive",
    "Rank": 23,
    "Sound": "בלדה עדינה עם אלמנטים אלקטרוניים",
    "Fashion": "תלבושות מינימליסטיות בלבן",
    "Language": "English - מסר של תקווה",
    "Choreography": "ביצוע עדין ואינטימי",
    "Tags": ["Ballad", "Electronic", "Hope"],
    "ImageUrl": ""
  },
  {
    "Year": 2018,
    "Artist": "נטע ברזילי",
    "ArtistEnglish": "Netta Barzilai",
    "Song": "טוי",
    "SongEnglish": "Toy",
    "Rank": 1,
    "Sound": "אלקטרו-פופ מוזר עם קולות תרנגולת ולופינג - ויראלי ובלתי נשכח",
    "Fashion": "קימונו צבעוני נועז עם אביזרים בולטים - אכזרי וייחודי",
    "Language": "English - המנון העצמה עם גישה שובבה",
    "Choreography": "תנועות 'ריקוד התרנגולת' המיתולוגיות שהפכו ויראליות בעולם - AFTERSHOCK טהור",
    "Tags": ["Winner", "Electro", "Viral", "Aftershock", "Empowerment", "Iconic"],
    "ImageUrl": ""
  },
  {
    "Year": 2019,
    "Artist": "כוכב נולד",
    "ArtistEnglish": "Kobi Marimi",
    "Song": "בית הספר לניצוחים",
    "SongEnglish": "Home",
    "Rank": null,
    "Sound": "בלדת פופ רגשית - לא עבר את חצי הגמר",
    "Fashion": "תלבושת פשוטה ואלגנטית",
    "Language": "English - Song על השתייכות",
    "Choreography": "ביצוע עדין ורגשי",
    "Tags": ["Ballad", "DidNotQualify", "Emotional"],
    "ImageUrl": ""
  },
  {
    "Year": 2020,
    "Artist": "עדן אלנה",
    "ArtistEnglish": "Eden Alene",
    "Song": "Feker Libi",
    "SongEnglish": "Feker Libi",
    "Rank": null,
    "Sound": "פיוז'ן אתני-אלקטרוני עם השפעות אתיופיות - הEurovision בוטל בגלל קורונה",
    "Fashion": "תלבושות אתניות מודרניות עם צבעוניות",
    "Language": "אמהרית + Hebrew - חגיגה תרבותית ייחודית",
    "Choreography": "Choreography משלבת ריקוד אתיופי עם פופ מודרני - לא הוצגה",
    "Tags": ["Ethnic", "Fusion", "Ethiopian", "COVID", "Cancelled"],
    "ImageUrl": ""
  },
  {
    "Year": 2021,
    "Artist": "עדן אלנה",
    "ArtistEnglish": "Eden Alene",
    "Song": "Set Me Free",
    "SongEnglish": "Set Me Free",
    "Rank": 17,
    "Sound": "פופ אלקטרוני עם אנרגיה גבוהה",
    "Fashion": "תלבושות עתידניות נוצצות",
    "Language": "English - Song על חופש",
    "Choreography": "Choreography מודרנית עם רקדנים",
    "Tags": ["Pop", "Electronic", "Freedom"],
    "ImageUrl": ""
  },
  {
    "Year": 2022,
    "Artist": "מיכאל בן דוד",
    "ArtistEnglish": "Michael Ben David",
    "Song": "I.M",
    "SongEnglish": "I.M",
    "Rank": 17,
    "Sound": "פופ-רוק עם אנרגיה חיובית",
    "Fashion": "תלבושת צבעונית ואנרגטית",
    "Language": "English - Song על ביטחון עצמי",
    "Choreography": "Choreography אנרגטית עם רקדנים",
    "Tags": ["Pop", "Rock", "Confidence"],
    "ImageUrl": ""
  },
  {
    "Year": 2023,
    "Artist": "נועה קירל",
    "ArtistEnglish": "Noa Kirel",
    "Song": "Unicorn",
    "SongEnglish": "Unicorn",
    "Rank": 3,
    "Sound": "פופ אלקטרוני עוצמתי עם אנרגיה גבוהה",
    "Fashion": "תלבושות עתידניות נוצצות בוורוד וסגול",
    "Language": "English - Song על ייחודיות",
    "Choreography": "Choreography מורכבת עם רקדנים ואפקטים ויזואליים",
    "Tags": ["Pop", "Electronic", "Top3", "Spectacle"],
    "ImageUrl": ""
  },
  {
    "Year": 2024,
    "Artist": "עדן גולן",
    "ArtistEnglish": "Eden Golan",
    "Song": "הוריקן",
    "SongEnglish": "Hurricane",
    "Rank": 5,
    "Sound": "בלדת כוח דרמטית עם אלמנטים אלקטרוניים - רגשית ואינטנסיבית",
    "Fashion": "שמלה אלגנטית מודרנית עם אלמנטים זורמים - במה מתוחכמת",
    "Language": "English - ביצוע ווקאלי עוצמתי עם מסירה דרמטית",
    "Choreography": "מחול עכשווי עם דימויים סמליים - משלב רגש עם דיוק טכני",
    "Tags": ["PowerBallad", "Dramatic", "Contemporary", "Top5"],
    "ImageUrl": ""
  },
  {
    "Year": 2025,
    "Artist": "יובל רפאל",
    "ArtistEnglish": "Yuval Raphael",
    "Song": "New Day Will Rise",
    "SongEnglish": "New Day Will Rise",
    "Rank": null,
    "Sound": "בלדת פופ עוצמתית - Eurovision 2025 עדיין לא התקיים",
    "Fashion": "שמלה שחורה ודרמטית",
    "Language": "English - מסר של תקווה",
    "Choreography": "טרם הוצג",
    "Tags": ["Pop", "Ballad", "Future", "2025"],
    "ImageUrl": ""
  },
  {
    "Year": 2026,
    "Artist": "נועם בתן",
    "ArtistEnglish": "Noam Batan",
    "Song": "-",
    "SongEnglish": "-",
    "Rank": null,
    "Sound": "הSong טרם נבחר - נועם בתן נבחר כArtist ב-2026",
    "Fashion": "טרם נקבע",
    "Language": "טרם נקבע",
    "Choreography": "טרם נקבע",
    "Tags": ["Future", "2026", "Selected"],
    "ImageUrl": ""
  }
];

        const slider = document.getElementById('yearSlider');
        const yearDisplay = document.getElementById('yearDisplay');
        const songTitle = document.getElementById('songTitle');
        const artistName = document.getElementById('artistName');
        const rankBadge = document.getElementById('rankBadge');
        const songHebrew = document.getElementById('songHebrew');
        const soundInfo = document.getElementById('soundInfo');
        const fashionInfo = document.getElementById('fashionInfo');
        const languageInfo = document.getElementById('languageInfo');
        const choreographyInfo = document.getElementById('choreographyInfo');
        
        // Image elements
        const artistImage = document.getElementById('artistImage');
        const imagePlaceholder = document.getElementById('imagePlaceholder');
        const imageYearText = document.getElementById('imageYearText');
        const imageArtistText = document.getElementById('imageArtistText');

        /**
         * Generates a beautiful Eurovision-branded placeholder image URL
         * Uses placeholder.com with Eurovision colors and text
         * @param {number} year - Eurovision year
         * @param {string} artist - Artist name in English
         * @param {number} rank - Competition rank
         * @returns {string} Placeholder image URL
         */
        function generateEurovisionPlaceholder(year, artist, rank) {
            // Eurovision color palette (without # for URL)
            const colors = {
                purple: '14052d',
                pink: 'ff0085',
                blue: '00b1ea',
                yellow: 'fdf200',
                gold: 'ffd700'
            };
            
            // Choose background color based on rank
            let bgColor = colors.purple;
            let textColor = 'ffffff';
            
            if (rank === 1) {
                bgColor = colors.gold;
                textColor = '000000';
            } else if (rank <= 5) {
                bgColor = colors.blue;
            } else if (rank <= 10) {
                bgColor = colors.pink;
            }
            
            // Create text for placeholder
            const text = `${year}+${encodeURIComponent(artist)}`;
            
            // Generate placeholder URL (900x500 to match container)
            return `https://via.placeholder.com/900x500/${bgColor}/${textColor}?text=${text}`;
        }

        // Update display when slider moves
        slider.addEventListener('input', function() {
            const year = parseInt(this.value);
            updateDisplay(year);
        });

        // Add click event listeners to year markers
        document.querySelectorAll('.year-marker').forEach(marker => {
            marker.addEventListener('click', function() {
                const yearText = this.textContent.trim();
                const year = parseInt(yearText.match(/\d{4}/)[0]);
                slider.value = year;
                updateDisplay(year);
            });
        });

        function updateDisplay(year) {
            yearDisplay.textContent = year;
            
            // Find data for this year
            const yearData = eurovisionData.find(d => d.Year === year);
            
            if (yearData) {
                // Sidebar Quick Facts
                document.getElementById('sidebarYear').textContent = year;
                document.getElementById('sidebarArtist').textContent = yearData.Artist;
                document.getElementById('sidebarSong').textContent = yearData.Song;
                document.getElementById('sidebarSongEnglish').textContent = yearData.SongEnglish || yearData.Song;
                
                // Rank Badge (both locations now)
                rankBadge.textContent = yearData.Rank || 'N/A';
                
                // Main Content Cards
                soundInfo.textContent = yearData.Sound;
                fashionInfo.textContent = yearData.Fashion;
                languageInfo.textContent = yearData.Language;
                choreographyInfo.textContent = yearData.Choreography;
                
                // NEW: Mood/National Spirit
                const moodElement = document.getElementById('moodInfo');
                if (moodElement) {
                    moodElement.textContent = yearData.Mood || yearData.HalachRuach || 'מידע לא זמין';
                }
                
                // Update image overlay text
                imageYearText.textContent = year;
                imageArtistText.textContent = yearData.Artist;
                
                // Update artist image with fade effect
                artistImage.style.opacity = '0';
                
                setTimeout(() => {
                    // Try multiple image formats (png, jpg, jpeg, JPG, webp, avif)
                    const year = yearData.Year;
                    const imageFormats = ['.png', '.jpg', '.jpeg', '.JPG', '.webp', '.avif'];
                    let imageFound = false;
                    let formatIndex = 0;
                    
                    const tryNextFormat = () => {
                        if (formatIndex >= imageFormats.length) {
                            // No image found, check for DNP
                            const dnpYears = [1980, 1984, 1994, 1997];
                            if (dnpYears.includes(year)) {
                                artistImage.src = 'images/eurovision/Not Participated.png';
                                artistImage.style.display = 'block';
                                imagePlaceholder.style.display = 'none';
                                setTimeout(() => { artistImage.style.opacity = '1'; }, 50);
                            } else {
                                // Use placeholder for missing images
                                const placeholderUrl = generateEurovisionPlaceholder(
                                    year, 
                                    yearData.ArtistEnglish || yearData.Artist, 
                                    yearData.Rank || 99
                                );
                                artistImage.src = placeholderUrl;
                                artistImage.style.display = 'block';
                                imagePlaceholder.style.display = 'none';
                                setTimeout(() => { artistImage.style.opacity = '1'; }, 50);
                            }
                            return;
                        }
                        
                        const testImage = new Image();
                        testImage.onload = function() {
                            // Image found!
                            artistImage.src = 'images/eurovision/' + year + imageFormats[formatIndex];
                            artistImage.style.display = 'block';
                            imagePlaceholder.style.display = 'none';
                            setTimeout(() => { artistImage.style.opacity = '1'; }, 50);
                        };
                        testImage.onerror = function() {
                            // Try next format
                            formatIndex++;
                            tryNextFormat();
                        };
                        testImage.src = 'images/eurovision/' + year + imageFormats[formatIndex];
                    };
                    
                    tryNextFormat();
                }, 300);
                
                // Change rank badge color based on performance
                if (yearData.Rank === 1) {
                    rankBadge.style.background = 'linear-gradient(135deg, #FFD700, #FFA500)';
                } else if (yearData.Rank <= 5) {
                    rankBadge.style.background = 'var(--euro-blue)';
                } else if (yearData.Rank === null) {
                    rankBadge.style.background = '#666';
                } else {
                    rankBadge.style.background = 'var(--euro-pink)';
                }
            } else {
                // No data for this year
                document.getElementById('sidebarYear').textContent = year;
                document.getElementById('sidebarArtist').textContent = 'לא השתתף';
                document.getElementById('sidebarSong').textContent = 'N/A';
                document.getElementById('sidebarSongEnglish').textContent = 'N/A';
                rankBadge.textContent = 'N/A';
                soundInfo.textContent = 'Israel did not participate this year.';
                fashionInfo.textContent = '-';
                languageInfo.textContent = '-';
                choreographyInfo.textContent = '-';
                rankBadge.style.background = '#444';
                
                // Show placeholder for non-participation years
                artistImage.style.opacity = '0';
                setTimeout(() => {
                    artistImage.style.display = 'none';
                    imagePlaceholder.style.display = 'flex';
                }, 300);
                
                imageYearText.textContent = year;
                imageArtistText.textContent = 'No Entry';
            }
        }

        // Initialize with default year
        updateDisplay(1978);
    </script>

    <script>
        // Display logged-in user
        window.addEventListener('DOMContentLoaded', function() {
            const currentUser = JSON.parse(localStorage.getItem('euroUser') || 'null');
            const userDisplay = document.getElementById('userDisplay');
            
            if (currentUser && userDisplay) {
                userDisplay.innerHTML = `<span>Hello ${currentUser.name}!</span> | <a href="#" onclick="logout(); return false;">Logout</a>`;
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
