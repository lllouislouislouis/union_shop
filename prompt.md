# Clothing Page — Feature Implementation Prompt

Goal
- Implement the Clothing collection page with the same structure, components, and interactions as the Sale page: “Filter By”, “Sort By”, and “Product Count”. 
- Ensure routing from Collections -> Clothing, accessible controls, and performance comparable to the Sale page.

Page Structure
- Header:
  - Title: “Clothing”
  - Optional breadcrumb
  - Product count (“X products”)
- Controls Bar (reused from Sale page if possible):
  - Filter By: multi-select filters
  - Sort By: dropdown (Popularity, Price Low→High, Price High→Low, Newest)
  - Product Count: updates after filters/sort
- Product Grid:
  - Responsive grid of product cards (reuse Sale page card component)
  - Columns: >800px: 3–4; ≤800px: 1–2
  - Consistent spacing and pagination/lazy-load if already supported

Data/State
- Use the same state management pattern as the Sale page (setState/Provider/Riverpod/Bloc).
- Inputs:
  - Products source: clothing category items from catalog or mock data
  - Filters model: identical to Sale page
  - Sort model: identical to Sale page
- Outputs:
  - Filtered + sorted product list
  - Product count after filters applied
  - Grid re-render on filter/sort change

Behavior & Actions
- Filter By:
  - Description: Users select/deselect filter options to narrow the clothing products.
  - Action: On change, recompute filtered list and refresh grid and count.
  - Clear Filters: Resets all filters; grid shows all clothing items; count updates.
- Sort By:
  - Description: Users choose a sort option (Popularity, Price Low→High, Price High→Low, Newest).
  - Action: On change, reorder the current filtered list, then re-render grid.
- Product Count:
  - Description: Displays the number of products currently visible after filters/sort.
  - Action: Updates immediately after any filter or sort change.
- Routing:
  - Description: Clicking “Clothing” collection tile navigates to the clothing page.
  - Action: Navigate via '/shop/clothing' or ShopCategoryPage(category: 'clothing'). Product card click opens ProductPage.

Accessibility
- Controls are focusable, labeled, and keyboard operable (Enter/Space).
- Product cards have semantic labels including product name and price.
- Ensure contrast and visible focus indicators.

Performance
- Avoid unnecessary rebuilds (reuse widgets, memoize filtered results where appropriate).
- Debounce expensive operations if necessary (e.g., text filter).

Acceptance Criteria
- Clothing page renders with Filter By, Sort By, and Product Count identical to the Sale page.
- Filtering updates the grid and count immediately.
- Sorting reorders products correctly for each option.
- Product count reflects the filtered list accurately.
- Navigation from Collections -> Clothing opens the page.
- Keyboard navigation and screen reader semantics work for controls and product cards.

Implementation Notes
- If using ShopCategoryPage:
  - Add a config to enable sale-like controls when category == 'clothing'.
  - Inject filter/sort options via constructor/provider, mirroring Sale page configuration.
- If creating a dedicated ClothingPage:
  - Scaffold with AppScaffold.
  - Extract and reuse Sale page controls bar and product card components.
  - Query products where category == 'clothing'; apply filters and sorting in memory or via service.

Deliverables
- New view or configured ShopCategoryPage for clothing.
- Reused controls and product card components from Sale page.
- Unit/widget tests:
  - Changing filters reduces product count and updates cards.
  - Changing sort option reorders products.
  - Navigation from Collections -> Clothing works.