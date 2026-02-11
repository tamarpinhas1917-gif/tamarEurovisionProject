#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Unify navigation design across all pages to match home page style
Changes from pill-style nav to full-width header with logo container
"""

import re

# Pages to update (excluding home-preview.html which is already correct)
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

# The HOME page navigation CSS to use
HOME_NAV_CSS = """        header {
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
        }"""

# Pattern to find the old .top-nav CSS
OLD_NAV_PATTERN = re.compile(
    r'\.top-nav\s*\{[^}]+\}\s*'
    r'\.top-nav\s+ul\s*\{[^}]+\}\s*'
    r'\.top-nav\s+ul\s+li\s+a\s*\{[^}]+\}\s*'
    r'\.top-nav\s+ul\s+li\s+a:hover\s*\{[^}]+\}',
    re.MULTILINE | re.DOTALL
)

def update_navigation_css(file_path):
    """Replace old pill-style nav CSS with home page header CSS"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace the CSS
        if OLD_NAV_PATTERN.search(content):
            content = OLD_NAV_PATTERN.sub(HOME_NAV_CSS, content)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Updated CSS: {file_path}")
            return True
        else:
            print(f"⊘ No old nav CSS found: {file_path}")
            return False
            
    except Exception as e:
        print(f"✗ Error: {file_path}: {e}")
        return False

def update_navigation_html(file_path):
    """Update HTML structure to match home page (header with logo-container and nav)"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern to find old nav structure: <nav class="top-nav">
        old_nav_html_pattern = re.compile(
            r'<nav class="top-nav">\s*<ul>',
            re.MULTILINE
        )
        
        if old_nav_html_pattern.search(content):
            # Replace <nav class="top-nav"> with new header structure
            # First, we need to find the complete nav block and replace it
            
            # Find the nav opening
            content = content.replace('<nav class="top-nav">', '''<header>
            <div class="logo-container">
                <a href="home-preview.html">
                    <img src="https://www.eurovision.com/static/images/70-logo.ba56318cd52f.webp" alt="Eurovision 70">
                </a>
            </div>
            <nav>''')
            
            # Close the nav and add closing header
            # Find where nav closes and add header close
            content = re.sub(
                r'</nav>',
                lambda m: '</nav>\n        </header>' if '</header>' not in content[:m.start() + 100] else m.group(0),
                content,
                count=1
            )
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"✓ Updated HTML structure: {file_path}")
            return True
        else:
            print(f"⊘ No old nav HTML found: {file_path}")
            return False
            
    except Exception as e:
        print(f"✗ Error updating HTML: {file_path}: {e}")
        return False

def main():
    """Update all pages to match home page navigation design"""
    print("🎨 Unifying navigation design to match home page...\n")
    
    css_count = 0
    html_count = 0
    
    for page in pages:
        print(f"\nProcessing: {page}")
        if update_navigation_css(page):
            css_count += 1
        if update_navigation_html(page):
            html_count += 1
    
    print(f"\n✅ Updated {css_count} pages (CSS)")
    print(f"✅ Updated {html_count} pages (HTML)")
    print("Navigation design now matches home page style!")

if __name__ == '__main__':
    main()
