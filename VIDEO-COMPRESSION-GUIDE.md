# Video Compression Guide for Eurovision Background

## Quick Method: Online Video Compressor (No Installation Needed!)

### Option 1: Online Converter (Easiest - 2 minutes)

1. **Go to:** https://www.freeconvert.com/video-compressor
   
2. **Upload your video:**
   - Click "Choose Files"
   - Select: `/Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject/images/eurovision/eurovision-background.mov`
   
3. **Settings:**
   - Target Size: Set to 10-20 MB
   - Or use "Compress by %" - try 95% compression
   
4. **Click "Compress Now"**
   
5. **Download** the compressed file
   
6. **Save as:** `eurovision-background-compressed.mp4`
   
7. **Move to:** `/Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject/images/eurovision/`

---

### Option 2: CloudConvert (High Quality)

1. **Go to:** https://cloudconvert.com/mov-to-mp4
   
2. **Upload:** `eurovision-background.mov`
   
3. **Settings (click wrench icon):**
   - Video Codec: H.264
   - Resolution: 1280x720 (or keep original if needed)
   - Quality: Medium (or 23-28 CRF)
   - Audio: AAC, 128 kbps
   
4. **Convert** and **Download**
   
5. **Rename to:** `eurovision-background-compressed.mp4`

---

## Manual Method: Install FFmpeg and Compress

If you want to use FFmpeg (better control, better quality):

### Step 1: Install FFmpeg

Open Terminal and run:

```bash
# Install Homebrew first (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install FFmpeg
brew install ffmpeg
```

**Note:** This may take 5-10 minutes and requires admin password.

### Step 2: Compress the Video

Once FFmpeg is installed, run this command:

```bash
cd /Users/pinhasy/Downloads/tamarEurovisionProject/tamarProject/tamarProject/images/eurovision

ffmpeg -i eurovision-background.mov \
  -vcodec libx264 \
  -crf 28 \
  -preset fast \
  -vf "scale=1280:-2" \
  -acodec aac \
  -b:a 128k \
  eurovision-background-compressed.mp4
```

**What this does:**
- `-crf 28` - Compression quality (18-28 is good, higher = smaller file)
- `scale=1280:-2` - Reduces resolution to 1280px width (keeps aspect ratio)
- `-preset fast` - Faster encoding
- Output: MP4 format (more compatible than MOV)

**Expected result:**
- Original: ~233 MB
- Compressed: ~10-30 MB (depending on settings)

### Step 3: Alternative - More Aggressive Compression

For an even smaller file (5-10 MB):

```bash
ffmpeg -i eurovision-background.mov \
  -vcodec libx264 \
  -crf 32 \
  -preset fast \
  -vf "scale=960:-2" \
  -acodec aac \
  -b:a 96k \
  eurovision-background-compressed.mp4
```

---

## After Compression: Update HTML File

Once you have the compressed file, I'll update `home-preview.html` to use it.

**Current code:**
```html
<source src="images/eurovision/eurovision-background.mov" type="video/mp4">
```

**Will change to:**
```html
<source src="images/eurovision/eurovision-background-compressed.mp4" type="video/mp4">
```

---

## Quick Comparison

| Method | Time | Quality | Size | Difficulty |
|--------|------|---------|------|------------|
| **Online (FreeConvert)** | 2-5 min | Good | 10-20 MB | ⭐ Easy |
| **Online (CloudConvert)** | 3-7 min | Better | 15-30 MB | ⭐ Easy |
| **FFmpeg** | 10+ min | Best | Custom | ⭐⭐ Medium |

---

## Recommendation

**For fastest deployment:**
1. Use **FreeConvert** (online, no installation)
2. Set target size to **15-20 MB**
3. Download the compressed file
4. Save as `eurovision-background-compressed.mp4` in the images folder
5. Tell me when done - I'll update the HTML!

**Or:** Just remove the video - your animated shapes look amazing! ✨

---

## Next Steps

Once you compress the video:

1. Save compressed file to: `images/eurovision/eurovision-background-compressed.mp4`
2. Let me know - I'll update the HTML code
3. Git add, commit, push
4. Deploy to Vercel!

🎬 Your site will have a beautiful background video at a fraction of the size!
