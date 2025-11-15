# Deployment Guide - Boskruin Tennis Club Website

## FTP Upload Instructions

### Your FTP Credentials
- **FTP Server**: `ftp.boskruintennis.co.za` or `boskruintennis.co.za.host-za.com`
- **Username**: `boskruin`
- **Password**: `3H35.SoXpw(xH8`
- **Hosting**: Absolute Hosting - Windows NVMe Silver Package

### Files to Upload

Upload ALL files from this project to your web hosting root directory:

#### Required Files:
```
index.html                    - Main website
login.html                    - Admin login page
admin.html                    - Calendar management panel
save-events.ashx              - Server-side save handler (ASP.NET)
calendar-events.json          - Event data
calendar-events.backup.json   - Backup file (created automatically)

Images:
20250720_072619.jpg
waynekets.jpg
jaysoncerovich.jpg
jdta.jpg
```

#### Documentation (optional):
```
CALENDAR_SETUP.md
DEPLOYMENT_GUIDE.md
```

---

## Step-by-Step FTP Upload

### Option 1: Using FileZilla (Recommended Free FTP Client)

1. **Download FileZilla**: https://filezilla-project.org/download.php?type=client

2. **Connect to your server**:
   - Host: `ftp.boskruintennis.co.za`
   - Username: `boskruin`
   - Password: `3H35.SoXpw(xH8`
   - Port: `21` (default)
   - Click "Quickconnect"

3. **Upload files**:
   - On the left side: Navigate to your local project folder
   - On the right side: You should see your server's root directory (usually `httpdocs` or `wwwroot`)
   - Select all files from your local folder
   - Drag and drop them to the server folder
   - Click "OK" on any overwrite prompts

4. **Verify**:
   - Check that all files appear on the server
   - Ensure `save-events.ashx` is uploaded

### Option 2: Using Windows File Explorer

1. **Open File Explorer**
2. **Enter in address bar**: `ftp://boskruin@ftp.boskruintennis.co.za`
3. **Enter password** when prompted: `3H35.SoXpw(xH8`
4. **Copy all files** from your local folder to the FTP window

### Option 3: Using Web-based File Manager

1. **Log in** to your Absolute Hosting control panel (Plesk)
2. **Go to** File Manager
3. **Navigate** to your website's root directory
4. **Upload** all files using the web interface

---

## After Upload

### 1. Test Your Website

Visit: `http://boskruintennis.co.za` or `https://www.boskruintennis.co.za`

You should see your tennis club website.

### 2. Test Calendar Display

- Scroll down to the "Calendar" section
- You should see upcoming events displayed

### 3. Test Admin Panel

**IMPORTANT: Keep this URL private!**

1. Visit: `http://boskruintennis.co.za/login.html`
2. Login with password: `BoskruinAdmin2025`
3. You should be redirected to the admin panel
4. Try adding a test event
5. Click "Save" - events should save automatically to the server
6. Refresh your main website to see the new event

---

## File Permissions (Important!)

The `save-events.ashx` file needs to be able to write to `calendar-events.json`.

### Check Permissions in Plesk:

1. Go to **File Manager**
2. Right-click `calendar-events.json`
3. Select **Change Permissions**
4. Ensure the file is writable by the web server
5. Recommended permissions: `644` or `666` (if 644 doesn't work)

### If you get "Permission Denied" errors:

1. Contact Absolute Hosting support
2. Ask them to ensure the IIS Application Pool user has write permissions to `calendar-events.json`
3. Or use the Plesk File Manager to set write permissions

---

## Troubleshooting

### Calendar events don't save

**Problem**: Click save, but events don't persist

**Solutions**:
1. Check file permissions on `calendar-events.json` (see above)
2. Open browser Developer Console (F12) → Console tab
3. Look for error messages
4. If you see CORS errors, the file might not have uploaded correctly

### Admin login doesn't work

**Problem**: Can't login to admin panel

**Solutions**:
1. Ensure password is exactly: `BoskruinAdmin2025`
2. Clear browser cache and cookies
3. Try a different browser
4. Check that `login.html` uploaded correctly

### Events save but don't appear on website

**Problem**: Events show in admin but not on public site

**Solutions**:
1. Hard refresh the main website (Ctrl+F5 or Cmd+Shift+R)
2. Clear browser cache
3. Check that `calendar-events.json` contains the events (view in File Manager)
4. Ensure `index.html` uploaded correctly

### Save-events.ashx returns 404

**Problem**: "Failed to save to server" error

**Solutions**:
1. Verify `save-events.ashx` uploaded to the root directory
2. Check that ASP.NET is enabled in your hosting control panel
3. Contact Absolute Hosting to confirm ASP.NET handlers are working
4. File extension must be `.ashx` (not `.txt` or `.ashx.txt`)

### Calendar shows old events

**Problem**: Past events still displaying

**Solution**: This is normal - the calendar automatically filters out past events. If you see old events, they might have future dates set incorrectly.

---

## Security Recommendations

### 1. Change the Admin Password

**Current password** is hardcoded in three places:
- `login.html` (line ~216)
- `save-events.ashx` (line ~11)
- `admin.html` (line ~739)

**To change it**:
1. Edit all three files
2. Replace `BoskruinAdmin2025` with your new password
3. Re-upload the modified files
4. Keep it strong and secret!

### 2. Hide Admin URLs

Consider these options:
1. Rename `login.html` to something obscure (e.g., `admin-xyz123.html`)
2. Remember to update the link in `admin.html` logout function
3. Don't link to the admin panel from your public website
4. Only share the URL with authorized administrators

### 3. Regular Backups

The system automatically creates `calendar-events.backup.json` when saving. Consider:
1. Periodically downloading this backup via FTP
2. Storing it somewhere safe (Dropbox, Google Drive, etc.)
3. Setting up automated backups if Absolute Hosting offers them

---

## Contact Support

**Absolute Hosting Support**:
- Website: https://www.absolutehosting.co.za
- Email: support@absolutehosting.co.za
- Phone: Check their website for current number

**Common questions to ask support**:
- "Can you confirm ASP.NET handlers (.ashx) are enabled for my account?"
- "Can you set write permissions for the calendar-events.json file?"
- "What is the correct root directory for my website files?"

---

## Quick Reference

| What | URL |
|------|-----|
| **Main Website** | http://boskruintennis.co.za |
| **Admin Login** | http://boskruintennis.co.za/login.html |
| **FTP Server** | ftp.boskruintennis.co.za |
| **Control Panel** | Usually provided by hosting (check email) |

---

## Success Checklist

After deployment, verify:

- [ ] Main website loads at boskruintennis.co.za
- [ ] Navigation menu works
- [ ] Calendar section shows events
- [ ] Login page accessible at login.html
- [ ] Can login with password
- [ ] Admin panel loads after login
- [ ] Can add/edit/delete events
- [ ] Events save automatically (no download prompt)
- [ ] New events appear on main website after refresh
- [ ] Images load correctly
- [ ] Contact form works (check Formspree setup)
- [ ] Weather widget shows current weather

---

**Deployment Complete!** 🎉

Your website is now live with full calendar management functionality!
