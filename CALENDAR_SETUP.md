# Calendar Management System Setup Guide

## Overview
Your website has a complete calendar event management system with server-side integration. Events are automatically saved to your web server and displayed on the public website.

## Quick Start

### 1. Deploy to Your Server
See **DEPLOYMENT_GUIDE.md** for detailed FTP upload instructions.

**Required files**:
- `index.html` - Main website
- `login.html` - Admin login
- `admin.html` - Admin panel
- `save-events.ashx` - Server save handler (ASP.NET)
- `calendar-events.json` - Event data
- All image files

### 2. Access the Admin Panel
- Open `http://boskruintennis.co.za/login.html` in your browser
- Password: `BoskruinAdmin2025`

### 3. Manage Events
- **Add Event**: Click "Add New Event" button
- **Edit Event**: Click "Edit" on any event card
- **Delete Event**: Click "Delete" on any event card

When you save changes, they are **automatically saved to the server**!

## How It Works

1. **Admin Panel** (admin.html)
   - Protected by login (session-based)
   - Manages events in a user-friendly interface
   - Saves changes directly to server via ASP.NET

2. **Server Integration**
   - `save-events.ashx` handles saving the JSON file
   - Automatically creates backup on each save
   - Instant updates (no rebuild wait time)

3. **Public Display**
   - Main website loads events from `calendar-events.json`
   - Shows next 6 upcoming events
   - Automatically filters out past events
   - Color-coded by event type

## Event Types

- **Social**: Blue - Social tennis sessions
- **Ladies**: Pink - Ladies' tennis group
- **Coaching**: Orange - Coaching sessions
- **Tournament**: Purple - Tournaments and competitions
- **Other**: Yellow - Other events

## Recurring Events

Supported patterns:
- Weekly (any day of the week)
- Multiple days (e.g., Tuesday & Thursday)
- One-time events

## Fallback Option

If server save fails (permissions issue, network error, etc.):
- The system will **automatically download** the JSON file
- You can manually upload it via FTP
- No data is lost!

## Security Notes

⚠️ **Important Security Information**:

1. **Password Security**: The admin password (`BoskruinAdmin2025`) is hardcoded in three files:
   - `login.html`
   - `admin.html`
   - `save-events.ashx`

2. **Change the Password**: Edit all three files and replace `BoskruinAdmin2025` with your own secure password

3. **File Permissions**: Ensure `calendar-events.json` has write permissions (usually 644 or 666)

4. **Hide Admin Access**: Consider renaming `login.html` to something less obvious

5. **Server Security**: The ASP.NET handler validates the password before saving events

## Troubleshooting

### Events not saving to server
- Check file permissions on `calendar-events.json` (should be writable)
- Verify `save-events.ashx` was uploaded correctly
- Check browser console (F12) for error messages
- Contact hosting support to verify ASP.NET is enabled

### Events not appearing on website
- Hard refresh your browser (Ctrl+F5 or Cmd+Shift+R)
- Clear browser cache
- Check that `calendar-events.json` contains the events (via FTP)

### "Permission denied" error
- Contact Absolute Hosting support
- Ask them to set write permissions for `calendar-events.json`
- Or use Plesk File Manager to change permissions to 666

### Download JSON instead of auto-save
- This happens when the server save fails
- Upload the downloaded file via FTP manually
- Check that `save-events.ashx` exists on the server

## Files Created

- `index.html` - Main website with calendar display
- `login.html` - Admin login page
- `admin.html` - Calendar management interface
- `save-events.ashx` - ASP.NET server save handler
- `calendar-events.json` - Event data storage
- `CALENDAR_SETUP.md` - This file
- `DEPLOYMENT_GUIDE.md` - FTP deployment instructions

## Accessing the System

- **Public Calendar**: Visit http://boskruintennis.co.za
- **Admin Login**: http://boskruintennis.co.za/login.html (keep this URL private)
- **Admin Panel**: Automatically redirected after login

## Recommended Workflow

1. Login to admin panel
2. Add/edit events as needed
3. Events automatically save to server
4. Public website shows updated events immediately

## Support

If you encounter issues:
1. See **DEPLOYMENT_GUIDE.md** for detailed troubleshooting
2. Check the browser console for errors (F12 → Console tab)
3. Verify file permissions on the server
4. Contact Absolute Hosting support for server issues
5. Try the manual download option as a backup

---

**Happy event management!** 🎾
