# 🔄 Preview Pages Sync Guide

## Overview
This guide explains how to keep the static HTML preview pages in sync with the original ASP.NET ASPX pages.

## Why Preview Pages?
Since this is an ASP.NET Framework project that requires Windows + Visual Studio to run, preview pages allow you to:
- ✅ View the website on **macOS/Linux**
- ✅ Test designs without running IIS Express
- ✅ Share the site with people who don't have Visual Studio
- ✅ Quick preview in any browser

## Files Structure
```
tamarProject/
├── homePage.aspx              ← Original ASP.NET page
├── timeline.aspx              ← Original ASP.NET page
├── fashion.aspx               ← Original ASP.NET page
├── data-manager.aspx          ← Original ASP.NET page
│
├── home-preview.html          ← Static HTML preview
├── timeline-preview.html      ← Static HTML preview
├── fashion-preview.html       ← Static HTML preview
├── data-manager-preview.html  ← Static HTML preview
│
└── convert_aspx_to_preview.py ← Conversion script
```

## 🚀 How to Update Preview Pages

### Automatic Method (Recommended)
After editing any `.aspx` file, run:

```bash
cd /Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject
python3 convert_aspx_to_preview.py
```

This will:
1. ✅ Remove all ASP.NET-specific code (`runat="server"`, `<%@ Page %>`, etc.)
2. ✅ Embed Eurovision JSON data from `App_Data/eurovision-data.json`
3. ✅ Convert all `.aspx` links to `-preview.html` links
4. ✅ Create fully functional static HTML files

### Manual Method
If you need to update a single page:
1. Copy the `.aspx` file content
2. Remove the `<%@ Page ... %>` directive at the top
3. Remove all `runat="server"` attributes
4. Replace `<%= GetEurovisionDataJson() %>` with actual JSON from `App_Data/eurovision-data.json`
5. Change all `.aspx` links to `-preview.html`
6. Save as `-preview.html`

## 📝 What the Conversion Script Does

### Removes:
- `<%@ Page Language="C#" ... %>`
- `runat="server"`
- `<form id="form1">` wrapper
- Server-side code blocks

### Adds/Replaces:
- Eurovision JSON data (from `App_Data/eurovision-data.json`)
- Converts links: `timeline.aspx` → `timeline-preview.html`
- Adds "PREVIEW" to page titles

## 🎯 When to Update Preview Pages

Update preview pages whenever you:
- ✏️ Change the HTML structure in `.aspx` files
- 🎨 Modify CSS styles
- 📊 Update Eurovision data in `App_Data/eurovision-data.json`
- 🔗 Add new navigation links
- ✨ Add new features

## ⚠️ Limitations of Preview Pages

Preview pages **cannot** handle:
- Server-side data processing
- Database connections
- C# code-behind logic
- Form submissions
- User authentication

For full functionality, you must run the project on Windows with Visual Studio.

## 🧪 Testing Preview Pages

1. Open `home-preview.html` in any browser
2. Navigate to other pages using the menu
3. Test the timeline slider
4. Verify Eurovision data displays correctly
5. Check all images load properly

## 📋 Preview Pages Checklist

- [x] `home-preview.html` - Updated with latest design
- [x] `timeline-preview.html` - Includes full Eurovision JSON data
- [x] `fashion-preview.html` - Includes fashion era cards
- [x] `data-manager-preview.html` - Shows data management UI
- [x] All navigation links work between preview pages
- [x] Eurovision data is embedded and functional

## 🔧 Troubleshooting

### Preview page shows "SERVER CODE: ..."
**Problem:** The conversion script didn't find the JSON data file.
**Solution:** 
```bash
# Check if JSON file exists
ls App_Data/eurovision-data.json

# Re-run conversion script
python3 convert_aspx_to_preview.py
```

### Navigation links don't work
**Problem:** Links still point to `.aspx` files.
**Solution:** Re-run the conversion script to update all links.

### Hebrew text displays incorrectly
**Problem:** Character encoding issue.
**Solution:** Ensure all files have `<meta charset="UTF-8">` in the `<head>` section.

## 📅 Last Updated
- **Date:** February 11, 2026
- **Updated by:** Automated conversion script
- **Status:** ✅ All preview pages in sync with ASPX files

## 🎉 Quick Start

To view your Eurovision project right now on macOS:

```bash
# Navigate to project folder
cd /Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject

# Open in browser
open home-preview.html
```

Or simply double-click `home-preview.html` in Finder!
