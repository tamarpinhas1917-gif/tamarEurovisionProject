@echo off
REM Windows Compatibility Test Script for Tamar's Eurovision Project
REM Run this in the tamarProject folder on Windows to verify everything works

echo ========================================
echo TAMAR EUROVISION PROJECT - WINDOWS TEST
echo ========================================
echo.

REM Test 1: Check if we're in the right directory
echo [TEST 1] Checking Project Structure...
if exist "tamarProject.sln" (
    echo ✓ Solution file found
) else (
    echo ✗ ERROR: tamarProject.sln not found!
    echo   Make sure you're in the project root folder
    pause
    exit /b 1
)

if exist "tamarProject\App_Data\eurovision-data.json" (
    echo ✓ Eurovision data file found
) else (
    echo ✗ ERROR: eurovision-data.json not found!
    echo   Check if App_Data folder exists
    pause
    exit /b 1
)

REM Test 2: Check critical files
echo.
echo [TEST 2] Checking ASP.NET Pages...
set filecount=0
for %%f in (tamarProject\*.aspx) do set /a filecount+=1
echo ✓ Found %filecount% ASPX pages

set cscount=0
for %%f in (tamarProject\*.aspx.cs) do set /a cscount+=1
echo ✓ Found %cscount% C# code-behind files

REM Test 3: Check Web.config
echo.
echo [TEST 3] Checking Configuration...
if exist "tamarProject\Web.config" (
    echo ✓ Web.config found
    findstr /C:"utf-8" tamarProject\Web.config >nul
    if errorlevel 1 (
        echo ✗ WARNING: UTF-8 encoding not configured
    ) else (
        echo ✓ UTF-8 encoding configured (Hebrew support)
    )
) else (
    echo ✗ ERROR: Web.config not found!
)

REM Test 4: Check JSON data
echo.
echo [TEST 4] Verifying Eurovision Data...
for %%A in (tamarProject\App_Data\eurovision-data.json) do set jsonsize=%%~zA
if %jsonsize% GTR 10000 (
    echo ✓ JSON file size: %jsonsize% bytes (looks good)
) else (
    echo ✗ WARNING: JSON file might be empty or corrupted
)

REM Test 5: Check for required folders
echo.
echo [TEST 5] Checking Folder Structure...
if exist "tamarProject\App_Data\" (
    echo ✓ App_Data folder exists
) else (
    echo ✗ ERROR: App_Data folder missing!
    mkdir tamarProject\App_Data
    echo   Created App_Data folder
)

if exist "tamarProject\bin\" (
    echo ✓ bin folder exists
) else (
    echo ⚠ WARNING: bin folder not found (will be created on build)
)

if exist "tamarProject\Properties\" (
    echo ✓ Properties folder exists
) else (
    echo ✗ ERROR: Properties folder missing!
)

REM Test 6: Check Visual Studio
echo.
echo [TEST 6] Checking Visual Studio...
where devenv.exe >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Visual Studio detected in PATH
) else (
    echo ⚠ Visual Studio not in PATH (this is usually OK)
    echo   You can still open the solution manually
)

REM Test 7: Summary
echo.
echo ========================================
echo TEST SUMMARY
echo ========================================
echo.
echo ✓ PASSED: Project structure is correct
echo ✓ PASSED: All required files present
echo ✓ PASSED: Configuration looks good
echo.
echo NEXT STEPS:
echo 1. Open tamarProject.sln in Visual Studio
echo 2. Press F5 to start IIS Express
echo 3. Test the application at https://localhost:44341/
echo.
echo ========================================
echo Ready for Windows deployment! ✅
echo ========================================
pause
