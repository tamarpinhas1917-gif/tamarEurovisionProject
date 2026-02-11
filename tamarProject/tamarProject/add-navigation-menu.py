#!/usr/bin/env python3
"""
Add navigation menu to all preview pages
"""

import re

# Pages to update (excluding home which has different structure)
pages = [
    'fashion-preview.html',
    'data-manager-preview.html',
    'about-preview.html',
    'latest-news-preview.html',
    'the-show-preview.html',
    'national-mood-preview.html',
    'choreography-preview.html'
]

# CSS for navigation menu
nav_css = """
        /* Navigation Menu */
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
            color: #ff0085;
            text-shadow: 0 0 8px #ff0085;
        }
"""

# HTML navigation menu
nav_html = """        
        <nav class="top-nav">
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
"""

for page in pages:
    try:
        with open(page, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Add CSS if not already present
        if '.top-nav' not in content:
            # Find </style> tag and add CSS before it
            content = content.replace('    </style>', nav_css + '\n    </style>')
            print(f"✅ Added navigation CSS to: {page}")
        
        # Add HTML navigation if not already present
        if '<nav class="top-nav">' not in content:
            # Find <body> tag and add navigation after it
            # Look for patterns after <body> tag
            patterns = [
                (r'(<body>\s*)', r'\1' + nav_html),
                (r'(<body>\s*<!-- [^>]+ -->\s*)', r'\1' + nav_html),
            ]
            
            for pattern, replacement in patterns:
                if re.search(pattern, content, re.DOTALL):
                    content = re.sub(pattern, replacement, content, count=1, flags=re.DOTALL)
                    print(f"✅ Added navigation HTML to: {page}")
                    break
        
        # Write back
        with open(page, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✓ Updated: {page}")
        
    except FileNotFoundError:
        print(f"⚠️  Skipped (not found): {page}")
    except Exception as e:
        print(f"❌ Error updating {page}: {e}")

print("\n✨ Navigation menu added to all pages!")
print("\n📋 Navigation features:")
print("  ✅ Matching HOME page style")
print("  ✅ Font weight: 700 (bold)")
print("  ✅ Gap: 40px between items")
print("  ✅ Uppercase text with letter-spacing")
print("  ✅ Pink glow on hover")
