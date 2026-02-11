#!/usr/bin/env python3
"""
Update all preview pages with timeline background and Eurovision heart decoration
"""

import os
import re

# Background and floating shapes CSS that timeline uses
TIMELINE_BACKGROUND_CSS = """        body {
            font-family: 'Segoe UI', 'Arial', sans-serif;
            background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%);
            background-attachment: fixed;
            color: white;
            min-height: 100vh;
            padding: 20px;
            padding-top: 120px;
            overflow-x: hidden;
            position: relative;
        }"""

FLOATING_SHAPES_CSS = """
        /* Floating Eurovision Heart/Circle Shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.6;
            animation: float 20s infinite ease-in-out;
            pointer-events: none;
            z-index: 0;
        }

        .shape1 {
            width: 300px;
            height: 300px;
            background: linear-gradient(135deg, var(--euro-pink), var(--euro-blue));
            top: 10%;
            left: -100px;
            animation-delay: 0s;
        }

        .shape2 {
            width: 400px;
            height: 400px;
            background: linear-gradient(135deg, var(--euro-blue), var(--euro-purple));
            top: 50%;
            right: -150px;
            animation-delay: 5s;
        }

        .shape3 {
            width: 250px;
            height: 250px;
            background: linear-gradient(135deg, var(--euro-pink), rgba(255, 0, 133, 0.5));
            bottom: 20%;
            left: 10%;
            animation-delay: 10s;
        }

        .shape4 {
            width: 350px;
            height: 350px;
            background: linear-gradient(135deg, var(--euro-blue), var(--euro-yellow));
            top: 30%;
            right: 20%;
            animation-delay: 7s;
        }

        .shape5 {
            width: 200px;
            height: 200px;
            background: linear-gradient(135deg, rgba(0, 177, 234, 0.6), rgba(255, 0, 133, 0.6));
            bottom: 10%;
            right: 10%;
            animation-delay: 3s;
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            25% {
                transform: translate(50px, -50px) scale(1.1);
            }
            50% {
                transform: translate(-30px, -100px) scale(0.9);
            }
            75% {
                transform: translate(30px, -50px) scale(1.05);
            }
        }"""

FLOATING_SHAPES_HTML = """
    <!-- Floating Eurovision Gradient Shapes -->
    <div class="floating-shape shape1"></div>
    <div class="floating-shape shape2"></div>
    <div class="floating-shape shape3"></div>
    <div class="floating-shape shape4"></div>
    <div class="floating-shape shape5"></div>

    <!-- Eurovision Heart Decoration (like official site) -->
    <img class="euro-heart-decoration" src="https://www.eurovision.com/static/images/70-heart.f6c629bcf5dd.webp" 
         srcset="https://www.eurovision.com/static/images/70-heart.f6c629bcf5dd.webp, https://www.eurovision.com/static/images/70-heart@2x.0fe89b9ce3a9.webp 2x" 
         alt="Eurovision Heart">
"""

HEART_DECORATION_CSS = """
        /* Eurovision Heart Decoration */
        .euro-heart-decoration {
            position: fixed;
            top: 15%;
            right: 10%;
            width: 200px;
            opacity: 0.4;
            filter: blur(3px);
            pointer-events: none;
            z-index: 0;
            animation: heartPulse 4s infinite ease-in-out;
        }

        @keyframes heartPulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.4;
            }
            50% {
                transform: scale(1.05);
                opacity: 0.5;
            }
        }"""

def update_preview_file(filepath):
    """Update a single preview file with timeline background"""
    
    # Skip timeline (it already has the design)
    if 'timeline-preview.html' in filepath:
        print(f"⏭️  Skipped: {os.path.basename(filepath)} (already has the design)")
        return False
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 1. Add --deep-navy color variable if not present
        if '--deep-navy' not in content:
            content = content.replace(
                ':root {',
                ':root {\n            --deep-navy: #050514;'
            )
        
        # 2. Update body CSS to match timeline
        # Find body style block and replace it
        body_pattern = r'body\s*(?:,\s*html)?\s*{[^}]+}'
        if re.search(body_pattern, content):
            content = re.sub(body_pattern, TIMELINE_BACKGROUND_CSS, content, count=1)
        
        # 3. Add floating shapes CSS before closing </style>
        if '.floating-shape' not in content and 'floating-shape' not in content:
            content = content.replace('</style>', FLOATING_SHAPES_CSS + '\n' + HEART_DECORATION_CSS + '\n    </style>')
        
        # 4. Add floating shapes HTML after <body> tag
        if 'floating-shape shape1' not in content:
            # Find the position right after <body> or after the header
            body_tag_match = re.search(r'<body[^>]*>', content)
            if body_tag_match:
                insert_pos = body_tag_match.end()
                content = content[:insert_pos] + FLOATING_SHAPES_HTML + content[insert_pos:]
        
        # Save if changes were made
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ Updated: {os.path.basename(filepath)}")
            return True
        else:
            print(f"⏭️  No changes needed: {os.path.basename(filepath)}")
            return False
            
    except Exception as e:
        print(f"❌ Error updating {filepath}: {e}")
        return False

def main():
    # Get all preview HTML files
    preview_files = [
        'home-preview.html',
        'login-preview.html',
        'fashion-preview.html',
        'data-manager-preview.html',
        'about-preview.html',
        'latest-news-preview.html',
        'the-show-preview.html',
        'choreography-preview.html',
        'national-mood-preview.html'
    ]
    
    print("🎨 Updating all preview pages with timeline background design...\n")
    
    updated_count = 0
    for filename in preview_files:
        if os.path.exists(filename):
            if update_preview_file(filename):
                updated_count += 1
        else:
            print(f"⚠️  File not found: {filename}")
    
    print(f"\n✨ Done! Updated {updated_count} files with Eurovision background and heart decoration.")

if __name__ == '__main__':
    main()
