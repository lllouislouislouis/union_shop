# Shop and Print Shack Dropdown Menus Implementation

I'm working on a Flutter online shop app and need to implement dropdown menus for the "Shop" and "The Print Shack" navigation buttons in the app header, with different behavior for desktop and mobile views.

## Current Code Context

- **Main File**: `lib/main.dart`
- **Header Component**: `lib/widgets/app_header.dart` (see attached file)
- **Existing Pages**: 
  - HomeScreen (at route '/')
  - ProductPage (at route '/product')
  - AboutPage (at route '/about')
  - SalePage (at route '/sale')
- **Navigation**: The app uses named routes with `Navigator.pushNamed()` for navigation
- **Theme Color**: `Color(0xFF4d2963)` (purple)
- **Responsive Breakpoint**: 800px (desktop vs mobile)

## Requirements

### 1. Shop Dropdown Menu Structure

**Menu Items** (in order):
1. **Clothing** - Navigate to `/shop/clothing`
2. **Merchandise** - Navigate to `/shop/merchandise`
3. **Halloween** - Navigate to `/shop/halloween`
4. **Signature & Essential Range** - Navigate to `/shop/signature-essential`
5. **Portsmouth City Collection** - Navigate to `/shop/portsmouth`
6. **Pride Collection** - Navigate to `/shop/pride`
7. **Graduation** - Navigate to `/shop/graduation`

### 2. The Print Shack Dropdown Menu Structure

**Menu Items** (in order):
1. **About** - Navigate to `/print-shack/about`
2. **Personalisation** - Navigate to `/print-shack/personalisation`

### 3. Desktop Dropdown Behavior (width > 800px)

**Visual Design**:
- Dropdown appears below the navigation button
- White background with subtle shadow (elevation: 4)
- Rounded bottom corners (8px radius)
- Minimum width: 250px (or match button width if larger)
- Smooth fade-in animation (150ms)

**Menu Item Styling**:
- Padding: 16px horizontal, 12px vertical
- Font size: 14px
- Color: grey[800] (default), purple `Color(0xFF4d2963)` (hover)
- Border between items: 1px solid grey[200]
- Hover effect: Light purple background `Color(0xFF4d2963).withValues(alpha: 0.1)`

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click "Shop" button | Dropdown menu appears below button showing all 7 shop categories |
| Hover over "Shop" button | Show hover effect on button (existing behavior) |
| Click "Shop" button again | Close dropdown menu (toggle behavior) |
| Click menu item (e.g., "Clothing") | Navigate to `/shop/clothing`, close dropdown, highlight "Shop" button as active |
| Hover over menu item | Show hover effect (light purple background, purple text) |
| Click outside dropdown | Close dropdown menu |
| Click another nav button | Close dropdown menu, perform other button's action |
| Press Escape key | Close dropdown menu |

**User Actions for Print Shack**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click "The Print Shack" button | Dropdown menu appears below button showing 2 menu items |
| Click "About" | Navigate to `/print-shack/about`, close dropdown |
| Click "Personalisation" | Navigate to `/print-shack/personalisation`, close dropdown |
| (All other interactions same as Shop dropdown) | |

### 4. Mobile Dropdown Behavior (width ≤ 800px)

**Visual Design - Slide-Over Panel**:
- Full-height overlay panel slides in from the right
- Width: 100% of screen (or 85% with dark backdrop on left)
- White background
- Top section with back navigation
- Smooth slide animation (250ms)

**Header Section**:
- Height: 64px (matching app header height)
- Purple background `Color(0xFF4d2963)`
- Content:
  - Left: Back arrow icon (white color)
  - Center: Button label ("Shop" or "The Print Shack") in white, bold, 18px
- Tap back arrow: Close panel, return to main mobile menu

**Menu Items Section**:
- White background
- Each item takes full width
- Padding: 20px horizontal, 16px vertical
- Font size: 16px
- Border between items: 1px solid grey[200]
- Tap effect: Ripple animation

**User Actions - Shop Button**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Tap "Shop" in mobile menu | Main mobile menu slides out to left, Shop submenu slides in from right with "Shop" header and back arrow |
| Tap back arrow in Shop submenu | Shop submenu slides out to right, main mobile menu slides back in from left |
| Tap "Clothing" in submenu | Navigate to `/shop/clothing`, close all menus (submenu + main menu), return to page content |
| Tap "Merchandise" in submenu | Navigate to `/shop/merchandise`, close all menus |
| Tap outside panel | Close submenu, return to main mobile menu |
| (Repeat for all 7 shop categories) | |

**User Actions - Print Shack Button**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Tap "The Print Shack" in mobile menu | Main mobile menu slides out to left, Print Shack submenu slides in from right with "The Print Shack" header and back arrow |
| Tap back arrow | Print Shack submenu slides out to right, main mobile menu slides back in from left |
| Tap "About" in submenu | Navigate to `/print-shack/about`, close all menus |
| Tap "Personalisation" in submenu | Navigate to `/print-shack/personalisation`, close all menus |

### 5. State Management Requirements

**New State Variables** (in `_AppHeaderState`):
```dart
bool _isShopDropdownOpen = false;
bool _isPrintShackDropdownOpen = false;
bool _isMobileSubmenuOpen = false;
String _currentSubmenu = ''; // 'shop' or 'printshack'
```

**State Management Logic**:
- Only one dropdown can be open at a time (close others when opening new one)
- On desktop: Clicking button toggles its dropdown, clicking another button switches dropdown
- On mobile: Track navigation stack (main menu → submenu → page)
- Ensure dropdown closes when navigating away
- Reset state when switching between desktop/mobile on window resize

### 6. Active State Highlighting

**Current Page Detection**:
- If `currentRoute` starts with `/shop/`, highlight "Shop" button as active
- If `currentRoute` starts with `/print-shack/`, highlight "The Print Shack" button as active
- Active button styling: Purple text `Color(0xFF4d2963)`, bold font (existing behavior)

**Menu Item Highlighting**:
- In dropdown, highlight the menu item that matches current route
- Active menu item: Purple text, slightly darker background
- Example: On `/shop/clothing` page, "Clothing" item in Shop dropdown has purple text

### 7. Desktop Implementation Details

**Dropdown Positioning**:
- Use `Stack` and `Positioned` widgets to overlay dropdown below button
- Calculate position based on button's global position
- Dropdown should align with left edge of button
- Z-index: Dropdown above page content, below modal overlays

**Click Outside Detection**:
- Use `GestureDetector` with `behavior: HitTestBehavior.opaque` wrapping entire screen
- On tap outside dropdown area, close dropdown
- Don't trigger other navigation when clicking outside

**Animation**:
- Fade + slide animation for dropdown appearance
- Duration: 150ms
- Curve: `Curves.easeOut`

### 8. Mobile Implementation Details

**Slide Animation**:
- Use `AnimatedPositioned` or `SlideTransition` for panel movement
- Main menu slides out to left (-100% width) while submenu slides in from right (+100% → 0%)
- Duration: 250ms
- Curve: `Curves.easeInOut`

**Navigation Stack**:
- Track menu navigation depth
- Support back gesture/button to return to previous menu level
- Ensure both menus close completely when navigating to a page

### 9. Route Setup in main.dart

**New Routes to Add**:
```dart
// Shop category routes
'/shop/clothing': (context) => ShopCategoryPage(category: 'Clothing'),
'/shop/merchandise': (context) => ShopCategoryPage(category: 'Merchandise'),
'/shop/halloween': (context) => ShopCategoryPage(category: 'Halloween'),
'/shop/signature-essential': (context) => ShopCategoryPage(category: 'Signature & Essential Range'),
'/shop/portsmouth': (context) => ShopCategoryPage(category: 'Portsmouth City Collection'),
'/shop/pride': (context) => ShopCategoryPage(category: 'Pride Collection'),
'/shop/graduation': (context) => ShopCategoryPage(category: 'Graduation'),

// Print Shack routes
'/print-shack/about': (context) => PrintShackAboutPage(),
'/print-shack/personalisation': (context) => PersonalisationPage(),
```

**Note**: Create placeholder pages for now (can reuse SalePage structure as template)

### 10. Accessibility & UX Considerations

**Keyboard Navigation** (Desktop):
- Tab key should navigate through menu items
- Enter/Space key should activate focused menu item
- Escape key should close dropdown
- Arrow keys should move focus up/down in dropdown

**Touch Targets** (Mobile):
- Minimum touch target size: 48x48px for all tappable elements
- Adequate spacing between menu items (minimum 8px)
- Clear visual feedback on tap (ripple effect)

**Focus Management**:
- When dropdown opens, focus should move to first menu item
- When dropdown closes, focus returns to button that opened it
- Prevent focus trap in dropdown

### 11. Visual Design Specifications

**Desktop Dropdown**:
```
┌────────────────────┐
│ Menu Item          │ ← 16px padding left/right, 12px top/bottom
├────────────────────┤ ← 1px border grey[200]
│ Menu Item          │
├────────────────────┤
│ Menu Item          │
└────────────────────┘
  ↓ 8px border radius bottom corners
  ↓ elevation: 4
```

**Mobile Submenu**:
```
┌─────────────────────────┐
│ ← Back    Shop         │ ← 64px height, purple background
├─────────────────────────┤
│                         │
│  Clothing               │ ← 20px padding sides, 16px top/bottom
│─────────────────────────│
│  Merchandise            │
│─────────────────────────│
│  Halloween              │
│                         │
└─────────────────────────┘
```

**Color Specifications**:
- Purple: `Color(0xFF4d2963)`
- Light purple hover: `Color(0xFF4d2963).withValues(alpha: 0.1)`
- Border: `Colors.grey[200]`
- Text default: `Colors.grey[800]`
- Text hover/active: `Color(0xFF4d2963)`

### 12. Code Structure Recommendations

**Create Helper Methods in AppHeader**:
```dart
// Desktop dropdown builder
Widget _buildDesktopDropdown(List<DropdownMenuItem> items, bool isOpen)

// Mobile submenu panel builder
Widget _buildMobileSubmenu(String title, List<SubmenuItem> items)

// Dropdown menu item data class
class DropdownMenuItem {
  final String label;
  final String route;
  final bool isActive;
}
```

**State Update Methods**:
```dart
void _openShopDropdown()
void _closeShopDropdown()
void _toggleShopDropdown()
void _openPrintShackDropdown()
void _closePrintShackDropdown()
void _togglePrintShackDropdown()
void _closeAllDropdowns()
void _openMobileSubmenu(String submenu)
void _closeMobileSubmenu()
```

### 13. Error Handling

**Handle these scenarios**:
- Route doesn't exist: Show error page or redirect to home
- Rapid clicking of dropdown buttons: Debounce or prevent state conflicts
- Window resize during dropdown open: Close dropdown and recalculate layout
- Navigation while dropdown open: Ensure dropdown closes on route change

### 14. Testing Checklist

Ensure the following works correctly:

**Desktop**:
- [ ] Shop dropdown opens/closes on button click
- [ ] Print Shack dropdown opens/closes on button click
- [ ] Only one dropdown open at a time
- [ ] Clicking menu item navigates to correct route
- [ ] Clicking outside dropdown closes it
- [ ] Escape key closes dropdown
- [ ] Hover effects work on menu items
- [ ] Active menu item highlighted when on its page
- [ ] Dropdown closes when navigating to other pages
- [ ] Dropdown animation smooth (150ms fade/slide)

**Mobile**:
- [ ] Tapping Shop opens submenu with slide animation
- [ ] Tapping Print Shack opens submenu with slide animation
- [ ] Back arrow returns to main menu
- [ ] Tapping menu item navigates and closes all menus
- [ ] Submenu header displays correct title
- [ ] Slide animations smooth (250ms)
- [ ] Main menu slides out when submenu opens
- [ ] Both menus close completely on navigation
- [ ] Touch targets are adequate (48x48px minimum)

**Both Views**:
- [ ] Active button highlighted when on shop/print-shack route
- [ ] No console errors or warnings
- [ ] Transitions smooth on window resize
- [ ] Memory leaks prevented (dispose controllers)

### 15. Deliverables

Please provide:

1. **Modified file**: Updated `lib/widgets/app_header.dart` with:
   - Desktop dropdown menu implementation
   - Mobile slide-over submenu implementation
   - State management for dropdowns
   - Helper methods for rendering menus
   - Proper animation controllers and transitions
   - Click/tap handlers for all menu items

2. **New files**: Placeholder category pages:
   - `lib/views/shop_category_page.dart` - Generic page for shop categories
   - `lib/views/print_shack_about_page.dart` - Print Shack about page
   - `lib/views/personalisation_page.dart` - Personalisation page

3. **Modified file**: Updated `lib/main.dart` with:
   - All new route definitions
   - Route parameter handling for shop categories
   - Updated MaterialApp routes map

4. **Comments**: Explain:
   - Desktop vs mobile dropdown strategy
   - Animation implementation choices
   - State management approach
   - Click outside detection method
   - Navigation stack handling for mobile

5. **Documentation**: Brief explanation of:
   - How to add new menu items
   - How to change dropdown styling
   - How to handle nested submenus (if future requirement)

## Code Style Preferences

- Match existing code style in `app_header.dart`
- Use `const` constructors where possible
- Extract reusable widgets (dropdown item, submenu header, etc.)
- Keep existing naming conventions
- Add helpful comments for complex animation logic
- Maintain consistent spacing and sizing with current header

## Implementation Notes

**Priority Order**:
1. Desktop dropdown functionality (core feature)
2. Mobile submenu functionality (core feature)
3. Animations and transitions (polish)
4. Keyboard navigation (accessibility)
5. Backdrop and advanced touch gestures (enhancement)

**Animation Controllers**:
- Create `AnimationController` for desktop dropdown fade
- Create `AnimationController` for mobile slide transitions
- Remember to dispose controllers in `dispose()` method

**Performance**:
- Use `const` constructors for static menu items
- Avoid rebuilding entire header when only dropdown changes
- Consider using `ValueNotifier` or `ChangeNotifier` for dropdown state if needed

## User Flow Examples

**Desktop - Shop Dropdown**:
```
1. User hovers over "Shop" → Button shows hover effect
2. User clicks "Shop" → Dropdown fades in below button
3. User hovers over "Pride Collection" → Item highlights purple
4. User clicks "Pride Collection" → Navigate to /shop/pride, dropdown closes
5. "Shop" button remains highlighted (active state)
```

**Mobile - Print Shack Submenu**:
```
1. User taps hamburger menu → Main mobile menu slides down
2. User taps "The Print Shack" → Main menu slides left, submenu slides in from right
3. Submenu shows: "← Back  The Print Shack" header + 2 menu items
4. User taps "Personalisation" → Navigate to /print-shack/personalisation
5. Both menus close, page content visible, "The Print Shack" highlighted in header
```

**Desktop - Multiple Dropdowns**:
```
1. User clicks "Shop" → Shop dropdown opens
2. User clicks "The Print Shack" → Shop dropdown closes, Print Shack dropdown opens
3. User clicks outside → Print Shack dropdown closes
```