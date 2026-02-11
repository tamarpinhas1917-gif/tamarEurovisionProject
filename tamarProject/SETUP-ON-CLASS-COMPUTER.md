# 📦 Setup Guide: Running Tamar's Eurovision Project on Class Computer

## 🎯 Overview
This guide explains how to copy the project to an external drive and run it on the school computer.

---

## Part 1: Copying to External Drive (Mac)

### Step 1: Connect External Drive
1. Plug in your USB drive or external hard drive
2. Wait for it to appear on Desktop or in Finder

### Step 2: Copy the Entire Project Folder

**Option A: Using Finder (Recommended)**
1. Open Finder
2. Navigate to: `OneDrive → Documents → VS gettingStarted`
3. **Right-click** on the `tamarProject` folder
4. Select **"Copy"**
5. Go to your external drive (should be in Finder sidebar)
6. **Right-click** in the drive and select **"Paste"**
7. Wait for all files to copy (may take 2-5 minutes)

**Option B: Using Terminal (Faster)**
```bash
# Replace "YOUR_DRIVE_NAME" with your actual drive name
cp -R "/Users/pinhasy/Library/CloudStorage/OneDrive-Starkey/Documents/VS gettingStarted/tamarProject" "/Volumes/YOUR_DRIVE_NAME/"
```

### Step 3: Verify the Copy
Check that these folders/files exist on the external drive:
- ✅ `tamarProject/` (main folder)
  - ✅ `tamarProject/` (inner folder with .aspx files)
  - ✅ `tamarProject/bin/`
  - ✅ `tamarProject/obj/`
  - ✅ `tamarProject/App_Data/`
  - ✅ `tamarProject/images/`
  - ✅ `packages/`
  - ✅ `TamarFinalProject.sln` or `tamarProject.sln`

### Step 4: Safely Eject
1. Right-click the drive icon
2. Select **"Eject"**
3. Wait for confirmation before unplugging

---

## Part 2: Setting Up on Windows Class Computer

### Step 1: Copy from External Drive to Computer

**Why?** Running directly from USB can be slow. Copy to the computer first.

1. **Plug in the external drive** to Windows computer
2. **Open File Explorer** (Windows Key + E)
3. Find your external drive (usually `D:` or `E:`)
4. Navigate to the `tamarProject` folder
5. **Right-click** on `tamarProject` folder → **Copy**
6. Navigate to `C:\Users\[YourName]\Documents\`
7. **Right-click** → **Paste**
8. Wait for all files to copy

### Step 2: Install Visual Studio (If Not Installed)

**Check if installed:**
- Look for "Visual Studio 2019" or "Visual Studio 2022" in Start Menu

**If not installed:**
1. Go to: https://visualstudio.microsoft.com/downloads/
2. Download **Visual Studio Community** (FREE)
3. During installation, select:
   - ✅ **ASP.NET and web development**
   - ✅ **.NET desktop development**
4. Click Install (takes 20-30 minutes)

### Step 3: Open the Project

1. **Navigate to** `C:\Users\[YourName]\Documents\tamarProject\`
2. **Double-click** on one of these files:
   - `TamarFinalProject.sln` OR
   - `tamarProject.sln`
3. Visual Studio will open
4. Wait for it to load (may take 30 seconds first time)

### Step 4: Set the Startup Page

**IMPORTANT: Do this before running!**

1. In **Solution Explorer** (right side), expand `tamarProject`
2. Find `homePage.aspx`
3. **Right-click** `homePage.aspx`
4. Select **"Set As Start Page"**
5. The file icon should now have a green arrow ▶️

### Step 5: Build the Project

1. Go to menu: **Build** → **Clean Solution**
2. Wait for "Clean succeeded"
3. Go to menu: **Build** → **Rebuild Solution**
4. Wait for "Rebuild succeeded" (should see "0 errors" at bottom)

### Step 6: Run the Project! 🚀

1. Press **F5** or click the green **▶ Start** button
2. Browser will open automatically
3. You should see the Eurovision home page!

---

## Part 3: Navigating the Project

Once running, you can visit:
- **Home Page**: Should load automatically
- **Timeline**: Click "Timeline" link or go to `/timeline.aspx`
- **Fashion**: Click "Fashion" link or go to `/fashion.aspx`

---

## 🐛 Troubleshooting Common Issues

### Problem 1: "tamarProject.dll is not a valid Win32 application"

**Solution:**
1. Build → **Clean Solution**
2. Build → **Rebuild Solution**
3. Try running again (F5)

### Problem 2: "Please select a valid startup item"

**Solution:**
1. Right-click `homePage.aspx` in Solution Explorer
2. Select **"Set As Start Page"**
3. Try running again (F5)

### Problem 3: Hebrew Text Shows as Symbols (×©™)

**Solution:** This should already be fixed! But if it happens:
1. Close the browser
2. Build → **Rebuild Solution**
3. Run again (F5)
4. Hard refresh in browser: **Ctrl + Shift + R**

### Problem 4: Images Not Loading

**Solution:**
1. Check that `tamarProject/images/eurovision/` folder exists
2. Should have 48 image files (1973.png through 2026.webp)
3. If missing, copy the `images` folder again from external drive

### Problem 5: Port Already in Use

**Solution:**
1. Close all browser windows
2. In Visual Studio: **Debug** → **Stop Debugging**
3. Try running again (F5)

### Problem 6: "Could not find file [...]/Web.config"

**Solution:**
1. Make sure you're opening the **.sln file** (not individual .aspx files)
2. Check that `Web.config` exists in `tamarProject/tamarProject/` folder
3. If missing, copy project again from external drive

---

## 📊 What Should Work

✅ **Homepage** - Main landing page with Eurovision branding  
✅ **Timeline** - Interactive slider with 54 years (1973-2026)  
✅ **Year Markers** - 7 clickable trophy/flag icons on timeline  
✅ **Images** - All 47 Eurovision performance images  
✅ **Fashion Page** - Era cards, flip cards, trend timeline  
✅ **Hebrew Text** - All Hebrew characters display correctly  
✅ **Navigation** - Links between pages work  
✅ **Responsive** - Pages adjust to different screen sizes  

---

## 💾 Making Changes on Class Computer

If Tamar wants to make changes during class:

### Option 1: Edit and Test Locally
1. Make changes in Visual Studio
2. Save files (Ctrl + S)
3. Rebuild (Ctrl + Shift + B)
4. Run to test (F5)

### Option 2: Save Changes Back to Drive
1. When done, copy the **entire** `tamarProject` folder
2. Paste it back to the external drive
3. This will overwrite the old version
4. Take drive home to sync with OneDrive/GitHub

---

## 🎓 Quick Reference for Teacher/Presentation

### To Run the Project:
1. ✅ Open Visual Studio
2. ✅ File → Open → Project/Solution
3. ✅ Navigate to `tamarProject.sln`
4. ✅ Right-click `homePage.aspx` → Set As Start Page
5. ✅ Press **F5**

### URLs When Running:
- Home: `https://localhost:44341/homePage.aspx`
- Timeline: `https://localhost:44341/timeline.aspx`
- Fashion: `https://localhost:44341/fashion.aspx`

(Port number might be different - check browser address bar)

---

## 📝 Files to Keep Safe

**Essential Files (DO NOT DELETE):**
- 📁 `tamarProject.sln` - Project solution file
- 📁 `tamarProject/` folder - All source code
- 📁 `packages/` - Required libraries
- 📄 `Web.config` - Configuration
- 📁 `images/eurovision/` - All 48 images
- 📄 `App_Data/eurovision-data.json` - All contest data

**Safe to Ignore:**
- 📁 `bin/` - Auto-generated
- 📁 `obj/` - Auto-generated
- 📁 `.vs/` - Visual Studio cache

---

## ⏰ Time Estimates

| Task | Time |
|------|------|
| Copy to external drive (Mac) | 2-5 minutes |
| Copy from drive to PC | 2-5 minutes |
| Install Visual Studio (if needed) | 20-30 minutes |
| Open and build project | 1-2 minutes |
| First run | 30 seconds |

**Total (if VS installed):** ~5-10 minutes  
**Total (if installing VS):** ~30-40 minutes

---

## ✅ Pre-Flight Checklist for Tamar

Before class presentation:

- [ ] External drive has complete `tamarProject` folder
- [ ] Project copied to class computer Documents folder
- [ ] Visual Studio opens the project successfully
- [ ] `homePage.aspx` set as Start Page
- [ ] Project builds with 0 errors
- [ ] Browser opens when pressing F5
- [ ] Home page displays correctly
- [ ] Timeline page loads with images
- [ ] Fashion page loads with animations
- [ ] Hebrew text displays properly (not garbled)
- [ ] All navigation links work

---

**Created:** February 1, 2026  
**For:** Tamar's Final C# Project - Eurovision Timeline  
**Good Luck! 🎉🎭🏆**
