@echo off
echo ========================================
echo  FIXING DLL ERROR - AGGRESSIVE CLEANUP
echo ========================================
echo.
echo This will completely clean your project to fix the DLL error.
echo.
echo IMPORTANT: Close Visual Studio if it's open!
echo.
pause

echo.
echo Step 1: Killing ALL Visual Studio and IIS processes...
taskkill /F /IM devenv.exe 2>nul
taskkill /F /IM MSBuild.exe 2>nul
taskkill /F /IM iisexpress.exe 2>nul
taskkill /F /IM iisexpresstray.exe 2>nul
taskkill /F /IM VBCSCompiler.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo Step 2: Deleting ALL compiled files...
if exist "tamarProject\bin" (
    echo Deleting tamarProject\bin...
    rd /s /q "tamarProject\bin"
)
if exist "tamarProject\obj" (
    echo Deleting tamarProject\obj...
    rd /s /q "tamarProject\obj"
)
if exist ".vs" (
    echo Deleting .vs folder...
    rd /s /q ".vs"
)

echo.
echo Step 3: Deleting user-specific files...
if exist "tamarProject\tamarProject.csproj.user" (
    del /q "tamarProject\tamarProject.csproj.user"
)

echo.
echo Step 4: Cleaning NuGet cache...
if exist "packages" (
    echo NuGet packages folder exists - OK
) else (
    echo WARNING: packages folder not found!
)

echo.
echo ========================================
echo  CLEANUP COMPLETE!
echo ========================================
echo.
echo Now opening Visual Studio...
echo.
echo CRITICAL STEPS TO DO IN VISUAL STUDIO:
echo ========================================
echo  1. Wait for Visual Studio to fully load
echo  2. Go to Build menu
echo  3. Click "Rebuild Solution" (NOT Clean, just Rebuild)
echo  4. Wait for "Build succeeded" message
echo  5. Make sure it says "1 succeeded" in the status bar
echo  6. Press F5 to run
echo.
echo If you still get the error:
echo  - Try switching from "Debug" to "Release" at the top
echo  - Or switch from "Any CPU" to "x86" in the dropdown
echo ========================================
echo.

REM Try to open the solution in Visual Studio
if exist "tamarProject.sln" (
    start "" "tamarProject.sln"
) else if exist "TamarFinalProject.sln" (
    start "" "TamarFinalProject.sln"
)

pause
