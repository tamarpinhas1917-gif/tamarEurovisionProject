# ============================================================
# AUTO-CREATE DATABASE SCRIPT FOR TAMAR EUROVISION PROJECT
# Run this script on Windows in Developer PowerShell in Visual Studio
# ============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Creating Eurovision Project Database   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Find the App_Data folder
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$appDataPath = Join-Path $scriptDir "tamarProject\tamarProject\App_Data"
$dbPath = Join-Path $appDataPath "db.mdf"

Write-Host "`n[1/4] Checking App_Data folder..." -ForegroundColor Yellow
if (-Not (Test-Path $appDataPath)) {
    New-Item -ItemType Directory -Path $appDataPath -Force | Out-Null
    Write-Host "      Created App_Data folder" -ForegroundColor Green
} else {
    Write-Host "      App_Data folder exists OK" -ForegroundColor Green
}

# Step 2: Start LocalDB
Write-Host "`n[2/4] Starting SQL Server LocalDB..." -ForegroundColor Yellow
try {
    & sqllocaldb start MSSQLLocalDB 2>&1 | Out-Null
    Write-Host "      LocalDB started OK" -ForegroundColor Green
} catch {
    Write-Host "      Starting LocalDB..." -ForegroundColor Yellow
    & sqllocaldb create MSSQLLocalDB 2>&1 | Out-Null
    & sqllocaldb start MSSQLLocalDB 2>&1 | Out-Null
    Write-Host "      LocalDB ready" -ForegroundColor Green
}

# Step 3: Create the database file
Write-Host "`n[3/4] Creating db.mdf database file..." -ForegroundColor Yellow
if (Test-Path $dbPath) {
    Write-Host "      db.mdf already exists - skipping creation" -ForegroundColor Yellow
} else {
    $createDbSQL = "CREATE DATABASE db ON PRIMARY (NAME='db', FILENAME='$dbPath') LOG ON (NAME='db_log', FILENAME='${dbPath -replace '\.mdf$', '_log.ldf'}')"
    try {
        & sqlcmd -S "(LocalDB)\MSSQLLocalDB" -Q $createDbSQL 2>&1
        Write-Host "      db.mdf created OK at: $dbPath" -ForegroundColor Green
    } catch {
        Write-Host "      ERROR creating database: $_" -ForegroundColor Red
        exit 1
    }
}

# Step 4: Create personalData table
Write-Host "`n[4/4] Creating personalData table..." -ForegroundColor Yellow
$createTableSQL = @"
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='personalData' AND xtype='U')
BEGIN
    CREATE TABLE personalData (
        idnum VARCHAR(20) PRIMARY KEY,
        fname NVARCHAR(50) NULL,
        lname NVARCHAR(50) NULL,
        pass  VARCHAR(50) NULL,
        area  NVARCHAR(50) NULL,
        isAdmin BIT NULL
    );
    PRINT 'Table personalData created successfully';
END
ELSE
BEGIN
    PRINT 'Table personalData already exists';
END
"@

try {
    & sqlcmd -S "(LocalDB)\MSSQLLocalDB" -d db -Q $createTableSQL 2>&1
    Write-Host "      personalData table ready OK" -ForegroundColor Green
} catch {
    Write-Host "      ERROR creating table: $_" -ForegroundColor Red
    exit 1
}

# Done!
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " SUCCESS! Database is ready!            " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Files created:" -ForegroundColor White
Write-Host "  - $dbPath" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. In Visual Studio, refresh App_Data folder" -ForegroundColor White
Write-Host "  2. You should now see db.mdf in the project" -ForegroundColor White
Write-Host "  3. Run the project and test!" -ForegroundColor White
Write-Host ""
