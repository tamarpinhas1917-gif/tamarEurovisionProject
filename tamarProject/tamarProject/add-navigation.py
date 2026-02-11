#!/usr/bin/env python3
"""
Add consistent navigation to all preview pages
"""

import re
from pathlib import Path

# Navigation HTML template
NAV_TEMPLATE = '''    <!-- Navigation Header -->
    <header class="nav-header">
        <div class="logo-container">
            <a href="home-preview.html">
                <img src="https://www.eurovision.com/static/images/70-logo.ba56318cd52f.webp" alt="Eurovision 70" class="euro-logo">
                <div class="user-display" id="userDisplay">
                    <a href="login-preview.html">הרשמה / התחברות</a>
                </div>
            </a>
        </div>
        <nav>
            <ul>
                <li><a href="home-preview.html">דף הבית</a></li>
                <li><a href="timeline-preview.html">ציר הזמן</a></li>
                <li><a href="fashion-preview.html">אופנה</a></li>
                <li><a href="data-manager-preview.html">ניהול נתונים</a></li>
                <li><a href="login-preview.html">הרשמה</a></li>
                <li><a href="latest-news-preview.html">חדשות אחרונות</a></li>
                <li><a href="the-show-preview.html">המופע</a></li>
            </ul>
        </nav>
    </header>

'''

# Navigation CSS template
NAV_CSS = '''
        /* Navigation Header */
        .nav-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.8), transparent);
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
            box-sizing: border-box;
        }

        .logo-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }

        .logo-container a {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
        }

        .logo-container img {
            height: 60px;
            filter: drop-shadow(0 0 10px rgba(255,255,255,0.3));
            transition: transform 0.3s;
        }

        .logo-container img:hover {
            transform: scale(1.1);
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
        }

        .user-display {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--euro-blue);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .user-display a {
            color: var(--euro-yellow);
            text-decoration: none;
            transition: color 0.3s;
        }

        .user-display a:hover {
            color: var(--euro-pink);
        }

        .user-display .logout-btn {
            color: var(--euro-pink);
            cursor: pointer;
            margin-right: 10px;
            font-size: 0.7rem;
        }

        .user-display .logout-btn:hover {
            color: var(--euro-yellow);
        }
'''

def add_navigation_to_preview(file_path):
    """Add consistent navigation to a preview page"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Skip if already has nav-header
        if 'nav-header' in content:
            print(f"⏭️  Skipped: {file_path.name} (already has navigation)")
            return
        
        # Add navigation CSS before </style>
        if '</style>' in content and NAV_CSS not in content:
            content = content.replace('</style>', NAV_CSS + '    </style>')
        
        # Add navigation HTML after <body>
        if '<body>' in content and NAV_TEMPLATE not in content:
            content = content.replace('<body>', '<body>\n' + NAV_TEMPLATE)
        
        # Add auth script before </body> if not present
        if '</body>' in content and 'euro-auth.js' not in content:
            content = content.replace(
                '</body>',
                '\n    <!-- User Authentication Script -->\n    <script src="euro-auth.js"></script>\n</body>'
            )
        
        # Write back
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✅ Updated: {file_path.name}")
        
    except Exception as e:
        print(f"❌ Error updating {file_path.name}: {e}")

def main():
    """Update all preview pages"""
    script_dir = Path(__file__).parent
    
    preview_files = [
        'about-preview.html',
        'latest-news-preview.html',
        'the-show-preview.html',
        'choreography-preview.html',
        'national-mood-preview.html'
    ]
    
    print("🚀 Adding Navigation to Preview Pages")
    print("=" * 60)
    
    for filename in preview_files:
        file_path = script_dir / filename
        if file_path.exists():
            add_navigation_to_preview(file_path)
        else:
            print(f"⚠️  Not found: {filename}")
    
    print("=" * 60)
    print("✨ Navigation update complete!")

if __name__ == '__main__':
    main()
