<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="trivia.aspx" Inherits="tamarProject.trivia" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eurovision Trivia - Israel</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            color: white;
            min-height: 100vh;
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

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 120px 20px 40px;
            position: relative;
            z-index: 10;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .page-header h1 {
            font-size: 3.5rem;
            font-weight: 900;
            text-transform: uppercase;
            margin-bottom: 15px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 0 20px rgba(255, 0, 133, 0.3));
        }

        .page-header p {
            font-size: 1.2rem;
            color: var(--euro-yellow);
            letter-spacing: 2px;
        }

        /* Layout Grid */
        .trivia-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        /* Trivia Section */
        .trivia-section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
        }

        .trivia-section h2 {
            font-size: 2rem;
            margin-bottom: 10px;
            color: var(--euro-pink);
        }

        .score-display {
            font-size: 1.5rem;
            color: var(--euro-yellow);
            margin-bottom: 30px;
            font-weight: 700;
        }

        /* Question Card */
        .question-card {
            background: rgba(0, 0, 0, 0.3);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
        }

        .question-number {
            color: var(--euro-blue);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }

        .question-text {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 25px;
            line-height: 1.4;
        }

        /* Answer Options */
        .answers {
            display: grid;
            gap: 15px;
        }

        .answer-btn {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            padding: 15px 20px;
            border-radius: 10px;
            color: white;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: left;
        }

        .answer-btn:hover {
            background: rgba(255, 0, 133, 0.2);
            border-color: var(--euro-pink);
            transform: translateX(5px);
        }

        .answer-btn.selected {
            background: rgba(0, 177, 234, 0.3);
            border-color: var(--euro-blue);
        }

        .answer-btn.correct {
            background: rgba(0, 255, 0, 0.2);
            border-color: #00ff00;
            animation: correctPulse 0.5s ease;
        }

        .answer-btn.incorrect {
            background: rgba(255, 0, 0, 0.2);
            border-color: #ff0000;
            animation: shake 0.5s ease;
        }

        @keyframes correctPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        /* Navigation Buttons */
        .trivia-nav {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .nav-btn {
            background: var(--euro-pink);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }

        .nav-btn:hover {
            background: var(--euro-blue);
            box-shadow: 0 0 30px rgba(0, 177, 234, 0.5);
            transform: scale(1.05);
        }

        .nav-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
            transform: scale(1);
        }

        /* Leaderboard Section */
        .leaderboard-section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 30px;
            max-height: 800px;
            overflow-y: auto;
        }

        .leaderboard-section h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: var(--euro-yellow);
            text-align: center;
        }

        .live-indicator {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .live-dot {
            width: 10px;
            height: 10px;
            background: #00ff00;
            border-radius: 50%;
            animation: livePulse 2s infinite;
        }

        @keyframes livePulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        /* Leaderboard Items */
        .leaderboard-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            margin-bottom: 10px;
            transition: background 0.3s ease, transform 0.3s ease;
            will-change: transform;
        }

        .leaderboard-item:hover {
            background: rgba(255, 0, 133, 0.1);
            transform: translateX(5px);
        }

        .rank {
            font-size: 1.5rem;
            font-weight: 900;
            width: 40px;
            text-align: center;
        }

        .rank.gold {
            color: #ffd700;
            text-shadow: 0 0 10px #ffd700;
        }

        .rank.silver {
            color: #c0c0c0;
            text-shadow: 0 0 10px #c0c0c0;
        }

        .rank.bronze {
            color: #cd7f32;
            text-shadow: 0 0 10px #cd7f32;
        }

        .player-info {
            flex: 1;
        }

        .player-name {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .player-time {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.6);
        }

        .player-score {
            font-size: 1.3rem;
            font-weight: 900;
            color: var(--euro-yellow);
        }

        /* Results Modal */
        .results-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .results-modal.active {
            display: flex;
        }

        .results-content {
            background: linear-gradient(135deg, var(--euro-purple), var(--deep-navy));
            border: 2px solid var(--euro-pink);
            border-radius: 20px;
            padding: 50px;
            max-width: 600px;
            text-align: center;
        }

        .results-content h2 {
            font-size: 3rem;
            color: var(--euro-yellow);
            margin-bottom: 20px;
        }

        .final-score {
            font-size: 4rem;
            color: var(--euro-pink);
            font-weight: 900;
            margin: 20px 0;
        }

        .restart-btn {
            background: var(--euro-blue);
            color: white;
            border: none;
            padding: 20px 60px;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 30px;
            transition: all 0.3s ease;
        }

        .restart-btn:hover {
            background: var(--euro-pink);
            box-shadow: 0 0 30px rgba(255, 0, 133, 0.5);
            transform: scale(1.05);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .trivia-layout {
                grid-template-columns: 1fr;
            }

            .top-nav ul {
                gap: 20px;
            }

            .top-nav ul li a {
                font-size: 0.8rem;
            }
        }
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

    <!-- Main Container -->
    <div class="container">
        <div class="page-header">
            <h1>🎵 Eurovision Trivia 🎵</h1>
            <p>Test Your Knowledge of Israel's Eurovision Journey</p>
        </div>

        <!-- Sign-In Gate (shown when not logged in) -->
        <div id="signInGate" style="display:none; text-align:center; padding: 80px 20px;">
            <div style="
                background: rgba(20, 5, 45, 0.8);
                backdrop-filter: blur(20px);
                border: 2px solid var(--euro-pink);
                border-radius: 30px;
                padding: 60px 40px;
                max-width: 500px;
                margin: 0 auto;
                box-shadow: 0 20px 60px rgba(255, 0, 133, 0.3);
            ">
                <div style="font-size: 4rem; margin-bottom: 20px;">🎤</div>
                <h2 style="font-size: 2rem; color: var(--euro-pink); margin-bottom: 15px;">Hold on!</h2>
                <p style="font-size: 1.2rem; color: white; margin-bottom: 10px; line-height: 1.6;">
                    You have to <strong style="color: var(--euro-yellow);">sign in</strong> in order to play.
                </p>
                <p style="font-size: 1rem; color: rgba(255,255,255,0.6); margin-bottom: 35px;">
                    Sign in to track your score and appear on the leaderboard!
                </p>
                <a href="login.aspx" style="
                    display: inline-block;
                    background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
                    color: white;
                    text-decoration: none;
                    padding: 18px 50px;
                    border-radius: 50px;
                    font-size: 1.1rem;
                    font-weight: bold;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    transition: all 0.3s;
                    box-shadow: 0 10px 30px rgba(255,0,133,0.4);
                ">Sign In / Sign Up 🎵</a>
                <br>
                <a href="homePage.aspx" style="
                    display: inline-block;
                    margin-top: 20px;
                    color: var(--euro-yellow);
                    text-decoration: none;
                    font-size: 0.9rem;
                ">← Back to Home</a>
            </div>
        </div>

        <!-- Trivia Game (shown when logged in) -->
        <div id="triviaGame" style="display:none;">
        <div class="trivia-layout">
            <!-- Trivia Section -->
            <div class="trivia-section">
                <h2>Challenge Yourself</h2>
                <div class="score-display">
                    Score: <span id="currentScore">0</span> / <span id="totalQuestions">10</span>
                </div>

                <div id="questionContainer" class="question-card">
                    <!-- Questions will be inserted here -->
                </div>

                <div class="trivia-nav">
                    <button class="nav-btn" id="prevBtn" onclick="previousQuestion()" disabled>← Previous</button>
                    <button class="nav-btn" id="nextBtn" onclick="nextQuestion()">Next →</button>
                </div>
            </div>

            <!-- Leaderboard Section -->
            <div class="leaderboard-section">
                <h2>🏆 Leaderboard 🏆</h2>
                <div class="live-indicator">
                    <div class="live-dot"></div>
                    <span>Live Updates</span>
                </div>
                <div id="leaderboardContainer">
                    <!-- Leaderboard items will be inserted here -->
                </div>
            </div>
        </div>
        </div>
    </div>

    <!-- Results Modal -->
    <div class="results-modal" id="resultsModal">
        <div class="results-content">
            <h2>🎉 Quiz Complete! 🎉</h2>
            <p id="resultPlayerName" style="font-size: 1.1rem; color: var(--euro-yellow); margin-bottom: 5px;"></p>
            <p style="font-size: 1.2rem; margin-bottom: 10px;">Your Final Score:</p>
            <div class="final-score" id="finalScore">0/10</div>
            <p id="resultMessage" style="font-size: 1.1rem; margin: 20px 0;"></p>
            <button class="restart-btn" onclick="restartTrivia()">Play Again 🎵</button>
        </div>
    </div>

    <script>
        // Trivia Questions Database
        const triviaQuestions = [
            {
                question: "In which year did Israel win Eurovision for the first time?",
                answers: ["1973", "1978", "1979", "1983"],
                correct: 1
            },
            {
                question: "What was the name of Israel's first Eurovision winning song?",
                answers: ["Hallelujah", "A-Ba-Ni-Bi", "Diva", "Toy"],
                correct: 1
            },
            {
                question: "Who won Eurovision 2018 with the song 'Toy'?",
                answers: ["Dana International", "Netta Barzilai", "Noa Kirel", "Eden Golan"],
                correct: 1
            },
            {
                question: "How many times has Israel won the Eurovision Song Contest?",
                answers: ["2 times", "3 times", "4 times", "5 times"],
                correct: 2
            },
            {
                question: "Which Israeli artist finished second place in 1983?",
                answers: ["Gali Atari", "Ofra Haza", "Ilanit", "Dana International"],
                correct: 1
            },
            {
                question: "What song did Dana International win with in 1998?",
                answers: ["Toy", "Diva", "Hallelujah", "Golden Boy"],
                correct: 1
            },
            {
                question: "In which year did Israel host Eurovision for the first time?",
                answers: ["1978", "1979", "1999", "2019"],
                correct: 1
            },
            {
                question: "Who represented Israel in Eurovision 2023?",
                answers: ["Eden Golan", "Noa Kirel", "Eden Alene", "Michael Ben David"],
                correct: 1
            },
            {
                question: "What place did Noa Kirel achieve in Eurovision 2023?",
                answers: ["Winner", "Second Place", "Third Place", "Fifth Place"],
                correct: 2
            },
            {
                question: "Which city hosted Eurovision 2019 after Israel's victory?",
                answers: ["Jerusalem", "Tel Aviv", "Haifa", "Eilat"],
                correct: 1
            }
        ];

        // Game State
        let currentQuestion = 0;
        let score = 0;
        let userAnswers = [];
        let currentUser = null;
        let answerLocked = false; // Prevent double-clicking during auto-advance

        // Load leaderboard from localStorage, seeded with defaults if empty
        function getLeaderboard() {
            var stored = localStorage.getItem('euroTriviaLeaderboard');
            if (stored) return JSON.parse(stored);
            // Default seed entries
            return [
                { name: "Sarah Cohen", score: 10, time: "2 mins ago" },
                { name: "David Levi", score: 9, time: "5 mins ago" },
                { name: "Maya Goldstein", score: 9, time: "8 mins ago" },
                { name: "Yoni Shapira", score: 8, time: "12 mins ago" },
                { name: "Avi Mizrahi", score: 7, time: "20 mins ago" }
            ];
        }

        let leaderboard = getLeaderboard();

        // Initialize
        window.addEventListener('DOMContentLoaded', function() {
            // Check if user is logged in (server-side Session variable)
            var isLoggedIn = '<%= Session["user"] != null ? "true" : "false" %>' === 'true';
            var userName = '<%= Session["user"] != null ? Session["user"].ToString() : "" %>';
            
            if (isLoggedIn) {
                // User is signed in - show the game
                currentUser = { name: userName };
                document.getElementById('userDisplay').innerHTML =
                    '<span>Welcome, ' + userName + '!</span>';
                document.getElementById('signInGate').style.display = 'none';
                document.getElementById('triviaGame').style.display = 'block';
                loadQuestion();
                updateLeaderboard();
            } else {
                // User is NOT signed in - show the gate, hide the game
                document.getElementById('signInGate').style.display = 'block';
                document.getElementById('triviaGame').style.display = 'none';
                // Still show leaderboard below the gate
                updateLeaderboard();
            }
        });

        function loadQuestion() {
            answerLocked = false;
            const question = triviaQuestions[currentQuestion];
            const container = document.getElementById('questionContainer');
            
            container.innerHTML =
                '<div class="question-number">Question ' + (currentQuestion + 1) + ' of ' + triviaQuestions.length + '</div>' +
                '<div class="question-text">' + question.question + '</div>' +
                '<div class="answers">' +
                question.answers.map(function(answer, index) {
                    return '<button class="answer-btn" onclick="selectAnswer(' + index + ')" id="answer' + index + '">' +
                        String.fromCharCode(65 + index) + '. ' + answer +
                        '</button>';
                }).join('') +
                '</div>';

            // Restore previous answer visually if already answered (locked)
            if (userAnswers[currentQuestion] !== undefined) {
                answerLocked = true;
                var prevIndex = userAnswers[currentQuestion];
                var correctIndex = question.correct;
                for (var i = 0; i < question.answers.length; i++) {
                    document.getElementById('answer' + i).disabled = true;
                }
                if (prevIndex === correctIndex) {
                    document.getElementById('answer' + prevIndex).classList.add('correct');
                } else {
                    document.getElementById('answer' + prevIndex).classList.add('incorrect');
                    document.getElementById('answer' + correctIndex).classList.add('correct');
                }
            }

            updateNavigationButtons();
        }

        function selectAnswer(answerIndex) {
            // Prevent answering if already answered or locked
            if (answerLocked) return;
            answerLocked = true;

            const question = triviaQuestions[currentQuestion];

            // Disable all buttons immediately
            for (var i = 0; i < question.answers.length; i++) {
                document.getElementById('answer' + i).disabled = true;
            }

            // Record the answer
            userAnswers[currentQuestion] = answerIndex;

            // Show correct/incorrect
            if (answerIndex === question.correct) {
                document.getElementById('answer' + answerIndex).classList.add('correct');
                // Only add to score if first time answering this question
                score++;
                updateScore();
            } else {
                document.getElementById('answer' + answerIndex).classList.add('incorrect');
                document.getElementById('answer' + question.correct).classList.add('correct');
            }

            // Auto-advance after 1.5 seconds
            setTimeout(function() {
                if (currentQuestion < triviaQuestions.length - 1) {
                    currentQuestion++;
                    loadQuestion();
                } else {
                    finishTrivia();
                }
            }, 1500);
        }

        function nextQuestion() {
            if (currentQuestion < triviaQuestions.length - 1) {
                currentQuestion++;
                loadQuestion();
            }
        }

        function previousQuestion() {
            if (currentQuestion > 0) {
                currentQuestion--;
                loadQuestion();
            }
        }

        function updateNavigationButtons() {
            document.getElementById('prevBtn').disabled = currentQuestion === 0;
            document.getElementById('nextBtn').textContent = 
                currentQuestion === triviaQuestions.length - 1 ? 'Finish' : 'Next →';
        }

        function updateScore() {
            document.getElementById('currentScore').textContent = score;
            document.getElementById('totalQuestions').textContent = triviaQuestions.length;
        }

        function finishTrivia() {
            const modal = document.getElementById('resultsModal');
            document.getElementById('finalScore').textContent = score + '/' + triviaQuestions.length;
            
            // Show player name in modal
            var playerNameEl = document.getElementById('resultPlayerName');
            if (currentUser) {
                playerNameEl.textContent = '🌟 ' + currentUser.name + ' 🌟';
            } else {
                playerNameEl.textContent = 'Sign in to save your score!';
                playerNameEl.style.color = 'rgba(255,255,255,0.6)';
            }

            let message = '';
            const percentage = (score / triviaQuestions.length) * 100;
            
            if (percentage === 100) {
                message = "🏆 PERFECT SCORE! You're a true Eurovision expert!";
            } else if (percentage >= 80) {
                message = "🌟 Excellent! You really know your Eurovision history!";
            } else if (percentage >= 60) {
                message = "👏 Good job! You have solid Eurovision knowledge!";
            } else if (percentage >= 40) {
                message = "📚 Not bad! Keep learning about Israel's Eurovision journey!";
            } else {
                message = "💪 Room for improvement! Try again to boost your score!";
            }
            
            document.getElementById('resultMessage').textContent = message;

            // Save score under the logged-in user's name
            if (currentUser) {
                addToLeaderboard(currentUser.name, score);
                currentUser.triviaScore = score;
                currentUser.triviaDate = new Date().toLocaleDateString();
                localStorage.setItem('euroUser', JSON.stringify(currentUser));
            } else {
                addToLeaderboard('Guest', score);
            }

            modal.classList.add('active');
        }

        function restartTrivia() {
            currentQuestion = 0;
            score = 0;
            userAnswers = [];
            answerLocked = false;
            document.getElementById('resultsModal').classList.remove('active');
            updateScore();
            loadQuestion();
        }

        function updateLeaderboard() {
            const container = document.getElementById('leaderboardContainer');
            
            // Sort by score descending
            leaderboard.sort(function(a, b) { return b.score - a.score; });
            
            container.innerHTML = leaderboard.map(function(player, index) {
                let rankClass = '';
                let rankIcon = index + 1;
                
                if (index === 0) { rankClass = 'gold'; rankIcon = '🥇'; }
                else if (index === 1) { rankClass = 'silver'; rankIcon = '🥈'; }
                else if (index === 2) { rankClass = 'bronze'; rankIcon = '🥉'; }
                
                // Highlight current user
                var nameStyle = (currentUser && player.name === currentUser.name)
                    ? ' style="color: var(--euro-yellow);"' : '';

                return '<div class="leaderboard-item">' +
                    '<div class="rank ' + rankClass + '">' + rankIcon + '</div>' +
                    '<div class="player-info">' +
                        '<div class="player-name"' + nameStyle + '>' + player.name + (currentUser && player.name === currentUser.name ? ' ⭐' : '') + '</div>' +
                        '<div class="player-time">' + player.time + '</div>' +
                    '</div>' +
                    '<div class="player-score">' + player.score + '/10</div>' +
                '</div>';
            }).join('');
        }

        function addToLeaderboard(playerName, playerScore) {
            const existingIndex = leaderboard.findIndex(function(p) { return p.name === playerName; });
            
            if (existingIndex !== -1) {
                // Only update if new score is better
                if (playerScore > leaderboard[existingIndex].score) {
                    leaderboard[existingIndex].score = playerScore;
                    leaderboard[existingIndex].time = 'Just now';
                } else {
                    leaderboard[existingIndex].time = 'Just now';
                }
            } else {
                leaderboard.push({ name: playerName, score: playerScore, time: 'Just now' });
            }

            // Save updated leaderboard to localStorage
            localStorage.setItem('euroTriviaLeaderboard', JSON.stringify(leaderboard));
            updateLeaderboard();
        }

        function logout() {
            localStorage.removeItem('euroUser');
            alert('Successfully logged out!');
            window.location.reload();
        }
    </script>
    </form>
</body>
</html>
