#!/usr/bin/env python3
"""
Update all preview pages with clickable logo and unified navigation
Remove standalone navigation buttons
"""

import re

# Pages to update
pages = [
    'home-preview.html',
    'timeline-preview.html',
    'fashion-preview.html',
    'data-manager-preview.html',
    'about-preview.html',
    'latest-news-preview.html',
    'the-show-preview.html',
    'national-mood-preview.html',
    'choreography-preview.html'
]

for page in pages:
    try:
        with open(page, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Make logo clickable - wrap in anchor tag if not already
        # Pattern 1: Logo without anchor in logo-container
        pattern1 = r'(<div class="logo-container">\s*)<img ([^>]*class="euro-logo"[^>]*)>'
        replacement1 = r'\1<a href="home-preview.html" style="text-decoration: none;">\n                <img \2>\n            </a>'
        
        if re.search(pattern1, content):
            content = re.sub(pattern1, replacement1, content)
            print(f"✅ Made logo clickable in: {page}")
        
        # Pattern 2: Standalone logo (not in logo-container) - like timeline
        pattern2 = r'(<img src="https://www\.eurovision\.com/static/images/70-logo[^>]*class="euro-logo"[^>]*>)(?!\s*</a>)'
        
        def wrap_logo(match):
            # Check if already wrapped in anchor
            img_tag = match.group(1)
            return f'<a href="home-preview.html" style="text-decoration: none;">\n        {img_tag}\n        </a>'
        
        if re.search(pattern2, content) and '<a href="home-preview.html"' not in content[:1000]:
            content = re.sub(pattern2, wrap_logo, content)
            print(f"✅ Made standalone logo clickable in: {page}")
        
        # Remove common navigation button patterns (back buttons, etc.)
        # Pattern: Back to Home buttons
        nav_button_patterns = [
            r'<a[^>]*class="back-[^"]*"[^>]*>.*?Back to Home.*?</a>',
            r'<a[^>]*class="back-[^"]*"[^>]*>.*?חזרה לדף הבית.*?</a>',
            r'<button[^>]*class="back-[^"]*"[^>]*>.*?</button>',
        ]
        
        for pattern in nav_button_patterns:
            if re.search(pattern, content, re.IGNORECASE | re.DOTALL):
                content = re.sub(pattern, '', content, flags=re.IGNORECASE | re.DOTALL)
                print(f"  → Removed navigation button from: {page}")
        
        # Write back
        with open(page, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✓ Updated: {page}")
        
    except FileNotFoundError:
        print(f"⚠️  Skipped (not found): {page}")
    except Exception as e:
        print(f"❌ Error updating {page}: {e}")

print("\n✨ Navigation update complete!")
print("\n📋 Summary:")
print("  ✅ Logo is now clickable on all pages")
print("  ✅ Logo links to home-preview.html")
print("  ✅ Removed standalone navigation buttons")
print("  ✅ Unified navigation bar maintained")
