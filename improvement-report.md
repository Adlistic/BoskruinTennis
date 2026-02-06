# Boskruin Tennis Club - Website Improvement Report

Generated: 2026-02-06 | Based on code analysis of index.html (174KB), admin.html, login.html

---

## Priority 1: Critical (Accessibility)

- [ ] **No ARIA labels anywhere** - 0 `aria-*` attributes found across the entire site
  - Counter +/- buttons have no label for screen readers
  - Modals missing `role="dialog"` and `aria-modal="true"`
  - FAQ toggle buttons missing `aria-expanded`
  - Mobile menu toggle missing `aria-expanded` and `aria-controls`
- [ ] **No skip-to-content link** - keyboard users must tab through entire navbar
- [ ] **No focus trap in modals** - Tab key escapes the membership and contact modals
- [ ] **No Escape key handler** - modals can't be closed via keyboard
- [ ] **FAQ not keyboard accessible** - uses `onclick` only, no `keydown` handler for Enter/Space
- [ ] **32 inline `onclick` handlers** - should use event listeners for better accessibility

## Priority 2: High Impact (SEO)

- [ ] **No Open Graph tags** - links shared on Facebook/WhatsApp/LinkedIn show no preview image or description
  - Add: `og:title`, `og:description`, `og:image`, `og:url`, `og:type`
- [ ] **No Twitter Card tags** - same issue for Twitter/X sharing
- [ ] **No canonical URL** - add `<link rel="canonical">`
- [ ] **No Schema.org structured data** - add JSON-LD for:
  - `SportsActivityLocation` (the club)
  - `Event` (calendar events)
  - `LocalBusiness` (contact info, hours)
- [ ] **No sitemap.xml** or robots.txt
- [ ] **No favicon** - `<link rel="icon">` is missing

## Priority 3: High Impact (Performance)

- [ ] **174KB single HTML file** with ~2,400 lines of inline CSS and ~1,300 lines of inline JS
  - Extract CSS to `styles.css` - enables browser caching
  - Extract JS to `scripts.js` - enables browser caching
  - After extraction, HTML drops to ~30KB, CSS and JS are cached on repeat visits
- [ ] **No lazy loading on images** - 0 images have `loading="lazy"`
  - Coach images, Google Maps iframe, and Instagram embed should all lazy-load
- [ ] **Oversized images**:
  - `20250720_072619.jpg` - **2.3MB** (appears unused on the public site?)
  - `waynekets.jpg` - 115KB (could compress to ~40KB)
  - `jdta.jpg` - 87KB (could compress to ~30KB)
- [ ] **Cache-busting on every load** - `calendar-events.json?v=${Date.now()}` defeats caching entirely. Use a versioned query string instead.

## Priority 4: Moderate (UX & Functionality)

- [ ] **Membership modal has no focus management** - opening the modal doesn't move focus into it
- [ ] **No form error messages** - relies solely on HTML5 validation bubbles which are inconsistent across browsers
- [ ] **EmailJS public key exposed in source** - not a security risk per se (it's a client-side key) but worth noting
- [ ] **Weather animations may impact performance on mobile** - rain/snow/cloud CSS animations run continuously with no `prefers-reduced-motion` support
- [ ] **No 404 page** - missing pages show the default server error
- [ ] **Admin password hardcoded in client JS** - visible to anyone who views source (already noted)

## Priority 5: Nice to Have

- [ ] **No print stylesheet** - printing the page produces a poor layout
- [ ] **No dark mode** - no `prefers-color-scheme` media query
- [ ] **No PWA support** - no manifest.json or service worker
- [ ] **Footer social links commented out** - either add them or remove the dead code
- [ ] **Google Analytics section tracking** exists but no conversion goals for membership applications

---

## Quick Wins (can fix in minutes)

| Fix | Impact | Effort |
|-----|--------|--------|
| Add `loading="lazy"` to images and iframes | Performance | 5 min |
| Add Open Graph meta tags | SEO/Social sharing | 10 min |
| Add `<link rel="icon" href="logo.png">` | SEO/Branding | 1 min |
| Add `aria-label` to counter buttons | Accessibility | 10 min |
| Add `role="dialog"` to modals | Accessibility | 5 min |
| Add `prefers-reduced-motion` media query | Accessibility | 5 min |
| Remove/optimize the 2.3MB unused image | Performance | 1 min |
