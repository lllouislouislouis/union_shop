# Sale Page Implementation Request

I'm working on a Flutter online shop app and need to implement a "Sale" page with filtering, sorting, and pagination features for displaying discounted products in a grid layout.

## Current Code Context

- **Main File**: `lib/main.dart`
- **Existing Pages**: 
  - HomeScreen (at route '/')
  - ProductPage (at route '/product')
  - AboutPage (at route '/about')
- **Navigation**: The app uses named routes with `Navigator.pushNamed()` for navigation
- **Reusable Components**: 
  - `AppHeader` widget (in `lib/widgets/app_header.dart`) - shared header with purple banner and navigation
  - `ProductCard` widget (in `lib/main.dart`) - displays product image, title, and price
- **Theme Color**: `Color(0xFF4d2963)` (purple)
- **Responsive Breakpoint**: 800px (desktop vs mobile)

## Requirements

### 1. Create Sale Page

**New File**: Create `lib/views/sale_page.dart` with a SalePage widget that includes:

- **AppHeader component** at the top (import from `lib/widgets/app_header.dart`)
- **Page Layout**:
  - White background
  - Full-width layout with proper padding (40px desktop, 24px mobile)
  - Scrollable content

**Content Structure**:
- **Heading Section**:
  - "SALE!" as large heading (fontSize: 48, bold, color: `Color(0xFF4d2963)`)
  - Subheading text below: "Don't miss out on our amazing deals! Limited time offers on selected items." (fontSize: 18, color: grey[700], centered)
  - Top padding: 64px
  - Bottom padding: 32px

- **Filter & Sort Controls**:
  - Horizontal row containing dropdown filters and sort button
  - Proper spacing between controls
  - Responsive: stack vertically on mobile (<600px)

- **Product Grid**:
  - 3x3 grid layout on desktop (3 columns)
  - 2x3 grid on tablet (2 columns, width 600-800px)
  - 2x3 grid on mobile (1 column, width <600px)
  - Grid spacing: 24px horizontal, 32px vertical
  - Display 9 products per page

- **Pagination Controls**:
  - Centered at bottom of grid
  - Arrow buttons (left/right) for navigation
  - Page indicator showing current page and total pages (e.g., "Page 1 of 3")
  - Spacing: 48px top margin

### 2. Product Data Structure

Create a mock product list with the following structure:

```dart
class SaleProduct {
  final String id;
  final String title;
  final double originalPrice;
  final double salePrice;
  final String imageUrl;
  final String category; // e.g., "Clothing", "Accessories", "Stationery"
  final DateTime saleEndDate; // For potential "ending soon" feature
  
  double get discountPercentage => 
    ((originalPrice - salePrice) / originalPrice * 100);
}
```

**Mock Data Requirements**:
- Create at least 10-20 sale products
- Mix of categories: "Clothing", "Mechandise", "PSUT"
- Price range: £5-£50 original, with 10-70% discounts
- Use placeholder images (can reuse existing product images or use AssetImage placeholders)
- Realistic product names (e.g., "University Hoodie", "Branded Notebook", "Campus Tote Bag")

### 3. Filtering Feature

**Filter Dropdown**:
- **Label**: "Category"
- **Position**: Left side of filter/sort row
- **Options**:
  - "All Categories" (default, shows all products)
  - "Clothing"
  - "Merchandies"
  - "PSUT"

**Visual Design**:
- Material Design dropdown (DropdownButton)
- Border: 1px solid grey[300]
- Padding: 12px horizontal, 8px vertical
- Icon: dropdown arrow
- Min width: 180px

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click category dropdown | Opens dropdown menu showing all category options |
| Select "All Categories" | Display all sale products, reset to page 1, show total count |
| Select specific category (e.g., "Clothing") | Filter products to only show selected category, reset to page 1, update page count, show filtered count (e.g., "Showing 12 Clothing items") |
| Switch between categories | Re-filter products immediately, maintain current sort order, reset to page 1 |

### 4. Sorting Feature

**Sort Dropdown**:
- **Label**: "Sort by"
- **Position**: Right side of filter/sort row (or below filter on mobile)
- **Options**:
  - "Featured" (default, original order)
  - "Best Selling"
  - "Alpabetically, A-Z"
  - "Alpabetically, Z-A"
  - "Price: Low to High"
  - "Price: High to Low"
  - "Date, old to new"
  - "Date, new to old"

**Visual Design**:
- Material Design dropdown (DropdownButton)
- Same styling as category filter
- Min width: 200px

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click sort dropdown | Opens dropdown menu showing all sort options |
| Select "Featured" | Reset to original product order (initial dataset order), maintain current category filter and try to keep current page |
| Select "Price: Low to High" | Sort currently shown (filtered) products by `salePrice` ascending; maintain current filters and stay on current page if possible |
| Select "Price: High to Low" | Sort currently shown (filtered) products by `salePrice` descending; maintain current filters |
| Select "Discount: High to Low" | Sort currently shown (filtered) products by `discountPercentage` descending (largest discount first) |
| Select "Name: A-Z" | Sort currently shown (filtered) products alphabetically by `title` (A→Z); maintain current filters |
| Apply sort while filtered | Sorting applies only to the filtered product set; recalculate total pages if necessary and update displayed page subset |
| Apply sort while on page 2+ | Attempt to keep the current page index if still valid for the new order; if the current page exceeds total pages after sorting, reset to page 1 and update the page indicator |

### 5. Product Grid Display

**Product Card Design**:
- Use or enhance existing `ProductCard` widget
- **Layout**:
  - Product image (aspect ratio 1:1 or 4:3)
  - Product title below image (2 lines max, ellipsis if longer)
  - Original price (crossed out, grey color)
  - Sale price (bold, purple color `Color(0xFF4d2963)`)
  - Discount badge (optional: top-right corner showing "20% OFF")

**Visual Enhancements**:
- Hover effect on desktop (slight scale or shadow increase)
- Tap feedback on mobile (ripple effect)
- Image placeholder if image fails to load

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click/tap on product card | Navigate to ProductPage (route '/product') with product details |
| Hover over product (desktop) | Show subtle hover effect (scale 1.02, shadow increase) |
| Image fails to load | Display placeholder with icon (same as current ProductCard behavior) |

### 6. Pagination Controls

**Layout**:
- Centered horizontally
- Components from left to right:
  - Previous button (left arrow icon)
  - Page indicator text (e.g., "Page 2 of 5")
  - Next button (right arrow icon)
- Spacing: 16px between elements

**Button Design**:
- Circular or rounded square buttons
- Size: 48x48px
- Background: white with border when enabled, grey when disabled
- Icon color: purple `Color(0xFF4d2963)` when enabled, grey when disabled
- Elevation/shadow on hover (desktop)

**Page Indicator**:
- Font size: 16px
- Color: grey[700]
- Format: "Page X of Y"

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| Click "Next" button (→) | Navigate to next page of products, scroll to top of grid, update page indicator, disable button if on last page |
| Click "Previous" button (←) | Navigate to previous page of products, scroll to top of grid, update page indicator, disable button if on first page |
| On first page | Disable/grey out Previous button |
| On last page | Disable/grey out Next button |
| Filter changes (reducing product count) | Recalculate total pages, reset to page 1 if current page exceeds new total pages |
| Filter changes (increasing product count) | Recalculate total pages, maintain current page if still valid |
| Window resize (changing grid columns) | Recalculate products per page and total pages dynamically |

**Pagination Logic**:
- **Products per page**: Always 9 (3x3 grid)
- **Total pages calculation**: `ceil(filteredProducts.length / 9)`
- **Current page products**: `filteredProducts.skip((currentPage - 1) * 9).take(9)`
- **Page validation**: Ensure currentPage is always between 1 and totalPages

### 7. Responsive Behavior

**Desktop (width > 800px)**:
- 3-column product grid (3x3 = 9 products per page)
- Filter and sort in single horizontal row
- Full navigation buttons in header
- Padding: 40px

**Tablet (width 600-800px)**:
- 2-column product grid (2x3 = 6 products per page, adjust pagination accordingly)
- Filter and sort in single horizontal row
- Hamburger menu in header
- Padding: 32px

**Mobile (width < 600px)**:
- 1-column product grid (1x9 = 9 products, but longer scroll)
- Filter and sort stacked vertically
- Each dropdown full width
- Hamburger menu in header
- Padding: 24px

### 8. State Management

**State Variables Needed**:
```dart
- List<SaleProduct> _allProducts // Full product list
- List<SaleProduct> _filteredProducts // After category filter
- List<SaleProduct> _displayedProducts // After sort, paginated
- String _selectedCategory // Current category filter
- String _selectedSort // Current sort option
- int _currentPage // Current pagination page (starts at 1)
- int _totalPages // Calculated based on filtered products
```

**State Updates**:
- Category change: Update `_filteredProducts`, recalculate pages, reset to page 1, apply current sort
- Sort change: Update `_displayedProducts` order, maintain current page
- Page change: Update `_currentPage`, update `_displayedProducts` subset
- Window resize: Recalculate products per page and total pages

### 9. Navigation Setup

**Route Registration**:
- Add '/sale' route in main.dart's MaterialApp routes
- Route should build and return the SalePage widget

**Navigation Actions**:
- When user clicks "SALE!" button in AppHeader (desktop) → Navigate to '/sale' route
- When user clicks "SALE!" in mobile menu → Close menu, then navigate to '/sale' route
- Update AppHeader to highlight "SALE!" button when on '/sale' route (pass `currentRoute: '/sale'` to AppHeader)
- SalePage's logo and "Home" button should navigate back to '/' route

### 10. Visual Design Requirements

**Color Scheme**:
- Primary color: `Color(0xFF4d2963)` (purple)
- Sale prices: Same purple color
- Original prices: grey[600] with strikethrough
- Background: white
- Text: black/grey[900] for headings, grey[700] for body
- Borders: grey[300]

**Typography**:
- Heading: 48px, bold, purple
- Subheading: 18px, regular, grey[700]
- Product title: 14px, regular, black
- Prices: 16px (sale: bold purple, original: regular grey)
- Page indicator: 16px, regular, grey[700]

**Spacing**:
- Page top padding: 64px
- Section spacing: 32px
- Grid gap: 24px horizontal, 32px vertical
- Button spacing: 16px
- Card internal padding: 8px

### 11. Error Handling & Edge Cases

**Handle these scenarios**:
- **No products in filtered category**: Show message "No products found in this category" with option to clear filters
- **Empty sale products list**: Show message "No sale items available at the moment"
- **Last page with fewer products**: Display remaining products (e.g., 5 products on last page instead of 9)
- **Single page of results**: Hide pagination controls or show "Page 1 of 1" with disabled arrows
- **Image loading errors**: Show placeholder icon (already handled by ProductCard)
- **Very long product names**: Truncate with ellipsis after 2 lines

### 12. Performance Considerations

- Use `const` constructors where possible
- Implement efficient filtering and sorting (don't recreate entire lists on every build)
- Consider using `ListView.builder` or `GridView.builder` if product list grows very large
- Cache filtered/sorted results to avoid recomputation
- Debounce filter/sort changes if implementing search later

## Technical Constraints

- Maintain consistent styling with existing pages (HomeScreen, AboutPage)
- Reuse AppHeader component from `lib/widgets/app_header.dart`
- Follow Flutter best practices (const constructors, proper state management)
- Use existing ProductCard widget or create enhanced version
- Ensure smooth animations for page transitions
- Support browser back button navigation

## Deliverables

Please provide:

1. **New file**: `lib/views/sale_page.dart` with complete SalePage implementation
2. **New file**: `lib/models/sale_product.dart` (optional) for product data model
3. **Modified file**: Updated `lib/main.dart` with:
   - New route for '/sale'
   - Updated navigation handlers for SALE! button (desktop and mobile)
   - Mock product data (or reference to separate data file)
4. **Modified file**: Updated `lib/widgets/app_header.dart` to:
   - Add navigation for SALE! button
   - Highlight SALE! when on '/sale' route
5. **Comments**: Explain key decisions, especially regarding state management and pagination logic
6. **Any additional files**: If creating separate product model, data service, or enhanced ProductCard

## Code Style Preferences

- Match existing code style (consistent with HomeScreen and AboutPage)
- Use `const` constructors where possible
- Follow existing naming conventions (`_privateVariables`, `publicMethods`)
- Keep consistent padding and sizing patterns
- Add helpful comments for complex logic (filtering, sorting, pagination)
- Extract reusable widgets where appropriate

## User Flow Summary

```
User Journey:
1. User clicks "SALE!" in header → Navigate to /sale route
2. SalePage loads → Shows all products (9 per page), default sort
3. User selects "Clothing" category → Filters to show only clothing items, resets to page 1
4. User selects "Price: Low to High" → Sorts filtered clothing by price ascending
5. User clicks Next arrow → Shows next 9 clothing products (page 2)
6. User clicks product card → Navigates to /product page
7. User clicks back → Returns to /sale page (maintains filters, sort, and page if possible)
```

## Testing Checklist

Ensure the following works correctly:

- [ ] Navigation to /sale from header works (desktop and mobile)
- [ ] SALE! button is highlighted when on /sale page
- [ ] Category filter shows all categories and "All Categories" option
- [ ] Filtering updates product grid and recalculates pages
- [ ] Sorting works with all options (price, discount, name)
- [ ] Sorting maintains current filters
- [ ] Pagination shows correct page numbers
- [ ] Previous button disabled on page 1
- [ ] Next button disabled on last page
- [ ] Clicking product card navigates to product page
- [ ] Responsive layout works (3 columns desktop, 2 tablet, 1 mobile)
- [ ] Filter/sort controls stack on mobile
- [ ] Empty state messages display when no products found
- [ ] Page state persists during browser back/forward navigation (bonus)
- [ ] No console errors or warnings
- [ ] Smooth animations and transitions

## Bonus Features (Optional)

If time permits, consider adding:

1. **Search bar**: Filter products by name/description
2. **Discount badges**: Visual badge on product cards showing discount percentage
3. **"Ending Soon" indicator**: Highlight products with sales ending within 48 hours
4. **Favorites/Wishlist**: Heart icon to save products
5. **Quick view**: Modal popup with product details on hover/click
6. **Loading states**: Skeleton screens or spinners while filtering/sorting
7. **Animations**: Fade in products when page changes, slide transitions
8. **URL parameters**: Persist filter/sort/page state in URL for sharing
9. **Product count**: Show "Showing X of Y products" above grid
10. **Clear filters button**: Quick reset to default state

## Notes

- Focus on core functionality first (filtering, sorting, pagination)
- Ensure robust state management for filter/sort/page changes
- Test edge cases (empty results, single page, last page with few items)
- Maintain performance with efficient list operations
- Keep UI consistent with existing app design