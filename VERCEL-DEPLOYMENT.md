# Vercel Deployment Guide - Eurovision Website

## 🚀 Deploy to Vercel (Recommended!)

Vercel is perfect for your Eurovision project - fast, free, and easy!

---

## Step-by-Step Deployment:

### 1. Sign Up / Login to Vercel

1. Go to: **https://vercel.com**
2. Click **"Sign Up"** or **"Login"**
3. Choose **"Continue with GitHub"**
4. Authorize Vercel to access your GitHub account

---

### 2. Import Your Project

1. On Vercel Dashboard, click **"Add New..."** → **"Project"**
2. Find and select **`tamarEurovisionProject`** from your repositories
3. Click **"Import"**

---

### 3. Configure Project Settings

You'll see the "Configure Project" screen:

**Root Directory:**
- Click "Edit" next to Root Directory
- Enter: `tamarProject/tamarProject`
- ✅ This tells Vercel where your HTML files are

**Framework Preset:**
- Leave as: `Other` (or select if auto-detected)

**Build Settings:**
- Build Command: (leave empty)
- Output Directory: (leave empty - Vercel auto-detects)
- Install Command: (leave empty)

**Environment Variables:**
- None needed for your project

---

### 4. Deploy!

1. Click **"Deploy"** button
2. Wait 30-60 seconds while Vercel builds your site
3. 🎉 You'll see "Congratulations" when done!

---

### 5. Access Your Live Site

Your site will be live at a URL like:
```
https://tamar-eurovision-project.vercel.app
```

Or you might see:
```
https://tamar-eurovision-project-[random].vercel.app
```

---

## 🎨 Customize Your Domain

### Change the Vercel subdomain:

1. Go to **Project Settings** → **Domains**
2. Click **"Edit"** next to your domain
3. Change it to something like:
   - `israel-eurovision.vercel.app`
   - `eurovision-journey.vercel.app`
   - `tamar-eurovision.vercel.app`

### Add a custom domain (optional):

If you own a domain like `mywebsite.com`:
1. Click **"Add"** in Domains section
2. Enter your domain
3. Follow DNS setup instructions

---

## ⚙️ Project Configuration

I've created a `vercel.json` file with optimal settings:
- ✅ Sets correct output directory
- ✅ Redirects root to home page
- ✅ Optimized for static site

---

## 🎬 Video Background Note

The video file (`eurovision-background.mov` - 233MB) is in `.gitignore` and won't be deployed.

**Options:**

### Option 1: Remove Video (Simplest)
The site will work perfectly without it - you have beautiful animated shapes!

### Option 2: Use a Background Image
Replace with a static Eurovision image - faster loading!

### Option 3: Compress Video
```bash
# Install FFmpeg first: brew install ffmpeg
ffmpeg -i images/eurovision/eurovision-background.mov \
       -vcodec libx264 -crf 28 -preset fast \
       -vf "scale=1280:-2" \
       images/eurovision/eurovision-bg-compressed.mp4
```

Then update `home-preview.html` to use the compressed version.

### Option 4: YouTube Embed
Use a Eurovision video from YouTube (free, no storage needed!)

---

## 📊 Vercel Features You Get (FREE):

✅ **Automatic Deployments**
- Every `git push` auto-deploys
- Preview URLs for every branch

✅ **HTTPS/SSL**
- Automatic secure connection

✅ **Global CDN**
- Fast loading worldwide

✅ **Analytics** (optional)
- See visitor stats

✅ **Zero Configuration**
- Just works!

---

## 🔄 Update Your Site

After deployment, any changes you make:

1. **Edit your code locally**
2. **Commit:** `git commit -m "Update"`
3. **Push:** `git push origin main`
4. **Vercel auto-deploys** in 30 seconds!

---

## 🐛 Troubleshooting

### Pages not showing?
- Check Root Directory is set to: `tamarProject/tamarProject`
- Verify file names match exactly (case-sensitive)

### Video not loading?
- Expected - it's in `.gitignore`
- See video options above

### 404 errors?
- Check `vercel.json` is in repository root
- Redeploy from Vercel dashboard

---

## 📱 Share Your Site

Once live, you can share:
```
https://your-project.vercel.app/home-preview.html
```

Or just the domain (redirects to home):
```
https://your-project.vercel.app
```

---

## 🎯 Next Steps After Deployment

1. ✅ Test all pages on live site
2. ✅ Share link with friends/classmates
3. ✅ Show to teacher for school project
4. ✅ Add to your portfolio/resume!

---

## 💡 Pro Tips

- **Preview Deployments**: Every branch gets its own URL for testing
- **Instant Rollback**: Can revert to any previous deployment
- **Edge Functions**: If you need server-side code later (advanced)

---

## Need Help?

- Vercel Docs: https://vercel.com/docs
- Support: https://vercel.com/support

Your Eurovision website will be live and accessible worldwide in minutes! 🌍✨
