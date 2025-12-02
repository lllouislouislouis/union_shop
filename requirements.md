# Shop and Print Shack Dropdown Menu Feature Requirements

## 1. Feature Overview

### Description
Implement hierarchical dropdown navigation menus for the "Shop" and "The Print Shack" buttons in the AppHeader component. These menus will provide quick access to product categories and services, with distinct behavior patterns for desktop (hover-activated dropdowns) and mobile (slide-over submenu panels) viewports.

### Purpose
- **Improve Navigation**: Provide direct access to specific product categories without extra page loads
- **Enhance Discoverability**: Make all shopping categories and print services immediately visible
- **Professional UX**: Implement industry-standard dropdown navigation patterns
- **Mobile Optimization**: Provide touch-friendly navigation hierarchy for mobile users
- **Reduce Clicks**: Allow users to navigate directly to category pages from any location

### Technical Context
- **Current State**: Shop and Print Shack buttons use placeholder callbacks
- **Modified Component**: `lib/widgets/app_header.dart` will be significantly enhanced
- **New Components**: Desktop dropdown overlays, mobile submenu panels, new page templates
- **New Routes**: 9 new routes total (7 shop categories + 2 print shack pages)
- **Framework**: Flutter web with named route navigation
- **Theme**: Consistent purple (`Color(0xFF4d2963)`) across all interactive elements
- **Responsive Breakpoint**: 800px separates desktop and mobile behavior

---

## 2. User Stories

### US-1: Desktop User Accesses Shop Categories
**As a** desktop user (screen > 800px)  
**I want to** click the "Shop" button to see a dropdown menu of categories  
**So that** I can quickly navigate to the specific products I'm interested in

**Acceptance Criteria:**
- Clicking "Shop" button opens dropdown menu below the button
- Dropdown displays all 7 categories vertically
- Dropdown appears with smooth fade-in animation (150ms)
- Dropdown has white background with subtle shadow (elevation: 4)
- Each menu item shows hover effect (light purple background, purple text)
- Clicking a category navigates to the correct route and closes dropdown
- Clicking "Shop" again closes the dropdown (toggle behavior)
- Clicking outside dropdown area closes it without triggering navigation
- Pressing Escape key closes the dropdown
- Only one dropdown (Shop or Print Shack) can be open at a time

---

### US-2: Desktop User Accesses Print Shack Services
**As a** desktop user  
**I want to** click "The Print Shack" button to see available services  
**So that** I can quickly access personalization or information pages

**Acceptance Criteria:**
- Clicking "The Print Shack" button opens dropdown menu below the button
- Dropdown displays 2 menu items: "About" and "Personalisation"
- Same visual styling as Shop dropdown (white, shadow, purple accents)
- Hover effects work on both menu items
- Clicking an item navigates to correct route and closes dropdown
- If Shop dropdown is open, it closes when Print Shack dropdown opens
- All interaction patterns match Shop dropdown behavior

---

### US-3: Mobile User Accesses Shop Categories
**As a** mobile user (screen ≤ 800px)  
**I want to** tap "Shop" in the mobile menu to see a submenu of categories  
**So that** I can browse categories on my touch device

**Acceptance Criteria:**
- Tapping hamburger menu opens main mobile menu
- "Shop" appears as a tappable item in main menu
- Tapping "Shop" slides main menu out to left and submenu in from right
- Submenu displays purple header with "← Back" arrow and "Shop" title
- Submenu lists all 7 categories as full-width tappable items
- Tapping back arrow returns to main menu (slides right, main slides left)
- Tapping any category navigates to route and closes all menus
- Slide animations are smooth (250ms duration)
- Touch targets are minimum 48x48px
- Ripple effect shows on tap

---

### US-4: Mobile User Accesses Print Shack Services
**As a** mobile user  
**I want to** tap "The Print Shack" to see a submenu of services  
**So that** I can access print services from my mobile device

**Acceptance Criteria:**
- "The Print Shack" appears in main mobile menu
- Tapping it opens submenu with purple header showing "← Back" and "The Print Shack"
- Submenu displays 2 items: "About" and "Personalisation"
- Navigation animations match Shop submenu (250ms slide transitions)
- Tapping back arrow returns to main menu
- Tapping menu item navigates and closes all menus
- Touch targets are adequate (minimum 48x48px)
- Visual styling matches Shop submenu

---

### US-5: User Sees Active State Highlighting
**As a** user on a shop category page  
**I want to** see the "Shop" button highlighted in the header  
**So that** I know which section of the site I'm currently viewing

**Acceptance Criteria:**
- When current route starts with `/shop/`, "Shop" button is highlighted
- When current route starts with `/print-shack/`, "The Print Shack" button is highlighted
- Highlighted state: purple text (`Color(0xFF4d2963)`), bold font
- In dropdown, the current category item is highlighted with purple text
- Active highlighting persists when dropdown is open
- Active highlighting works on both desktop and mobile views
- Example: On `/shop/clothing` page, "Shop" button is purple and "Clothing" in dropdown has purple text

---

### US-6: Desktop User Clicks Outside Dropdown
**As a** desktop user with a dropdown open  
**I want to** click anywhere outside the dropdown to close it  
**So that** I can dismiss the menu without selecting an option

**Acceptance Criteria:**
- Clicking page background closes open dropdown
- Clicking header area (but not other buttons) closes dropdown
- Clicking other navigation buttons closes current dropdown and performs their action
- Clicking inside dropdown keeps it open
- Click outside detection doesn't interfere with other navigation
- No navigation occurs when clicking outside dropdown area

---

### US-7: Desktop User Switches Between Dropdowns
**As a** desktop user  
**I want to** click between Shop and Print Shack buttons to see different menus  
**So that** I can explore both navigation options easily

**Acceptance Criteria:**
- Clicking "The Print Shack" when Shop dropdown is open switches to Print Shack dropdown
- Clicking "Shop" when Print Shack dropdown is open switches to Shop dropdown
- Transition is smooth with no flicker
- Previous dropdown fully closes before new one opens
- Only one dropdown is ever visible at a time
- State management prevents conflicting open states

---

### US-8: Mobile User Navigates Submenu Hierarchy
**As a** mobile user  
**I want to** navigate back and forth between main menu and submenus  
**So that** I can explore options before committing to navigation

**Acceptance Criteria:**
- Main menu → Shop submenu → Back → Main menu flow works correctly
- Main menu → Print Shack submenu → Back → Main menu flow works correctly
- Back arrow always returns to previous menu level
- Main menu slides in/out from correct directions
- Submenu slides in/out from correct directions
- No menu state conflicts or visual glitches
- Animation timing is consistent (250ms)

---

### US-9: User Navigates to Category Pages
**As a** user selecting a category from dropdown/submenu  
**I want to** be taken to a page showing products in that category  
**So that** I can browse and shop for specific types of items

**Acceptance Criteria:**
- Clicking/tapping "Clothing" navigates to `/shop/clothing`
- Clicking/tapping "Merchandise" navigates to `/shop/merchandise`
- (Repeat for all 7 shop categories)
- Page displays category name as heading
- Placeholder page structure matches existing pages (header, content area)
- Category pages can be extended later with product grids
- Browser back button returns to previous page
- All dropdown/submenu menus close after navigation

---

### US-10: User Navigates to Print Shack Pages
**As a** user selecting a Print Shack service  
**I want to** be taken to the relevant information or service page  
**So that** I can learn about or use print services

**Acceptance Criteria:**
- Clicking/tapping "About" navigates to `/print-shack/about`
- Clicking/tapping "Personalisation" navigates to `/print-shack/personalisation`
- Pages display appropriate headings
- Placeholder page structure matches existing pages
- Pages can be filled with content later
- Browser back button works correctly
- All menus close after navigation

---

## 3. Functional Requirements

### FR-1: State Management Enhancement
- **FR-1.1**: Add state variables to `_AppHeaderState`:
  - `bool _isShopDropdownOpen = false`
  - `bool _isPrintShackDropdownOpen = false`
  - `bool _isMobileSubmenuOpen = false`
  - `String _currentSubmenu = ''` (values: '', 'shop', 'printshack')
- **FR-1.2**: Implement state update methods:
  - `void _toggleShopDropdown()`
  - `void _togglePrintShackDropdown()`
  - `void _closeAllDropdowns()`
  - `void _openMobileSubmenu(String submenu)`
  - `void _closeMobileSubmenu()`
- **FR-1.3**: Ensure only one dropdown open at a time on desktop
- **FR-1.4**: Track submenu navigation stack on mobile
- **FR-1.5**: Reset all dropdown states when navigating to a new page
- **FR-1.6**: Close dropdowns when window resizes across 800px breakpoint

### FR-2: Desktop Dropdown - Visual Design
- **FR-2.1**: Dropdown container with white background
- **FR-2.2**: Box shadow with elevation: 4
- **FR-2.3**: Border radius on bottom corners: 8px
- **FR-2.4**: Minimum width: 250px (or match button width if larger)
- **FR-2.5**: Position dropdown below button, aligned to left edge
- **FR-2.6**: Use Stack and Positioned widgets for overlay
- **FR-2.7**: Z-index: above page content, below modal overlays
- **FR-2.8**: Border: 1px solid grey[200] (optional, for definition)

### FR-3: Desktop Dropdown - Menu Items
- **FR-3.1**: Each item is a clickable InkWell or TextButton
- **FR-3.2**: Padding: 16px horizontal, 12px vertical
- **FR-3.3**: Font size: 14px
- **FR-3.4**: Default text color: grey[800]
- **FR-3.5**: Hover text color: purple `Color(0xFF4d2963)`
- **FR-3.6**: Hover background: light purple `Color(0xFF4d2963).withValues(alpha: 0.1)`
- **FR-3.7**: Border between items: 1px solid grey[200]
- **FR-3.8**: Active item (current page): purple text, slightly darker background
- **FR-3.9**: OnTap callback: navigate to route, close dropdown, update state
- **FR-3.10**: Cursor changes to pointer on hover

### FR-4: Desktop Dropdown - Animation
- **FR-4.1**: Create AnimationController for dropdown (duration: 150ms)
- **FR-4.2**: Implement fade-in animation using FadeTransition
- **FR-4.3**: Optional: Add slight slide-down (10-20px) combined with fade
- **FR-4.4**: Animation curve: Curves.easeOut
- **FR-4.5**: Dispose animation controller in dispose() method
- **FR-4.6**: Reverse animation when closing dropdown

### FR-5: Desktop Dropdown - Click Outside Detection
- **FR-5.1**: Wrap entire screen content in GestureDetector
- **FR-5.2**: Set behavior: HitTestBehavior.opaque on detector
- **FR-5.3**: OnTap callback checks if click is outside dropdown bounds
- **FR-5.4**: Close dropdown if click is outside
- **FR-5.5**: Don't trigger other navigation when clicking outside
- **FR-5.6**: Ensure dropdown itself absorbs pointer events (doesn't close on self-click)

### FR-7: Mobile Submenu - Visual Design
- **FR-7.1**: Full-height panel (100% viewport height)
- **FR-7.2**: Full-width or 100% viewport width
- **FR-7.3**: White background
- **FR-7.4**: Header section: 64px height, purple background `Color(0xFF4d2963)`
- **FR-7.5**: Header content: back arrow (left), submenu title (center)
- **FR-7.6**: Back arrow: white color, 24px icon size
- **FR-7.7**: Title: white text, bold, 18px font size
- **FR-7.8**: Menu items section: white background, full width items
- **FR-7.9**: Shadow or elevation: 8 (for depth perception)

### FR-8: Mobile Submenu - Menu Items
- **FR-8.1**: Each item full width of panel
- **FR-8.2**: Padding: 20px horizontal, 16px vertical
- **FR-8.3**: Font size: 16px
- **FR-8.4**: Text color: black/grey[900]
- **FR-8.5**: Border between items: 1px solid grey[200]
- **FR-8.6**: Tap ripple effect (InkWell)
- **FR-8.7**: OnTap callback: navigate to route, close all menus, update state
- **FR-8.8**: Touch target: minimum 48x48px (verify with padding)
- **FR-8.9**: Active item (current page): purple text, light purple background

### FR-9: Mobile Submenu - Animation
- **FR-9.1**: Create AnimationController for submenu (duration: 250ms)
- **FR-9.2**: Implement SlideTransition for main menu (slides left to -100% width)
- **FR-9.3**: Implement SlideTransition for submenu (slides in from right, 100% → 0%)
- **FR-9.4**: Animation curve: Curves.easeInOut
- **FR-9.5**: Reverse animations when navigating back to main menu
- **FR-9.6**: Dispose animation controller in dispose() method
- **FR-9.7**: Coordinate animations so main menu slides out as submenu slides in

### FR-10: Mobile Submenu - Navigation Stack
- **FR-10.1**: Track current menu level (main or submenu)
- **FR-10.2**: _isMobileMenuOpen tracks main menu state
- **FR-10.3**: _isMobileSubmenuOpen tracks submenu state
- **FR-10.4**: _currentSubmenu stores which submenu is open ('shop' or 'printshack')
- **FR-10.5**: Implement _openMobileSubmenu(String) to transition main → submenu
- **FR-10.6**: Implement _closeMobileSubmenu() to transition submenu → main
- **FR-10.7**: Navigating to a page closes both main menu and submenu
- **FR-10.8**: State validation prevents impossible states (both menus open, etc.)

### FR-11: Shop Button Update
- **FR-11.1**: Replace placeholder callback with _toggleShopDropdown() on desktop
- **FR-11.2**: Replace placeholder callback with _openMobileSubmenu('shop') on mobile
- **FR-11.3**: Update isActive logic: active if currentRoute starts with '/shop/'
- **FR-11.4**: Pass current dropdown state to button for visual feedback
- **FR-11.5**: Maintain existing hover/tap effects
- **FR-11.6**: Ensure button styling consistent with other nav buttons

### FR-12: Print Shack Button Update
- **FR-12.1**: Replace placeholder callback with _togglePrintShackDropdown() on desktop
- **FR-12.2**: Replace placeholder callback with _openMobileSubmenu('printshack') on mobile
- **FR-12.3**: Update isActive logic: active if currentRoute starts with '/print-shack/'
- **FR-12.4**: Pass current dropdown state to button for visual feedback
- **FR-12.5**: Maintain existing hover/tap effects
- **FR-12.6**: Ensure button styling consistent with other nav buttons

### FR-13: Dropdown Data Structure
- **FR-13.1**: Create helper class/model for menu items:
  ```dart
  class DropdownMenuItem {
    final String label;
    final String route;
    bool get isActive => currentRoute == route;
  }
  ```
- **FR-13.2**: Define Shop dropdown items list (7 items):
  - Clothing → /shop/clothing
  - Merchandise → /shop/merchandise
  - Halloween → /shop/halloween
  - Signature & Essential Range → /shop/signature-essential
  - Portsmouth City Collection → /shop/portsmouth
  - Pride Collection → /shop/pride
  - Graduation → /shop/graduation
- **FR-13.3**: Define Print Shack dropdown items list (2 items):
  - About → /print-shack/about
  - Personalisation → /print-shack/personalisation
- **FR-13.4**: Make lists accessible to both desktop dropdown and mobile submenu builders

### FR-14: Helper Method - Desktop Dropdown Builder
- **FR-14.1**: Create method: `Widget _buildDesktopDropdown(List<DropdownMenuItem> items, bool isOpen)`
- **FR-14.2**: Return null/empty if not isOpen
- **FR-14.3**: Build Column of menu items with borders
- **FR-14.4**: Apply container styling (background, shadow, border radius)
- **FR-14.5**: Wrap in AnimatedOpacity or FadeTransition
- **FR-14.6**: Position below corresponding button using Stack/Positioned
- **FR-14.7**: Reusable for both Shop and Print Shack dropdowns

### FR-15: Helper Method - Mobile Submenu Builder
- **FR-15.1**: Create method: `Widget _buildMobileSubmenu(String title, List<DropdownMenuItem> items)`
- **FR-15.2**: Build Column with purple header section (back arrow + title)
- **FR-15.3**: Build list of menu items below header
- **FR-15.4**: Wrap in Container with full height
- **FR-15.5**: Apply white background and shadow
- **FR-15.6**: Wrap in SlideTransition for animation
- **FR-15.7**: Reusable for both Shop and Print Shack submenus
- **FR-15.8**: Header back arrow triggers _closeMobileSubmenu()

### FR-16: Route Registration - Shop Categories
- **FR-16.1**: Add '/shop/clothing' route to MaterialApp routes in main.dart
- **FR-16.2**: Add '/shop/merchandise' route
- **FR-16.3**: Add '/shop/halloween' route
- **FR-16.4**: Add '/shop/signature-essential' route
- **FR-16.5**: Add '/shop/portsmouth' route
- **FR-16.6**: Add '/shop/pride' route
- **FR-16.7**: Add '/shop/graduation' route
- **FR-16.8**: Each route returns ShopCategoryPage widget with category parameter

### FR-17: Route Registration - Print Shack Pages
- **FR-17.1**: Add '/print-shack/about' route to MaterialApp routes
- **FR-17.2**: Add '/print-shack/personalisation' route
- **FR-17.3**: Each route returns respective page widget
- **FR-17.4**: Ensure routes follow existing navigation patterns

### FR-18: Shop Category Page Template
- **FR-18.1**: Create file: `lib/views/shop_category_page.dart`
- **FR-18.2**: Define ShopCategoryPage as StatelessWidget
- **FR-18.3**: Accept category parameter: `final String category`
- **FR-18.4**: Include AppHeader with currentRoute: '/shop/$category'
- **FR-18.5**: Display category name as heading (48px, purple, bold)
- **FR-18.6**: Include placeholder text: "Products for [Category] will appear here"
- **FR-18.7**: Apply white background and consistent padding
- **FR-18.8**: Structure matches HomeScreen and AboutPage layouts
- **FR-18.9**: Scrollable content area for future product grid

### FR-19: Print Shack About Page
- **FR-19.1**: Create file: `lib/views/print_shack_about_page.dart`
- **FR-19.2**: Define PrintShackAboutPage as StatelessWidget
- **FR-19.3**: Include AppHeader with currentRoute: '/print-shack/about'
- **FR-19.4**: Display "About The Print Shack" heading (48px, purple, bold)
- **FR-19.5**: Include placeholder text about print services
- **FR-19.6**: Apply consistent styling with other pages
- **FR-19.7**: Scrollable content area for future detailed content

### FR-20: Personalisation Page
- **FR-20.1**: Create file: `lib/views/personalisation_page.dart`
- **FR-20.2**: Define PersonalisationPage as StatelessWidget
- **FR-20.3**: Include AppHeader with currentRoute: '/print-shack/personalisation'
- **FR-20.4**: Display "Personalisation Services" heading (48px, purple, bold)
- **FR-20.5**: Include placeholder text about personalisation options
- **FR-20.6**: Apply consistent styling with other pages
- **FR-20.7**: Scrollable content area for future form or service details

### FR-21: Responsive Behavior Coordination
- **FR-21.1**: Use MediaQuery to determine isDesktop (width > 800px)
- **FR-21.2**: On desktop: show dropdown buttons, hide mobile menu
- **FR-21.3**: On mobile: show hamburger menu, hide dropdown buttons
- **FR-21.4**: Close all dropdowns when resizing crosses 800px threshold
- **FR-21.5**: Reset submenu state when switching to desktop view
- **FR-21.6**: Ensure no visual glitches during window resize
- **FR-21.7**: Test smooth transition between mobile and desktop layouts

### FR-22: Navigation Integration
- **FR-22.1**: Clicking dropdown item closes dropdown before navigating
- **FR-22.2**: Update _closeMobileMenu() to also close submenus
- **FR-22.3**: Ensure AppHeader currentRoute prop updates on navigation
- **FR-22.4**: Pass correct currentRoute to AppHeader in all new pages
- **FR-22.5**: Verify active state highlighting works on all new pages
- **FR-22.6**: Test browser back button returns to previous page correctly
- **FR-22.7**: Ensure Logo and Home button navigate from all new pages

---

## 4. Non-Functional Requirements

### NFR-1: Performance
- Desktop dropdown opens within 50ms of click
- Mobile submenu slide animation is smooth 60 FPS
- No lag or stuttering during animations
- Click outside detection responds immediately
- State updates don't cause entire header to rebuild unnecessarily
- Animation controllers disposed properly to prevent memory leaks
- No performance degradation with multiple dropdown open/close cycles

### NFR-2: Animation Quality
- Desktop dropdown fade-in is smooth and professional (150ms)
- Mobile submenu slide is fluid and synchronized (250ms)
- No flickering or visual artifacts during transitions
- Animations use appropriate curves (easeOut, easeInOut)
- Reverse animations are equally smooth
- Multiple rapid clicks don't break animation state

### NFR-3: Responsive Design
- Dropdowns position correctly at all desktop widths (800px - 1920px)
- Mobile submenus work on all mobile widths (320px - 800px)
- Transition between desktop/mobile layouts is seamless
- No layout breaking at 800px breakpoint
- Touch targets adequate on mobile (48x48px minimum)
- Dropdowns don't overflow screen boundaries

### NFR-4: Accessibility
- Focus states visible on all interactive elements
- Screen reader support for menu structure
- ARIA labels for dropdown buttons and items
- Escape key closes dropdowns consistently
- Tab order is logical and intuitive
- Focus management prevents traps

### NFR-5: Code Maintainability
- State management is clear and well-documented
- Helper methods reduce code duplication
- Animation logic is commented and explained
- Menu items defined in reusable data structures
- Easy to add new categories or menu items
- Separation of concerns (desktop vs mobile logic)
- Consistent naming conventions throughout

### NFR-6: Visual Consistency
- All dropdowns use consistent purple theme (`Color(0xFF4d2963)`)
- Typography matches existing pages
- Spacing follows 8px grid system (8, 16, 24, 32, 40, 48, 64)
- Hover effects consistent with existing buttons
- Mobile submenu header matches mobile menu styling
- Border colors and shadows consistent across components

### NFR-7: User Experience
- Dropdown behavior matches user expectations (industry standards)
- Hover effects provide clear affordance
- Active state highlighting is obvious
- Click outside to close is intuitive
- Mobile back arrow clearly indicates return to previous menu
- No confusing states or navigation dead-ends
- Smooth, non-jarring transitions

---

## 5. Technical Constraints

### TC-1: Flutter Widgets
- Use standard Material widgets (InkWell, TextButton, etc.)
- Use AnimationController for animations
- Use FadeTransition and SlideTransition for effects
- Use Stack and Positioned for dropdown overlay
- Use GestureDetector for click-outside detection
- Use FocusScope for keyboard navigation
- No third-party packages required

### TC-2: State Management
- Local StatefulWidget state in AppHeader
- No external state management libraries required
- State variables track dropdown and submenu states
- Methods handle state transitions
- setState() calls optimized to prevent unnecessary rebuilds

### TC-3: File Organization
- All dropdown logic in `lib/widgets/app_header.dart`
- New page files in `lib/views/` directory
- Optional: Extract menu item data to separate file if list grows
- Update `lib/main.dart` for route registration
- No changes to existing page files beyond route updates

### TC-4: Theme Requirements
- Primary color: `Color(0xFF4d2963)` (purple)
- White: `Colors.white`
- Grey shades: `Colors.grey[200]`, `Colors.grey[300]`, `Colors.grey[600]`, `Colors.grey[700]`, `Colors.grey[800]`, `Colors.grey[900]`
- Font sizes: 14px (dropdown items), 16px (mobile items), 18px (mobile submenu title)
- Consistent with existing theme configuration

---

## 6. Acceptance Criteria Summary

The feature is considered **complete** when:

### Desktop Dropdown - Shop
- [ ] Clicking "Shop" button opens dropdown menu
- [ ] Dropdown displays all 7 categories
- [ ] Dropdown positioned below button with correct styling
- [ ] Fade-in animation smooth (150ms)
- [ ] Hover effects work on all menu items
- [ ] Clicking menu item navigates to correct route
- [ ] Clicking menu item closes dropdown
- [ ] Clicking "Shop" again toggles dropdown closed
- [ ] Clicking outside dropdown closes it
- [ ] Pressing Escape closes dropdown
- [ ] Active category highlighted in dropdown
- [ ] "Shop" button highlighted when on shop category page

### Desktop Dropdown - Print Shack
- [ ] Clicking "The Print Shack" button opens dropdown
- [ ] Dropdown displays "About" and "Personalisation"
- [ ] Same styling and behavior as Shop dropdown
- [ ] Opening Print Shack dropdown closes Shop dropdown if open
- [ ] All interaction patterns work identically
- [ ] Active item highlighted correctly
- [ ] "The Print Shack" button highlighted on print-shack pages

### Mobile Submenu - Shop
- [ ] Tapping hamburger opens main mobile menu
- [ ] "Shop" appears in main menu
- [ ] Tapping "Shop" opens submenu with slide animation
- [ ] Main menu slides left as submenu slides in from right
- [ ] Submenu shows purple header with "← Back" and "Shop"
- [ ] Submenu lists all 7 categories
- [ ] Tapping back arrow returns to main menu
- [ ] Tapping category navigates and closes all menus
- [ ] Animations smooth (250ms)
- [ ] Touch targets adequate (48x48px minimum)
- [ ] Ripple effects on tap

### Mobile Submenu - Print Shack
- [ ] "The Print Shack" appears in main mobile menu
- [ ] Tapping opens submenu with slide animation
- [ ] Submenu shows purple header with "← Back" and "The Print Shack"
- [ ] Submenu lists "About" and "Personalisation"
- [ ] All interactions match Shop submenu behavior
- [ ] Navigation and animation work correctly

### Routes & Pages
- [ ] All 7 shop category routes registered in main.dart
- [ ] All 2 print-shack routes registered in main.dart
- [ ] ShopCategoryPage displays correct category name
- [ ] PrintShackAboutPage displays correctly
- [ ] PersonalisationPage displays correctly
- [ ] All pages include AppHeader with correct currentRoute
- [ ] All pages match existing page structure
- [ ] Browser back button works from all new pages

### State Management
- [ ] Only one desktop dropdown open at a time
- [ ] Mobile main menu and submenu states managed correctly
- [ ] Dropdowns close when navigating to new page
- [ ] Dropdowns close when window resizes across breakpoint
- [ ] No state conflicts or impossible states
- [ ] State resets correctly after navigation

### Visual Consistency
- [ ] Purple theme (`Color(0xFF4d2963)`) used throughout
- [ ] Typography matches existing pages
- [ ] Spacing follows 8px grid system
- [ ] Hover/active states use consistent colors
- [ ] Mobile submenu styling matches mobile menu
- [ ] All borders and shadows consistent

### Responsive Behavior
- [ ] Desktop layout shows dropdown buttons (>800px)
- [ ] Mobile layout shows hamburger menu (≤800px)
- [ ] Transition between layouts is smooth
- [ ] No layout breaking during window resize
- [ ] Dropdowns position correctly at all widths
- [ ] Mobile submenus work at all mobile widths

### Interaction Quality
- [ ] Hover effects smooth on desktop
- [ ] Click outside closes dropdown
- [ ] Escape key closes dropdown
- [ ] Keyboard navigation works (Tab, Arrow keys, Enter)
- [ ] Touch targets adequate on mobile
- [ ] Tap ripple effects on mobile
- [ ] No animation glitches or flickering

### Code Quality
- [ ] Code follows existing conventions
- [ ] State management is clear and documented
- [ ] Helper methods reduce duplication
- [ ] Animation controllers disposed properly
- [ ] No Dart analyzer warnings
- [ ] No console errors
- [ ] Const constructors used where possible
- [ ] Meaningful comments on complex logic

### Testing
- [ ] Manual testing on desktop (various widths)
- [ ] Manual testing on mobile (various widths)
- [ ] Window resize testing completed
- [ ] All dropdown interactions tested
- [ ] All submenu interactions tested
- [ ] Navigation from all menu items verified
- [ ] Active state highlighting verified on all pages
- [ ] Keyboard navigation tested
- [ ] Click outside detection tested
- [ ] No regression in existing features
