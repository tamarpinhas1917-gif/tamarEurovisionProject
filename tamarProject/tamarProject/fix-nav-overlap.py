#!/usr/bin/env python3
"""
Add padding-top to prevent navigation overlap on all pages
"""

import re

# Pages to update
pages = [
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
        
        # Add padding to body or main container to prevent overlap
        # Look for body style
        if re.search(r'body\s*\{[^}]*\}', content):
            # Check if padding-top already exists
            body_match = re.search(r'(body\s*\{[^}]*)(overflow-x:\s*hidden;)', content)
            if body_match and 'padding-top' not in body_match.group(0):
                content = re.sub(
                    r'(body\s*\{[^}]*)(overflow-x:\s*hidden;)',
                    r'\1\2\n            padding-top: 100px;',
                    content
                )
                print(f"✅ Added padding-top to body in: {page}")
        
        # Also look for container or main sections
        patterns = [
            # Pattern for container class
            (r'(\.container\s*\{[^}]*max-width:[^}]*margin:[^}]*)(position:\s*relative;)', 
             r'\1\2\n            padding-top: 100px;'),
            # Pattern for main content sections
            (r'(\.main-content\s*\{[^}]*)(padding:\s*\d+px;)',
             r'\1padding: 100px 20px 20px 20px;'),
        ]
        
        for pattern, replacement in patterns:
            if re.search(pattern, content) and 'padding-top: 100px' not in content:
                content = re.sub(pattern, replacement, content, count=1)
                print(f"  → Added padding to container in: {page}")
                break
        
        # Write back
        with open(page, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✓ Updated: {page}")
        
    except FileNotFoundError:
        print(f"⚠️  Skipped (not found): {page}")
    except Exception as e:
        print(f"❌ Error updating {page}: {e}")

print("\n✨ Padding added to prevent navigation overlap!")
