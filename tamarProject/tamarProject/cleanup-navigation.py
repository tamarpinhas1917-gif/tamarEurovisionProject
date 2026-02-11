#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Clean up duplicate logos and fix user-display positioning for new header design
"""

import re

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

def remove_duplicate_logo(file_path):
    """Remove the standalone .euro-logo that's now duplicated in header"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern to find standalone euro-logo (before the header)
        old_logo_pattern = re.compile(
            r'<a href="home-preview\.html" style="text-decoration: none;">\s*'
            r'<img src="https://www\.eurovision\.com/static/images/70-logo\.ba56318cd52f\.webp" '
            r'alt="Eurovision 70" class="euro-logo">\s*'
            r'</a>\s*',
            re.MULTILINE
        )
        
        if old_logo_pattern.search(content):
            content = old_logo_pattern.sub('', content)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Removed duplicate logo: {file_path}")
            return True
        else:
            print(f"⊘ No duplicate logo found: {file_path}")
            return False
            
    except Exception as e:
        print(f"✗ Error: {file_path}: {e}")
        return False

def update_user_display_css(file_path):
    """Update .user-display CSS to work with new full-width header"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Find the old user-display CSS (designed for pill nav)
        old_user_display = re.compile(
            r'\.user-display\s*\{[^}]+\}',
            re.MULTILINE | re.DOTALL
        )
        
        # New user-display CSS matching home page
        new_user_display = """.user-display {
            position: fixed;
            top: 25px;
            right: 20px;
            color: #fdf200;
            font-weight: 600;
            z-index: 1001;
            font-size: 0.9rem;
        }

        .user-display a {
            color: #fdf200;
            text-decoration: none;
            transition: 0.3s;
        }

        .user-display a:hover {
            color: #fff;
            text-shadow: 0 0 8px #fdf200;
        }"""
        
        if old_user_display.search(content):
            content = old_user_display.sub(new_user_display, content)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Updated user-display CSS: {file_path}")
            return True
        else:
            print(f"⊘ No user-display CSS found: {file_path}")
            return False
            
    except Exception as e:
        print(f"✗ Error updating user-display: {file_path}: {e}")
        return False

def remove_old_euro_logo_css(file_path):
    """Remove old .euro-logo CSS that's no longer needed"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern for old euro-logo CSS
        old_logo_css = re.compile(
            r'\.euro-logo\s*\{[^}]+\}',
            re.MULTILINE | re.DOTALL
        )
        
        if old_logo_css.search(content):
            content = old_logo_css.sub('', content)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Removed old logo CSS: {file_path}")
            return True
        else:
            return False
            
    except Exception as e:
        print(f"✗ Error: {file_path}: {e}")
        return False

def main():
    """Clean up pages after navigation redesign"""
    print("🧹 Cleaning up duplicate elements and fixing positioning...\n")
    
    for page in pages:
        print(f"\nProcessing: {page}")
        remove_duplicate_logo(page)
        update_user_display_css(page)
        remove_old_euro_logo_css(page)
    
    print("\n✅ Cleanup complete!")

if __name__ == '__main__':
    main()
