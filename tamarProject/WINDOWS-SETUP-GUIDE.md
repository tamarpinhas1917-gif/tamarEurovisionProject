# Windows Setup Guide for Eurovision Project

## Requirements

### 1. .NET Framework 4.7.2
- **Required Version:** .NET Framework 4.7.2 or higher
- **Download:** https://dotnet.microsoft.com/download/dotnet-framework/net472
- Most school computers with Windows 10/11 already have this installed

### 2. Visual Studio
- **Recommended:** Visual Studio 2022 (Community Edition is free)
- **Minimum:** Visual Studio 2019
- **Workload Required:** ASP.NET and web development

## How to Run the Project

### Step 1: Open the Solution
1. Launch Visual Studio
2. Click **"Open a project or solution"**
3. Navigate to your project folder
4. Select **`TamarFinalProject.sln`**
5. Click **Open**

### Step 2: Restore NuGet Packages
- Visual Studio should automatically restore packages
- If not, right-click on the solution and select **"Restore NuGet Packages"**

### Step 3: Run the Project
1. Press **F5** or click the green **"Start"** button (usually shows "IIS Express")
2. The website will open automatically in your default browser
3. The URL will be something like: `http://localhost:xxxxx/`

## Troubleshooting

### If you get ".NET Framework not found" error:
1. Download and install .NET Framework 4.7.2 from the link above
2. Restart your computer
3. Try running the project again

### If the page shows encoding errors (weird characters):
- This shouldn't happen anymore - all pages are now in English!
- If you still see issues, check that the file encoding is UTF-8

### If IIS Express doesn't start:
1. Go to **Tools → Options → Projects and Solutions → Web Projects**
2. Check **"Use the 64-bit version of IIS Express"**
3. Restart Visual Studio

### If packages fail to restore:
1. Go to **Tools → NuGet Package Manager → Package Manager Console**
2. Run: `Update-Package -reinstall`

## Project Structure

- **Solution File:** `TamarFinalProject.sln` ← Open this file
- **Project Folder:** `tamarProject/tamarProject/`
- **Web Pages:** `.aspx` files (these are the live server pages)
- **Preview Pages:** `-preview.html` files (static versions for testing)
- **Start Page:** `homePage.aspx` or `home-preview.html`

## Important Notes

✅ All pages are now in **English** (converted from Hebrew)
✅ All text direction is **Left-to-Right** (LTR)
✅ Video background is ready on the home page
✅ Timeline markers are aligned correctly
✅ Israel flag appears on all pages

## For Your Teacher

This is an ASP.NET Web Forms project targeting .NET Framework 4.7.2. It includes:
- Client-side authentication using localStorage
- Interactive timeline with HTML5 range slider
- Responsive design with CSS gradients and animations
- Video background integration
- Data management system

---

**Last Updated:** February 14, 2026
**Version:** 1.5 (English Translation)
