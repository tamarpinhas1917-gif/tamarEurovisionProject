#!/usr/bin/env python3
"""
Verify and ensure all preview pages have consistent background design as timeline
"""

import os
import re

def check_file_consistency(filepath):
    """Check if file has all required elements"""
    
    if 'timeline-preview.html' in filepath:
        return True, []  # Timeline is the reference
    
    issues = []
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check for required elements
        if '--deep-navy' not in content:
            issues.append("Missing --deep-navy color variable")
        
        if '--euro-purple' not in content:
            issues.append("Missing --euro-purple color variable")
        
        if '--euro-pink' not in content:
            issues.append("Missing --euro-pink color variable")
        
        if '--euro-blue' not in content:
            issues.append("Missing --euro-blue color variable")
        
        if '--euro-yellow' not in content:
            issues.append("Missing --euro-yellow color variable")
        
        if 'background: linear-gradient(135deg, var(--deep-navy) 0%, var(--euro-purple) 100%)' not in content:
            issues.append("Missing or incorrect background gradient")
        
        if 'floating-shape' not in content:
            issues.append("Missing floating shapes CSS")
        
        if 'euro-heart-decoration' not in content:
            issues.append("Missing heart decoration CSS")
        
        if '<div class="floating-shape shape1"></div>' not in content:
            issues.append("Missing floating shapes HTML elements")
        
        if 'euro-heart-decoration' not in content or '70-heart' not in content:
            issues.append("Missing heart decoration HTML element")
        
        return len(issues) == 0, issues
        
    except Exception as e:
        return False, [f"Error reading file: {e}"]

def main():
    preview_files = [
        'home-preview.html',
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
    
    print("🔍 Checking consistency across all preview pages...\n")
    
    all_good = True
    for filename in preview_files:
        if os.path.exists(filename):
            is_consistent, issues = check_file_consistency(filename)
            
            if is_consistent:
                print(f"✅ {filename:30s} - Consistent")
            else:
                print(f"❌ {filename:30s} - Issues found:")
                for issue in issues:
                    print(f"   • {issue}")
                all_good = False
        else:
            print(f"⚠️  {filename:30s} - File not found")
    
    print()
    if all_good:
        print("🎉 All pages are consistent with timeline design!")
    else:
        print("⚠️  Some pages need updates")

if __name__ == '__main__':
    main()
