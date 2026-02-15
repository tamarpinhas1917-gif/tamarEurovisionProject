@echo off
REM ==================================================
REM Tamar Eurovision Project - Quick Start (Windows)
REM ==================================================
REM This script helps you start the project quickly
REM ==================================================

echo.
echo ================================================
echo    TAMAR EUROVISION PROJECT - QUICK START
echo ================================================
echo.

REM Check if we're in the right directory
if not exist "tamarProject.sln" (
    echo ERROR: Cannot find tamarProject.sln
    echo Please run this script from the tamarProject folder!
    echo.
    pause
    exit /b 1
)

REM Find Visual Studio
set VS2022="%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
set VS2019="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"

echo Looking for Visual Studio...
echo.

if exist %VS2022% (
    echo Found: Visual Studio 2022 Community Edition
    echo Opening project...
    echo.
    start "" %VS2022% "tamarProject.sln"
    echo.
    echo ================================================
    echo NEXT STEPS IN VISUAL STUDIO:
    echo ================================================
    echo 1. Wait for NuGet packages to restore
    echo 2. Press F5 to start the project
    echo 3. Browser will open at https://localhost:44341/
    echo ================================================
    echo.
    pause
    exit /b 0
)

if exist %VS2019% (
    echo Found: Visual Studio 2019 Community Edition
    echo Opening project...
    echo.
    start "" %VS2019% "tamarProject.sln"
    echo.
    echo ================================================
    echo NEXT STEPS IN VISUAL STUDIO:
    echo ================================================
    echo 1. Wait for NuGet packages to restore
    echo 2. Press F5 to start the project
    echo 3. Browser will open at https://localhost:44341/
    echo ================================================
    echo.
    pause
    exit /b 0
)

REM Visual Studio not found in default location
echo WARNING: Visual Studio not found in default location
echo.
echo Please open Visual Studio manually and:
echo 1. File → Open → Project/Solution
echo 2. Select: tamarProject.sln
echo 3. Press F5 to start
echo.
echo ================================================
echo OR: If Visual Studio is installed elsewhere:
echo ================================================
echo Right-click on tamarProject.sln
echo Select "Open with Visual Studio"
echo.
pause
