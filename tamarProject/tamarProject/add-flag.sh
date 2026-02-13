#!/bin/bash

# List of files to update (excluding home and data-manager which already have it)
files=(
    "timeline-preview.html"
    "fashion-preview.html"
    "login-preview.html"
    "about-preview.html"
    "latest-news-preview.html"
    "the-show-preview.html"
    "choreography-preview.html"
    "national-mood-preview.html"
)

css_block='
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
'

html_element='    <!-- Israel Flag -->
    <img class="carousel-winner-flag" src="https://storage.googleapis.com/eurovision-com.appspot.com/public/core_data/flag_il.svg" alt="Israel flag in a eurovision heart" width="50">
    '

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Check if flag CSS already exists
        if ! grep -q "carousel-winner-flag" "$file"; then
            # Add CSS before </style>
            sed -i '' "/<\/style>/i\\
$css_block
" "$file"
            
            # Add HTML after <body>
            sed -i '' "/<body>/a\\
$html_element
" "$file"
            
            echo "  ✓ Added flag to $file"
        else
            echo "  - Flag already exists in $file"
        fi
    fi
done

echo ""
echo "✓ All files updated!"
