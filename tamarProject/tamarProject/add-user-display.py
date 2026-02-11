#!/usr/bin/env python3
"""
Add user display functionality to all preview pages
"""

import re

# Pages to update (excluding home, timeline, and login which are already done)
pages = [
    'fashion-preview.html',
    'data-manager-preview.html',
    'about-preview.html',
    'latest-news-preview.html',
    'the-show-preview.html',
    'national-mood-preview.html',
    'choreography-preview.html'
]

# CSS to add for user display
user_display_css = """
        .user-display {
            font-size: 0.9rem;
            color: #fdf200;
            font-weight: 500;
        }

        .user-display a {
            color: #fdf200;
            text-decoration: none;
        }

        .user-display a:hover {
            text-decoration: underline;
        }
"""

# HTML to add in logo-container
user_display_html = """                <div class="user-display" id="userDisplay">
                    <a href="login-preview.html">הרשמה / התחברות</a>
                </div>"""

# JavaScript to add before </body>
user_display_js = """
    <script>
        // Display logged-in user
        window.addEventListener('DOMContentLoaded', function() {
            const currentUser = JSON.parse(localStorage.getItem('euroUser') || 'null');
            const userDisplay = document.getElementById('userDisplay');
            
            if (currentUser && userDisplay) {
                userDisplay.innerHTML = `<span>שלום ${currentUser.name}!</span> | <a href="#" onclick="logout(); return false;">התנתק</a>`;
            }
        });

        function logout() {
            localStorage.removeItem('euroUser');
            alert('התנתקת בהצלחה / Successfully logged out');
            window.location.reload();
        }
    </script>
"""

for page in pages:
    try:
        with open(page, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Add CSS for user-display (before nav ul or similar selector)
        if '.user-display' not in content:
            # Find a good place to add CSS - usually before nav styling
            css_patterns = [
                (r'(\s+nav ul \{)', user_display_css + r'\1'),
                (r'(\s+nav \{)', user_display_css + r'\1'),
                (r'(\s+header nav)', user_display_css + r'\1'),
            ]
            
            for pattern, replacement in css_patterns:
                if re.search(pattern, content):
                    content = re.sub(pattern, replacement, content, count=1)
                    break
        
        # Add user display HTML in logo-container
        if 'id="userDisplay"' not in content:
            # Find logo-container and add user display after the logo
            patterns = [
                # Pattern for logo inside anchor tag
                (r'(<div class="logo-container">\s*<a[^>]*>\s*<img[^>]*class="euro-logo"[^>]*>\s*</a>)',
                 r'\1' + user_display_html),
                # Pattern for standalone logo
                (r'(<div class="logo-container">\s*<img[^>]*class="euro-logo"[^>]*>)',
                 r'\1' + user_display_html),
            ]
            
            for pattern, replacement in patterns:
                if re.search(pattern, content, re.DOTALL):
                    content = re.sub(pattern, replacement, content, count=1, flags=re.DOTALL)
                    break
        
        # Add JavaScript before </body>
        if 'localStorage.getItem(\'euroUser\')' not in content:
            content = content.replace('</body>', user_display_js + '\n</body>')
        
        # Write back
        with open(page, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✅ Updated: {page}")
        
    except FileNotFoundError:
        print(f"⚠️  Skipped (not found): {page}")
    except Exception as e:
        print(f"❌ Error updating {page}: {e}")

print("\n✨ User display added to all pages!")
