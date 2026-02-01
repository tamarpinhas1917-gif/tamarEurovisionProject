<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="timeline.aspx.cs" Inherits="tamarProject.timeline" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ציר הזמן של ישראל באירוויזיון</title>
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
            margin-bottom: 30px;
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
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Floating Eurovision Gradient Shapes -->
        <div class="floating-shape shape1"></div>
        <div class="floating-shape shape2"></div>
        <div class="floating-shape shape3"></div>
        <div class="floating-shape shape4"></div>
        <div class="floating-shape shape5"></div>
        
        <img src="https://www.eurovision.com/static/images/70-logo.ba56318cd52f.webp" alt="Eurovision 70" class="euro-logo">
        
        <div class="container">
            <header>
                <h1>
                    <span class="white-text">המסע של ישראל</span>
                    <span class="pink-text">באירוויזיון</span>
                </h1>
                <p class="subtitle">1973 - היום</p>
            </header>

            <div class="timeline-section">
                <div class="year-display" id="yearDisplay">1978</div>
                
                <div class="slider-container">
                    <input type="range" id="yearSlider" min="1973" max="2025" value="1978" step="1">
                    <div class="year-labels">
                        <span>1973</span>
                        <span>1990</span>
                        <span>2025</span>
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

            <div class="content-grid">
                <div class="main-card">
                <div class="song-title" id="songTitle">א-בה-ני-בי</div>
                <div class="artist-name" id="artistName">יזהר כהן והאלפבטית</div>
                <div class="rank-badge" id="rankBadge">🏆 מקום 1 - ניצחון!</div>
                <p id="songHebrew" style="font-size: 1.3rem; color: #ccc; margin-top: 10px;">A-Ba-Ni-Bi</p>
                </div>

                <div class="info-card">
                    <h3>🎵 צליל</h3>
                    <p id="soundInfo">פופ-דיסקו קצבי עם הברות עבריות שהפכו לאייקוניות בעולם.</p>
                </div>

                <div class="info-card">
                    <h3>👗 אופנה</h3>
                    <p id="fashionInfo">חולצות צבעוניות ומכנסיים מתרחבים - סגנון דיסקו קלאסי של שנות ה-70 המאוחרות.</p>
                </div>

                <div class="info-card">
                    <h3>🗣️ שפה</h3>
                    <p id="languageInfo">עברית - שיר משחק ילדים שובב שכבש את אירופה.</p>
                </div>

                <div class="info-card">
                    <h3>💃 כוריאוגרפיה</h3>
                    <p id="choreographyInfo">תנועות קבוצתיות פשוטות ושמחות עם מחיאות כפיים - נגיש ומהנה.</p>
                </div>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <a href="homePage.aspx" class="back-btn" style="margin-left: 15px;">→ חזרה לעמוד הבית</a>
                <a href="fashion.aspx" class="back-btn" style="background: linear-gradient(135deg, #ff0085, #00b1ea);">👗 לדף האופנה</a>
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
    </form>

    <script>
        // Eurovision data will be populated from C# code-behind
        const eurovisionData = <%= GetEurovisionDataJson() %>;

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

        function updateDisplay(year) {
            yearDisplay.textContent = year;
            
            // Find data for this year
            const yearData = eurovisionData.find(d => d.Year === year);
            
            if (yearData) {
                songTitle.textContent = yearData.Song;
                artistName.textContent = yearData.Artist;
                rankBadge.textContent = yearData.RankDisplay;
                songHebrew.textContent = yearData.SongEnglish || '';
                soundInfo.textContent = yearData.Sound;
                fashionInfo.textContent = yearData.Fashion;
                languageInfo.textContent = yearData.Language;
                choreographyInfo.textContent = yearData.Choreography;
                
                // Update image overlay text
                imageYearText.textContent = year;
                imageArtistText.textContent = yearData.Artist;
                
                // Update artist image with fade effect
                if (yearData.ImageUrl && yearData.ImageUrl !== '') {
                    // Real image provided - use it
                    artistImage.style.opacity = '0';
                    
                    setTimeout(() => {
                        artistImage.src = yearData.ImageUrl;
                        artistImage.style.display = 'block';
                        imagePlaceholder.style.display = 'none';
                        
                        setTimeout(() => {
                            artistImage.style.opacity = '1';
                        }, 50);
                    }, 300);
                    
                    artistImage.onerror = function() {
                        // If real image fails, use placeholder
                        const placeholderUrl = generateEurovisionPlaceholder(
                            yearData.Year, 
                            yearData.ArtistEnglish || yearData.Artist, 
                            yearData.Rank || 99
                        );
                        artistImage.src = placeholderUrl;
                    };
                } else {
                    // No image URL - generate Eurovision placeholder
                    artistImage.style.opacity = '0';
                    
                    setTimeout(() => {
                        const placeholderUrl = generateEurovisionPlaceholder(
                            yearData.Year, 
                            yearData.ArtistEnglish || yearData.Artist, 
                            yearData.Rank || 99
                        );
                        
                        artistImage.src = placeholderUrl;
                        artistImage.style.display = 'block';
                        imagePlaceholder.style.display = 'none';
                        
                        setTimeout(() => {
                            artistImage.style.opacity = '1';
                        }, 50);
                    }, 300);
                    
                    // No error handler needed for placeholders
                    artistImage.onerror = null;
                }
                
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
                songTitle.textContent = 'No Entry';
                artistName.textContent = 'Israel did not participate';
                rankBadge.textContent = 'N/A';
                songHebrew.textContent = '';
                soundInfo.textContent = 'Israel was not in the contest this year.';
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
</body>
</html>
