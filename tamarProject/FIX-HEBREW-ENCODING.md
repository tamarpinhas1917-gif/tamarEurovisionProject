# 🔧 Fix: Hebrew Text Shows as Garbled Characters on Windows

## Problem
When running the project on Windows, Hebrew text appears as strange symbols like:
- `× © Œ ™ ©` instead of Hebrew letters
- Title showing wrong characters
- Artist names unreadable

## Root Cause
Windows wasn't interpreting the UTF-8 encoding correctly for Hebrew characters.

## Solution Applied ✅

### 1. Updated All .aspx Pages
Added proper UTF-8 encoding declarations to:
- `timeline.aspx`
- `fashion.aspx`
- `homePage.aspx`
- `login.aspx`
- `data-manager.aspx`

**What changed:**
```aspx
<%@ Page ... ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="UTF-8">
    ...
```

### 2. Updated Web.config
Added globalization settings to enforce UTF-8 across the entire application:

```xml
<globalization requestEncoding="utf-8" 
               responseEncoding="utf-8" 
               fileEncoding="utf-8" 
               culture="auto" 
               uiCulture="auto" />
```

## How to Test on Windows

1. **Clean and Rebuild** in Visual Studio:
   - Build → Clean Solution
   - Build → Rebuild Solution

2. **Run the project** (F5 or click Start)

3. **Check Hebrew text** on:
   - Timeline page - decorative text should show Hebrew
   - Song titles like "א-בה-ני-בי" 
   - Artist names like "יזהר כהן והאלפבטית"

## Expected Result ✅
All Hebrew text should now display correctly with proper characters instead of garbled symbols.

## If Still Not Working

1. **Check file encoding:**
   - In Visual Studio: File → Advanced Save Options
   - Ensure "Encoding: Unicode (UTF-8 with signature) - Codepage 65001"

2. **Clear browser cache:**
   - Ctrl + Shift + Delete
   - Clear cached files and reload

3. **Check IIS Express settings:**
   - Make sure your browser isn't forcing a different encoding

---

**Fixed:** February 1, 2026
**Tested on:** Windows (Visual Studio + IIS Express)
