<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="data-manager.aspx.cs" Inherits="tamarProject.data_manager" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision Data Manager - Tamar's Project</title>
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
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            background-attachment: fixed;
            color: white;
            padding: 20px;
            min-height: 100vh;
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
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 3rem;
            font-weight: 900;
            text-transform: uppercase;
            background: linear-gradient(135deg, var(--euro-yellow), var(--euro-pink));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: none;
        }

        .controls {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #00c853, #00e676);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--euro-yellow), #ffa726);
            color: #14052d;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 0, 133, 0.4);
        }

        .search-box {
            flex: 1;
            min-width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 1em;
        }

        .search-box input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .data-grid {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: white;
        }

        th, td {
            padding: 12px;
            text-align: right;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        th {
            background: rgba(255, 0, 133, 0.3);
            font-weight: bold;
            position: sticky;
            top: 0;
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .rank-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9em;
        }

        .rank-1 {
            background: linear-gradient(135deg, #ffd700, #ffed4e);
            color: #14052d;
        }

        .rank-2 {
            background: linear-gradient(135deg, #c0c0c0, #e8e8e8);
            color: #14052d;
        }

        .rank-3 {
            background: linear-gradient(135deg, #cd7f32, #daa520);
            color: white;
        }

        .rank-top10 {
            background: rgba(0, 177, 234, 0.5);
            color: white;
        }

        .rank-other {
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .tag {
            display: inline-block;
            padding: 3px 8px;
            margin: 2px;
            border-radius: 12px;
            font-size: 0.8em;
            background: rgba(255, 0, 133, 0.3);
        }

        .stats-panel {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.05);
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .stat-card:hover {
            background: rgba(255, 0, 133, 0.2);
            border-color: var(--euro-pink);
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(255, 0, 133, 0.3);
        }

        .stat-card.active {
            background: rgba(255, 0, 133, 0.3);
            border-color: var(--euro-yellow);
            box-shadow: 0 10px 25px rgba(253, 242, 0, 0.4);
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: var(--euro-pink);
            margin: 10px 0;
        }

        .stat-label {
            font-size: 1em;
            opacity: 0.8;
        }

        .action-btns {
            display: flex;
            gap: 5px;
        }

        .btn-small {
            padding: 6px 12px;
            font-size: 0.85em;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-edit {
            background: var(--euro-blue);
            color: white;
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn-small:hover {
            transform: scale(1.05);
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

        .euro-logo:hover {
            transform: scale(1.05);
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

        .user-display a {
            color: #fdf200;
            text-decoration: none;
        }

        .user-display a:hover {
            text-decoration: underline;
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

        @keyframes float {
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
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag" width="50">

    <!-- User Display -->
    <div class="user-display" id="userDisplay">
        <% if (Session["user"] != null) { %>
            <span style="color:#fdf200;">👤 <%= Session["user"] %></span>
            &nbsp;|&nbsp;<a href="logout.aspx">Logout</a>
        <% } else { %>
            <a href="login.aspx">Sign Up / Login</a>
        <% } %>
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
            <% if (Session["user"] != null) { %><li><a href="update.aspx">My Profile</a></li><li><a href="logout.aspx">Logout</a></li><% if (Session["isAdmin"] != null) { %><li><a href="admin.aspx" style="color:#fdf200;">Admin</a></li><% } %><% } else { %><li><a href="signUp.aspx">Sign Up</a></li><li><a href="login.aspx">Login</a></li><% } %>
        </ul>
    </nav>

    <div class="container" style="padding-top: 120px;">
            <h1>Site Data Manager</h1>

            <div class="stats-panel">
                <div class="stat-card" onclick="filterByCategory('all')" data-filter="all">
                    <div class="stat-label">סה"כ שנים</div>
                    <div class="stat-number" id="totalYears">0</div>
                </div>
                <div class="stat-card" onclick="filterByCategory('winner')" data-filter="winner">
                    <div class="stat-label">🏆 ניצחונות</div>
                    <div class="stat-number" id="totalWins">0</div>
                </div>
                <div class="stat-card" onclick="filterByCategory('second')" data-filter="second">
                    <div class="stat-label">🥈 Place 2</div>
                    <div class="stat-number" id="totalSecond">0</div>
                </div>
                <div class="stat-card" onclick="filterByCategory('third')" data-filter="third">
                    <div class="stat-label">🥉 Place 3</div>
                    <div class="stat-number" id="totalThird">0</div>
                </div>
                <div class="stat-card" onclick="filterByCategory('top10')" data-filter="top10">
                    <div class="stat-label">⭐ Top 10</div>
                    <div class="stat-number" id="totalTop10">0</div>
                </div>
            </div>

            <div class="controls">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="🔍 חיפוש לפי Year, אמן, Song..." onkeyup="filterTable()">
                </div>
                <button type="button" class="btn btn-success" onclick="window.location.href='timeline.aspx'">
                    📊 צפייה בTimeline
                </button>
                <button type="button" class="btn btn-warning" onclick="exportToExcel()">
                    📥 ייצוא ל-Excel
                </button>
            </div>

            <div class="data-grid">
                <table id="dataTable">
                    <thead>
                        <tr>
                            <th>פעולות</th>
                            <th>תגיות</th>
                            <th>דירוג</th>
                            <th>Song</th>
                            <th>אמן</th>
                            <th>Year</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be loaded here by JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    

    <script>
        let allData = [];

        // Load data when page loads
        window.onload = function() {
            loadData();
        };

        function loadData() {
            // In ASP.NET, we'll inject the JSON data here
            allData = [
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
    "Rank": "COVID",
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
    "Rank": 2,
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
            renderTable(allData);
            updateStats(allData);
        }

        function renderTable(data) {
            const tbody = document.getElementById('tableBody');
            tbody.innerHTML = '';

            data.forEach(entry => {
                const row = document.createElement('tr');
                
                // Rank badge
                let rankClass = 'rank-other';
                let rankText = entry.Rank || 'N/A';
                
                if (entry.Rank === 1) rankClass = 'rank-1';
                else if (entry.Rank === 2) rankClass = 'rank-2';
                else if (entry.Rank === 3) rankClass = 'rank-3';
                else if (entry.Rank && entry.Rank <= 10) rankClass = 'rank-top10';

                // Tags
                const tags = entry.Tags ? entry.Tags.map(tag => `<span class="tag">${tag}</span>`).join(' ') : '';

                row.innerHTML = `
                    <td>
                        <div class="action-btns">
                            <button class="btn-small btn-edit" onclick="editEntry(${entry.Year})">✏️</button>
                            <button class="btn-small btn-delete" onclick="deleteEntry(${entry.Year})">🗑️</button>
                        </div>
                    </td>
                    <td>${tags}</td>
                    <td><span class="rank-badge ${rankClass}">${rankText}</span></td>
                    <td>${entry.Song} (${entry.SongEnglish})</td>
                    <td>${entry.Artist}</td>
                    <td><strong>${entry.Year}</strong></td>
                `;
                
                tbody.appendChild(row);
            });
        }

        function updateStats(data) {
            document.getElementById('totalYears').textContent = data.length;
            
            const wins = data.filter(e => e.Rank === 1).length;
            const second = data.filter(e => e.Rank === 2).length;
            const third = data.filter(e => e.Rank === 3).length;
            const top10 = data.filter(e => e.Rank && e.Rank >= 4 && e.Rank <= 10).length;
            
            document.getElementById('totalWins').textContent = wins;
            document.getElementById('totalSecond').textContent = second;
            document.getElementById('totalThird').textContent = third;
            document.getElementById('totalTop10').textContent = top10;
        }

        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            
            const filtered = allData.filter(entry => {
                return entry.Year.toString().includes(searchTerm) ||
                       entry.Artist.toLowerCase().includes(searchTerm) ||
                       entry.ArtistEnglish.toLowerCase().includes(searchTerm) ||
                       entry.Song.toLowerCase().includes(searchTerm) ||
                       entry.SongEnglish.toLowerCase().includes(searchTerm) ||
                       (entry.Tags && entry.Tags.some(tag => tag.toLowerCase().includes(searchTerm)));
            });
            
            renderTable(filtered);
        }

        let currentFilter = 'all';

        function filterByCategory(category) {
            currentFilter = category;
            
            // Update active state on stat cards
            document.querySelectorAll('.stat-card').forEach(card => {
                card.classList.remove('active');
            });
            document.querySelector(`[data-filter="${category}"]`).classList.add('active');
            
            // Clear search box
            document.getElementById('searchInput').value = '';
            
            let filtered = allData;
            
            if (category === 'all') {
                filtered = allData;
            } else if (category === 'winner') {
                filtered = allData.filter(entry => entry.Rank === 1);
            } else if (category === 'second') {
                filtered = allData.filter(entry => entry.Rank === 2);
            } else if (category === 'third') {
                filtered = allData.filter(entry => entry.Rank === 3);
            } else if (category === 'top10') {
                filtered = allData.filter(entry => entry.Rank && entry.Rank <= 10);
            }
            
            renderTable(filtered);
            
            // Show feedback
            const labels = {
                'all': 'All Years',
                'winner': 'Winners Only',
                'second': '2nd Place Only',
                'third': '3rd Place Only',
                'top10': 'Top 10 Only'
            };
            
            console.log(`Filter: ${labels[category]} - ${filtered.length} results`);
        }

        function editEntry(year) {
            alert('Edit entry for year ' + year + '\n\nTo edit, open the file:\nApp_Data/eurovision-data.json\n\nin a text editor or Visual Studio');
        }

        function deleteEntry(year) {
            if (confirm('Are you sure you want to delete the entry for year ' + year + '?')) {
                alert('To delete, edit the file:\nApp_Data/eurovision-data.json');
            }
        }

        function exportToExcel() {
            // Simple CSV export
            let csv = 'Year,Artist,Song,Rank,Sound,Fashion\n';
            
            allData.forEach(entry => {
                csv += `${entry.Year},"${entry.Artist}","${entry.Song}",${entry.Rank || 'N/A'},"${entry.Sound}","${entry.Fashion}"\n`;
            });
            
            const blob = new Blob(['\ufeff' + csv], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'eurovision-data.csv';
            link.click();
        }
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
            alert('Successfully logged out');
            window.location.reload();
        }
    </script>

</body>
</html>
