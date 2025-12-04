# Clothing Page — Feature Requirements

## 1. Feature overview
Description
- Implement a Clothing collection page that displays clothing products with filtering, sorting, and product count capabilities identical to the Sale page.
- **Filter and sort controls must have the exact same options and functionality as the Sale page.**
- Only one filter can be selected at a time (no multi-select); there is **no "Reset Filters" button** (same as Sale page).
- Reuse Sale page components (FilterBar, SortDropdown, ProductGrid, ProductCard) to maintain consistency and reduce duplication.
- Integrate with existing navigation from Collections page and ensure accessible, responsive design.

Purpose
- Provide users with a dedicated, filterable view of clothing products.
- Enable discovery through filters (All products, clothing, merchandise, popular) and sorting options.
- Maintain UX consistency across collection pages (Clothing, Sale, etc.).

Scope
- Configure ShopCategoryPage to support clothing category with Sale-like controls, OR create a dedicated ClothingPage view.
- Reuse existing filter/sort components and state management from Sale page.
- Ensure routing from Collections -> Clothing works via '/shop/clothing' or ShopCategoryPage(category: 'clothing').
- Add tests verifying filtering, sorting, product count updates, and navigation.

## 2. User stories

US-1: Browse clothing products (visitor/shopper)
- As a shopper, I want to view all clothing products in a grid so I can browse available items.
- Expected: Page shows product cards with images, names, prices; count displays total products.

US-2: Filter clothing products (shopper)
- As a shopper, I want to filter by all products, clothing, merchandise and popular so I can narrow results to my preferences.
- Expected: Selecting a filter updates the grid immediately; count shows filtered total.
- **Only one filter can be selected at a time, and there is no reset filters button (identical to Sale page).**

US-3: Sort clothing products (shopper)
- As a shopper, I want to sort by Popularity, Price (Low→High, High→Low), and Newest so I can find items that match my priorities.
- Expected: Changing sort reorders products; grid updates; count remains accurate.

US-4: Navigate from Collections (visitor)
- As a visitor, I want to click the "Clothing" tile on the Collections page so I can view clothing products.
- Expected: Tapping tile navigates to Clothing page; products load immediately.

US-5: Mobile shopping (mobile user)
- As a mobile user, I want filters/sort controls and product cards to be touch-friendly and stack vertically so I can browse comfortably on small screens.
- Expected: Single or dual column grid; controls accessible and tappable; no horizontal overflow.

US-6: Keyboard navigation (accessibility user)
- As a keyboard user, I want to tab through filters, sort options, and product cards so I can navigate without a mouse.
- Expected: All controls focusable; Enter/Space activates; focus indicators visible.

US-7: Developer/maintainer
- As a developer, I want to reuse Sale page components and state logic so the Clothing page is easy to maintain and extend.

## 3. Acceptance criteria

Page structure & layout
- AC-1: Page title displays "Clothing" at the top.
- AC-2: Product count displays "X products" and updates after filters/sort.
- AC-3: Controls bar includes "Filter By" (multi-select) and "Sort By" (dropdown), identical to Sale page.
- AC-4: Product grid is responsive: >800px: 3–4 columns; ≤800px: 1–2 columns.
- AC-5: Spacing and card design match Sale page for consistency.

Filtering behavior
- AC-6: Filter By includes options: all products, clothing, merchandise and popular.
- AC-7: Selecting a filter immediately updates:
  - Filtered product list displayed in grid
  - Product count
- **AC-8: Only one filter can be selected at a time (no multi-select, no reset button), matching Sale page behavior.**
- **AC-9: Filter and sort controls/options are exactly the same as on the Sale page.**

Sorting behavior
- AC-10: Sort By dropdown includes: Popularity, Price Low→High, Price High→Low, Newest.
- AC-11: Changing sort option reorders the current filtered list and re-renders grid.
- AC-12: Product count remains accurate after sorting (no change in count, only order).

Product count
- AC-13: Count displays total products after filters applied.
- AC-14: Count updates immediately after any filter or sort change.

Navigation & routing
- AC-15: Clicking "Clothing" tile on Collections page navigates to '/shop/clothing' or ShopCategoryPage(category: 'clothing').
- AC-16: Clicking a product card navigates to ProductPage for that item.
- AC-17: Browser back button returns to Collections page.

Accessibility
Performance
- AC-22: Filtering and sorting complete within 300ms for typical product counts (<500 items).
- AC-23: Grid renders efficiently; avoid unnecessary rebuilds (use keys, const widgets, memoization).

Testing & QA
- AC-24: Widget tests confirm:
  - Changing a filter reduces product count and updates grid.
  - Changing sort option reorders products correctly.
  - Navigation from Collections -> Clothing works.
  - Accessibility semantics present on controls and cards.
- AC-25: Manual QA at widths: 360px, 800px, 1200px shows correct layout and no overflow.

## 4. Functional requirements (summary)

FR-1 Page structure
- FR-1.1: Use AppScaffold with currentRoute='/shop/clothing'.
- FR-1.2: Display page title "Clothing" and product count in header/controls bar.
- FR-1.3: Include FilterBar and SortDropdown components from Sale page.
- FR-1.4: Display ProductGrid with responsive columns.

FR-2 Data & state
- FR-2.1: Load products where category == 'clothing' from catalog or mock data.
- FR-2.2: Use same state management pattern as Sale page (setState/Provider/Riverpod/Bloc).
- FR-2.3: State includes:
  - allProducts: List<Product> (clothing items)
  - activeFilters: Map<String, dynamic> (all products, clothing, merchandise, popular)
  - sortOption: String (e.g., 'price-asc', 'newest')
  - filteredProducts: List<Product> (computed)
- FR-2.4: Recompute filteredProducts when filters or sort changes.

FR-3 Filtering
- FR-3.1: Reuse FilterBar widget from Sale page.
- FR-3.2: Filter options:
  - All products
  - Clothing
  - Merchandise
  - Popular
- **FR-3.2.1: Only one filter can be selected at a time (no multi-select, no reset button), matching Sale page.**
- FR-3.3: Apply filters to allProducts; update filteredProducts and count.

FR-4 Sorting
- FR-4.1: Reuse SortDropdown widget from Sale page.
- FR-4.2: Sort options:
  - Popularity (if popularity data available; else omit or use placeholder)
  - Price Low→High
  - Price High→Low
  - Newest (if date added available)
- **FR-4.2.1: Sort options and logic must match Sale page exactly.**
- FR-4.3: Apply sort to filteredProducts; re-render grid.

FR-5 Product grid
- FR-5.1: Reuse ProductGrid and ProductCard widgets from Sale page.
- FR-5.2: Responsive columns: >800px: 3–4; ≤800px: 1–2.
- FR-5.3: Grid spacing: 16px between cards; 24px outer padding.
- FR-5.4: Each card shows image, name, price, optional badge (e.g., "New").

FR-6 Navigation
- FR-6.1: Route '/shop/clothing' maps to ShopCategoryPage(category: 'clothing') or dedicated ClothingPage.
- FR-6.2: Clicking product card navigates to ProductPage(productId: item.id).
- FR-6.3: Ensure route is registered in main.dart routes.

FR-7 Accessibility
- FR-7.1: Wrap controls in Semantics with appropriate labels.
- FR-7.2: Ensure keyboard navigation via Focus widgets.
- FR-7.3: Product cards have semantic labels and minimum 44x44 touch targets.

## 5. Non-functional requirements

NFR-1 Performance
- Filter/sort operations complete in <300ms for typical product counts.
- Use efficient list operations (where, orderBy) or memoization to avoid expensive rebuilds.

NFR-2 Maintainability
- Reuse Sale page components (FilterBar, SortDropdown, ProductGrid, ProductCard).
- Avoid duplicating filter/sort logic; extract into shared service/provider if needed.
- Keep ClothingPage or ShopCategoryPage config simple and testable.

NFR-3 Consistency
- Match Sale page design and behavior exactly for filters, sorting, and product cards.
- Use same spacing, fonts, colors, and interaction patterns.

NFR-4 Accessibility
- Follow WCAG AA standards for contrast and keyboard navigation.
- Provide semantic labels and focus indicators.

## 6. Implementation notes & examples (brief)

Option A: Configure ShopCategoryPage
- Add a feature flag or config to ShopCategoryPage: enableFiltersAndSort (default false; true for 'clothing' and 'sale').
- Inject filter options and sort options via constructor or provider.
- **Use the exact same filter and sort options as the Sale page.**
- Example:
  ```dart
  ShopCategoryPage(
    category: 'clothing',
    enableFiltersAndSort: true,
    filterOptions: kSaleFilters, // Use same as Sale page
    sortOptions: kSaleSortOptions, // Use same as Sale page
  )
  ```

Option B: Create dedicated ClothingPage
- Scaffold with AppScaffold.
- Import and reuse FilterBar, SortDropdown, ProductGrid from Sale page.
- Query products: `products.where((p) => p.category == 'clothing').toList()`.
- Manage state with setState or provider; mirror Sale page logic.

Recommended: Option A (configure ShopCategoryPage) for DRY and easier maintenance.

## 7. Subtasks (actionable)

- [ ] **Subtask 1**: Identify and extract reusable components from Sale page:
  - FilterBar widget
  - SortDropdown widget (with Popularity, Price, Newest options)
  - ProductGrid and ProductCard widgets
  - Place in `lib/widgets/` if not already extracted.

- [ ] **Subtask 2**: Update ShopCategoryPage to support filters and sorting:
  - Add `enableFiltersAndSort` boolean parameter (default false).
  - Add `filterOptions` and `sortOptions` parameters.
  - When enabled, display FilterBar and SortDropdown above ProductGrid.
  - **FilterBar must allow only one filter to be selected at a time (no reset button), matching Sale page.**
  - Manage filter/sort state with setState or provider.

- [ ] **Subtask 3**: Load clothing products:
  - Query or filter products where category == 'clothing'.
  - Use mock data if catalog not yet available.
  - Ensure at least 10–20 sample clothing products for testing.

- [ ] **Subtask 4**: Implement filtering logic:
  - On filter change, recompute filteredProducts from allProducts.
  - Update product count and re-render grid.

- [ ] **Subtask 5**: Implement sorting logic:
  - On sort change, apply orderBy to filteredProducts.
  - Re-render grid with sorted list.
  - Ensure product count remains accurate (sorting does not change count).

- [ ] **Subtask 6**: Wire navigation:
  - Ensure '/shop/clothing' route exists in main.dart:
    ```dart
    '/shop/clothing': (context) => ShopCategoryPage(
      category: 'clothing',
      enableFiltersAndSort: true,
      filterOptions: kClothingFilters,
      sortOptions: kDefaultSortOptions,
    ),
    ```
  - Verify Collections -> Clothing navigation works.

- [ ] **Subtask 7**: Add accessibility:
  - Wrap FilterBar and SortDropdown in Semantics.
  - Ensure keyboard focus order: Filters -> Sort -> Product Grid.
  - Add semantic labels to product cards.
  - Test with keyboard navigation and screen reader.

- [ ] **Subtask 8**: Add widget tests:
  - Test: Changing a filter updates product count and grid.
  - Test: Changing sort option reorders products.
  - Test: Navigation from Collections -> Clothing.
  - Test: Product card tap navigates to ProductPage.

- [ ] **Subtask 9**: Manual QA:
  - Test at widths: 360px (mobile), 800px (tablet), 1200px (desktop).
  - Verify filters, sorting, product count, and layout.
  - Check keyboard navigation and screen reader.
  - Compare with Sale page for consistency.

- [ ] **Subtask 10**: Performance check:
  - Profile filtering/sorting with 100+ products.
  - Ensure <300ms response time.
  - Optimize with memoization or debouncing if needed.

--- 

End of requirements.
