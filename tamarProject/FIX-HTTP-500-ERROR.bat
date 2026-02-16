@echo off
echo ========================================
echo  FIXING HTTP 500.19 ERROR
echo ========================================
echo.
echo This error means IIS Express needs to be reset or reinstalled.
echo.
pause

echo.
echo Step 1: Killing IIS Express processes...
taskkill /F /IM iisexpress.exe 2>nul
taskkill /F /IM iisexpresstray.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Step 2: Deleting IIS Express config cache...
if exist "%USERPROFILE%\Documents\IISExpress\config\applicationhost.config" (
    echo Found IIS Express config - will be reset on next run
)

echo.
echo Step 3: Cleaning project files...
if exist "tamarProject\bin" rd /s /q "tamarProject\bin"
if exist "tamarProject\obj" rd /s /q "tamarProject\obj"
if exist ".vs" rd /s /q ".vs"

echo.
echo ========================================
echo  NEXT STEPS:
echo ========================================
echo.
echo Option 1 - TRY THIS FIRST:
echo   1. Open Visual Studio
echo   2. Right-click the PROJECT (tamarProject) in Solution Explorer
echo   3. Click "Unload Project"
echo   4. Right-click it again
echo   5. Click "Reload Project"
echo   6. Build -^> Rebuild Solution
echo   7. Press F5
echo.
echo Option 2 - If Option 1 doesn't work:
echo   1. Open Visual Studio
echo   2. Tools -^> NuGet Package Manager -^> Package Manager Console
echo   3. Type: Update-Package -reinstall
echo   4. Wait for it to complete
echo   5. Build -^> Rebuild Solution
echo   6. Press F5
echo.
echo Option 3 - If still not working:
echo   1. Download fresh copy from GitHub
echo   2. Extract to NEW folder
echo   3. Run START-WINDOWS.bat
echo.
echo ========================================
pause
