# Footer Component Implementation

I need a persistent footer that appears on every page of the app. It must be responsive, accessible, and match the existing theme (purple: #4d2963). Please implement it as a reusable widget and integrate it across all views.

## Code Context

- Header: lib/widgets/app_header.dart
- Main: lib/main.dart (routes already configured)
- Views: lib/views/*.dart (about_page.dart, product_page.dart, sale_page.dart, collections_page.dart, shop_category_page.dart, print_shack_about_page.dart, personalisation_page.dart, etc.)

## Requirements

- Persistent footer on all pages
- Two columns on desktop/tablet; stacked vertically on mobile (≤800px)
- Visuals:
  - Background: Colors.grey[200]
  - Text: Colors.black87
  - Column titles bold
  - Spacing: 24px vertical padding, 16px between items, 32px column gap
- Accessibility: Semantics for headings and buttons, proper contrast, tappable targets ≥ 44x44

## Implementation

- Create widget: lib/widgets/app_footer.dart (AppFooter)
- Integrate via a shared layout:
  - Create AppScaffold(child) that renders AppHeader, body (child), AppFooter
  - Migrate all pages to use AppScaffold to guarantee the footer is present everywhere
- Responsive layout: Use LayoutBuilder or MediaQuery to switch between a Row (desktop) and Column (mobile)

## Footer Content

Column 1: Opening Hours
- Title: Opening hours
- Items (static text):
  - Monday–Friday: 9:00–17:00
  - Saturday: 10:00–16:00
  - Sunday: Closed

Column 2: Help & information
- Title: Help & information
- Controls:
  - Search button (primary, purple background)
  - Terms & Conditions of Sale Policy button (outlined or text button)

## Behaviours (User Actions)

Opening Hours (Column 1)
- Description: Static information showing when the shop is open.
- User actions:
  - None (read-only). Content should be selectable for copy.

Help & information (Column 2)
- Search button
  - Description: Entry point to search the shop content/products.
  - User actions:
    - Tap/click: Open search
      - Desktop: Prefer showSearch with a SearchDelegate if available
      - Fallback: Navigate to a new route '/search'
    - Keyboard: Enter triggers search, Esc closes (if using SearchDelegate)
  - Result:
    - If SearchDelegate exists: overlay search UI
    - Else: pushNamed('/search') to a placeholder SearchPage with a TextField

- Terms & Conditions of Sale Policy button
  - Description: Opens the shop’s terms and conditions of sale policy
  - User actions:
    - Tap/click: Navigate to '/policies/terms'
  - Result:
    - Navigate to TermsAndConditionsPage (placeholder acceptable for now)

## Routes to Add

- '/search' -> SearchPage (placeholder with an input and title "Search")
- '/policies/terms' -> TermsAndConditionsPage (placeholder with title "Terms & Conditions of Sale")

## Styling

- Buttons:
  - Search: ElevatedButton, backgroundColor: Color(0xFF4d2963), foregroundColor: Colors.white
  - Terms & Conditions: OutlinedButton (purple border), or TextButton with purple text
- Typography:
  - Column titles: fontSize 18, fontWeight bold
  - Body text: fontSize 14–16
- Layout:
  - Desktop (width > 800): Row with two Expanded columns, gap 32
  - Mobile (width ≤ 800): Column, 16px vertical spacing between the two sections

## Testing Checklist

- Footer renders on all major pages:
  - Home, Collections, Sale, About, Product, Category, Print Shack About, Personalisation
- Desktop layout shows two columns; mobile layout stacks sections
- Search button:
  - Tapping opens SearchDelegate if present; otherwise navigates to '/search'
- Terms button:
  - Tapping navigates to '/policies/terms'
- Accessibility:
  - Semantics labels for headings ("Opening hours", "Help & information")
  - Buttons have clear labels ("Search", "Terms & Conditions of Sale")

## Deliverables

- lib/widgets/app_footer.dart (AppFooter)
- lib/widgets/app_scaffold.dart (AppScaffold with header + body + footer)
- Route registrations for '/search' and '/policies/terms'
- Placeholder pages:
  - lib/views/search_page.dart
  - lib/views/terms_and_conditions_page.dart
- All existing pages updated to use AppScaffold(child: ...)