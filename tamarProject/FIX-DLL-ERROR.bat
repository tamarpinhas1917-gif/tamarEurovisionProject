@echo off
echo ========================================
echo  FIXING DLL ERROR
echo ========================================
echo.
echo This will clean and rebuild your project to fix the DLL error.
echo.
pause

echo.
echo Step 1: Closing any running instances...
taskkill /F /IM iisexpress.exe 2>nul
taskkill /F /IM iisexpresstray.exe 2>nul

echo.
echo Step 2: Deleting bin and obj folders...
if exist "tamarProject\bin" rd /s /q "tamarProject\bin"
if exist "tamarProject\obj" rd /s /q "tamarProject\obj"

echo.
echo Step 3: Opening Visual Studio to rebuild...
echo.
echo ========================================
echo  NEXT STEPS IN VISUAL STUDIO:
echo ========================================
echo  1. Go to Build menu
echo  2. Click "Clean Solution"
echo  3. Wait for it to complete
echo  4. Go to Build menu again
echo  5. Click "Rebuild Solution"
echo  6. Wait for build to complete
echo  7. Press F5 to run
echo ========================================
echo.

REM Try to open the solution in Visual Studio
if exist "tamarProject.sln" (
    start "" "tamarProject.sln"
) else if exist "TamarFinalProject.sln" (
    start "" "TamarFinalProject.sln"
)

pause
