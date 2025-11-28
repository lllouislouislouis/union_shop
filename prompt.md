# Navigation Bar Implementation Request

I'm working on a Flutter online shop app and need to implement a responsive navigation bar with specific layout requirements for desktop and mobile views.

## Current Code Context

- **File**: `lib/main.dart`
- **Location**: Inside the `HomeScreen` widget, there's a header `Container` (height: 100) with a purple banner at the top
- **Current Structure**: Below the purple banner with "PLACEHOLDER HEADER TEXT", there's a Row containing a logo and some action icons (search, person, shopping bag, menu)
- **Navigation Setup**: The app uses named routes with `Navigator.pushNamed()` and has existing routes for '/' (home) and '/product'

## Requirements

### 1. Desktop/Wide Screen Layout (width > 800px)

Add navigation buttons **between the logo and the action icons** in the existing Row:

- **Buttons needed**: "Home", "Shop", "The Print Shack", "SALE!", "About"
- "Home" represents the current page (HomeScreen)
- Buttons should be horizontally aligned and properly spaced
- Style should match the existing design (simple, clean, grey text)
- Each button should have hover effects (optional but nice to have)

### 2. Mobile/Narrow Screen Layout (width ≤ 800px)

- **Hide** the navigation buttons
- **Replace** with a hamburger menu icon (☰ three horizontal bars)
- Position the hamburger icon in the same Row, between the logo and action icons
- Clicking the hamburger icon should open a **Drawer** widget from the left side
- The Drawer should contain:
  - The same 5 navigation options in a vertical list
  - Proper spacing and styling
  - Close button or swipe-to-dismiss functionality

### 3. Responsive Behavior

- Use `MediaQuery.of(context).size.width` or `LayoutBuilder` to detect screen width
- Breakpoint: **800px** (show buttons if width > 800px, show hamburger if ≤ 800px)
- Smooth conditional rendering between layouts

### 4. Navigation Logic

For now, use placeholder navigation:
- "Home" button: calls `navigateToHome(context)` (already exists in the code)
- Other buttons: call `placeholderCallbackForButtons()` (already exists in the code)
- Later, I'll add proper routes for Shop, The Print Shack, SALE!, and About pages

## Technical Constraints

- The HomeScreen is a `StatelessWidget`, so if state management is needed for the Drawer, suggest converting to `StatefulWidget` or another approach
- Maintain the existing header structure and styling
- Don't modify the existing logo, action icons, or their functionality
- Use Flutter best practices for responsive design

## Deliverables

Please provide:

1. Complete modified code for the header Container section in `main.dart`
2. Implementation of both desktop navigation buttons and mobile drawer
3. Comments explaining key decisions and the responsive logic
4. Any necessary imports or state management changes

## Code Style Preferences

- Use `const` constructors where possible (as in existing code)
- Match existing styling patterns (grey icons, purple theme color: `0xFF4d2963`)
- Keep consistent padding and sizing with current design
- Use existing helper methods where applicable