# 🚀 GitHub Setup Guide for Tamar's Eurovision Project

## Step 1: Create GitHub Account (if needed)

1. Go to https://github.com/signup
2. Enter your email address
3. Create a password
4. Choose a username (e.g., "tamar-eurovision" or your name)
5. Verify your account

---

## Step 2: Create New Repository

1. **Go to:** https://github.com/new

2. **Fill in the details:**
   - **Repository name:** `tamar-eurovision-project`
   - **Description:** "Israel Eurovision History - Interactive Timeline and Fashion Pages"
   - **Visibility:** ✅ **Private** (for school project)
   - **❌ Do NOT check:** "Add a README file"
   - **❌ Do NOT check:** "Add .gitignore"
   - **❌ Do NOT check:** "Choose a license"

3. **Click:** "Create repository"

---

## Step 3: Push Your Code

GitHub will show you instructions. Use the **"push an existing repository"** section.

**Copy your repository URL** (it will look like):
```
https://github.com/YOUR_USERNAME/tamar-eurovision-project.git
```

**Then run these commands on your Mac:**

```bash
cd "/Users/pinhasy/Library/CloudStorage/OneDrive-Starkey/Documents/VS gettingStarted/tamarProject"

# Add the GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/tamar-eurovision-project.git

# Push the code
git push -u origin main
```

---

## Step 4: Verify on GitHub

1. Go to your repository on GitHub
2. You should see all the files
3. Check that the commit message is there: "✨ Add interactive timeline and fashion pages..."

---

## Step 5: Clone on Windows Computer (At School)

**On the Windows computer:**

1. **Install Git for Windows** (if not installed):
   - Download from: https://git-scm.com/download/win
   - Install with default settings

2. **Open Command Prompt or PowerShell**

3. **Navigate to where you want the project:**
   ```bash
   cd C:\Users\YourName\Documents
   ```

4. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/tamar-eurovision-project.git
   ```

5. **Open in Visual Studio:**
   - Navigate to the cloned folder
   - Double-click `tamarProject.sln`
   - Press F5 to run

---

## 🔄 Making Changes and Syncing

### On ANY computer (Mac or Windows):

**After making changes:**

```bash
# See what changed
git status

# Add all changes
git add .

# Commit with a message
git commit -m "Description of what you changed"

# Push to GitHub
git push
```

**To get latest changes:**

```bash
# Pull latest code from GitHub
git pull
```

---

## 📋 Quick Reference

### First Time Setup (Mac - Already Done!)
✅ `git init`
✅ `git add .`
✅ `git commit -m "message"`
⏳ `git remote add origin <URL>` ← Do this next
⏳ `git push -u origin main` ← Then this

### Daily Workflow
1. Make changes in Visual Studio
2. `git add .`
3. `git commit -m "what you did"`
4. `git push`

### Getting Updates
1. `git pull`
2. Open Visual Studio
3. Continue working

---

## 🎯 Benefits of GitHub + OneDrive

✅ **GitHub:** Version control, backup, collaboration
✅ **OneDrive:** File sync, easy access on all computers
✅ **Together:** Best of both worlds!

- OneDrive syncs the files
- Git tracks all changes
- Can work from anywhere
- Never lose your work

---

## 🆘 Troubleshooting

### "Authentication failed"
- GitHub now requires Personal Access Token instead of password
- Go to: Settings → Developer settings → Personal access tokens
- Create a token with "repo" scope
- Use the token as your password

### "Already up to date" but files are different
```bash
git fetch
git reset --hard origin/main
```

---

**Ready to push to GitHub?** Follow Step 3 above! 🚀
