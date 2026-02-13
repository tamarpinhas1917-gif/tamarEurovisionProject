#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Convert all Hebrew text to English across all preview pages"""

import os
import re

# Translation dictionary - Hebrew to English
translations = {
    # Navigation
    'דף הבית': 'Home',
    'ציר הזמן': 'Timeline',
    'אופנה': 'Fashion',
    'ניהול נתונים': 'Data Manager',
    'חדשות אחרונות': 'Latest News',
    'המופע': 'The Show',
    'הרשמה': 'Sign Up',
    'התחברות': 'Login',
    'הרשמה / התחברות': 'Sign Up / Login',
    
    # User display
    'שלום': 'Hello',
    'התנתק': 'Logout',
    'התנתקת בהצלחה': 'Successfully logged out',
    
    # Home page
    'הצטרפו לחגיגה': 'Join the Celebration',
    'ברוך הבא': 'Welcome',
    'גלה את המסע שלנו': 'Discover Our Journey',
    'לחץ להפעלת הווידאו': 'Click to Play Video',
    
    # Timeline page
    'המסע של ישראל': "Israel's Journey",
    'באירוויזיון': 'in Eurovision',
    'היום': 'Today',
    'פרטים מהירים': 'Quick Facts',
    'שנה': 'Year',
    'נציג': 'Artist',
    'שיר': 'Song',
    'שם באנגלית': 'English Name',
    'מיקום': 'Position',
    'מקום': 'Place',
    'צליל': 'Sound',
    'תצורה': 'Fashion',
    'שפה': 'Language',
    'כוריאוגרפיה': 'Choreography',
    'הלך רוח לאומי': 'National Mood',
    
    # Login/Signup pages
    'כניסה': 'Login',
    'שם משתמש': 'Username',
    'סיסמה': 'Password',
    'היכנס': 'Login',
    'אין לך חשבון': "Don't have an account",
    'להרשמה': 'Sign Up',
    'יש לך חשבון': 'Have an account',
    
    # Fashion page
    'THE LOOK OF ISRAEL': 'THE LOOK OF ISRAEL',
    
    # Data Manager
    'מנהל נתוני אירוויזיון': 'Eurovision Data Manager',
    'הוסף שנה': 'Add Year',
    'ערוך': 'Edit',
    'מחק': 'Delete',
    'שמור': 'Save',
    'בטל': 'Cancel',
    
    # Common
    'ישראל': 'Israel',
    'אירוויזיון': 'Eurovision',
    'עברית': 'Hebrew',
    'אנגלית': 'English',
}

# Files to translate
files = [
    'home-preview.html',
    'timeline-preview.html',
    'fashion-preview.html',
    'data-manager-preview.html',
    'login-preview.html',
    'about-preview.html',
    'latest-news-preview.html',
    'the-show-preview.html',
    'choreography-preview.html',
    'national-mood-preview.html'
]

def translate_file(filename):
    """Translate Hebrew text to English in a file"""
    if not os.path.exists(filename):
        print(f"⚠️  File not found: {filename}")
        return
    
    print(f"Processing {filename}...")
    
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Replace all Hebrew text with English
    for hebrew, english in translations.items():
        content = content.replace(hebrew, english)
    
    # Change dir="rtl" to dir="ltr"
    content = content.replace('dir="rtl"', 'dir="ltr"')
    
    # Change lang="he" to lang="en"
    content = content.replace('lang="he"', 'lang="en"')
    
    # Save the file
    if content != original_content:
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  ✓ Translated {filename}")
    else:
        print(f"  - No changes needed in {filename}")

# Process all files
print("=" * 60)
print("Converting all pages from Hebrew to English")
print("=" * 60)
print()

for filename in files:
    translate_file(filename)

print()
print("=" * 60)
print("✓ All pages have been translated to English!")
print("✓ Changed dir='rtl' to dir='ltr'")
print("✓ Changed lang='he' to lang='en'")
print("=" * 60)
