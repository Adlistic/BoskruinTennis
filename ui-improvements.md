# Boskruin Tennis Club - UI/UX Improvement Implementation Guide

Generated: 2026-02-06

This document contains complete implementation details for 14 UI/UX improvements to `index.html` and `admin.html`. Each item includes the CSS, HTML, and JavaScript needed, along with exact insertion points.

---

## Table of Contents

1. [Back-to-Top Button](#1-back-to-top-button)
2. [Active Nav Link Highlighting (Scroll Spy)](#2-active-nav-link-highlighting)
3. [Section Progress Indicator](#3-section-progress-indicator)
4. [Calculator Reset Button](#4-calculator-reset-button)
5. [Couple Packages Guidance](#5-couple-packages-guidance)
6. [League vs Social Comparison Table](#6-league-vs-social-comparison-table)
7. [Sticky Total / Apply Bar](#7-sticky-total--apply-bar)
10. [Month Filter for Calendar Events](#10-month-filter-for-calendar-events)
11. [Add-to-Calendar per Event](#11-add-to-calendar-per-event)
14. [Next Social Session Countdown](#14-next-social-session-countdown)
15. [Better Form Confirmation](#15-better-form-confirmation)
18. [Tennis Weather Indicator](#18-tennis-weather-indicator)
22. [Mobile Section Quick-Nav](#22-mobile-section-quick-nav)
24. [Add/Delete Coaches in Admin](#24-adddelete-coaches-in-admin)

---

## 1. Back-to-Top Button

**What:** A floating button that appears after scrolling down, smoothly scrolls back to top when clicked.

### CSS (add inside the `<style>` block, after `.whatsapp-float` styles)

```css
/* Back to Top Button */
.back-to-top {
    position: fixed;
    bottom: 100px;
    right: 2rem;
    width: 45px;
    height: 45px;
    background: var(--primary-color);
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    box-shadow: 0 4px 15px rgba(13, 79, 79, 0.3);
    opacity: 0;
    visibility: hidden;
    transform: translateY(20px);
    transition: all 0.3s ease;
    z-index: 999;
}

.back-to-top.visible {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.back-to-top:hover {
    background: var(--secondary-color);
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(13, 79, 79, 0.4);
}
```

### HTML (add just before `</body>`, after the WhatsApp float `<a>`)

```html
<button class="back-to-top" id="backToTop" title="Back to top">
    <i class="fas fa-chevron-up"></i>
</button>
```

### JavaScript (add inside the main `<script>` block, after the navbar scroll listener)

```javascript
// Back to Top Button
const backToTopBtn = document.getElementById('backToTop');
window.addEventListener('scroll', function() {
    if (window.scrollY > 500) {
        backToTopBtn.classList.add('visible');
    } else {
        backToTopBtn.classList.remove('visible');
    }
});

backToTopBtn.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});
```

---

## 2. Active Nav Link Highlighting

**What:** The current section's nav link gets highlighted as the user scrolls through the page.

### CSS (add inside the `<style>` block, after `.nav-menu a` styles)

```css
.nav-menu a.active-section {
    color: var(--accent-color) !important;
    font-weight: 600;
}

.nav-menu a.active-section::after {
    content: '';
    position: absolute;
    bottom: -4px;
    left: 0;
    width: 100%;
    height: 2px;
    background: var(--accent-color);
    border-radius: 1px;
}
```

### JavaScript (add inside the main `<script>` block, after the back-to-top code)

```javascript
// Scroll Spy - Active Nav Highlighting
const navLinks = document.querySelectorAll('.nav-menu a[href^="#"]');
const sections = [];
navLinks.forEach(link => {
    const href = link.getAttribute('href');
    if (href && href !== '#' && !link.classList.contains('nav-cta')) {
        const section = document.querySelector(href);
        if (section) sections.push({ element: section, link: link });
    }
});

function updateActiveNav() {
    const scrollPos = window.scrollY + 120;
    let currentSection = null;
    sections.forEach(s => {
        if (s.element.offsetTop <= scrollPos) {
            currentSection = s;
        }
    });
    navLinks.forEach(link => link.classList.remove('active-section'));
    if (currentSection) {
        currentSection.link.classList.add('active-section');
    }
}

window.addEventListener('scroll', updateActiveNav);
updateActiveNav();
```

---

## 3. Section Progress Indicator

**What:** A thin progress bar at the very top of the page showing how far the user has scrolled.

### CSS (add inside the `<style>` block)

```css
/* Scroll Progress Bar */
.scroll-progress {
    position: fixed;
    top: 0;
    left: 0;
    height: 3px;
    background: linear-gradient(90deg, var(--accent-color), var(--secondary-color));
    z-index: 1001;
    transition: width 0.1s linear;
    width: 0%;
}
```

### HTML (add as the very first child inside `<body>`, before `<nav>`)

```html
<div class="scroll-progress" id="scrollProgress"></div>
```

### JavaScript (add inside the main `<script>` block)

```javascript
// Scroll Progress Bar
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', function() {
    const scrollTop = window.scrollY;
    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    const scrollPercent = (scrollTop / docHeight) * 100;
    progressBar.style.width = scrollPercent + '%';
});
```

---

## 4. Calculator Reset Button

**What:** A "Reset" button in the calculator that clears all package selections back to zero.

### CSS (add inside the `<style>` block)

```css
/* Calculator Reset Button */
.calculator-reset {
    background: none;
    border: 2px solid var(--border-color);
    color: var(--text-light);
    padding: 0.6rem 1.5rem;
    border-radius: 8px;
    cursor: pointer;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}

.calculator-reset:hover {
    border-color: #dc3545;
    color: #dc3545;
    background: rgba(220, 53, 69, 0.05);
}
```

### HTML (insert inside the calculator section, after the `<div class="calculator-intro">` closing tag, before the calculator-form div)

Find this in `index.html` around line 2831:
```html
<p>Customize your membership package to fit your needs</p>
</div>
```

Add after it:
```html
<div style="text-align: right; margin-bottom: 1rem;">
    <button class="calculator-reset" onclick="resetCalculator()">
        <i class="fas fa-undo"></i> Reset All
    </button>
</div>
```

### JavaScript (add inside the main `<script>` block, after `calculateTotal` function)

```javascript
// Reset Calculator
function resetCalculator() {
    for (const type in packageCounts) {
        packageCounts[type] = 0;
        const countElement = document.getElementById(type + '-count');
        if (countElement) countElement.textContent = '0';
    }
    calculateTotal();
}
```

---

## 5. Couple Packages Guidance

**What:** A subtle info tip near the couple packages explaining when to use individual vs. couple packages.

### CSS (add inside the `<style>` block)

```css
/* Couple Help Tip */
.couple-help-tip {
    background: linear-gradient(135deg, #e8f8f0 0%, #d4f1e8 100%);
    border: 1px solid rgba(26, 128, 128, 0.2);
    border-radius: 10px;
    padding: 1rem 1.25rem;
    margin: 0.5rem 0 1rem;
    font-size: 0.85rem;
    color: var(--primary-color);
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
}

.couple-help-tip i {
    font-size: 1.1rem;
    margin-top: 0.1rem;
    color: var(--secondary-color);
    flex-shrink: 0;
}

.couple-help-tip strong {
    display: block;
    margin-bottom: 0.25rem;
}
```

### HTML (insert after the `adultSocial` package-item div, before the `coupleLeague` package-item div)

Find the closing `</div>` of the `adultSocial` counter area (around line 2871) and add after it:

```html
<div class="couple-help-tip">
    <i class="fas fa-lightbulb"></i>
    <div>
        <strong>Couples save more together</strong>
        Married or living-together couples can save R950-R1,450 per year compared to two individual memberships. Choose a Couple package below instead of selecting two individual Adult packages.
    </div>
</div>
```

---

## 6. League vs Social Comparison Table

**What:** A visual comparison showing the difference between League and Social membership benefits.

### CSS (add inside the `<style>` block)

```css
/* Membership Comparison Table */
.membership-comparison {
    background: white;
    border-radius: 15px;
    padding: 2rem;
    margin-top: 2rem;
    box-shadow: var(--shadow);
    overflow: hidden;
}

.membership-comparison h3 {
    text-align: center;
    color: var(--primary-color);
    margin-bottom: 1.5rem;
    font-size: 1.2rem;
}

.comparison-table {
    width: 100%;
    border-collapse: collapse;
}

.comparison-table th {
    padding: 0.75rem 1rem;
    text-align: center;
    font-weight: 600;
    font-size: 0.95rem;
}

.comparison-table th:first-child {
    text-align: left;
    width: 40%;
}

.comparison-table th.league-col {
    background: var(--primary-color);
    color: white;
    border-radius: 8px 8px 0 0;
}

.comparison-table th.social-col {
    background: var(--secondary-color);
    color: white;
    border-radius: 8px 8px 0 0;
}

.comparison-table td {
    padding: 0.6rem 1rem;
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
    font-size: 0.9rem;
}

.comparison-table td:first-child {
    text-align: left;
    color: var(--text-dark);
    font-weight: 500;
}

.comparison-table tr:last-child td {
    border-bottom: none;
}

.comparison-table .check {
    color: var(--success-color);
    font-size: 1.1rem;
}

.comparison-table .cross {
    color: #ccc;
    font-size: 1.1rem;
}

@media (max-width: 768px) {
    .membership-comparison {
        padding: 1rem;
    }
    .comparison-table td,
    .comparison-table th {
        padding: 0.5rem 0.5rem;
        font-size: 0.8rem;
    }
}
```

### HTML (insert after the closing `</div>` of `.calculator-container` and before the closing `</div>` of the `.container`, around line 3049)

Find this block (around line 3045-3048):
```html
<div style="display: grid; gap: 1rem; margin-top: 2rem;">
    <button onclick="openMembershipModal()" ...>Apply for Membership</button>
</div>
```

Add after the closing `</div>` of `.calculator-form` (line ~3048), but still inside `<div class="calculator-container">`:

```html
<div class="membership-comparison">
    <h3><i class="fas fa-balance-scale"></i> League vs Social - What's the Difference?</h3>
    <table class="comparison-table">
        <thead>
            <tr>
                <th>Benefit</th>
                <th class="league-col"><i class="fas fa-trophy"></i> League</th>
                <th class="social-col"><i class="fas fa-user"></i> Social</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Free court usage</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-check check"></i></td>
            </tr>
            <tr>
                <td>Court key & light box access</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-check check"></i></td>
            </tr>
            <tr>
                <td>Online court booking (SportyHQ)</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-check check"></i></td>
            </tr>
            <tr>
                <td>Social tennis sessions</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-check check"></i></td>
            </tr>
            <tr>
                <td>Club Championships entry</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-check check"></i></td>
            </tr>
            <tr>
                <td>Regional league matches (GCTA)</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-times cross"></i></td>
            </tr>
            <tr>
                <td>TSA/GTA league registration</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-times cross"></i></td>
            </tr>
            <tr>
                <td>Represent club in team matches</td>
                <td><i class="fas fa-check check"></i></td>
                <td><i class="fas fa-times cross"></i></td>
            </tr>
        </tbody>
    </table>
</div>
```

---

## 7. Sticky Total / Apply Bar

**What:** When the user scrolls past the calculator total, a sticky bar appears at the bottom showing the current total and an "Apply" button.

### CSS (add inside the `<style>` block)

```css
/* Sticky Total Bar */
.sticky-total-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: var(--primary-color);
    color: white;
    padding: 0.75rem 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 2rem;
    z-index: 998;
    transform: translateY(100%);
    transition: transform 0.3s ease;
    box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.15);
}

.sticky-total-bar.visible {
    transform: translateY(0);
}

.sticky-total-bar .sticky-total-amount {
    font-family: 'Poppins', sans-serif;
    font-size: 1.3rem;
    font-weight: 700;
}

.sticky-total-bar .sticky-total-label {
    font-size: 0.85rem;
    opacity: 0.9;
}

.sticky-total-bar .sticky-apply-btn {
    background: var(--accent-color);
    color: var(--primary-color);
    border: none;
    padding: 0.6rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.sticky-total-bar .sticky-apply-btn:hover {
    background: var(--accent-hover);
    transform: translateY(-1px);
}

@media (max-width: 768px) {
    .sticky-total-bar {
        padding: 0.6rem 1rem;
        gap: 1rem;
    }
    .sticky-total-bar .sticky-total-amount {
        font-size: 1.1rem;
    }
}
```

### HTML (add just before `</body>`)

```html
<div class="sticky-total-bar" id="stickyTotalBar">
    <div>
        <div class="sticky-total-label">Total Membership</div>
        <div class="sticky-total-amount" id="stickyTotalAmount">R0</div>
    </div>
    <button class="sticky-apply-btn" onclick="openMembershipModal()">
        Apply Now <i class="fas fa-arrow-right"></i>
    </button>
</div>
```

### JavaScript (modify `calculateTotal()` to update sticky bar, and add visibility logic)

Add this at the end of the `calculateTotal()` function, just before the closing `}`:

```javascript
    // Update sticky total bar
    const stickyAmount = document.getElementById('stickyTotalAmount');
    if (stickyAmount) {
        stickyAmount.textContent = 'R' + grandTotal.toLocaleString('en-US');
    }
```

Add this observer code in the main `<script>` block:

```javascript
// Sticky Total Bar visibility
const stickyBar = document.getElementById('stickyTotalBar');
const priceSummary = document.querySelector('.price-summary');
const membershipSection = document.getElementById('membership');

if (priceSummary && stickyBar) {
    const stickyObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            // Show sticky bar when price summary is NOT visible AND we have selections
            const hasSelections = Object.values(packageCounts).some(c => c > 0);
            if (!entry.isIntersecting && hasSelections) {
                // Check if we're in the membership section area
                const rect = membershipSection.getBoundingClientRect();
                if (rect.top < 0 && rect.bottom > 0) {
                    stickyBar.classList.add('visible');
                } else {
                    stickyBar.classList.remove('visible');
                }
            } else {
                stickyBar.classList.remove('visible');
            }
        });
    }, { threshold: 0.1 });

    stickyObserver.observe(priceSummary);

    // Also hide when scrolling away from membership section
    window.addEventListener('scroll', function() {
        if (stickyBar.classList.contains('visible')) {
            const rect = membershipSection.getBoundingClientRect();
            if (rect.bottom < 0 || rect.top > window.innerHeight) {
                stickyBar.classList.remove('visible');
            }
        }
    });
}
```

---

## 10. Month Filter for Calendar Events

**What:** Filter buttons above the calendar allowing users to filter events by month.

### CSS (add inside the `<style>` block)

```css
/* Month Filter Buttons */
.month-filter-container {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
    margin-bottom: 1.5rem;
}

.month-filter-btn {
    padding: 0.4rem 1rem;
    border: 2px solid var(--border-color);
    background: white;
    border-radius: 20px;
    cursor: pointer;
    font-size: 0.85rem;
    font-weight: 500;
    color: var(--text-light);
    transition: all 0.3s ease;
}

.month-filter-btn:hover {
    border-color: var(--secondary-color);
    color: var(--secondary-color);
}

.month-filter-btn.active {
    background: var(--primary-color);
    color: white;
    border-color: var(--primary-color);
}
```

### HTML (insert inside the calendar section, after the view toggle div and before `calendarGrid`)

Find around line 3301 (`</div>` closing the view toggle wrapper) and add:

```html
<div class="month-filter-container" id="monthFilterContainer">
    <!-- Populated dynamically from available event months -->
</div>
```

### JavaScript (modify `loadCalendarEvents` and add filter functions)

Replace the `loadCalendarEvents` function with:

```javascript
let activeMonthFilter = 'all';

async function loadCalendarEvents() {
    try {
        const response = await fetch('calendar-events.json?v=' + Date.now());
        const events = await response.json();

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        calendarUpcomingEvents = events
            .filter(event => new Date(event.date) >= today)
            .sort((a, b) => new Date(a.date) - new Date(b.date));

        buildMonthFilters(calendarUpcomingEvents);
        renderCalendarEvents(getFilteredEvents());
    } catch (error) {
        console.error('Error loading calendar events:', error);
        document.getElementById('calendarEmpty').style.display = 'block';
        document.getElementById('calendarGrid').style.display = 'none';
    }
}

function buildMonthFilters(events) {
    const container = document.getElementById('monthFilterContainer');
    if (!container || events.length === 0) return;

    const months = new Set();
    events.forEach(e => {
        const d = new Date(e.date);
        months.add(d.getFullYear() + '-' + String(d.getMonth()).padStart(2, '0'));
    });

    const sorted = Array.from(months).sort();
    let html = '<button class="month-filter-btn active" onclick="filterByMonth(\'all\')">All</button>';
    sorted.forEach(key => {
        const [year, month] = key.split('-');
        const label = new Date(year, month).toLocaleDateString('en-ZA', { month: 'short', year: 'numeric' });
        html += '<button class="month-filter-btn" onclick="filterByMonth(\'' + key + '\')">' + label + '</button>';
    });
    container.innerHTML = html;
}

function filterByMonth(key) {
    activeMonthFilter = key;
    document.querySelectorAll('.month-filter-btn').forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    renderCalendarEvents(getFilteredEvents());
}

function getFilteredEvents() {
    if (activeMonthFilter === 'all') return calendarUpcomingEvents;
    const [year, month] = activeMonthFilter.split('-');
    return calendarUpcomingEvents.filter(e => {
        const d = new Date(e.date);
        return d.getFullYear() === parseInt(year) && d.getMonth() === parseInt(month);
    });
}
```

Also update `switchPublicView` to use `getFilteredEvents()`:

```javascript
function switchPublicView(view) {
    currentCalendarView = view;
    localStorage.setItem('calendarView', view);
    document.getElementById('gridViewBtnPublic').classList.toggle('active', view === 'grid');
    document.getElementById('tableViewBtnPublic').classList.toggle('active', view === 'table');
    renderCalendarEvents(getFilteredEvents());
}
```

---

## 11. Add-to-Calendar per Event

**What:** Each event card/row gets a small "Add to Calendar" button that generates a `.ics` file download.

### CSS (add inside the `<style>` block)

```css
/* Add to Calendar Button */
.add-to-cal-btn {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    padding: 0.3rem 0.75rem;
    background: rgba(13, 79, 79, 0.08);
    color: var(--primary-color);
    border: 1px solid rgba(13, 79, 79, 0.2);
    border-radius: 6px;
    font-size: 0.75rem;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-top: 0.75rem;
}

.add-to-cal-btn:hover {
    background: var(--primary-color);
    color: white;
}
```

### JavaScript (add a helper function, then modify grid/table render functions)

Add this helper function:

```javascript
function generateICS(event) {
    const date = new Date(event.date);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    let startTime = '090000';
    let endTime = '100000';
    if (event.time) {
        const [h, m] = event.time.split(':');
        startTime = h.padStart(2, '0') + m.padStart(2, '0') + '00';
        const endHour = (parseInt(h) + 2) % 24;
        endTime = String(endHour).padStart(2, '0') + m.padStart(2, '0') + '00';
    }

    const dtStart = year + month + day + 'T' + startTime;
    const dtEnd = year + month + day + 'T' + endTime;

    const ics = [
        'BEGIN:VCALENDAR',
        'VERSION:2.0',
        'PRODID:-//Boskruin Tennis Club//Events//EN',
        'BEGIN:VEVENT',
        'DTSTART;TZID=Africa/Johannesburg:' + dtStart,
        'DTEND;TZID=Africa/Johannesburg:' + dtEnd,
        'SUMMARY:' + event.title,
        'DESCRIPTION:' + (event.description || '').replace(/\n/g, '\\n'),
        'LOCATION:Boskruin Tennis Club\\, Kelly Road\\, Boskruin\\, Johannesburg',
        'END:VEVENT',
        'END:VCALENDAR'
    ].join('\r\n');

    const blob = new Blob([ics], { type: 'text/calendar;charset=utf-8' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = event.title.replace(/[^a-zA-Z0-9]/g, '_') + '.ics';
    link.click();
    URL.revokeObjectURL(link.href);
}
```

Modify `renderCalendarGridView` - add the button inside each card, after the description and recurring badge:

In the grid card template, add before the closing `</div>` of the card:

```javascript
// Add this line to the grid card template string, after the recurring-badge section:
`<button class="add-to-cal-btn" onclick="generateICS(calendarUpcomingEvents.find(e => e.title === '${event.title.replace(/'/g, "\\'")}'))">
    <i class="fas fa-calendar-plus"></i> Add to Calendar
</button>`
```

**Full updated `renderCalendarGridView`:**

```javascript
function renderCalendarGridView(events, grid) {
    grid.innerHTML = events.map((event, idx) => `
        <div class="calendar-event ${event.type}">
            <span class="event-type-badge ${event.type}">${formatEventType(event.type)}</span>
            <h3>${event.title}</h3>
            <div class="event-meta">
                <div class="event-meta-item">
                    <i class="fas fa-calendar"></i>
                    <span>${formatEventDate(event.date)}</span>
                </div>
                ${event.time ? `
                <div class="event-meta-item">
                    <i class="fas fa-clock"></i>
                    <span>${formatEventTime(event.time)}</span>
                </div>
                ` : ''}
                ${event.organizer ? `
                <div class="event-meta-item">
                    <i class="fas fa-users"></i>
                    <span>${event.organizer}</span>
                </div>
                ` : ''}
            </div>
            ${event.description ? `<div class="event-description">${event.description}</div>` : ''}
            ${event.recurring !== 'none' ? `
                <div class="recurring-badge">
                    <i class="fas fa-redo"></i>
                    <span>${formatRecurringPattern(event.recurring)}</span>
                </div>
            ` : ''}
            <button class="add-to-cal-btn" onclick='generateICS(${JSON.stringify(event).replace(/'/g, "&#39;")})'>
                <i class="fas fa-calendar-plus"></i> Add to Calendar
            </button>
        </div>
    `).join('');
}
```

For the table view, add a column:

Add `<th>Actions</th>` to the table header, and add a cell to `renderCalendarTableView`:

```javascript
function renderCalendarTableView(events, tableBody) {
    tableBody.innerHTML = events.map(event => `
        <tr>
            <td class="event-title-cell">${event.title}</td>
            <td>${event.organizer || '-'}</td>
            <td><span class="event-type-cell ${event.type}">${formatEventType(event.type)}</span></td>
            <td>${formatEventDate(event.date)}</td>
            <td>${event.time ? formatEventTime(event.time) : 'TBD'}</td>
            <td style="max-width: 300px;">${event.description || '-'}</td>
            <td>
                <button class="add-to-cal-btn" onclick='generateICS(${JSON.stringify(event).replace(/'/g, "&#39;")})'>
                    <i class="fas fa-calendar-plus"></i>
                </button>
            </td>
        </tr>
    `).join('');
}
```

Also add `<th>Actions</th>` to the `<thead>` in the HTML (line ~3316).

---

## 14. Next Social Session Countdown

**What:** A countdown banner in the Social Tennis section showing time until the next session.

### CSS (add inside the `<style>` block)

```css
/* Social Countdown */
.social-countdown {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border-radius: 15px;
    padding: 1.5rem 2rem;
    text-align: center;
    margin-bottom: 2rem;
    box-shadow: var(--shadow-lg);
}

.social-countdown h3 {
    font-size: 1rem;
    font-weight: 500;
    opacity: 0.9;
    margin-bottom: 0.5rem;
}

.countdown-timer {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin: 0.75rem 0;
}

.countdown-unit {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.countdown-value {
    font-family: 'Poppins', sans-serif;
    font-size: 2rem;
    font-weight: 700;
    line-height: 1;
}

.countdown-label {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    opacity: 0.8;
    margin-top: 0.25rem;
}

.countdown-session-name {
    font-size: 0.95rem;
    opacity: 0.9;
    margin-top: 0.25rem;
}

@media (max-width: 768px) {
    .countdown-value { font-size: 1.5rem; }
    .countdown-timer { gap: 1rem; }
}
```

### HTML (insert inside the `#social` section, after the section-header `</div>` and before `<div class="social-grid">`)

Find around line 3161:
```html
</div>
<div class="social-grid">
```

Insert between them:
```html
<div class="social-countdown" id="socialCountdown">
    <h3>Next Social Session</h3>
    <div class="countdown-timer" id="countdownTimer"></div>
    <div class="countdown-session-name" id="countdownSessionName"></div>
</div>
```

### JavaScript (add inside the main `<script>` block)

```javascript
// Social Session Countdown
function updateSocialCountdown() {
    const now = new Date();
    const currentDay = now.getDay(); // 0=Sun, 1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat

    const sessions = [
        { day: 2, hour: 18, minute: 0, name: 'Tuesday Evening Social', label: 'Tue 6:00 PM' },
        { day: 6, hour: 14, minute: 0, name: 'Saturday Afternoon Social', label: 'Sat 2:00 PM' }
    ];

    let nextSession = null;
    let minDiff = Infinity;

    sessions.forEach(session => {
        let daysUntil = session.day - currentDay;
        if (daysUntil < 0) daysUntil += 7;

        const sessionDate = new Date(now);
        sessionDate.setDate(now.getDate() + daysUntil);
        sessionDate.setHours(session.hour, session.minute, 0, 0);

        // If today is the session day but the time has passed, go to next week
        if (sessionDate <= now) {
            sessionDate.setDate(sessionDate.getDate() + 7);
        }

        const diff = sessionDate - now;
        if (diff < minDiff) {
            minDiff = diff;
            nextSession = { ...session, date: sessionDate, diff: diff };
        }
    });

    if (!nextSession) return;

    const totalSeconds = Math.floor(nextSession.diff / 1000);
    const days = Math.floor(totalSeconds / 86400);
    const hours = Math.floor((totalSeconds % 86400) / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    const timerEl = document.getElementById('countdownTimer');
    const nameEl = document.getElementById('countdownSessionName');

    if (timerEl) {
        timerEl.innerHTML =
            (days > 0 ? '<div class="countdown-unit"><span class="countdown-value">' + days + '</span><span class="countdown-label">Days</span></div>' : '') +
            '<div class="countdown-unit"><span class="countdown-value">' + hours + '</span><span class="countdown-label">Hours</span></div>' +
            '<div class="countdown-unit"><span class="countdown-value">' + minutes + '</span><span class="countdown-label">Min</span></div>' +
            '<div class="countdown-unit"><span class="countdown-value">' + seconds + '</span><span class="countdown-label">Sec</span></div>';
    }

    if (nameEl) {
        nameEl.innerHTML = '<i class="fas fa-tennis-ball"></i> ' + nextSession.name + ' - ' + nextSession.label;
    }
}

updateSocialCountdown();
setInterval(updateSocialCountdown, 1000);
```

---

## 15. Better Form Confirmation

**What:** After successfully sending the contact form, replace the form with a friendly "thank you" state instead of just showing a small message.

### CSS (add inside the `<style>` block)

```css
/* Form Success State */
.form-success-state {
    text-align: center;
    padding: 3rem 2rem;
    animation: fadeInUp 0.5s ease;
}

.form-success-state .success-icon {
    width: 80px;
    height: 80px;
    background: var(--success-color);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1.5rem;
    font-size: 2rem;
    color: white;
    animation: scaleIn 0.5s ease 0.2s both;
}

.form-success-state h3 {
    color: var(--primary-color);
    font-size: 1.4rem;
    margin-bottom: 0.5rem;
}

.form-success-state p {
    color: var(--text-light);
    margin-bottom: 1rem;
}

.form-success-state .send-another-btn {
    background: none;
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
    padding: 0.6rem 1.5rem;
    border-radius: 8px;
    cursor: pointer;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    margin-top: 1rem;
}

.form-success-state .send-another-btn:hover {
    background: var(--primary-color);
    color: white;
}

@keyframes scaleIn {
    from { transform: scale(0); }
    to { transform: scale(1); }
}

@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}
```

### JavaScript (modify `sendContactEmail` success handler)

Replace the `.then(function() {...})` success callback in `sendContactEmail` with:

```javascript
.then(function() {
    // Replace form with success state
    const formContainer = document.querySelector('.contact-form');
    formContainer.innerHTML = `
        <div class="form-success-state">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h3>Message Sent!</h3>
            <p>Thank you for reaching out. We'll get back to you within 24 hours.</p>
            <p style="font-size: 0.85rem;">You can also reach us directly via WhatsApp at <a href="https://wa.me/27837031434" style="color: var(--secondary-color); font-weight: 600;">083 703 1434</a></p>
            <button class="send-another-btn" onclick="location.reload()">
                <i class="fas fa-envelope"></i> Send Another Message
            </button>
        </div>
    `;
}, function(error) {
```

---

## 18. Tennis Weather Indicator

**What:** A compact "Good to Play" / "Not Ideal" indicator near the compact weather widget, based on conditions.

### CSS (add inside the `<style>` block)

```css
/* Tennis Weather Indicator */
.tennis-weather-indicator {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    margin-top: 1rem;
    padding: 0.6rem 1.5rem;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
    max-width: 350px;
    margin-left: auto;
    margin-right: auto;
}

.tennis-weather-indicator.good {
    background: linear-gradient(135deg, rgba(40, 167, 69, 0.1) 0%, rgba(40, 167, 69, 0.05) 100%);
    color: #28a745;
    border: 1px solid rgba(40, 167, 69, 0.2);
}

.tennis-weather-indicator.moderate {
    background: linear-gradient(135deg, rgba(255, 193, 7, 0.1) 0%, rgba(255, 193, 7, 0.05) 100%);
    color: #d4a017;
    border: 1px solid rgba(255, 193, 7, 0.2);
}

.tennis-weather-indicator.poor {
    background: linear-gradient(135deg, rgba(220, 53, 69, 0.1) 0%, rgba(220, 53, 69, 0.05) 100%);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
}
```

### HTML (add inside the compact weather section, after `#compactWeatherWidget`)

Find around line 2523-2524:
```html
</div>
</div>
```

Add between the `</div>` of `compactWeatherWidget` and the `</div>` of the container:

```html
<div id="tennisWeatherIndicator"></div>
```

### JavaScript (modify `displayCompactWeather` to add the indicator)

Add this at the end of the `displayCompactWeather` function:

```javascript
// Tennis playability indicator
const indicator = document.getElementById('tennisWeatherIndicator');
if (indicator) {
    const code = current.weather_code;
    const wind = current.wind_speed_10m;
    const temp = current.temperature_2m;

    let status, statusClass, icon;

    // Rain or thunderstorm
    if ([51, 53, 55, 61, 63, 65, 80, 81, 82, 95, 96, 99].includes(code)) {
        status = 'Not ideal for tennis - rain expected';
        statusClass = 'poor';
        icon = 'fa-umbrella';
    }
    // Very windy (over 30 km/h)
    else if (wind > 30) {
        status = 'Windy conditions - play with caution';
        statusClass = 'moderate';
        icon = 'fa-wind';
    }
    // Very cold (under 10) or very hot (over 35)
    else if (temp < 10 || temp > 35) {
        status = temp < 10 ? 'Cold - dress warmly for tennis' : 'Very hot - stay hydrated';
        statusClass = 'moderate';
        icon = temp < 10 ? 'fa-temperature-low' : 'fa-temperature-high';
    }
    // Good conditions
    else {
        status = 'Great conditions for tennis!';
        statusClass = 'good';
        icon = 'fa-tennis-ball';
    }

    indicator.innerHTML = '<div class="tennis-weather-indicator ' + statusClass + '">' +
        '<i class="fas ' + icon + '"></i> ' + status + '</div>';
}
```

---

## 22. Mobile Section Quick-Nav

**What:** On mobile, floating dot indicators on the right side showing which section is active and allowing quick jumps.

### CSS (add inside the `<style>` block)

```css
/* Mobile Quick Nav Dots */
.mobile-quick-nav {
    display: none;
    position: fixed;
    right: 0.5rem;
    top: 50%;
    transform: translateY(-50%);
    z-index: 997;
    flex-direction: column;
    gap: 0.6rem;
    padding: 0.5rem;
}

.quick-nav-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: rgba(13, 79, 79, 0.2);
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 0;
    position: relative;
}

.quick-nav-dot.active {
    background: var(--accent-color);
    transform: scale(1.3);
    box-shadow: 0 0 8px rgba(200, 210, 0, 0.4);
}

.quick-nav-dot .dot-tooltip {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    background: var(--primary-color);
    color: white;
    padding: 0.3rem 0.6rem;
    border-radius: 4px;
    font-size: 0.7rem;
    white-space: nowrap;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.2s ease;
}

.quick-nav-dot:hover .dot-tooltip,
.quick-nav-dot:focus .dot-tooltip {
    opacity: 1;
}

@media (max-width: 768px) {
    .mobile-quick-nav {
        display: flex;
    }
}
```

### HTML (add just before `</body>`)

```html
<nav class="mobile-quick-nav" id="mobileQuickNav">
    <button class="quick-nav-dot" data-section="benefits" onclick="document.getElementById('benefits').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Why Join</span>
    </button>
    <button class="quick-nav-dot" data-section="membership" onclick="document.getElementById('membership').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Membership</span>
    </button>
    <button class="quick-nav-dot" data-section="coaching" onclick="document.getElementById('coaching').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Coaching</span>
    </button>
    <button class="quick-nav-dot" data-section="social" onclick="document.getElementById('social').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Social</span>
    </button>
    <button class="quick-nav-dot" data-section="calendar" onclick="document.getElementById('calendar').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Events</span>
    </button>
    <button class="quick-nav-dot" data-section="weather" onclick="document.getElementById('weather').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Weather</span>
    </button>
    <button class="quick-nav-dot" data-section="contact" onclick="document.getElementById('contact').scrollIntoView({behavior:'smooth'})">
        <span class="dot-tooltip">Contact</span>
    </button>
</nav>
```

### JavaScript (add inside the main `<script>` block)

```javascript
// Mobile Quick Nav - update active dot on scroll
const quickNavDots = document.querySelectorAll('.quick-nav-dot');
const quickNavSections = ['benefits', 'membership', 'coaching', 'social', 'calendar', 'weather', 'contact'];

function updateQuickNav() {
    const scrollPos = window.scrollY + window.innerHeight / 2;
    let currentId = '';

    quickNavSections.forEach(id => {
        const el = document.getElementById(id);
        if (el && el.offsetTop <= scrollPos) {
            currentId = id;
        }
    });

    quickNavDots.forEach(dot => {
        dot.classList.toggle('active', dot.dataset.section === currentId);
    });
}

window.addEventListener('scroll', updateQuickNav);
updateQuickNav();
```

---

## 24. Add/Delete Coaches in Admin

**What:** Add ability to create new coaches and delete existing ones from the admin panel (currently only edit is supported).

### Changes to `admin.html`

#### CSS (add inside the admin `<style>` block)

```css
/* Add Coach Button */
.btn-add-coach {
    background: var(--primary);
    color: white;
    border: none;
    padding: 0.6rem 1.2rem;
    border-radius: 8px;
    cursor: pointer;
    font-size: 0.9rem;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    transition: all 0.3s ease;
    margin-bottom: 1.5rem;
}

.btn-add-coach:hover {
    background: var(--primary-dark);
    transform: translateY(-1px);
}

/* Delete Button on Coach Cards */
.btn-delete {
    background: none;
    border: 1px solid var(--danger);
    color: var(--danger);
    padding: 0.4rem 0.8rem;
    border-radius: 8px;
    cursor: pointer;
    font-size: 0.85rem;
    transition: all 0.2s ease;
}

.btn-delete:hover {
    background: var(--danger);
    color: white;
}

/* Delete Confirmation Modal */
.confirm-modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1100;
    display: none;
    align-items: center;
    justify-content: center;
}

.confirm-modal-overlay.show {
    display: flex;
}

.confirm-modal {
    background: white;
    border-radius: 15px;
    padding: 2rem;
    max-width: 400px;
    text-align: center;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.confirm-modal h3 {
    margin-bottom: 0.5rem;
    color: var(--danger);
}

.confirm-modal p {
    color: #666;
    margin-bottom: 1.5rem;
}

.confirm-modal-actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
}

.confirm-modal-actions button {
    padding: 0.5rem 1.5rem;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
    border: none;
    transition: all 0.2s ease;
}

.btn-confirm-cancel {
    background: #f0f0f0;
    color: #666;
}

.btn-confirm-cancel:hover {
    background: #e0e0e0;
}

.btn-confirm-delete {
    background: var(--danger);
    color: white;
}

.btn-confirm-delete:hover {
    background: #c0392b;
}
```

#### HTML - Add "Add Coach" button

Find the coaches tab content area (the `<div class="tab-content" id="coachesTab">`). Add this button before `<div id="coachesAdminGrid">`:

```html
<button class="btn-add-coach" onclick="addNewCoach()">
    <i class="fas fa-plus"></i> Add New Coach
</button>
<div id="coachesAdminGrid" class="coaches-admin-grid">
```

#### HTML - Delete Confirmation Modal

Add before `</body>` in admin.html:

```html
<div class="confirm-modal-overlay" id="deleteConfirmModal">
    <div class="confirm-modal">
        <h3><i class="fas fa-exclamation-triangle"></i> Delete Coach</h3>
        <p>Are you sure you want to delete <strong id="deleteCoachName"></strong>? This action cannot be undone.</p>
        <div class="confirm-modal-actions">
            <button class="btn-confirm-cancel" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn-confirm-delete" onclick="confirmDeleteCoach()">Delete</button>
        </div>
    </div>
</div>
```

#### JavaScript - Modify `renderCoaches()` to include delete button

Update the coach card actions section to include a delete button:

```javascript
function renderCoaches() {
    const grid = document.getElementById('coachesAdminGrid');
    if (coaches.length === 0) {
        grid.innerHTML = '<div class="empty-state"><i class="fas fa-user-friends"></i><h3>No Coaches</h3><p>No coach data found. Click "Add New Coach" to get started.</p></div>';
        return;
    }

    grid.innerHTML = coaches.map(coach => {
        const imageHtml = coach.image
            ? '<img src="' + coach.image + '" alt="' + coach.name + '">'
            : '<i class="fas fa-user-tie"></i>';
        const feesHtml = coach.pricing.map(p =>
            '<div><span>' + p.label + '</span><span>' + p.price + '</span></div>'
        ).join('');
        return '<div class="coach-admin-card">' +
            '<div class="coach-admin-image">' + imageHtml + '</div>' +
            '<div class="coach-admin-body">' +
                '<h3>' + coach.name + '</h3>' +
                '<p class="coach-admin-title">' + coach.title + '</p>' +
                '<div class="coach-admin-fees">' + feesHtml + '</div>' +
            '</div>' +
            '<div class="coach-admin-actions">' +
                '<button class="btn-edit" onclick="editCoach(' + coach.id + ')">' +
                    '<i class="fas fa-edit"></i> Edit' +
                '</button>' +
                '<button class="btn-delete" onclick="promptDeleteCoach(' + coach.id + ')">' +
                    '<i class="fas fa-trash"></i> Delete' +
                '</button>' +
            '</div>' +
        '</div>';
    }).join('');
}
```

#### JavaScript - Add New Coach function

```javascript
function addNewCoach() {
    editingCoachId = null;
    pendingImageFile = null;

    document.getElementById('coachModalTitle').textContent = 'Add New Coach';
    document.getElementById('coachId').value = '';
    document.getElementById('coachName').value = '';
    document.getElementById('coachTitle').value = '';
    document.getElementById('coachBio').value = '';
    document.getElementById('coachWhatsapp').value = '';
    document.getElementById('coachPricingHeader').value = 'Coaching Fees';

    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '<i class="fas fa-cloud-upload-alt"></i><p>Click or drag to upload image (JPG, PNG, WebP - max 5MB)</p>';

    document.getElementById('coachImageFile').value = '';
    renderPricingRows([{ label: '', price: '' }]);

    document.getElementById('coachModal').classList.add('show');
}
```

#### JavaScript - Delete Coach functions

```javascript
let pendingDeleteCoachId = null;

function promptDeleteCoach(id) {
    pendingDeleteCoachId = id;
    const coach = coaches.find(c => c.id === id);
    if (!coach) return;

    document.getElementById('deleteCoachName').textContent = coach.name;
    document.getElementById('deleteConfirmModal').classList.add('show');
}

function closeDeleteModal() {
    document.getElementById('deleteConfirmModal').classList.remove('show');
    pendingDeleteCoachId = null;
}

async function confirmDeleteCoach() {
    if (pendingDeleteCoachId === null) return;

    coaches = coaches.filter(c => c.id !== pendingDeleteCoachId);
    closeDeleteModal();
    renderCoaches();

    // Save to server
    try {
        const response = await fetch('save-coaches.ashx', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Admin-Password': 'BoskruinAdmin2025'
            },
            body: JSON.stringify(coaches)
        });
        const result = await response.json();
        if (!result.success) {
            alert('Warning: Changes may not have saved to the server.');
        }
    } catch (error) {
        console.error('Error saving after delete:', error);
        alert('Warning: Could not save to server. Changes are local only.');
    }
}
```

#### JavaScript - Modify `saveCoaches` to handle new coaches

In the existing `saveCoaches()` function (inside the form submit handler), modify the logic to handle creating vs editing:

```javascript
// Inside the form submit handler, replace the coach update logic with:
const formCoachId = document.getElementById('coachId').value;

if (formCoachId) {
    // Editing existing coach
    const idx = coaches.findIndex(c => c.id === parseInt(formCoachId));
    if (idx !== -1) {
        coaches[idx].name = document.getElementById('coachName').value;
        coaches[idx].title = document.getElementById('coachTitle').value;
        coaches[idx].bio = document.getElementById('coachBio').value;
        coaches[idx].whatsapp = document.getElementById('coachWhatsapp').value;
        coaches[idx].pricingHeader = document.getElementById('coachPricingHeader').value;
        coaches[idx].pricing = Array.from(document.querySelectorAll('.pricing-row-item')).map(row => ({
            label: row.querySelector('.pricing-label').value,
            price: row.querySelector('.pricing-price').value
        })).filter(p => p.label && p.price);
    }
} else {
    // Adding new coach
    const newId = coaches.length > 0 ? Math.max(...coaches.map(c => c.id)) + 1 : 1;
    const newCoach = {
        id: newId,
        name: document.getElementById('coachName').value,
        title: document.getElementById('coachTitle').value,
        bio: document.getElementById('coachBio').value,
        image: '',
        whatsapp: document.getElementById('coachWhatsapp').value,
        pricingHeader: document.getElementById('coachPricingHeader').value,
        pricing: Array.from(document.querySelectorAll('.pricing-row-item')).map(row => ({
            label: row.querySelector('.pricing-label').value,
            price: row.querySelector('.pricing-price').value
        })).filter(p => p.label && p.price)
    };
    coaches.push(newCoach);
    editingCoachId = newId;
    document.getElementById('coachId').value = newId;
}
```

---

## Implementation Order (Recommended)

1. Items 1, 2, 3 (scroll-related: back-to-top, scroll spy, progress bar) - purely additive, no conflicts
2. Items 4, 5, 6, 7 (calculator area: reset, couple tip, comparison table, sticky bar) - all in membership section
3. Items 10, 11 (calendar: month filter, add-to-calendar) - calendar section modifications
4. Item 14 (social countdown) - standalone addition
5. Item 15 (form confirmation) - modifies one function
6. Item 18 (tennis weather indicator) - extends existing weather code
7. Item 22 (mobile quick-nav) - purely additive
8. Item 24 (admin coaches add/delete) - separate file (admin.html)

---

## Notes

- All CSS uses existing CSS variables from `:root` for consistency
- All JavaScript uses vanilla JS (no frameworks) matching the existing codebase
- The `.nav-menu a` needs `position: relative` added to its existing styles for the scroll-spy underline to work (item 2)
- Item 7 (sticky bar) works best when item 4 (reset) is also implemented
- Item 10 (month filter) replaces the `loadCalendarEvents` function entirely
- Item 24 (admin) modifies `admin.html` only - `index.html` is unaffected
