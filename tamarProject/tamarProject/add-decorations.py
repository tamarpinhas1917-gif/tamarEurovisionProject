#!/usr/bin/env python3
"""
Add second heart decoration and Israel flag to all preview pages
"""

import os
import re

# CSS for second heart and Israel flag
ADDITIONAL_DECORATIONS_CSS = """
        /* Second Heart Decoration (bottom left) */
        .euro-heart-decoration-2 {
            position: fixed;
            bottom: 25%;
            left: 10%;
            width: 150px;
            opacity: 0.3;
            filter: blur(2px);
            pointer-events: none;
            z-index: 0;
            animation: heartPulse 5s infinite ease-in-out;
            animation-delay: 1s;
        }

        /* Israel Flag in Eurovision Heart */
        .carousel-winner-flag {
            position: fixed;
            bottom: 15%;
            right: 8%;
            width: 80px;
            height: 80px;
            opacity: 0.6;
            pointer-events: none;
            z-index: 0;
            animation: flagFloat 6s infinite ease-in-out;
            filter: drop-shadow(0 0 10px rgba(0, 177, 234, 0.5));
        }

        @keyframes flagFloat {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
        }"""

ADDITIONAL_DECORATIONS_HTML = """
    <!-- Second Heart Decoration (bottom left) -->
    <img class="euro-heart-decoration-2" src="https://www.eurovision.com/static/images/70-heart.f6c629bcf5dd.webp" 
         srcset="https://www.eurovision.com/static/images/70-heart.f6c629bcf5dd.webp, https://www.eurovision.com/static/images/70-heart@2x.0fe89b9ce3a9.webp 2x" 
         alt="Eurovision Heart">

    <!-- Israel Flag in Eurovision Heart -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" 
         alt="Israel flag in a eurovision heart" width="80">
"""

def update_preview_file(filepath):
    """Add second heart and Israel flag decorations"""
    
    if 'home-preview.html' in filepath:
        print(f"⏭️  Skipped: {os.path.basename(filepath)} (already updated)")
        return False
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 1. Add CSS for second heart and flag if not present
        if 'euro-heart-decoration-2' not in content and 'carousel-winner-flag' not in content:
            # Find the heartPulse keyframe and add after it
            if '@keyframes heartPulse' in content:
                content = content.replace(
                    '@keyframes heartPulse',
                    ADDITIONAL_DECORATIONS_CSS + '\n\n        @keyframes heartPulse'
                )
        
        # 2. Add HTML elements for second heart and flag if not present
        if 'euro-heart-decoration-2' not in content or 'carousel-winner-flag' not in content:
            # Find the first heart decoration and add the new elements after it
            pattern = r'(<img class="euro-heart-decoration"[^>]+>\s*(?:\n\s*)?)'
            match = re.search(pattern, content)
            if match:
                insert_pos = match.end()
                content = content[:insert_pos] + ADDITIONAL_DECORATIONS_HTML + content[insert_pos:]
        
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
    preview_files = [
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
    
    print("🎨 Adding second heart decoration and Israel flag to all preview pages...\n")
    
    updated_count = 0
    for filename in preview_files:
        if os.path.exists(filename):
            if update_preview_file(filename):
                updated_count += 1
        else:
            print(f"⚠️  File not found: {filename}")
    
    print(f"\n✨ Done! Updated {updated_count} files with additional decorations.")

if __name__ == '__main__':
    main()
