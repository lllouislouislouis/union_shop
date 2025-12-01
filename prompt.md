# About Page Implementation Request

I'm working on a Flutter online shop app and need to implement an "About" page with a reusable header component and simple content layout.

## Current Code Context

- **File**: `lib/main.dart`
- **Existing Pages**: HomeScreen (at route '/') and ProductPage (at route '/product')
- **Navigation**: The app uses named routes with `Navigator.pushNamed()` for navigation
- **Header Structure**: Currently implemented in HomeScreen with:
  - Purple banner at top (height varies, contains sale announcement text)
  - Main header bar (height 100) with logo, navigation buttons, and action icons
  - Responsive navigation (desktop buttons vs mobile hamburger menu)
  - Logo click navigates to home
  - Navigation includes: Home, Shop, The Print Shack, SALE!, About

## Requirements

### 1. Create About Page

**New File**: Create `lib/about_page.dart` with an AboutPage widget that includes:

- **Same header structure** as HomeScreen (purple banner + navigation bar)
- **Page content**:
  - Plain white background
  - "About Us" as a large heading (consider using fontSize: 32-36, bold, with proper spacing)
  - Placeholder body text below the heading (3-4 paragraphs of lorem ipsum or descriptive placeholder text)
  - Proper padding around content (e.g., 40px on desktop, 24px on mobile)
  - Centered

### 2. Header Reusability

Since the header will be shared between pages, consider one of these approaches:

**Extract Reusable Widget**:
- Create a separate `AppHeader` widget that can be used on both HomeScreen and AboutPage
- Extract the entire header (purple banner + navigation bar) into this component
- Make it accept parameters if needed (e.g., current route for highlighting active nav button)

### 3. Navigation Setup

**Route Registration**:
- Add '/about' route in main.dart's MaterialApp routes
- Route should build and return the AboutPage widget

**Navigation Actions**:
- When user clicks "About" button in navigation bar (desktop) → Navigate to '/about' route
- When user clicks "About" in mobile menu → Close menu, then navigate to '/about' route
- Update the `placeholderCallbackForButtons()` call for the About button to use proper navigation
- AboutPage's "Home" button should navigate back to '/' route
- AboutPage's "About" button should be highlighted or styled to indicate it's the current page

### 4. Visual Design Requirements

**Purple Banner**:
- Same styling as HomeScreen
- Background color: `Color(0xFF4d2963)`
- White text, centered
- Same sale announcement text (or make it configurable)

**Main Header Bar**:
- Height: 100
- White background
- Same logo (clickable, navigates to home)
- Same navigation buttons with hover effects
- Same action icons (search, profile, cart)
- Same responsive behavior (buttons on desktop, hamburger menu on mobile)
- Highlight "About" button to show current page (e.g., different color, underline, or bold text)

**Content Area**:
- White background
- "About Us" heading:
  - Large font size (32-36px)
  - Bold weight
  - Black or dark grey color
  - Top padding: 64px
  - Bottom padding: 24px
- Body text:
  - Normal font size (16px)
  - Regular weight
  - Dark grey color for readability
  - Line height: 1.6-1.8 for better readability
  - Max width: 800px (centered) for optimal reading experience on wide screens
- Overall page padding: 40px on desktop, 24px on mobile

### 5. Responsive Behavior

- Use the same breakpoint as HomeScreen (800px)
- Desktop (width > 800px): Show navigation buttons, wider content
- Mobile (width ≤ 800px): Show hamburger menu, full-width content with padding
- Ensure text is readable on all screen sizes

### 6. State Management

- AboutPage can be a StatelessWidget unless you need state for the mobile menu
- If using a shared header component, handle mobile menu state appropriately
- Reuse existing helper methods where possible (_buildNavButton, _buildMobileMenuItem, etc.)

## Technical Constraints

- Maintain consistent styling with HomeScreen (colors, fonts, spacing)
- Use existing theme color: `Color(0xFF4d2963)`
- Follow Flutter best practices (const constructors where possible)
- Ensure smooth navigation transitions

## Deliverables

Please provide:

1. **New file**: `lib/about_page.dart` with complete AboutPage implementation
2. **Modified file**: Updated `lib/main.dart` with:
   - New route for '/about'
   - Updated navigation handlers for About button (desktop and mobile)
   - Extracted AppHeader component
3. **Comments**: Explain key decisions, especially regarding header reusability
4. **Any additional files**: If creating separate header widget or other components

## Code Style Preferences

- Match existing code style (consistent with HomeScreen)
- Use `const` constructors where possible
- Follow existing naming conventions
- Keep consistent padding and sizing patterns
- Add helpful comments for future maintainability

## User Actions Summary

| User Action | Expected Behavior |
|-------------|-------------------|
| Click "About" button (desktop) | Navigate to /about route, show AboutPage |
| Click "About" in mobile menu | Close mobile menu, then navigate to /about route |
| Click logo on AboutPage | Navigate back to home (/) |
| Click "Home" button on AboutPage | Navigate back to home (/) |
| Click back button (browser/device) | Return to previous page |
| View on mobile (<800px) | See hamburger menu, responsive content layout |
| View on desktop (>800px) | See full navigation buttons, "About" highlighted as current page |