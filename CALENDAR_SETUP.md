# Calendar Management System Setup Guide

## Overview
Your website now has a complete calendar event management system with GitHub API integration. Events are automatically saved to your GitHub repository and displayed on the public website.

## Quick Start

### 1. Access the Admin Panel
- Open `login.html` in your browser
- Password: `BoskruinAdmin2025`

### 2. Configure GitHub Integration (One-time setup)

#### Step 1: Create a GitHub Personal Access Token
1. Go to: https://github.com/settings/tokens/new
2. Token name: `Calendar Admin`
3. Expiration: Choose your preferred expiration (recommend 90 days or 1 year)
4. Select scopes:
   - For **public repositories**: Check `public_repo`
   - For **private repositories**: Check entire `repo` scope
5. Click "Generate token"
6. **IMPORTANT**: Copy the token immediately (you won't see it again!)

#### Step 2: Configure Settings in Admin Panel
1. Click the **Settings** button in the admin panel
2. Enter your information:
   - **GitHub Username/Organization**: `Adlistic` (or your username)
   - **Repository Name**: `BoskruinTennis`
   - **Branch**: `main` or `gh-pages` (whichever you're using for GitHub Pages)
   - **Personal Access Token**: Paste the token you just created
3. Click **Save Settings**

### 3. Manage Events
- **Add Event**: Click "Add New Event" button
- **Edit Event**: Click "Edit" on any event card
- **Delete Event**: Click "Delete" on any event card

When you save changes, they will be **automatically committed to GitHub**!

## How It Works

1. **Admin Panel** (admin.html)
   - Protected by login (session-based)
   - Manages events in a user-friendly interface
   - Commits changes directly to GitHub via API

2. **GitHub Integration**
   - Saves `calendar-events.json` to your repository
   - Creates a commit with timestamp
   - GitHub Pages automatically updates within 1-2 minutes

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

If GitHub API fails (wrong token, network issues, etc.):
- The system will **automatically download** the JSON file
- You can manually upload it to your repository
- No data is lost!

## Security Notes

⚠️ **Important Security Information**:

1. **Token Storage**: Your GitHub token is stored in browser localStorage
2. **Token Permissions**: Only grant minimum required permissions (`public_repo` for public repos)
3. **Token Expiration**: Set an expiration date and renew when needed
4. **Revoke if Needed**: You can revoke the token anytime at: https://github.com/settings/tokens

5. **Password Security**: The admin password (`BoskruinAdmin2025`) is hardcoded in JavaScript. Anyone who views the source code can see it. This is acceptable for low-security internal use, but consider changing it if needed.

## Troubleshooting

### Events not saving to GitHub
- Check that your token hasn't expired
- Verify repository name, owner, and branch are correct
- Ensure token has correct permissions
- Check browser console for error messages

### Events not appearing on website
- Wait 1-2 minutes for GitHub Pages to rebuild
- Hard refresh your browser (Ctrl+F5 or Cmd+Shift+R)
- Check that `calendar-events.json` exists in your repository

### "Failed to get file info" error
- Verify the branch name is correct
- Check that the repository exists and is accessible
- Ensure the token has the right permissions

### Download JSON instead of auto-save
- This happens when GitHub settings aren't configured
- Click "Settings" and enter your GitHub credentials
- Or continue using manual download/upload method

## Files Created

- `login.html` - Admin login page
- `admin.html` - Calendar management interface
- `calendar-events.json` - Event data storage
- `index.html` - Main website with calendar display
- `CALENDAR_SETUP.md` - This file

## Accessing the System

- **Public Calendar**: Visit your main website, click "Calendar" in navigation
- **Admin Login**: Open `login.html` (keep this URL private)
- **Admin Panel**: Automatically redirected after login

## Recommended Workflow

1. Login to admin panel
2. Add/edit events as needed
3. Events automatically save to GitHub
4. GitHub Pages rebuilds (1-2 minutes)
5. Public website shows updated events

## Support

If you encounter issues:
1. Check the browser console for errors (F12 → Console tab)
2. Verify your GitHub token is valid and has correct permissions
3. Ensure the repository settings are correct
4. Try the manual download option as a backup

---

**Happy event management!** 🎾
