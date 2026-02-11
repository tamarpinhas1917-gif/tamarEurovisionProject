#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Reorder navigation menu to move הרשמה (signup) to the last position
"""

import os
import re

# Pages with navigation to update
pages = [
    'timeline-preview.html',
    'fashion-preview.html',
    'data-manager-preview.html',
    'about-preview.html',
    'latest-news-preview.html',
    'the-show-preview.html',
    'national-mood-preview.html',
    'choreography-preview.html'
]

# Define navigation menu items with old and new order
def get_old_nav_pattern():
    """Old navigation pattern with הרשמה in middle position"""
    return re.compile(
        r'(<ul>\s*'
        r'<li><a href="home-preview\.html">דף הבית</a></li>\s*'
        r'<li><a href="timeline-preview\.html">ציר הזמן</a></li>\s*'
        r'<li><a href="fashion-preview\.html">אופנה</a></li>\s*'
        r'<li><a href="data-manager-preview\.html">ניהול נתונים</a></li>\s*'
        r'<li><a href="login-preview\.html">הרשמה</a></li>\s*'
        r'<li><a href="latest-news-preview\.html">חדשות אחרונות</a></li>\s*'
        r'<li><a href="the-show-preview\.html">המופע</a></li>\s*'
        r'</ul>)',
        re.MULTILINE
    )

def get_new_nav():
    """New navigation with הרשמה moved to last position"""
    return """<ul>
                <li><a href="home-preview.html">דף הבית</a></li>
                <li><a href="timeline-preview.html">ציר הזמן</a></li>
                <li><a href="fashion-preview.html">אופנה</a></li>
                <li><a href="data-manager-preview.html">ניהול נתונים</a></li>
                <li><a href="latest-news-preview.html">חדשות אחרונות</a></li>
                <li><a href="the-show-preview.html">המופע</a></li>
                <li><a href="login-preview.html">הרשמה</a></li>
            </ul>"""

def reorder_navigation(file_path):
    """Update navigation menu in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Get pattern and replacement
        old_pattern = get_old_nav_pattern()
        new_nav = get_new_nav()
        
        # Check if file has the old navigation order
        match = old_pattern.search(content)
        if match:
            # Replace with new order
            content = old_pattern.sub(new_nav, content)
            
            # Write back
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Updated: {file_path}")
            return True
        else:
            print(f"⊘ Skipped: {file_path} (already updated or no navigation found)")
            return False
    
    except FileNotFoundError:
        print(f"⚠ Not found: {file_path}")
        return False
    except Exception as e:
        print(f"✗ Error with {file_path}: {e}")
        return False

def main():
    """Process all preview pages"""
    print("🔄 Reordering navigation menus...\n")
    
    updated_count = 0
    
    for page in pages:
        if reorder_navigation(page):
            updated_count += 1
    
    print(f"\n✅ Updated {updated_count} pages")
    print("הרשמה is now at the far left (last position) in RTL navigation")

if __name__ == '__main__':
    main()
