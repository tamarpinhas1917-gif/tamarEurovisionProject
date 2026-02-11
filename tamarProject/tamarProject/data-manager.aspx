<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="data-manager.aspx.cs" Inherits="tamarProject.data_manager" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>מנהל נתוני אירוויזיון - Tamar's Project</title>
    <style>
        :root {
            --euro-purple: #14052d;
            --euro-pink: #ff0085;
            --euro-blue: #00b1ea;
            --euro-yellow: #fdf200;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #050514 0%, var(--euro-purple) 100%);
            background-attachment: fixed;
            color: white;
            padding: 20px;
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
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

        .info-panel {
            background: rgba(0, 177, 234, 0.2);
            border-right: 4px solid var(--euro-blue);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .info-panel h3 {
            margin-bottom: 10px;
            color: var(--euro-blue);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>🎵 מנהל נתוני אירוויזיון 🇮🇱</h1>

            <div class="info-panel">
                <h3>📋 מידע על קובץ הנתונים</h3>
                <p><strong>מיקום:</strong> <code>App_Data/eurovision-data.json</code></p>
                <p><strong>פורמט:</strong> JSON - קל לעריכה ולניהול</p>
                <p><strong>שימוש:</strong> כל העמודים באתר קוראים מקובץ זה</p>
            </div>

            <div class="stats-panel">
                <div class="stat-card">
                    <div class="stat-label">סה"כ שנים</div>
                    <div class="stat-number" id="totalYears">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">🏆 ניצחונות</div>
                    <div class="stat-number" id="totalWins">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">🥈 מקום 2</div>
                    <div class="stat-number" id="totalSecond">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">🥉 מקום 3</div>
                    <div class="stat-number" id="totalThird">0</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">⭐ Top 10</div>
                    <div class="stat-number" id="totalTop10">0</div>
                </div>
            </div>

            <div class="controls">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="🔍 חיפוש לפי שנה, אמן, שיר..." onkeyup="filterTable()">
                </div>
                <button type="button" class="btn btn-success" onclick="window.location.href='timeline.aspx'">
                    📊 צפייה בציר הזמן
                </button>
                <button type="button" class="btn btn-warning" onclick="exportToExcel()">
                    📥 ייצוא ל-Excel
                </button>
                <button type="button" class="btn btn-primary" onclick="window.location.href='homePage.aspx'">
                    🏠 חזרה לדף הבית
                </button>
            </div>

            <div class="data-grid">
                <table id="dataTable">
                    <thead>
                        <tr>
                            <th>פעולות</th>
                            <th>תגיות</th>
                            <th>דירוג</th>
                            <th>שיר</th>
                            <th>אמן</th>
                            <th>שנה</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be loaded here by JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    </form>

    <script>
        let allData = [];

        // Load data when page loads
        window.onload = function() {
            loadData();
        };

        function loadData() {
            // In ASP.NET, we'll inject the JSON data here
            allData = <%= GetEurovisionDataJson() %>;
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

        function editEntry(year) {
            alert('עריכת רשומה לשנת ' + year + '\n\nלעריכה, פתחי את הקובץ:\nApp_Data/eurovision-data.json\n\nבעורך טקסט או Visual Studio');
        }

        function deleteEntry(year) {
            if (confirm('האם את בטוחה שאת רוצה למחוק את הרשומה לשנת ' + year + '?')) {
                alert('למחיקה, ערכי את הקובץ:\nApp_Data/eurovision-data.json');
            }
        }

        function exportToExcel() {
            // Simple CSV export
            let csv = 'שנה,אמן,שיר,דירוג,סאונד,אופנה\n';
            
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
</body>
</html>
