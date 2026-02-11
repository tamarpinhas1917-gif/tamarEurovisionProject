#!/usr/bin/env python3
"""
Add unified navigation with logo to all preview pages.
- Logo clickable to home
- הרשמה (signup) is last in navigation
- Remove old navigation buttons
"""

import re
import os

NAVIGATION_HTML = '''        <header>
            <div class="logo-container">
                <a href="home-preview.html" style="text-decoration: none;">
                    <img src="https://www.eurovision.com/static/images/70-logo.ba56318cd52f.webp" alt="Eurovision 70" class="euro-logo">
                </a>
            </div>
            <nav>
                <ul>
                    <li><a href="home-preview.html">דף הבית</a></li>
                    <li><a href="timeline-preview.html">ציר הזמן</a></li>
                    <li><a href="fashion-preview.html">אופנה</a></li>
                    <li><a href="data-manager-preview.html">ניהול נתונים</a></li>
                    <li><a href="latest-news-preview.html">חדשות אחרונות</a></li>
                    <li><a href="the-show-preview.html">המופע</a></li>
                    <li><a href="login-preview.html">הרשמה</a></li>
                </ul>
            </nav>
        </header>'''

NAVIGATION_CSS = '''        /* סרגל ניווט שקוף ומודרני */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.8), transparent);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-sizing: border-box;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-container img {
            height: 60px;
            filter: drop-shadow(0 0 10px rgba(255,255,255,0.3));
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        
        .logo-container img:hover {
            transform: scale(1.05);
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        nav ul li a:hover {
            color: var(--euro-pink);
            text-shadow: 0 0 8px var(--euro-pink);
        }'''

def update_page_navigation(filepath):
    """Update a single page with unified navigation"""
    
    if not os.path.exists(filepath):
        print(f"⏭️  Skipping: {os.path.basename(filepath)} (not found)")
        return False
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Step 1: Ensure body has padding-top for fixed header
    if 'padding-top: 120px;' not in content and 'padding-top: 100px;' not in content:
        content = re.sub(
            r'(body\s*{[^}]*?padding:\s*20px;)',
            r'\1\n            padding-top: 120px;',
            content
        )
    
    # Step 2: Add/Update navigation CSS
    if 'header {' not in content or '.logo-container' not in content:
        # Add navigation CSS before the floating shapes or before </style>
        if '/* Floating' in content:
            content = content.replace('        /* Floating', NAVIGATION_CSS + '\n\n        /* Floating')
        else:
            content = content.replace('    </style>', '\n' + NAVIGATION_CSS + '\n    </style>')
    else:
        # Update existing navigation CSS
        content = re.sub(
            r'/\* סרגל ניווט.*?text-shadow: 0 0 8px var\(--euro-pink\);\s*}',
            NAVIGATION_CSS,
            content,
            flags=re.DOTALL
        )
    
    # Step 3: Remove old navigation buttons (like "→ חזרה לעמוד הבית")
    content = re.sub(
        r'<a href="[^"]*-preview\.html" class="back-btn"[^>]*>.*?</a>',
        '',
        content,
        flags=re.DOTALL
    )
    
    # Step 4: Add/Update header navigation HTML
    if '<header>' in content:
        # Replace existing header
        content = re.sub(
            r'<header>.*?</header>',
            NAVIGATION_HTML,
            content,
            flags=re.DOTALL
        )
    else:
        # Add header after <body> tag
        content = re.sub(
            r'(<body>\s*)',
            r'\1' + NAVIGATION_HTML + '\n        ',
            content,
            count=1
        )
    
    # Only save if content changed
    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"✅ Updated: {os.path.basename(filepath)}")
        return True
    else:
        print(f"⏭️  No changes needed: {os.path.basename(filepath)}")
        return False

def main():
    print("🎨 Adding unified navigation to all preview pages...\n")
    
    # List of all preview pages
    pages = [
        'home-preview.html',
        'login-preview.html',
        'timeline-preview.html',
        'fashion-preview.html',
        'data-manager-preview.html',
        'about-preview.html',
        'latest-news-preview.html',
        'the-show-preview.html',
        'choreography-preview.html',
        'national-mood-preview.html'
    ]
    
    updated_count = 0
    for page in pages:
        if update_page_navigation(page):
            updated_count += 1
    
    print(f"\n✨ Done! Updated {updated_count} files with unified navigation.")
    print("\nNavigation features:")
    print("  • Logo clickable → redirects to home page")
    print("  • Consistent navigation on all pages")
    print("  • הרשמה (signup) positioned last (far left)")
    print("  • Old navigation buttons removed")

if __name__ == '__main__':
    main()
