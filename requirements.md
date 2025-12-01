# Sale Page Feature Requirements

## 1. Feature Overview

### Description
Implement a comprehensive "Sale" page for the Union Shop Flutter application that displays discounted products in a filterable, sortable, and paginated grid layout. The page will allow users to browse sale items efficiently, filter by category, sort by various criteria (price, name, discount, etc.), and navigate through multiple pages of products.

### Purpose
- **Showcase Discounts**: Highlight products currently on sale to drive conversions
- **Improve Discoverability**: Help users find sale items that match their interests through filtering
- **Enhance User Experience**: Provide intuitive sorting and pagination for browsing large product catalogs
- **Drive Sales**: Make it easy for users to find and purchase discounted items
- **Professional Appearance**: Demonstrate a complete, feature-rich e-commerce experience

### Technical Context
- **Current State**: "SALE!" button exists in navigation but uses placeholder callback
- **New Components**: SalePage widget, SaleProduct model, enhanced ProductCard
- **Framework**: Flutter web application with named route navigation
- **Route**: '/sale' will be added to application routes
- **Shared Elements**: AppHeader component will be reused from other pages
- **Data Management**: Mock product data with filtering, sorting, and pagination logic

---

## 2. User Stories

### US-1: Navigating to Sale Page (Desktop)
**As a** desktop user  
**I want to** click the "SALE!" button in the navigation bar  
**So that** I can browse discounted products

**Acceptance Criteria:**
- SALE! button in desktop navigation is clickable
- Clicking SALE! button navigates to '/sale' route
- Page loads without errors showing initial 9 products
- Navigation transition is smooth
- SALE! button appears highlighted/active on the Sale page
- All other navigation buttons remain functional
- Default state: "All Categories" filter, "Featured" sort, page 1

---

### US-2: Navigating to Sale Page (Mobile)
**As a** mobile user  
**I want to** select "SALE!" from the mobile menu  
**So that** I can view discounted items on my device

**Acceptance Criteria:**
- SALE! option appears in mobile hamburger menu
- Tapping SALE! closes the menu automatically
- Navigation to '/sale' route occurs after menu closes
- Page loads correctly on mobile viewport
- Mobile header functions correctly on Sale page
- Products display in single column on mobile
- Filter and sort controls stack vertically

---

### US-3: Viewing Sale Products
**As a** user on the Sale page  
**I want to** see a grid of discounted products with clear pricing  
**So that** I can quickly identify good deals

**Acceptance Criteria:**
- "SALE!" heading is prominent and visible at top (48px, purple)
- Subheading explains the sale purpose
- Products display in responsive grid (3 cols desktop, 2 tablet, 1 mobile)
- Each product shows: image, title, original price (struck through), sale price (bold purple)
- Original price is clearly crossed out in grey
- Sale price is prominently displayed in purple
- Optional discount badge shows percentage off
- Grid spacing is consistent (24px horizontal, 32px vertical)
- 9 products visible per page initially

---

### US-4: Filtering Products by Category
**As a** user browsing sale items  
**I want to** filter products by category  
**So that** I can focus on items I'm interested in

**Acceptance Criteria:**
- Category dropdown appears on left side of controls (desktop) or top (mobile)
- Dropdown label reads "Category"
- Options include: "All Categories", "Clothing", "Merchandise", "PSUT"
- "All Categories" is selected by default
- Clicking dropdown opens menu showing all options
- Selecting a category immediately filters the grid
- Page resets to 1 when filter changes
- Total page count updates based on filtered results
- Optional: Display count of filtered items (e.g., "Showing 12 items")
- Current sort order is maintained when filtering

---

### US-5: Sorting Products
**As a** user viewing sale items  
**I want to** sort products by different criteria  
**So that** I can find items that best match my preferences

**Acceptance Criteria:**
- Sort dropdown appears on right side of controls (desktop) or below filter (mobile)
- Dropdown label reads "Sort by"
- Options include:
  - "Featured" (default)
  - "Best Selling"
  - "Alphabetically, A-Z"
  - "Alphabetically, Z-A"
  - "Price: Low to High"
  - "Price: High to Low"
  - "Date, old to new"
  - "Date, new to old"
- "Featured" is selected by default
- Clicking dropdown opens menu showing all options
- Selecting a sort option immediately reorders products
- Current category filter is maintained when sorting
- Current page is maintained if still valid after sorting
- Page resets to 1 if current page exceeds new total after sort

---

### US-6: Navigating Through Pages
**As a** user browsing multiple pages of sale items  
**I want to** navigate between pages using arrow buttons  
**So that** I can view all available products

**Acceptance Criteria:**
- Pagination controls appear centered below product grid
- Controls include: Previous button (←), Page indicator, Next button (→)
- Page indicator shows "Page X of Y" format
- Previous button is disabled on page 1
- Next button is disabled on last page
- Clicking Next advances to next page and scrolls to top
- Clicking Previous goes to previous page and scrolls to top
- Page indicator updates correctly
- Total pages recalculate when filters change
- Current page stays valid or resets to 1 if out of range

---

### US-7: Viewing Product Details
**As a** user interested in a specific product  
**I want to** click on a product card  
**So that** I can view more details and purchase

**Acceptance Criteria:**
- Clicking any product card navigates to '/product' route
- Product details are passed to product page (if applicable)
- Navigation transition is smooth
- Hover effect shows on desktop (scale/shadow increase)
- Tap feedback shows on mobile (ripple effect)
- Back button returns to Sale page
- Browser back button works correctly

---

### US-8: Responsive Sale Page Layout
**As a** user viewing the Sale page on different devices  
**I want** the layout to adapt to my screen size  
**So that** I can browse comfortably regardless of device

**Acceptance Criteria:**
- Desktop (>800px): 3-column grid, horizontal filter/sort row, 40px padding
- Tablet (600-800px): 2-column grid, horizontal filter/sort row, 32px padding
- Mobile (<600px): 1-column grid, vertical filter/sort stack, 24px padding
- Header switches between desktop/mobile layouts at 800px
- Products per page adjust based on grid columns (9 for 3-col, 6 for 2-col, 9 for 1-col)
- Page doesn't overflow or break at any width
- Scrolling is smooth on all devices
- Touch targets are minimum 44x44 logical pixels

---

### US-9: Handling Empty States
**As a** user applying filters that return no results  
**I want to** see a helpful message  
**So that** I know the filter worked but found nothing

**Acceptance Criteria:**
- Message displays when filtered category has no products
- Message reads: "No products found in this category"
- Option to clear filter or return to "All Categories" is provided
- Message is centered and clearly visible
- Pagination controls hide when no products
- Filter and sort controls remain accessible
- User can easily change category or sort to see products again

---

### US-10: Consistent Experience Across Pages
**As a** user navigating between pages  
**I want** the header to look and function identically on all pages  
**So that** I have a consistent, predictable experience

**Acceptance Criteria:**
- Header appearance is identical on Home, About, and Sale pages
- Purple banner displays on all pages
- Logo, navigation, and utility icons positioned consistently
- Responsive behavior works the same across pages
- Mobile menu operates identically on all pages
- Color scheme and styling are consistent
- SALE! button is highlighted when on Sale page

---

## 3. Functional Requirements

### FR-1: Sale Page Creation
- **FR-1.1**: Create new file `lib/views/sale_page.dart`
- **FR-1.2**: Implement SalePage widget as StatefulWidget for managing filters, sort, and pagination state
- **FR-1.3**: Include AppHeader component at top with currentRoute: '/sale'
- **FR-1.4**: Include white content area with heading, subheading, filters, grid, and pagination
- **FR-1.5**: Implement responsive layout with 800px and 600px breakpoints
- **FR-1.6**: Handle state changes for category, sort, and page navigation
- **FR-1.7**: Implement SingleChildScrollView for vertical scrolling

### FR-2: Product Data Model
- **FR-2.1**: Create `lib/models/sale_product.dart` file (optional, can be in same file)
- **FR-2.2**: Define SaleProduct class with fields:
  - `String id` - Unique product identifier
  - `String title` - Product name
  - `double originalPrice` - Price before discount
  - `double salePrice` - Discounted price
  - `String imageUrl` - Path to product image
  - `String category` - One of: "Clothing", "Merchandise", "PSUT"
  - `DateTime saleEndDate` - When sale expires (for future features)
- **FR-2.3**: Add computed property `discountPercentage` that calculates percentage off
- **FR-2.4**: Create mock data list with 10-20 sample products
- **FR-2.5**: Ensure realistic product names and prices (£5-£50 range)
- **FR-2.6**: Mix categories evenly across mock products

### FR-3: Heading Section
- **FR-3.1**: "SALE!" heading with fontSize 48, bold, purple color `Color(0xFF4d2963)`
- **FR-3.2**: Subheading text: "Don't miss out on our amazing deals! Limited time offers on selected items."
- **FR-3.3**: Subheading fontSize 18, grey[700], centered alignment
- **FR-3.4**: Top padding: 64px from AppHeader
- **FR-3.5**: Bottom padding: 32px before filter controls
- **FR-3.6**: Heading centered horizontally on page

### FR-4: Filter & Sort Controls
- **FR-4.1**: Container for controls with horizontal Row layout on desktop (>600px)
- **FR-4.2**: Container switches to vertical Column layout on mobile (≤600px)
- **FR-4.3**: Category filter dropdown on left (desktop) or top (mobile)
- **FR-4.4**: Sort dropdown on right (desktop) or below filter (mobile)
- **FR-4.5**: Spacing between controls: 16px
- **FR-4.6**: Controls centered on page with max-width constraint
- **FR-4.7**: Both dropdowns have consistent styling (border, padding, colors)

### FR-5: Category Filter Implementation
- **FR-5.1**: DropdownButton with label "Category"
- **FR-5.2**: Options: "All Categories", "Clothing", "Merchandise", "PSUT"
- **FR-5.3**: Default selection: "All Categories"
- **FR-5.4**: Border: 1px solid grey[300]
- **FR-5.5**: Padding: 12px horizontal, 8px vertical
- **FR-5.6**: Min width: 180px
- **FR-5.7**: Dropdown icon: standard Material dropdown arrow
- **FR-5.8**: OnChanged callback updates `_selectedCategory` state
- **FR-5.9**: Triggers `_applyFilters()` method to update displayed products
- **FR-5.10**: Resets `_currentPage` to 1 when filter changes

### FR-6: Sort Implementation
- **FR-6.1**: DropdownButton with label "Sort by"
- **FR-6.2**: Options:
  - "Featured" (default, original order)
  - "Best Selling"
  - "Alphabetically, A-Z"
  - "Alphabetically, Z-A"
  - "Price: Low to High"
  - "Price: High to Low"
  - "Date, old to new"
  - "Date, new to old"
- **FR-6.3**: Default selection: "Featured"
- **FR-6.4**: Same styling as category filter (border, padding, min-width: 200px)
- **FR-6.5**: OnChanged callback updates `_selectedSort` state
- **FR-6.6**: Triggers `_applySorting()` method to reorder displayed products
- **FR-6.7**: Maintains current category filter when sorting
- **FR-6.8**: Attempts to maintain current page if still valid

### FR-7: Product Grid Layout
- **FR-7.1**: Use GridView.builder or GridView.count for grid
- **FR-7.2**: Desktop (>800px): 3 columns (crossAxisCount: 3)
- **FR-7.3**: Tablet (600-800px): 2 columns (crossAxisCount: 2)
- **FR-7.4**: Mobile (<600px): 1 column (crossAxisCount: 1)
- **FR-7.5**: Cross-axis spacing: 24px
- **FR-7.6**: Main-axis spacing: 32px
- **FR-7.7**: Grid padding: 40px desktop, 32px tablet, 24px mobile
- **FR-7.8**: Display paginated subset of filtered/sorted products
- **FR-7.9**: Each cell uses ProductCard or enhanced variant

### FR-8: Product Card Design
- **FR-8.1**: Reuse or enhance existing ProductCard widget
- **FR-8.2**: Product image with 1:1 or 4:3 aspect ratio
- **FR-8.3**: Product title below image (max 2 lines, ellipsis overflow)
- **FR-8.4**: Original price with strikethrough and grey[600] color
- **FR-8.5**: Sale price bold, purple `Color(0xFF4d2963)`, larger font
- **FR-8.6**: Optional discount badge at top-right corner
- **FR-8.7**: Hover effect on desktop: scale 1.02 or shadow increase
- **FR-8.8**: Tap ripple effect on mobile
- **FR-8.9**: OnTap navigates to '/product' route
- **FR-8.10**: Image error handling with placeholder icon

### FR-9: Pagination Controls
- **FR-9.1**: Row container centered horizontally below grid
- **FR-9.2**: Top margin: 48px from grid
- **FR-9.3**: Previous button (IconButton with left arrow icon)
- **FR-9.4**: Page indicator text in center
- **FR-9.5**: Next button (IconButton with right arrow icon)
- **FR-9.6**: Spacing between elements: 16px
- **FR-9.7**: Button size: 48x48px
- **FR-9.8**: Page indicator format: "Page X of Y"
- **FR-9.9**: Page indicator fontSize: 16, color: grey[700]
- **FR-9.10**: Buttons disabled when at first/last page

### FR-10: Pagination Logic
- **FR-10.1**: Products per page: 9 (constant)
- **FR-10.2**: Calculate `_totalPages`: `ceil(_filteredProducts.length / 9)`
- **FR-10.3**: Calculate displayed products: `_filteredProducts.skip((_currentPage - 1) * 9).take(9)`
- **FR-10.4**: Previous button OnPressed: decrement `_currentPage`, setState, scroll to top
- **FR-10.5**: Next button OnPressed: increment `_currentPage`, setState, scroll to top
- **FR-10.6**: Disable Previous when `_currentPage == 1`
- **FR-10.7**: Disable Next when `_currentPage == _totalPages`
- **FR-10.8**: Reset to page 1 when filters change
- **FR-10.9**: Validate current page doesn't exceed total pages after filter/sort
- **FR-10.10**: Auto-scroll to top of grid on page change

### FR-11: State Management
- **FR-11.1**: Declare state variables:
  - `List<SaleProduct> _allProducts` - Full product catalog
  - `List<SaleProduct> _filteredProducts` - After category filter
  - `List<SaleProduct> _displayedProducts` - Paginated subset
  - `String _selectedCategory` - Current category ("All Categories" default)
  - `String _selectedSort` - Current sort ("Featured" default)
  - `int _currentPage` - Current page number (starts at 1)
  - `int _totalPages` - Calculated from filtered products
- **FR-11.2**: Initialize `_allProducts` in initState with mock data
- **FR-11.3**: Implement `_applyFilters()` method:
  - Filter `_allProducts` by `_selectedCategory`
  - Update `_filteredProducts`
  - Recalculate `_totalPages`
  - Reset `_currentPage` to 1
  - Call `_applySorting()`
- **FR-11.4**: Implement `_applySorting()` method:
  - Sort `_filteredProducts` based on `_selectedSort`
  - Update `_displayedProducts` with paginated subset
  - Validate `_currentPage` doesn't exceed `_totalPages`
  - Call setState to rebuild
- **FR-11.5**: Implement `_changePage(int newPage)` method:
  - Validate newPage is between 1 and `_totalPages`
  - Update `_currentPage`
  - Update `_displayedProducts` with new paginated subset
  - Scroll to top of grid
  - Call setState to rebuild

### FR-12: Navigation Integration
- **FR-12.1**: Add '/sale' route to MaterialApp routes in main.dart
- **FR-12.2**: Route should return `const SalePage()`
- **FR-12.3**: Update AppHeader SALE! button callback to navigate to '/sale'
- **FR-12.4**: Update AppHeader mobile menu SALE! item to close menu and navigate to '/sale'
- **FR-12.5**: Pass `currentRoute: '/sale'` to AppHeader in SalePage
- **FR-12.6**: Highlight SALE! button when on '/sale' route
- **FR-12.7**: Logo and Home button navigate to '/' route from Sale page
- **FR-12.8**: Product card OnTap navigates to '/product' route
- **FR-12.9**: Browser back button returns to previous page

### FR-13: Responsive Behavior
- **FR-13.1**: Use MediaQuery to get screen width
- **FR-13.2**: Define breakpoints: desktop >800px, tablet 600-800px, mobile <600px
- **FR-13.3**: Adjust grid columns based on breakpoint
- **FR-13.4**: Adjust padding based on breakpoint (40/32/24px)
- **FR-13.5**: Stack filter/sort vertically on mobile (<600px)
- **FR-13.6**: Make dropdowns full-width on mobile
- **FR-13.7**: Recalculate products per page if grid columns change (optional)
- **FR-13.8**: Ensure touch targets are minimum 44x44 on mobile

### FR-14: Visual Design Consistency
- **FR-14.1**: Primary color: `Color(0xFF4d2963)` throughout
- **FR-14.2**: White background: `Colors.white`
- **FR-14.3**: Text colors: black/grey[900] headings, grey[700] body, grey[600] original prices
- **FR-14.4**: Borders: grey[300] on controls
- **FR-14.5**: Sale prices: bold, purple
- **FR-14.6**: Original prices: strikethrough, grey
- **FR-14.7**: Typography consistent with HomeScreen and AboutPage
- **FR-14.8**: Spacing follows 8px grid system (8, 16, 24, 32, 40, 48, 64)

### FR-15: Error Handling & Edge Cases
- **FR-15.1**: Handle empty `_allProducts` list: show "No sale items available" message
- **FR-15.2**: Handle filtered category with no products: show "No products found in this category"
- **FR-15.3**: Provide "Clear filters" or "View all" button in empty state
- **FR-15.4**: Handle last page with fewer than 9 products: display remaining products
- **FR-15.5**: Hide pagination when only 1 page of results
- **FR-15.6**: Show disabled pagination arrows when at boundaries
- **FR-15.7**: Handle image loading errors with placeholder
- **FR-15.8**: Truncate long product names with ellipsis
- **FR-15.9**: Validate page number is always within valid range

---

## 4. Non-Functional Requirements

### NFR-1: Performance
- Sale page loads within 1 second on average connection
- Filtering operation completes within 100ms
- Sorting operation completes within 100ms
- Page navigation is instant (no visible delay)
- No flickering or layout shifts during state changes
- Smooth 60 FPS animations on hover effects
- Grid scrolling is smooth and responsive
- No frame drops when resizing window

### NFR-2: Maintainability
- Code is well-commented explaining complex logic (especially filtering/sorting/pagination)
- Helper methods are extracted and clearly named
- State management is straightforward and easy to understand
- Product data model is easily extensible for future features
- Filtering and sorting logic can be easily modified or extended
- Pagination logic is reusable for other pages if needed

### NFR-3: Accessibility
- Touch targets are minimum 44x44 logical pixels
- Text contrast meets WCAG AA standards
- Focus states are visible on interactive elements
- Dropdown menus are keyboard navigable
- Product cards are keyboard accessible
- Pagination buttons support keyboard navigation
- Screen reader support for price information (sale vs original)

### NFR-4: Code Quality
- Follows existing code style and conventions
- Uses const constructors where applicable
- No Dart analyzer warnings or errors
- Proper null safety handling throughout
- Consistent naming conventions (`_privateVariables`, `publicMethods`)
- Efficient list operations (avoid unnecessary copying)
- State updates are batched appropriately

### NFR-5: Responsive Design
- Content readable on screens from 320px to 1920px width
- Grid adapts smoothly at breakpoints (600px, 800px)
- Filter/sort controls don't overflow at any width
- Product cards maintain aspect ratio at all sizes
- Images scale appropriately without distortion
- Layout doesn't break at any screen width
- Mobile menu works on touch devices
- Pagination controls remain accessible on mobile

### NFR-6: User Experience
- Filtering provides immediate visual feedback
- Sorting shows clear indication of current order
- Pagination clearly shows current position
- Empty states are helpful and actionable
- Hover effects provide clear affordance
- Touch feedback is immediate and visible
- Loading states are smooth (if added)
- Transitions are smooth and not jarring

---

## 5. Technical Constraints

### TC-1: Component Architecture
- SalePage must be StatefulWidget to manage filter/sort/page state
- Reuse AppHeader component from `lib/widgets/app_header.dart`
- Reuse or enhance existing ProductCard widget
- Product data can be mock list in-file or separate data service
- No additional package dependencies required

### TC-2: Styling Requirements
- Primary color: `Color(0xFF4d2963)` (purple)
- White: `Colors.white`
- Grey shades: `Colors.grey[300]`, `Colors.grey[600]`, `Colors.grey[700]`, `Colors.grey[900]`
- Font sizes: 48px (heading), 18px (subheading), 16px (prices, indicators), 14px (product titles)
- Consistent spacing: 8px, 16px, 24px, 32px, 40px, 48px, 64px
- Borders: 1px solid grey[300]

### TC-3: Flutter Specifics
- Use standard Material widgets (DropdownButton, GridView, IconButton, etc.)
- Use MediaQuery for responsive breakpoints
- Use Navigator.pushNamed for route navigation
- Compatible with hot reload during development
- Works with existing theme configuration
- Supports browser back button navigation

### TC-4: Data Requirements
- Minimum 10-20 mock products for testing pagination
- Mix of categories: approximately equal distribution
- Price range: £5-£50 original, 10-70% discounts
- Realistic product names (university-themed)
- Placeholder images can reuse existing assets or use AssetImage

### TC-5: File Organization
- `lib/views/sale_page.dart` for SalePage widget
- Optional: `lib/models/sale_product.dart` for product model
- Optional: `lib/widgets/sale_product_card.dart` for enhanced card
- Update `lib/main.dart` for route registration
- Update `lib/widgets/app_header.dart` for SALE! navigation

---

## 6. Acceptance Criteria Summary

The feature is considered **complete** when:

### Sale Page Implementation
- [ ] `lib/views/sale_page.dart` file created with SalePage StatefulWidget
- [ ] AppHeader component integrated at top with currentRoute: '/sale'
- [ ] "SALE!" heading and subheading displayed with correct styling
- [ ] White background applied to entire page
- [ ] Responsive padding implemented (40px desktop, 32px tablet, 24px mobile)
- [ ] Page is scrollable vertically

### Product Data & Model
- [ ] SaleProduct class created with all required fields
- [ ] discountPercentage computed property implemented
- [ ] Mock product list created with 10-20 items
- [ ] Products evenly distributed across categories
- [ ] Realistic product names and prices
- [ ] Placeholder images assigned to each product

### Filter Functionality
- [ ] Category dropdown displays with correct label and styling
- [ ] All category options present: "All Categories", "Clothing", "Merchandise", "PSUT"
- [ ] "All Categories" selected by default
- [ ] Selecting category filters products correctly
- [ ] Page resets to 1 when filter changes
- [ ] Total pages recalculate based on filtered results
- [ ] Current sort order maintained when filtering
- [ ] Filter dropdown full-width on mobile

### Sort Functionality
- [ ] Sort dropdown displays with correct label and styling
- [ ] All sort options present (Featured, Best Selling, Alphabetically A-Z/Z-A, Price Low-High/High-Low, Date old-new/new-old)
- [ ] "Featured" selected by default
- [ ] Selecting sort reorders products correctly
- [ ] Current category filter maintained when sorting
- [ ] Current page maintained if still valid after sorting
- [ ] Sort dropdown full-width on mobile

### Product Grid
- [ ] Grid displays with correct column count per breakpoint (3/2/1)
- [ ] Grid spacing correct (24px horizontal, 32px vertical)
- [ ] 9 products displayed per page (paginated subset)
- [ ] Product cards show image, title, original price, sale price
- [ ] Original price has strikethrough and grey color
- [ ] Sale price is bold and purple
- [ ] Hover effect works on desktop
- [ ] Tap ripple effect works on mobile
- [ ] Clicking product navigates to '/product' route
- [ ] Image error handling displays placeholder

### Pagination
- [ ] Pagination controls appear centered below grid
- [ ] Previous button (←), page indicator, Next button (→) present
- [ ] Page indicator shows "Page X of Y" format
- [ ] Previous disabled on page 1
- [ ] Next disabled on last page
- [ ] Clicking Next advances to next page and scrolls to top
- [ ] Clicking Previous goes to previous page and scrolls to top
- [ ] Page indicator updates correctly
- [ ] Total pages recalculate when filters change
- [ ] Current page validates and resets if out of range

### Navigation Integration
- [ ] '/sale' route registered in main.dart MaterialApp routes
- [ ] Desktop SALE! button navigates to '/sale' route
- [ ] Mobile menu SALE! item navigates to '/sale' route
- [ ] Mobile menu closes before navigating
- [ ] SALE! button highlighted when on '/sale' route
- [ ] Logo navigation returns to home from Sale page
- [ ] Home button returns to home from Sale page
- [ ] Browser back button works correctly

### Responsive Behavior
- [ ] Desktop layout (>800px): 3 columns, horizontal filters, 40px padding
- [ ] Tablet layout (600-800px): 2 columns, horizontal filters, 32px padding
- [ ] Mobile layout (<600px): 1 column, vertical filters, 24px padding
- [ ] Filter/sort controls stack vertically on mobile
- [ ] Dropdowns full-width on mobile
- [ ] Header switches between desktop/mobile at 800px
- [ ] No layout breaking at any width
- [ ] Touch targets minimum 44x44 on mobile

### Visual Consistency
- [ ] Purple theme color used throughout (`Color(0xFF4d2963)`)
- [ ] Typography matches existing pages
- [ ] Spacing follows 8px grid system
- [ ] Border styling consistent (grey[300])
- [ ] Sale prices bold purple
- [ ] Original prices strikethrough grey
- [ ] Overall design matches HomeScreen and AboutPage

### Error Handling
- [ ] Empty product list shows "No sale items available"
- [ ] Filtered category with no products shows appropriate message
- [ ] "Clear filters" or "View all" option in empty state
- [ ] Last page displays remaining products (even if < 9)
- [ ] Single page hides or disables pagination appropriately
- [ ] Image loading errors show placeholder
- [ ] Long product names truncate with ellipsis

### Code Quality
- [ ] Code follows existing conventions
- [ ] Helpful comments explain complex logic
- [ ] Const constructors used where possible
- [ ] No Dart analyzer warnings
- [ ] No console errors
- [ ] Proper null safety handling
- [ ] Efficient list operations
- [ ] State management is clear and maintainable

### Testing
- [ ] Manual testing on desktop (>800px)
- [ ] Manual testing on tablet (600-800px)
- [ ] Manual testing on mobile (<600px)
- [ ] Window resize testing completed
- [ ] All filtering scenarios tested
- [ ] All sorting scenarios tested
- [ ] Pagination navigation tested
- [ ] Product navigation verified
- [ ] Mobile menu interaction tested
- [ ] Empty states tested
- [ ] Edge cases verified (last page, single page, etc.)
- [ ] No regression in existing features

---

## 7. Out of Scope

The following are explicitly **not** included in this feature:

- Real product data from backend API
- Database integration or data persistence
- User authentication or personalized sale items
- Shopping cart integration from Sale page
- Product quick view modal
- Wishlist/favorites functionality
- Product comparison feature
- Search bar for filtering by keyword
- Price range filter slider
- Multiple category selection (checkboxes)
- Advanced filtering (size, color, brand, etc.)
- Sale countdown timer ("Ending in X hours")
- Stock level indicators
- Product ratings or reviews on cards
- "Recently Viewed" section
- "Recommended for You" section
- Email signup for sale notifications
- Social sharing buttons
- Print-friendly sale page
- Export sale items to PDF
- SEO optimization or meta tags
- Analytics tracking for filter/sort usage
- A/B testing different layouts
- Accessibility audit beyond basic requirements
- Unit tests or widget tests
- Integration tests
- Performance profiling

---

## 8. Implementation Guidance

### Recommended Approach

#### **Phase 1 - Data Model & Mock Data**
1. Create SaleProduct class with all required fields
2. Add discountPercentage computed property
3. Create mock product list with 10-20 items
4. Distribute products across categories
5. Assign realistic names, prices, and images
6. Test data structure is correct

#### **Phase 2 - Basic Page Structure**
1. Create sale_page.dart file with SalePage StatefulWidget
2. Add AppHeader component with currentRoute: '/sale'
3. Add heading section (title and subheading)
4. Set up white background and responsive padding
5. Register '/sale' route in main.dart
6. Update AppHeader to navigate to '/sale' and highlight button
7. Test navigation works from desktop and mobile

#### **Phase 3 - Product Grid**
1. Initialize state variables (_allProducts, _filteredProducts, _displayedProducts)
2. Implement responsive grid with correct column counts
3. Reuse or enhance ProductCard for sale products
4. Display initial 9 products (page 1, all categories, featured sort)
5. Test grid displays correctly on all screen sizes
6. Test product card click navigates to product page

#### **Phase 4 - Filtering**
1. Add category dropdown with correct options
2. Implement _applyFilters() method
3. Update _filteredProducts based on _selectedCategory
4. Reset _currentPage to 1 on filter change
5. Recalculate _totalPages
6. Test filtering updates grid correctly
7. Test "All Categories" shows all products

#### **Phase 5 - Sorting**
1. Add sort dropdown with all options
2. Implement _applySorting() method
3. Sort _filteredProducts based on _selectedSort
4. Update _displayedProducts with paginated subset
5. Maintain current page if valid, reset to 1 if not
6. Test all sort options work correctly
7. Test sorting maintains category filter

#### **Phase 6 - Pagination**
1. Implement pagination controls (Previous, Indicator, Next)
2. Implement _changePage() method
3. Calculate _totalPages from _filteredProducts
4. Update _displayedProducts with correct subset based on _currentPage
5. Disable buttons at boundaries
6. Add scroll-to-top on page change
7. Test pagination navigates correctly
8. Test pagination updates when filters/sort change

#### **Phase 7 - Empty States & Error Handling**
1. Add empty state message for no products
2. Add empty state for filtered category with no results
3. Add "Clear filters" or "View all" button
4. Handle last page with fewer products
5. Handle single page (hide/disable pagination)
6. Test all edge cases

#### **Phase 8 - Responsive Refinements**
1. Test all breakpoints (320px, 600px, 800px, 1200px, 1920px)
2. Ensure filter/sort stack on mobile
3. Verify touch targets are adequate
4. Test mobile menu integration
5. Fix any layout issues

#### **Phase 9 - Visual Polish**
1. Verify colors match theme (`Color(0xFF4d2963)`)
2. Check spacing follows 8px grid
3. Test hover effects on desktop
4. Test tap feedback on mobile
5. Ensure typography is consistent
6. Add any final visual refinements

#### **Phase 10 - Testing & Documentation**
1. Manual testing on multiple devices/browsers
2. Test all user stories and acceptance criteria
3. Verify no regressions in existing features
4. Add code comments explaining complex logic
5. Document any assumptions or decisions
6. Prepare for code review

### Key Design Decisions to Document

1. **State Management Approach**: Document why you chose local state vs provider/bloc
2. **Pagination Calculation**: Explain how products per page is determined and calculated
3. **Filter/Sort Interaction**: Document how filters and sorts interact (order of operations)
4. **Product Data Structure**: Explain product model fields and computed properties
5. **Responsive Breakpoints**: Document why 600px and 800px were chosen
6. **Empty State Handling**: Explain different empty state scenarios and messages
7. **Performance Optimizations**: Note any caching or efficiency improvements
8. **Future Extensibility**: Comment on how to easily add new categories or sort options

### Testing Strategy

**Manual Testing Checklist:**
- [ ] Desktop navigation to Sale page
- [ ] Mobile navigation to Sale page
- [ ] Filter by each category individually
- [ ] Return to "All Categories" filter
- [ ] Sort by each option individually
- [ ] Combine filtering and sorting
- [ ] Navigate through all pages
- [ ] Test pagination at boundaries (page 1, last page)
- [ ] Filter to reduce products and verify pagination updates
- [ ] Resize window across all breakpoints
- [ ] Click product cards to verify navigation
- [ ] Test back button returns correctly
- [ ] Verify SALE! button highlighted on Sale page
- [ ] Test empty states (no products, filtered no results)
- [ ] Verify image error handling
- [ ] Test touch targets on mobile
- [ ] Check text truncation on long product names

**Edge Cases to Test:**
- [ ] Single page of results (≤9 products)
- [ ] Exactly 9 products (one full page)
- [ ] 10 products (two pages, last page has 1 item)
- [ ] Empty product list (no mock data)
- [ ] Category with 0 products
- [ ] Very long product names
- [ ] Missing product images
- [ ] Window resize during filtering/sorting
- [ ] Rapid filter/sort changes
- [ ] Navigation while on page 5+ of results

---

## 9. Future Enhancements

Potential improvements for future iterations:

### Phase 2 Enhancements
1. **Search Functionality**: Add search bar to filter by product name/description
2. **Price Range Filter**: Slider to filter by minimum/maximum price
3. **Multiple Category Selection**: Checkboxes to select multiple categories at once
4. **Discount Badge**: Visual badge on cards showing percentage off
5. **Sort by Discount**: Add "Discount: High to Low" sort option
6. **Product Count Indicator**: Show "Showing X of Y products" above grid

### Phase 3 Enhancements
1. **Sale Countdown**: Show "Sale ends in X hours" on products
2. **Stock Indicators**: Show "Low stock" or "Only X left" warnings
3. **Quick View**: Modal popup with product details on hover/click
4. **Wishlist Integration**: Heart icon to save favorite sale items
5. **Comparison Feature**: Select products to compare side-by-side
6. **Recently Viewed**: Show recently viewed sale products

### Phase 4 Enhancements
1. **Backend Integration**: Connect to real product API
2. **Persistent State**: Save filter/sort/page in URL parameters
3. **Loading States**: Skeleton screens while loading products
4. **Animations**: Fade-in products when page changes
5. **Infinite Scroll**: Load more products as user scrolls (alternative to pagination)
6. **Product Recommendations**: "You might also like" section

### Phase 5 Enhancements
1. **Email Notifications**: Sign up for sale alerts
2. **Social Sharing**: Share favorite sale products
3. **Advanced Analytics**: Track filter/sort usage, popular products
4. **A/B Testing**: Test different layouts and features
5. **Accessibility Improvements**: Full WCAG AAA compliance
6. **Performance Optimization**: Lazy loading, image optimization