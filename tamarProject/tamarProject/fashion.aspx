<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fashion.aspx.cs" Inherits="tamarProject.fashion" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Look of Israel - Eurovision Fashion Journey</title>
    <style>
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-blue: #00b1ea;
            --euro-yellow: #fdf200;
            --gold: #ffd700;
            --black: #000000;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Hebrew', Arial, sans-serif;
            background: var(--black);
            color: white;
            overflow-x: hidden;
        }

        /* Navigation */
        .nav-menu {
            position: fixed;
            top: 30px;
            right: 30px;
            z-index: 1000;
            display: flex;
            gap: 15px;
        }

        .nav-button {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border: 2px solid var(--euro-pink);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 1em;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-button:hover {
            background: var(--euro-pink);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255,0,133,0.4);
        }

        .nav-button span {
            font-size: 1.2em;
        }

        /* Hero Section */
        .hero {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%2314052d"/></svg>');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, 
                rgba(255,0,133,0.1) 0%, 
                rgba(20,5,45,0.8) 50%, 
                rgba(0,177,234,0.1) 100%);
            animation: shimmer 15s infinite;
        }

        @keyframes shimmer {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 900px;
            padding: 40px;
        }

        .hero h1 {
            font-size: 5em;
            font-weight: 900;
            margin-bottom: 20px;
            background: linear-gradient(135deg, white, var(--euro-pink), var(--euro-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: fadeInDown 1.5s ease;
        }

        .hero .subtitle {
            font-size: 1.8em;
            color: var(--euro-yellow);
            margin-bottom: 15px;
            font-weight: 300;
            letter-spacing: 3px;
            animation: fadeInUp 2s ease;
        }

        .hero .description {
            font-size: 1.2em;
            line-height: 1.8;
            color: rgba(255,255,255,0.9);
            max-width: 700px;
            margin: 0 auto;
            animation: fadeIn 2.5s ease;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .scroll-indicator {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0) translateX(-50%); }
            40% { transform: translateY(-20px) translateX(-50%); }
            60% { transform: translateY(-10px) translateX(-50%); }
        }

        /* Eras Section */
        .eras-section {
            padding: 100px 20px;
            background: linear-gradient(180deg, #000 0%, #0a0a0a 100%);
        }

        .section-title {
            text-align: center;
            font-size: 3.5em;
            margin-bottom: 60px;
            background: linear-gradient(135deg, var(--euro-pink), white);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .eras-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            padding: 0 20px;
        }

        .era-card {
            background: linear-gradient(135deg, rgba(255,255,255,0.05), rgba(255,255,255,0.02));
            border-radius: 20px;
            padding: 40px;
            border: 2px solid transparent;
            transition: all 0.5s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .era-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--era-color), transparent);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .era-card:hover::before {
            opacity: 0.2;
        }

        .era-card:hover {
            transform: translateY(-10px);
            border-color: var(--era-color);
            box-shadow: 0 20px 40px rgba(255,0,133,0.3);
        }

        .era-card.ethnic { --era-color: #8B4513; }
        .era-card.uniforms { --era-color: #9370DB; }
        .era-card.diva { --era-color: var(--euro-pink); }
        .era-card.modern { --era-color: var(--euro-blue); }

        .era-header {
            position: relative;
            z-index: 1;
        }

        .era-years {
            font-size: 1em;
            color: var(--euro-yellow);
            font-weight: 600;
            margin-bottom: 10px;
        }

        .era-name {
            font-size: 2.2em;
            font-weight: 900;
            margin-bottom: 20px;
            color: white;
        }

        .era-description {
            font-size: 1.1em;
            line-height: 1.6;
            color: rgba(255,255,255,0.8);
            margin-bottom: 20px;
        }

        .era-icon-item {
            background: rgba(255,0,133,0.1);
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            border-right: 4px solid var(--era-color);
        }

        .icon-label {
            font-size: 0.9em;
            color: var(--euro-yellow);
            margin-bottom: 5px;
        }

        .icon-value {
            font-size: 1.1em;
            font-weight: bold;
        }

        /* Fashion Gallery */
        .fashion-gallery {
            padding: 100px 20px;
            background: #000;
        }

        .gallery-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            padding: 0 20px;
        }

        .fashion-card {
            perspective: 1000px;
            height: 400px;
        }

        .card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            transition: transform 0.8s;
            transform-style: preserve-3d;
        }

        .fashion-card:hover .card-inner {
            transform: rotateY(180deg);
        }

        .card-front, .card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 15px;
            overflow: hidden;
        }

        .card-front {
            background: linear-gradient(135deg, #1a1a1a, #2a2a2a);
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 20px;
            border: 2px solid rgba(255,255,255,0.1);
        }

        .card-front::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(180deg, transparent 0%, rgba(0,0,0,0.9) 100%);
            z-index: 1;
        }

        .card-content {
            position: relative;
            z-index: 2;
        }

        .card-year {
            font-size: 2.5em;
            font-weight: 900;
            color: var(--euro-pink);
            margin-bottom: 5px;
        }

        .card-artist {
            font-size: 1.2em;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card-back {
            background: linear-gradient(135deg, var(--euro-purple), #1a0a2e);
            transform: rotateY(180deg);
            padding: 25px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border: 2px solid var(--euro-pink);
        }

        .xray-title {
            font-size: 1.3em;
            color: var(--euro-yellow);
            margin-bottom: 15px;
            font-weight: 900;
            text-align: center;
        }

        .xray-item {
            margin-bottom: 12px;
            padding: 10px;
            background: rgba(255,255,255,0.05);
            border-radius: 8px;
            border-right: 3px solid var(--euro-blue);
        }

        .xray-label {
            font-size: 0.85em;
            color: var(--euro-pink);
            font-weight: 600;
            margin-bottom: 3px;
        }

        .xray-value {
            font-size: 0.95em;
            line-height: 1.4;
        }

        /* Trend Impact Section */
        .trend-impact {
            padding: 100px 20px;
            background: linear-gradient(180deg, #000 0%, var(--euro-purple) 100%);
        }

        .timeline {
            max-width: 1200px;
            margin: 60px auto 0;
            position: relative;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            height: 100%;
            width: 4px;
            background: linear-gradient(180deg, var(--euro-pink), var(--euro-blue), var(--euro-yellow));
            transform: translateX(-50%);
        }

        .timeline-item {
            margin-bottom: 60px;
            position: relative;
        }

        .timeline-item:nth-child(odd) {
            text-align: left;
            padding-right: 50%;
            padding-left: 20px;
        }

        .timeline-item:nth-child(even) {
            text-align: right;
            padding-left: 50%;
            padding-right: 20px;
        }

        .timeline-content {
            background: rgba(255,255,255,0.05);
            padding: 30px;
            border-radius: 15px;
            border: 2px solid rgba(255,0,133,0.3);
            position: relative;
        }

        .timeline-decade {
            font-size: 2em;
            color: var(--euro-yellow);
            font-weight: 900;
            margin-bottom: 10px;
        }

        .timeline-influence {
            font-size: 1.1em;
            line-height: 1.6;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 3em;
            }

            .hero .subtitle {
                font-size: 1.3em;
            }

            .section-title {
                font-size: 2.5em;
            }

            .timeline::before {
                left: 20px;
            }

            .timeline-item:nth-child(odd),
            .timeline-item:nth-child(even) {
                text-align: right;
                padding-left: 60px;
                padding-right: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Menu -->
    <nav class="nav-menu">
        <a href="homePage.aspx" class="nav-button">
            <span>🏠</span>
            דף הבית
        </a>
        <a href="timeline.aspx" class="nav-button" style="margin-right: 10px;">
            <span>⏱️</span>
            ציר הזמן
        </a>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>THE LOOK OF ISRAEL</h1>
            <div class="subtitle">FROM MASKIT TO GAUTIER</div>
            <p class="description">
                מהסנדלים והרקמה לאופנת העילית • איך האופנה הישראלית על במת האירוויזיון 
                שיקפה את השינוי בזהות הלאומית: מהצבר השורשי ועד לפופ-סטאר הבינלאומית.
            </p>
        </div>
        <div class="scroll-indicator">
            <div style="font-size: 2em; color: var(--euro-pink);">▼</div>
        </div>
    </section>

    <!-- The Eras Gallery -->
    <section class="eras-section">
        <h2 class="section-title">THE ERAS • התקופות</h2>
        <div class="eras-grid">
            <!-- Era 1: Ethnic Roots -->
            <div class="era-card ethnic">
                <div class="era-header">
                    <div class="era-years">1973-1983</div>
                    <h3 class="era-name">The Ethnic Roots</h3>
                    <p class="era-description">
                        רקמות אתניות, גלביות, צהוב וכחול-לבן. ישראל מציגה את השורשים המזרח-תיכוניים 
                        והזהות העברית המחודשת. מ"משכית" לתכשיטים תימניים.
                    </p>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">פריט איקוני:</div>
                    <div class="icon-value">שמלת ה"משכית" של אילנית (1973)</div>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">צבעים מרכזיים:</div>
                    <div class="icon-value">צהוב זהב, כחול-לבן, חום אדמה</div>
                </div>
            </div>

            <!-- Era 2: Group Uniforms -->
            <div class="era-card uniforms">
                <div class="era-header">
                    <div class="era-years">1982-1995</div>
                    <h3 class="era-name">The Group Uniforms</h3>
                    <p class="era-description">
                        מראה אחיד ללהקות, כריות כתפיים, פסטל וסאטן. עידן ה-MTV וההשפעה האמריקאית. 
                        מ"הורה" ל"הללויה" - אחידות ויזואלית כמסר של אחדות.
                    </p>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">פריט איקוני:</div>
                    <div class="icon-value">החליפות הצבעוניות של "עולה עולה"</div>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">צבעים מרכזיים:</div>
                    <div class="icon-value">פסטל, כסף מטאלי, סאטן מבריק</div>
                </div>
            </div>

            <!-- Era 3: Diva Revolution -->
            <div class="era-card diva">
                <div class="era-header">
                    <div class="era-years">1998-2014</div>
                    <h3 class="era-name">The Diva Revolution</h3>
                    <p class="era-description">
                        שמלות קוטור, נוצות, מראות, ומראה ה"גלאם" של הוליווד. דנה אינטרנשיונל פותחת 
                        את השער למהפכת הדיווה - ישראל כמעצמת אופנה עולמית.
                    </p>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">פריט איקוני:</div>
                    <div class="icon-value">שמלת הנוצות של דנה אינטרנשיונל (1998)</div>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">מעצבים:</div>
                    <div class="icon-value">ז'אן פול גוטייה, אלון ליבנה</div>
                </div>
            </div>

            <!-- Era 4: Modern Icon -->
            <div class="era-card modern">
                <div class="era-header">
                    <div class="era-years">2015-2026</div>
                    <h3 class="era-name">The Modern Icon</h3>
                    <p class="era-description">
                        סטריט-וור, בגדי גוף ביוניים, מראה עתידני ולוחמני. מנדב גדג' לנועה קירל - 
                        ישראל כחלק מהפופ-קאלצ'ר העולמי, עם גישה אוונגרדית ונועזת.
                    </p>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">פריט איקוני:</div>
                    <div class="icon-value">בגד הגוף Unicorn של נועה קירל (2023)</div>
                </div>
                <div class="era-icon-item">
                    <div class="icon-label">השפעות:</div>
                    <div class="icon-value">K-Pop, אפרו-פוטוריזם, סטריט-וור</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Fashion Gallery with Flip Cards -->
    <section class="fashion-gallery">
        <h2 class="section-title">X-RAY FASHION • ניתוח לוק</h2>
        <div id="galleryGrid" class="gallery-grid">
            <!-- Cards will be generated by JavaScript -->
        </div>
    </section>

    <!-- Trend Impact Timeline -->
    <section class="trend-impact">
        <h2 class="section-title">TREND IMPACT • ההשפעה האירופית</h2>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-decade">שנות ה-70</div>
                    <div class="timeline-influence">
                        <strong>היפים וילדי הפרחים:</strong> השפעת התנועה הבוהמית האירופית על הבדים 
                        הנושמים והצבעים הטבעיים של ישראל. שמלות מקסי, רקמות ידניות, ושילוב של אלמנטים אתניים.
                    </div>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-decade">שנות ה-80</div>
                    <div class="timeline-influence">
                        <strong>MTV והדיסקו:</strong> המהפכה הויזואלית של MTV והשפעת הדיסקו האמריקאי 
                        על החליפות המבריקות של יזהר כהן. כריות כתפיים, צבעי פסטל, וסאטן מטאלי.
                    </div>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-decade">שנות ה-90</div>
                    <div class="timeline-influence">
                        <strong>מהפכת הסופר-מודלס:</strong> עידן הדיווה בעולם משפיע על ישראל. 
                        מעצבים אירופאים נכנסים לתמונה, ואופנת הקוטור מגיעה לאירוויזיון.
                    </div>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-decade">שנות ה-2020</div>
                    <div class="timeline-influence">
                        <strong>K-Pop וסטריט-וור:</strong> ההשפעה הקוריאנית והאמריקאית של הסטריט-וור 
                        על המראה של נועה קירל ועדן אלנה. פוטוריזם, אפרו-סנטריזם, ואסתטיקה דיגיטלית.
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Load Eurovision data and generate gallery
        const eurovisionData = <%= GetEurovisionDataJson() %>;

        // Filter to iconic fashion moments
        const fashionHighlights = [
            1973, 1978, 1979, 1983, 1985, 1998, 2015, 2018, 2023, 2024
        ];

        const galleryGrid = document.getElementById('galleryGrid');

        fashionHighlights.forEach(year => {
            const entry = eurovisionData.find(e => e.Year === year);
            if (!entry) return;

            const card = document.createElement('div');
            card.className = 'fashion-card';
            card.innerHTML = `
                <div class="card-inner">
                    <div class="card-front">
                        <div class="card-content">
                            <div class="card-year">${entry.Year}</div>
                            <div class="card-artist">${entry.Artist}</div>
                            <div>${entry.Song}</div>
                        </div>
                    </div>
                    <div class="card-back">
                        <div class="xray-title">🔍 X-RAY ANALYSIS</div>
                        <div class="xray-item">
                            <div class="xray-label">הלבוש:</div>
                            <div class="xray-value">${entry.Fashion}</div>
                        </div>
                        <div class="xray-item">
                            <div class="xray-label">הסגנון:</div>
                            <div class="xray-value">${entry.Sound}</div>
                        </div>
                        <div class="xray-item">
                            <div class="xray-label">דירוג:</div>
                            <div class="xray-value">מקום ${entry.Rank || 'N/A'}</div>
                        </div>
                    </div>
                </div>
            `;
            galleryGrid.appendChild(card);
        });
    </script>
</body>
</html>
