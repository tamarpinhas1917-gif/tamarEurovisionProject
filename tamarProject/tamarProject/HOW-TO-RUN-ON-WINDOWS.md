# 🚀 How to Run Tamar's Eurovision Project on Windows

## 📋 Quick Start Guide

### Step 1: Open the Project
1. Navigate to the project folder on your computer
2. Find the file: **`TamarFinalProject.sln`** or **`tamarProject.sln`**
3. Double-click it - Visual Studio will open automatically

### Step 2: Run the Project
1. Look at the top toolbar in Visual Studio
2. Find the green "play" button (▶) that says **"IIS Express"**
3. Click it (or press **F5** on your keyboard)
4. Wait a few seconds for the project to build
5. Your default web browser will open automatically with the website!

### Step 3: Navigate the Website

#### Home Page
The browser will open to the home page automatically:
```
https://localhost:44341/homePage.aspx
```

From here you can click on:
- **Timeline** - Interactive timeline with all Eurovision years
- **Fashion** - Fashion evolution through the decades
- **Data Manager** - View and manage Eurovision data
- **Registration** - Login/signup page

#### Direct Links (if needed)
You can also type these URLs directly in the browser:

**Timeline Page:**
```
https://localhost:44341/timeline.aspx
```

**Fashion Page:**
```
https://localhost:44341/fashion.aspx
```

**Home Page:**
```
https://localhost:44341/homePage.aspx
```

---

## 🔗 Page Navigation

### From Home Page:
- Click "Timeline" → Goes to interactive timeline
- Click "Fashion" → Goes to fashion history page
- Click "Data Manager" → View all Eurovision data

### From Timeline Page:
- Click "→ חזרה לעמוד הבית" → Back to home
- Click "👗 לדף האופנה" → Go to fashion page

### From Fashion Page:
- Click "🏠 דף הבית" → Back to home
- Click "⏱️ ציר הזמן" → Go to timeline page

---

## ✅ What Works on Windows

All these features work perfectly in Visual Studio on Windows:

### Timeline Page (`timeline.aspx`)
✅ Interactive slider (1973-2026)
✅ 7 clickable year markers with emojis (🏆 🚩)
✅ Year display updates in real-time
✅ Image loading from `images/eurovision/` folder
✅ Complete Eurovision data display
✅ Gold/Silver/Bronze rank badges
✅ Smooth animations
✅ Navigation buttons

### Fashion Page (`fashion.aspx`)
✅ Hero section with animations
✅ 4 Era cards (1973-2026 divided into periods)
✅ Flip cards with hover effects
✅ Trend timeline
✅ Eurovision color scheme
✅ Responsive design
✅ Navigation buttons

### Home Page (`homePage.aspx`)
✅ Eurovision branding
✅ Navigation menu to all pages
✅ Links to timeline, fashion, data manager
✅ Modern glassmorphism design

---

## 🎨 Project Features

### Complete Pages
1. **homePage.aspx** - Main landing page with navigation
2. **timeline.aspx** - Interactive Eurovision timeline
3. **fashion.aspx** - Fashion evolution showcase
4. **data-manager.aspx** - Data viewing tool
5. **login.aspx** - Registration/login
6. **signUp.aspx** - User signup
7. **about.aspx** - About page

### Data System
- **eurovision-data.json** - 54 years of Eurovision data (1973-2026)
- **Images folder** - `images/eurovision/` with performance photos
- **C# Code-behind** - `.aspx.cs` files for server-side logic

### Navigation Flow
```
homePage.aspx
    ↓
    ├─→ timeline.aspx ←→ fashion.aspx
    ├─→ data-manager.aspx
    ├─→ login.aspx
    └─→ about.aspx
```

---

## 🐛 Troubleshooting

### Problem: "The project won't build"
**Solution:** 
1. Right-click on the project in Solution Explorer
2. Click "Clean Solution"
3. Then click "Rebuild Solution"
4. Press F5 to run

### Problem: "Page not found (404)"
**Solution:**
- Make sure you're using the correct URL with `.aspx` extension
- Example: `https://localhost:44341/timeline.aspx` (not `/timeline`)

### Problem: "Images not loading"
**Solution:**
- Check that the `images/eurovision/` folder exists
- Make sure image files are in the project
- Images should be named by year: `1973.png`, `1978.jpg`, etc.
- Special image: `Not Participated.png` for DNP years

### Problem: "IIS Express won't start"
**Solution:**
1. Close Visual Studio completely
2. Reopen the `.sln` file
3. Try running again with F5

---

## 📚 For Teachers/Presentation

### How to Demo the Project

1. **Start**: Press F5 in Visual Studio
2. **Home Page**: Show the main navigation and branding
3. **Timeline**: Click "Timeline" and demonstrate:
   - Drag the slider to different years
   - Click the trophy icons (🏆) to jump to winning years
   - Scroll down to see full details for each year
4. **Fashion Page**: Click the fashion link and show:
   - Scroll through different eras
   - Hover over cards to see flip effects
   - View the trend timeline

### Project Highlights
- ✨ 54 years of Eurovision history (1973-2026)
- 🎨 Modern, animated user interface
- 📱 Responsive design (works on different screen sizes)
- 🔗 Connected navigation between pages
- 💾 Real Eurovision data in JSON format
- 🖼️ Image support with multiple formats
- 🏆 Special highlighting for victories and iconic moments

---

## 🎓 Educational Value

This project demonstrates:
- **C# Programming**: Code-behind files, data handling
- **ASP.NET Web Forms**: Page lifecycle, server controls
- **HTML/CSS**: Modern layouts, animations, gradients
- **JavaScript**: DOM manipulation, event handling
- **Data Management**: JSON parsing, file I/O
- **User Experience**: Interactive design, navigation
- **Cultural Knowledge**: Israeli Eurovision history

---

## 📝 File Structure

```
tamarProject/
├── homePage.aspx          ← Main landing page
├── timeline.aspx          ← Interactive timeline ⭐
├── fashion.aspx           ← Fashion history ⭐
├── data-manager.aspx      ← Data viewer
├── login.aspx             ← Login page
├── signUp.aspx            ← Registration
├── about.aspx             ← About page
├── App_Data/
│   └── eurovision-data.json ← All Eurovision data
├── images/
│   └── eurovision/        ← Performance photos
│       ├── 1973.png
│       ├── 1978.jpg
│       ├── ...
│       └── Not Participated.png
└── [Code-behind files].cs
```

---

## 🌟 Success!

If you see the Eurovision timeline with clickable year markers and smooth animations, **you're all set!** 🎉

The project is working correctly and ready for presentation.

---

**Created:** February 1, 2026  
**For:** Tamar's Final C# Project  
**Teacher:** Visual Studio / Windows Environment
