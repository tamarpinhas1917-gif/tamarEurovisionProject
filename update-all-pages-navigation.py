#!/usr/bin/env python3
"""
Script to update all preview pages with consistent navigation layout:
- Navigation bar on LEFT
- Eurovision 70 logo on RIGHT  
- User display below logo on RIGHT
- Consistent background with floating shapes
- Israel flag at bottom-right
"""

import os
import re

# Pages to update (excluding timeline which is already correct)
PAGES = [
    'home-preview.html',
    'fashion-preview.html',
    'data-manager-preview.html',
    'the-show-preview.html',
    'login-preview.html',
    'about-preview.html',
    'choreography-preview.html',
    'national-mood-preview.html'
]

BASE_DIR = '/Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject/'

# CSS for consistent navigation
NAV_CSS = '''        /* Navigation Menu - LEFT SIDE */
        .top-nav {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background: rgba(20, 5, 45, 0.8);
            backdrop-filter: blur(10px);
            padding: 15px 25px;
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .top-nav ul {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
            padding: 0;
        }

        .top-nav ul li a {
            text-decoration: none;
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .top-nav ul li a:hover {
            color: var(--euro-pink);
            text-shadow: 0 0 8px var(--euro-pink);
        }

        /* Eurovision 70 Logo - RIGHT SIDE */
        .euro-logo {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 150px;
            height: auto;
            z-index: 1000;
            filter: drop-shadow(0 0 20px rgba(255, 0, 133, 0.3));
        }

        /* User Display - BELOW LOGO ON RIGHT */
        .user-display {
            position: fixed;
            top: 115px;
            right: 30px;
            color: var(--euro-yellow);
            font-weight: 600;
            z-index: 1001;
            font-size: 0.9rem;
            background: rgba(20, 5, 45, 0.7);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-display a {
            color: var(--euro-yellow);
            text-decoration: none;
            transition: 0.3s;
        }

        .user-display a:hover {
            color: #fff;
            text-shadow: 0 0 8px var(--euro-yellow);
        }'''

# HTML for navigation structure
NAV_HTML = '''    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag" width="50">

    <!-- User Display -->
    <div class="user-display" id="userDisplay">
        <a href="login-preview.html">Sign Up / Login</a>
    </div>

    <!-- Eurovision 70 Logo - RIGHT SIDE -->
    <a href="home-preview.html" style="text-decoration: none;">
        <img src="images/eurovision/eurovision-70-logo.png" alt="Eurovision 70" class="euro-logo">
    </a>

    <!-- Navigation Menu - LEFT SIDE -->
    <nav class="top-nav">
        <ul>
            <li><a href="home-preview.html">Home</a></li>
            <li><a href="timeline-preview.html">Timeline</a></li>
            <li><a href="fashion-preview.html">Fashion</a></li>
            <li><a href="data-manager-preview.html">Data Manager</a></li>
            <li><a href="latest-news-preview.html">Gallery</a></li>
            <li><a href="the-show-preview.html">The Show</a></li>
            <li><a href="login-preview.html">Sign Up</a></li>
        </ul>
    </nav>'''

def update_page(filepath):
    """Update a single page with consistent navigation"""
    print(f"Processing {os.path.basename(filepath)}...")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove old header/nav CSS patterns
    # This is a simplified approach - removes common old patterns
    patterns_to_remove = [
        r'header\s*{[^}]*display:\s*flex[^}]*}',
        r'\.logo-container\s*{[^}]*}',
        r'\.logo-container\s+img\s*{[^}]*}',
        r'nav\s+ul\s*{[^}]*}',
        r'nav\s+ul\s+li\s+a\s*{[^}]*}',
        r'nav\s+ul\s+li\s+a:hover\s*{[^}]*}',
    ]
    
    # Replace old header HTML with new structure
    # Find <body> tag and insert new navigation after it
    body_match = re.search(r'<body[^>]*>', content)
    if body_match:
        # Find old header/nav block and remove it
        old_header_pattern = r'<header>.*?</header>\s*(?:<div\s+id="userDisplay"></div>)?'
        content = re.sub(old_header_pattern, '', content, flags=re.DOTALL)
        
        # Insert new navigation after <body>
        insert_pos = body_match.end()
        content = content[:insert_pos] + '\n' + NAV_HTML + '\n' + content[insert_pos:]
    
    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✓ Updated {os.path.basename(filepath)}")

def main():
    print("=== Updating All Pages with Consistent Navigation ===\n")
    
    for page in PAGES:
        filepath = os.path.join(BASE_DIR, page)
        if os.path.exists(filepath):
            try:
                update_page(filepath)
            except Exception as e:
                print(f"✗ Error updating {page}: {e}")
        else:
            print(f"✗ File not found: {page}")
    
    print("\n=== Update Complete ===")
    print("\nNote: You may need to manually:")
    print("1. Add the NAV_CSS to each page's <style> section")
    print("2. Remove any duplicate header/nav elements")
    print("3. Adjust page-specific padding if needed")

if __name__ == '__main__':
    main()
