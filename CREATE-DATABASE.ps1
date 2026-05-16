# ============================================================
# AUTO-CREATE DATABASE - TAMAR EUROVISION PROJECT
# Run in Developer PowerShell on ANY Windows computer
# ============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Eurovision Project - Database Setup    " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$appDataPath = Join-Path $scriptDir "tamarProject\tamarProject\App_Data"
$dbPath      = Join-Path $appDataPath "db.mfg.mdf"
$dbLogPath   = Join-Path $appDataPath "db.mfg_log.ldf"

Write-Host "`n[1/5] Checking App_Data folder..." -ForegroundColor Yellow
if (-Not (Test-Path $appDataPath)) {
    New-Item -ItemType Directory -Path $appDataPath -Force | Out-Null
}
Write-Host "      OK: $appDataPath" -ForegroundColor Green

Write-Host "`n[2/5] Starting LocalDB..." -ForegroundColor Yellow
& sqllocaldb start MSSQLLocalDB 2>&1 | Out-Null
Write-Host "      OK" -ForegroundColor Green

Write-Host "`n[3/5] Creating database db.mfg..." -ForegroundColor Yellow
if (Test-Path $dbPath) {
    Write-Host "      Already exists - skipping" -ForegroundColor Yellow
} else {
    $sql = "CREATE DATABASE [db.mfg] ON PRIMARY (NAME='db.mfg', FILENAME='$dbPath') LOG ON (NAME='db.mfg_log', FILENAME='$dbLogPath')"
    & sqlcmd -S "(LocalDB)\MSSQLLocalDB" -Q $sql 2>&1
    Write-Host "      OK: $dbPath" -ForegroundColor Green
}

Write-Host "`n[4/5] Creating personalData table..." -ForegroundColor Yellow
$tableSQL = "IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='personalData' AND xtype='U') BEGIN CREATE TABLE personalData (idnum VARCHAR(20) PRIMARY KEY, fname NVARCHAR(50) NULL, lname NVARCHAR(50) NULL, pass VARCHAR(50) NULL, area NVARCHAR(50) NULL, isAdmin BIT NULL); PRINT 'Created'; END ELSE PRINT 'Already exists';"
& sqlcmd -S "(LocalDB)\MSSQLLocalDB" -d "db.mfg" -Q $tableSQL 2>&1
Write-Host "      OK" -ForegroundColor Green

Write-Host "`n[5/5] Creating admin user..." -ForegroundColor Yellow
$adminSQL = "IF NOT EXISTS (SELECT * FROM personalData WHERE idnum='111111111') BEGIN INSERT INTO personalData VALUES('111111111',N'מנהל',N'מערכת','admin123',N'מרכז',1); PRINT 'Created'; END ELSE PRINT 'Already exists';"
& sqlcmd -S "(LocalDB)\MSSQLLocalDB" -d "db.mfg" -Q $adminSQL 2>&1
Write-Host "      OK" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " ALL DONE! Ready to run!               " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Steps:" -ForegroundColor Yellow
Write-Host "  1. Open tamarProject.sln in Visual Studio" -ForegroundColor White
Write-Host "  2. Press F5" -ForegroundColor White
Write-Host "  3. Admin login: ID=111111111  Pass=admin123" -ForegroundColor White
Write-Host ""
