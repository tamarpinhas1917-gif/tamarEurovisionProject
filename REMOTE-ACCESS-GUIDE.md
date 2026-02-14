# Remote Access Guide - Eurovision Website

## Free Hosting Options for Your Eurovision Project

Since your project is currently **static HTML/CSS/JavaScript** (the preview pages), you have several excellent **FREE** hosting options:

---

## ⭐ RECOMMENDED: GitHub Pages (Easiest & Free Forever)

### Why GitHub Pages?
- ✅ **Completely Free**
- ✅ **Already using GitHub** - Your code is already there!
- ✅ **Custom domain support** (optional)
- ✅ **HTTPS by default**
- ✅ **No server management needed**
- ✅ **Fast CDN delivery**

### Setup Steps (5 minutes):

1. **Go to your GitHub repository:**
   ```
   https://github.com/tamarpinhas1917-gif/tamarEurovisionProject
   ```

2. **Click on "Settings" (top right)**

3. **Scroll down to "Pages" in left sidebar**

4. **Under "Source", select:**
   - Branch: `main`
   - Folder: `/tamarProject/tamarProject`
   - Click "Save"

5. **Wait 2-3 minutes** - GitHub will build your site

6. **Your site will be live at:**
   ```
   https://tamarpinhas1917-gif.github.io/tamarEurovisionProject/
   ```

### Important Notes:
- **Video file**: The `eurovision-background.mov` (233MB) is in `.gitignore` and won't be on the live site
- **Solution**: Either upload a smaller compressed version OR use a YouTube embed instead
- All your preview pages will work perfectly!

---

## 🌐 Alternative Option 1: Netlify (Super Easy)

### Why Netlify?
- ✅ Free tier is generous
- ✅ Drag & drop deployment
- ✅ Auto-deploys from GitHub
- ✅ Custom domains
- ✅ Serverless functions (if needed later)

### Setup Steps:

1. **Go to:** https://www.netlify.com/

2. **Sign up** with your GitHub account

3. **Click "Add new site" → "Import an existing project"**

4. **Connect to GitHub** and select `tamarEurovisionProject`

5. **Build settings:**
   - Base directory: `tamarProject/tamarProject`
   - Build command: (leave empty)
   - Publish directory: `tamarProject/tamarProject`

6. **Click "Deploy site"**

7. **Your site will be live at:**
   ```
   https://random-name-12345.netlify.app
   ```
   (You can customize this name in settings)

---

## 🚀 Alternative Option 2: Vercel (Developer-Friendly)

### Why Vercel?
- ✅ Free for personal projects
- ✅ GitHub integration
- ✅ Fast deployment
- ✅ Great for modern web apps

### Setup Steps:

1. **Go to:** https://vercel.com/

2. **Sign up** with GitHub

3. **Click "Add New" → "Project"**

4. **Select** `tamarEurovisionProject`

5. **Configure:**
   - Framework Preset: Other
   - Root Directory: `tamarProject/tamarProject`
   - Build Command: (leave empty)
   - Output Directory: `tamarProject/tamarProject`

6. **Click "Deploy"**

7. **Your site will be live at:**
   ```
   https://tamar-eurovision-project.vercel.app
   ```

---

## 📱 Quick Test Option: ngrok (Temporary Tunneling)

### For Testing/Demo Purposes Only:

1. **Install ngrok:**
   ```bash
   brew install ngrok
   ```

2. **Start a local server:**
   ```bash
   cd /Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject
   python3 -m http.server 8000
   ```

3. **In another terminal, create tunnel:**
   ```bash
   ngrok http 8000
   ```

4. **Share the URL** that ngrok provides (e.g., `https://abc123.ngrok.io`)

5. **NOTE:** This URL is temporary and will change when you restart ngrok

---

## 🎬 Video Background Solution

Since the video file is 233MB and can't be on GitHub Pages, here are solutions:

### Option 1: YouTube Embed
```html
<div class="video-background">
    <iframe 
        src="https://www.youtube.com/embed/YOUR_VIDEO_ID?autoplay=1&mute=1&loop=1&playlist=YOUR_VIDEO_ID&controls=0"
        frameborder="0" 
        allow="autoplay; fullscreen"
        style="position: absolute; top: 50%; left: 50%; min-width: 100%; min-height: 100%; width: auto; height: auto; transform: translate(-50%, -50%);">
    </iframe>
</div>
```

### Option 2: Cloudinary (Free CDN)
1. Sign up at https://cloudinary.com (free tier)
2. Upload your video
3. Get the CDN URL
4. Update `home-preview.html` to use Cloudinary URL

### Option 3: Convert to smaller format
```bash
# Use FFmpeg to compress (install with: brew install ffmpeg)
ffmpeg -i eurovision-background.mov -vcodec libx264 -crf 28 -preset fast eurovision-background-compressed.mp4
```

---

## 🎯 Recommended Setup for Your Project

**For immediate remote access:**

1. ✅ **Use GitHub Pages** (free, already have the repo)
2. ✅ **Replace video** with YouTube embed or compressed version
3. ✅ **Share URL** with friends/classmates
4. ✅ **Keep developing** - changes auto-deploy when you push to GitHub

**Steps:**
1. Remove video file from preview pages OR add compressed version
2. Enable GitHub Pages in repository settings
3. Access your site at: `https://tamarpinhas1917-gif.github.io/tamarEurovisionProject/home-preview.html`

---

## 📝 Notes

- Your **.aspx files** (ASP.NET) won't work on these platforms (they need Windows/IIS)
- Your **preview HTML files** will work perfectly
- For full ASP.NET support, you'd need:
  - Azure (has free tier with credit card)
  - DigitalOcean ($5/month)
  - AWS (complex setup)

**For school project presentation, stick with the HTML preview pages + GitHub Pages!** ✨

---

## Need Help?

Let me know which option you want to proceed with, and I'll help you:
1. Set up the deployment
2. Fix the video background issue
3. Test the live site
4. Add a custom domain (if desired)
