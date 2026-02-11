#!/usr/bin/env python3
"""
Script to convert ASP.NET ASPX files to static HTML preview files
Removes ASP.NET-specific tags and code-behind references
"""

import re
import os
import json
from pathlib import Path

def load_eurovision_data(data_file):
    """Load Eurovision data from JSON file"""
    try:
        with open(data_file, 'r', encoding='utf-8') as f:
            return f.read().strip()
    except Exception as e:
        print(f"⚠️  Warning: Could not load {data_file}: {e}")
        return "[]"

def convert_aspx_to_html(aspx_content, filename, eurovision_json=None):
    """
    Convert ASPX content to static HTML
    
    Args:
        aspx_content: String content of ASPX file
        filename: Name of the source file
        eurovision_json: JSON data to inject
        
    Returns:
        Converted HTML content
    """
    
    # Remove ASP.NET Page directive
    html_content = re.sub(r'<%@\s*Page\s+.*?%>\s*', '', aspx_content, flags=re.DOTALL)
    
    # Remove runat="server" attributes
    html_content = re.sub(r'\s+runat="server"', '', html_content)
    
    # Remove runat='server' attributes (single quotes)
    html_content = re.sub(r"\s+runat='server'", '', html_content)
    
    # Remove <form id="form1" runat="server"> and </form> tags but keep content
    html_content = re.sub(r'<form\s+id="form1"[^>]*>', '', html_content)
    html_content = re.sub(r'</form>', '', html_content)
    
    # Replace server-side code blocks with actual data
    if eurovision_json:
        # <%= GetEurovisionDataJson() %> - replace with actual JSON data
        html_content = re.sub(
            r'<%=\s*GetEurovisionDataJson\(\)\s*%>', 
            eurovision_json, 
            html_content
        )
    
    # Replace any remaining server-side code blocks with comments
    html_content = re.sub(r'<%=\s*(.*?)\s*%>', r'/* SERVER CODE: \1 */', html_content)
    
    # Change .aspx links to -preview.html
    html_content = html_content.replace('homePage.aspx', 'home-preview.html')
    html_content = html_content.replace('timeline.aspx', 'timeline-preview.html')
    html_content = html_content.replace('fashion.aspx', 'fashion-preview.html')
    html_content = html_content.replace('data-manager.aspx', 'data-manager-preview.html')
    html_content = html_content.replace('login.aspx', 'login-preview.html')
    html_content = html_content.replace('about.aspx', 'about-preview.html')
    html_content = html_content.replace('latest-news.aspx', 'latest-news-preview.html')
    html_content = html_content.replace('the-show.aspx', 'the-show-preview.html')
    
    # Add preview notice in the title if not present
    if '-preview' not in filename and 'Preview' not in html_content[:500]:
        html_content = html_content.replace('<title>', '<title>PREVIEW - ', 1)
    
    return html_content

def process_file(aspx_path, output_path, eurovision_json=None):
    """
    Process a single ASPX file and create HTML preview
    
    Args:
        aspx_path: Path to source ASPX file
        output_path: Path to output HTML file
        eurovision_json: JSON data to inject
    """
    try:
        with open(aspx_path, 'r', encoding='utf-8') as f:
            aspx_content = f.read()
        
        html_content = convert_aspx_to_html(aspx_content, aspx_path.name, eurovision_json)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        print(f"✅ Converted: {aspx_path.name} → {output_path.name}")
        
    except Exception as e:
        print(f"❌ Error processing {aspx_path.name}: {e}")

def main():
    """Main conversion process"""
    # Get the directory where the script is located
    script_dir = Path(__file__).parent
    
    # Load Eurovision data
    data_file = script_dir / 'App_Data' / 'eurovision-data.json'
    eurovision_json = load_eurovision_data(data_file)
    
    # Files to convert (aspx_file, preview_file)
    files_to_convert = [
        ('homePage.aspx', 'home-preview.html'),
        ('timeline.aspx', 'timeline-preview.html'),
        ('fashion.aspx', 'fashion-preview.html'),
        ('data-manager.aspx', 'data-manager-preview.html'),
        ('login.aspx', 'login-preview.html'),
        ('about.aspx', 'about-preview.html'),
        ('latest-news.aspx', 'latest-news-preview.html'),
        ('the-show.aspx', 'the-show-preview.html'),
    ]
    
    print("🚀 Starting ASPX to HTML Preview Conversion")
    print("=" * 60)
    
    for aspx_file, preview_file in files_to_convert:
        aspx_path = script_dir / aspx_file
        output_path = script_dir / preview_file
        
        if aspx_path.exists():
            process_file(aspx_path, output_path, eurovision_json)
        else:
            print(f"⚠️  File not found: {aspx_file}")
    
    print("=" * 60)
    print("✨ Conversion complete!")
    print("\n📝 Note: The preview files have been updated with:")
    print("   ✅ Latest ASPX content")
    print("   ✅ Eurovision JSON data embedded")
    print("   ✅ Working navigation links")
    print("\n🌐 Open home-preview.html in your browser to view the site!")

if __name__ == '__main__':
    main()
