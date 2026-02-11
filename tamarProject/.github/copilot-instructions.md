# Copilot Instructions - Tamar Eurovision Project

## Project Overview
**Educational Project**: High school (11th grade) final C# course project for student Tamar.

ASP.NET Web Forms application (.NET Framework 4.7.2) themed around Eurovision Song Contest, chronicling Israel's history in the competition. Uses classic WebForms architecture with IIS Express for local development.

**CRITICAL**: This is a learning project. Use **only** technologies and patterns taught in high school C# courses:
- ASP.NET Web Forms (no MVC, no React, no modern frameworks)
- C# in code-behind files
- HTML/CSS/JavaScript (vanilla JS only - no jQuery, no npm packages)
- Simple data structures (arrays, lists, classes)
- No external databases initially (can use XML, JSON files, or hardcoded data)

## Architecture & Structure

### WebForms Triple-File Pattern
Every page follows the standard ASP.NET WebForms structure:
- `*.aspx` - UI markup with inline styles/scripts
- `*.aspx.cs` - C# code-behind (extends `System.Web.UI.Page`)
- `*.aspx.designer.cs` - Auto-generated designer file (DO NOT manually edit)

Example: `login.aspx`, `login.aspx.cs`, `login.aspx.designer.cs`

### Project Organization
- Root level: Single-tier structure with all `.aspx` files in `tamarProject/` directory
- No MVC/Razor - pure WebForms with server controls
- Namespace: `tamarProject` for all code-behind classes
- Static resources: `StyleMenu.css` for shared navigation styles

## Styling Conventions

### Two Distinct UI Approaches
1. **Modern Eurovision Pages** (`login.aspx`, `homePage.aspx`):
   - Inline `<style>` blocks in `.aspx` files
   - CSS custom properties (e.g., `--euro-purple: #14052d`)
   - Glass-morphism effects: `backdrop-filter: blur(15px)`
   - Eurovision color palette: purple (#14052d), pink (#ff0085), blue (#00b1ea), yellow (#fdf200)

2. **Classic Navigation Pages** (`about.aspx`, `signUp.aspx`, `page1-3.aspx`):
   - External `StyleMenu.css` stylesheet
   - Side navigation menu pattern with hamburger icon (&#9776;)
   - Dark blue theme (#000066) with transitions

### Language & Direction
- Hebrew support: `lang="he" dir="rtl"` (right-to-left) on some pages
- English default: `lang="en" dir="ltr"` on others

## Development Workflow

### Build & Run
- **Build**: Use MSBuild or Visual Studio build commands
- **Run**: IIS Express on port 44341 (HTTPS) - configured in `.csproj`
- **Entry Point**: No default startup page configured - manually navigate to desired `.aspx`

### Dependencies
- Single NuGet package: `Microsoft.CodeDom.Providers.DotNetCompilerPlatform 2.0.1` (Roslyn compiler)
- References in `packages/` directory (committed to source control)

### Configuration
- `Web.config`: Debug mode enabled (`debug="true"`)
- Compilation target: .NET Framework 4.7.2
- No database connection strings present (static site currently)

## Code Patterns

### Page Lifecycle
Standard WebForms lifecycle hooks in code-behind:
```csharp
protected void Page_Load(object sender, EventArgs e) {
    // Currently empty stubs - implement per-page logic here
}
```

### Navigation Menu Pattern
Reusable side-nav HTML block with JavaScript controls:
```html
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="homePage.aspx">Home Page</a>
  <!-- ... navigation links ... -->
</div>
<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>
```

## Key Observations

- **JSON-Based Data Storage**: Eurovision data stored in `App_Data/eurovision-data.json` (47 years, 1973-2025)
- **Data Manager**: `data-manager.aspx` provides web interface for viewing/managing data
- **Inline Styles Preferred**: Modern pages use embedded CSS rather than external stylesheets
- **Mixed Styling Strategies**: Project uses both inline styles (new pages) and external CSS (legacy pages)
- **Manual Routing**: Pages linked via direct `.aspx` URLs (e.g., `href="login.aspx"`)
- **Visual Consistency**: Eurovision branding and color scheme should be maintained when adding pages

## Data Management System

### JSON Data File
- **Location**: `App_Data/eurovision-data.json`
- **Structure**: Array of `EurovisionYear` objects
- **Fields**: Year, Artist (Hebrew + English), Song (Hebrew + English), Rank, Sound, Fashion, Language, Choreography, Tags, ImageUrl
- **Count**: 47 entries (1973-2025)
- **Tags System**: Categorization by style (Folk, Disco, Rock, Pop, Ballad), success (Winner, Top3, Top5), and special attributes (Aftershock, LGBTQ, Political)

### EurovisionYear Class
```csharp
public class EurovisionYear
{
    public int Year { get; set; }
    public string Artist { get; set; }
    public string ArtistEnglish { get; set; }
    public string Song { get; set; }
    public string SongEnglish { get; set; }
    public int? Rank { get; set; }  // Nullable for non-qualifiers
    public string Sound { get; set; }
    public string Fashion { get; set; }
    public string Language { get; set; }
    public string Choreography { get; set; }
    public List<string> Tags { get; set; }
    public string ImageUrl { get; set; }
}
```

### Reading Data from JSON
Standard pattern in all pages:
```csharp
private List<EurovisionYear> GetAllEurovisionYears()
{
    string filePath = Server.MapPath("~/App_Data/eurovision-data.json");
    string jsonContent = File.ReadAllText(filePath);
    JavaScriptSerializer serializer = new JavaScriptSerializer();
    return serializer.Deserialize<List<EurovisionYear>>(jsonContent);
}
```

### Passing Data to JavaScript
```csharp
protected string GetEurovisionDataJson()
{
    List<EurovisionYear> data = GetAllEurovisionYears();
    JavaScriptSerializer serializer = new JavaScriptSerializer();
    return serializer.Serialize(data);
}
```

Used in ASPX:
```javascript
const eurovisionData = <%= GetEurovisionDataJson() %>;
```

## Adding New Pages

1. Create `.aspx` file with `CodeBehind="[filename].aspx.cs"` and `Inherits="tamarProject.[classname]"`
2. Create `.aspx.cs` code-behind extending `System.Web.UI.Page`
3. Add to `.csproj` under `<Content>` (aspx) and `<Compile>` (cs) sections
4. Choose styling approach: inline Eurovision theme OR external `StyleMenu.css` with side-nav
5. Update navigation menus in existing pages if needed

## Implementation Approach for Interactive Features

For the Eurovision timeline and interactive components, use high school-appropriate techniques:

### Data Storage Options
- **Hardcoded C# classes**: Create a `EurovisionYear` class with properties (Year, Artist, Song, Rank, etc.)
- **Static lists**: `List<EurovisionYear>` initialized in code-behind
- **XML/JSON files**: Store in App_Data folder, read with `System.IO` or `System.Xml`

### Client-Side Interactivity
- **Vanilla JavaScript**: Use `<script>` blocks for timeline slider, year selection
- **CSS transitions**: For smooth animations and glassmorphism effects
- **ASP.NET controls**: DropDownList, TextBox, Label for data display
- **ViewState**: To maintain state between postbacks

### Example Pattern for Timeline Feature
```csharp
// In code-behind
protected List<EurovisionYear> GetEurovisionData() {
    return new List<EurovisionYear> {
        new EurovisionYear { Year = 1978, Artist = "Izhar Cohen", Song = "A-Ba-Ni-Bi", Rank = 1 },
        // ... more years
    };
}
```

```javascript
// In .aspx file
<script>
function updateYear(year) {
    // Update display elements using vanilla JS
    document.getElementById('artistName').innerText = getArtistForYear(year);
}
</script>
```

## Educational Goals
- Practice C# object-oriented programming (classes, lists, LINQ)
- Understand ASP.NET page lifecycle and events
- Learn HTML/CSS styling and responsive design
- Apply JavaScript for client-side interactions
- Manage project structure and version control
