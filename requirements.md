# Footer Component Feature Requirements

## 1. Feature Overview

### Description
Implement a persistent, responsive footer that appears on all pages of the Union Shop app. The footer presents two content columns on desktop/tablet and stacks vertically on mobile (≤800px). It provides opening hours information and help & information actions (Search and Terms & Conditions of Sale Policy).

### Purpose
- Provide consistent access to opening hours and help resources across the app.
- Improve usability by exposing search and policy access at the site-wide footer.
- Ensure accessibility and responsiveness consistent with the app’s design system.

### Technical Context
- New reusable widget: `AppFooter` in `lib/widgets/app_footer.dart`.
- Shared layout: `AppScaffold` wraps pages to include `AppHeader`, page body, and `AppFooter`.
- All views updated to use `AppScaffold(child: ...)`.
- Theme: primary purple `#4d2963`.
- Responsive breakpoint: 800px for mobile vs desktop/tablet.
- New routes:
  - `/search` → `SearchPage`
  - `/policies/terms` → `TermsAndConditionsPage`

---

## 2. User Stories

### US-F1: See Footer on All Pages
As a visitor on any page,
I want to see a consistent footer at the bottom,
So that I can quickly find opening hours and help information.

Acceptance Criteria:
- Footer is visible on all views: Home, Collections, Sale, About, Product, Category, Print Shack About, Personalisation.
- Footer respects page theming and spacing.

---

### US-F2: View Opening Hours
As a user browsing the site,
I want to view the shop’s opening hours,
So that I know when the shop is open.

Acceptance Criteria:
- Column title "Opening hours" is visible.
- Static items:
  - Monday–Friday: 9:00–17:00
  - Saturday: 10:00–16:00
  - Sunday: Closed
- Text is selectable for copy.
- Content is readable with sufficient contrast.

---

### US-F3: Use Help & Information – Search
As a user needing to find items or content,
I want to use the Search action in the footer,
So that I can quickly locate products or pages.

Acceptance Criteria:
- Column title "Help & information" is visible.
- Search button is clearly labeled "Search" and styled with purple background, white text.
- On tap/click:
  - navigates to `/search` route showing `SearchPage` with an input field.

---

### US-F4: Use Help & Information – Terms & Conditions of Sale Policy
As a user seeking policy details,
I want to open the Terms & Conditions of Sale Policy,
So that I can read the sales terms before purchasing.

Acceptance Criteria:
- Terms button labeled "Terms & Conditions of Sale".
- Styled as OutlinedButton or TextButton with purple color/border.
- On tap/click: navigates to `/policies/terms` route showing `TermsAndConditionsPage`.

---

### US-F5: Responsive Layout
As a user on different devices,
I want the footer to adapt layout,
So that the content is easy to read and use on any screen size.

Acceptance Criteria:
- Desktop/tablet (>800px): 2-column layout using Row with spacing.
- Mobile (≤800px): stacked Column layout with vertical spacing.
- Controls maintain minimum touch target size (≥44x44).

---

### US-F6: Accessibility
As an accessibility-focused user,
I want meaningful labels and proper semantics,
So that assistive technologies can interpret the footer correctly.

Acceptance Criteria:
- Semantic headings for "Opening hours" and "Help & information".
- Buttons have clear accessible labels: "Search", "Terms & Conditions of Sale".
- Contrast meets WCAG AA for text on background.
- Focus order is logical; buttons are focusable.

---

## 3. Functional Requirements

### FR-F1: Layout and Styling
- FR-F1.1: Footer background: `Colors.grey[200]`, text: `Colors.black87`.
- FR-F1.2: Column titles: fontSize 18, fontWeight bold.
- FR-F1.3: Spacing: 24px vertical padding, 16px between items, 32px column gap (desktop).
- FR-F1.4: Responsive switch via `LayoutBuilder` or `MediaQuery.width`: breakpoint at 800px.

### FR-F2: Opening Hours Content
- FR-F2.1: Static list of opening times as specified in US-F2.
- FR-F2.2: Text selectable; no interaction beyond copy.
- FR-F2.3: Proper semantics grouping.

### FR-F3: Help & Information Actions
- FR-F3.1: Search button:
  - ElevatedButton with `backgroundColor: Color(0xFF4d2963)`, white text.
  - OnPressed:
    - `Navigator.pushNamed(context, '/search')`.
- FR-F3.2: Terms button:
  - OutlinedButton or TextButton with purple styling.
  - OnPressed: `Navigator.pushNamed(context, '/policies/terms')`.

### FR-F4: Integration Across Pages
- FR-F4.1: Create `AppScaffold` in `lib/widgets/app_scaffold.dart` rendering `AppHeader`, page `child`, and `AppFooter`.
- FR-F4.2: Update all views in `lib/views/*.dart` to use `AppScaffold(child: ...)`.

### FR-F5: Routes
- FR-F5.1: Register `/search` → `SearchPage` placeholder (title "Search" and TextField).
- FR-F5.2: Register `/policies/terms` → `TermsAndConditionsPage` placeholder (title "Terms & Conditions of Sale").

### FR-F6: Accessibility
- FR-F6.1: Add `Semantics` for section titles and buttons.
- FR-F6.2: Ensure focusable controls and logical tab order.
- FR-F6.3: Maintain contrast for text/background.

---

## 4. Non-Functional Requirements

### NFR-F1: Performance
- Footer renders quickly and does not introduce jank.
- No heavy operations on build; static content prefers const widgets.

### NFR-F2: Maintainability
- Footer encapsulated in `AppFooter` for reuse.
- All pages standardize on `AppScaffold`.
- Clear comments and consistent naming.

### NFR-F3: Responsiveness
- Works from 320px to 2560px widths.
- No horizontal overflow on mobile.

---

## 5. Acceptance Criteria Summary

The feature is complete when:
- [ ] Footer visible on all pages via `AppScaffold`.
- [ ] Desktop/tablet uses two-column layout; mobile stacks vertically.
- [ ] Column 1 shows opening hours exactly as specified.
- [ ] Column 2 shows "Help & information" with:
  - [ ] Search button opening SearchDelegate or `/search`.
  - [ ] Terms button navigating to `/policies/terms`.
- [ ] Buttons meet minimum touch size and accessible labels.
- [ ] Styling matches theme: purple `#4d2963` for primary action.
- [ ] Routes `/search` and `/policies/terms` are registered and render placeholder pages.
- [ ] Accessibility semantics present for headings and buttons.
- [ ] No layout overflows at common widths; mobile and desktop verified.

### Subtasks
- [ ] Implement `AppFooter` (layout, styling, semantics).
- [ ] Implement `AppScaffold` and migrate all views.
- [ ] Add `/search` and `/policies/terms` routes and placeholder pages.
- [ ] Write widget tests:
  - Footer presence on all pages.
  - Responsive layout check at widths 600px and 1200px.
  - Button navigation behavior for Search and Terms.
  - Accessibility labels existence.
