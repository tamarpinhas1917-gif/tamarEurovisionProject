#!/usr/bin/env python3
import re

files_to_update = [
    "login-preview.html",
    "about-preview.html",
    "latest-news-preview.html",
    "the-show-preview.html"
]

css_block = '''
        /* Israel Flag */
        .carousel-winner-flag {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 100;
            animation: flagFloat 6s infinite ease-in-out;
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.3));
        }

        @keyframes flagFloat {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
        }
'''

html_element = '''    
    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag in a eurovision heart" width="50">
'''

for filename in files_to_update:
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check if flag already exists
        if 'carousel-winner-flag' in content:
            print(f"✓ {filename} - Flag already exists")
            continue
        
        # Add CSS before </style>
        content = content.replace('    </style>', css_block + '\n    </style>')
        
        # Add HTML after <body>
        content = content.replace('<body>\n    \n    <!--', '<body>\n' + html_element + '\n    <!--')
        content = content.replace('<body>\n    \n        <', '<body>\n' + html_element + '\n        <')
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✓ {filename} - Flag added")
    except Exception as e:
        print(f"✗ {filename} - Error: {e}")

print("\n✓ All files processed!")
