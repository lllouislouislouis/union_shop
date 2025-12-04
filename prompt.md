# Product Page — Feature Implementation Prompt

Goal
- Implement a fully functional Product Page that displays detailed information for a single product, including image, title, price, customization options (color, size), quantity selection, and purchase actions (Add to Cart, Buy Now).
- Ensure the page is responsive, accessible, and follows the existing app design patterns (reusing AppScaffold, color scheme, typography).
- Support navigation from product cards (Sale page, Clothing page, etc.) and display product-specific data dynamically.

Page Structure
- Header:
  - Uses existing AppScaffold with currentRoute='/product'
  - Back button navigation (browser back or app navigation)
- Product Image Section:
  - Large product image (responsive sizing)
  - Placeholder/error state for missing images
- Product Details Section:
  - Product title (heading style, prominent)
  - Product price (large, bold, purple theme color)
  - Color dropdown (if applicable to product)
  - Size dropdown (if applicable to product)
  - Quantity selector (increment/decrement buttons + number input)
  - Add to Cart button (primary action)
  - Buy Now button (secondary action, proceeds directly to checkout)
  - Product description (multi-line text, supports formatting)
- Layout:
  - Desktop (>800px): Two-column layout (image left, details right)
  - Mobile (≤800px): Single-column layout (image top, details below)
  - Consistent spacing and padding with Sale/Clothing pages

Data/State
- Inputs:
  - Product data: passed via route arguments or fetched by product ID
    - Product model should include: id, title, price, imageUrl, availableColors, availableSizes, description, stock availability
  - Selected options: color, size, quantity (managed in state)
- Outputs:
  - Add to Cart: adds {productId, selectedColor, selectedSize, quantity} to cart state/service
  - Buy Now: navigates to checkout with current product configuration
- State Management:
  - Use same pattern as Sale/Clothing pages (setState, Provider, Riverpod, or Bloc)
  - Track: selectedColor, selectedSize, selectedQuantity
  - Validate: size/color selection required before adding to cart

Behavior & Actions

1. Product Image
   - Description: Displays the main product image prominently.
   - Action: On load, fetch and display image from imageUrl. Show placeholder if loading or error icon if failed.

2. Product Title
   - Description: Displays the product name as a large, bold heading.
   - Action: Static display, no interaction required.

3. Product Price
   - Description: Displays the current price in large, bold text (purple theme color: #4d2963).
   - Action: Static display. If product has sale/original price, show original price struck through next to sale price (similar to SaleProductCard).
   - Format: £XX.XX

4. Color Dropdown
   - Description: A dropdown selector for choosing product color (e.g., Purple, Black, White, Red).
   - Action: User selects a color from the dropdown. Selection updates selectedColor state.
   - Behavior:
     - Default: No color selected initially (show "Select Color" placeholder).
     - On change: Update selectedColor state; enable Add to Cart/Buy Now buttons only if all required options are selected.
   - Validation: If product has colors, user must select one before adding to cart.
   - Accessibility: Dropdown is keyboard navigable and has semantic label "Choose product color".

5. Size Dropdown
   - Description: A dropdown selector for choosing product size (e.g., XS, S, M, L, XL, XXL).
   - Action: User selects a size from the dropdown. Selection updates selectedSize state.
   - Behavior:
     - Default: No size selected initially (show "Select Size" placeholder).
     - On change: Update selectedSize state; enable Add to Cart/Buy Now buttons only if all required options are selected.
   - Validation: If product has sizes, user must select one before adding to cart.
   - Accessibility: Dropdown is keyboard navigable and has semantic label "Choose product size".

6. Quantity Selector
   - Description: A numeric input with increment (+) and decrement (-) buttons to choose quantity.
   - Action:
     - User clicks + button: Increase quantity by 1 (max limit based on stock availability, e.g., max 10 or stock count).
     - User clicks - button: Decrease quantity by 1 (minimum 1, cannot go below).
     - User types in input field: Validate and update quantity (must be positive integer between 1 and max stock).
   - Default: Quantity starts at 1.
   - Validation: Prevent invalid input (e.g., zero, negative, non-numeric).
   - Accessibility: Buttons have semantic labels "Increase quantity" and "Decrease quantity". Input field has label "Quantity".

7. Add to Cart Button
   - Description: Primary action button to add the configured product to the shopping cart.
   - Action:
     - On click: Validate that required options (color, size if applicable) are selected.
     - If valid: Add {productId, selectedColor, selectedSize, selectedQuantity} to cart state/service. Show success feedback (e.g., snackbar "Added to cart!").
     - If invalid: Show error message (e.g., "Please select a color and size").
   - Behavior:
     - Button is disabled (greyed out) until all required options are selected.
     - Button is enabled (purple background, white text) when options are valid.
     - On success: Optional animation or feedback; cart icon badge updates (if implemented).
   - Style: Large button, full width on mobile, fixed width on desktop. Purple background (#4d2963), white text, rounded corners.

8. Buy Now Button
   - Description: Secondary action button to proceed directly to checkout with the current product.
   - Action:
     - On click: Validate that required options (color, size if applicable) are selected.
     - If valid: Navigate to checkout page with {productId, selectedColor, selectedSize, selectedQuantity} as route arguments or state.
     - If invalid: Show error message (e.g., "Please select a color and size").
   - Behavior:
     - Button is disabled (greyed out) until all required options are selected.
     - Button is enabled (white background, purple border/text) when options are valid.
   - Style: Large button, full width on mobile, fixed width on desktop. White background, purple border and text, rounded corners.

9. Product Description
   - Description: Multi-line text area displaying product details, features, materials, care instructions, etc.
   - Action: Static display, no interaction required. Supports line breaks and basic formatting (plain text or simple Markdown).
   - Behavior: Scrollable if description is long; responsive width.

Performance
- Product data loads quickly (<500ms if fetched remotely).
- Image loads efficiently; use placeholders while loading.
- Avoid unnecessary rebuilds; use const widgets where possible.
- Validate inputs synchronously without lag.

Acceptance Criteria
- AC-1: Product page displays product image, title, price, color dropdown, size dropdown, quantity selector, Add to Cart button, Buy Now button, and description.
- AC-2: Selecting a color updates selectedColor state; dropdown shows selected value.
- AC-3: Selecting a size updates selectedSize state; dropdown shows selected value.
- AC-4: Quantity selector increments/decrements correctly (min 1, max based on stock).
- AC-5: Add to Cart button is disabled until required options (color, size) are selected.
- AC-6: Clicking Add to Cart adds product to cart with selected options; shows success feedback.
- AC-7: Buy Now button is disabled until required options are selected.
- AC-8: Clicking Buy Now navigates to checkout with selected product configuration.
- AC-9: Product description displays full text with line breaks and formatting.
- AC-10: Page is responsive: desktop shows two-column layout; mobile shows single-column layout.
- AC-12: Product image shows placeholder while loading and error icon if failed.
- AC-13: Navigation from product cards (Sale, Clothing pages) opens Product page with correct product data.

Functional Requirements (Summary)

FR-1 Page Structure & Layout
- FR-1.1: Use AppScaffold with currentRoute='/product'.
- FR-1.2: Desktop (>800px): Two-column layout (image 50%, details 50%).
- FR-1.3: Mobile (≤800px): Single-column layout (image full width, details below).
- FR-1.4: Consistent padding and spacing with Sale/Clothing pages (24-40px horizontal padding).

FR-2 Data & State
- FR-2.1: Product data includes: id, title, price, originalPrice (optional), imageUrl, availableColors, availableSizes, description, maxStock.
- FR-2.2: State includes: selectedColor, selectedSize, selectedQuantity (default 1).
- FR-2.3: Fetch product data by ID from route arguments or provider.
- FR-2.4: If product is a sale item, display originalPrice (struck through) and salePrice (bold, purple).

FR-3 Product Image
- FR-3.1: Display large product image using imageUrl.
- FR-3.2: Show placeholder while loading; show error icon if image fails to load.
- FR-3.3: Image responsive: max width 100%, maintain aspect ratio.

FR-4 Product Title & Price
- FR-4.1: Display product title as h1 heading (48px font, bold, purple color).
- FR-4.2: Display price as large text (32px font, bold, purple color).
- FR-4.3: If sale item, show originalPrice (struck through, grey, 18px) and salePrice (bold, purple, 32px).

FR-5 Color Dropdown
- FR-5.1: Render dropdown if availableColors is not empty.
- FR-5.2: Options: list of colors from product.availableColors array (e.g., ['Purple', 'Black', 'White']).
- FR-5.3: Placeholder: "Select Color" (initial state).
- FR-5.4: On change: Update selectedColor state.
- FR-5.5: Validation: Required if colors exist; show error if user tries to add to cart without selecting.

FR-6 Size Dropdown
- FR-6.1: Render dropdown if availableSizes is not empty.
- FR-6.2: Options: list of sizes from product.availableSizes array (e.g., ['XS', 'S', 'M', 'L', 'XL']).
- FR-6.3: Placeholder: "Select Size" (initial state).
- FR-6.4: On change: Update selectedSize state.
- FR-6.5: Validation: Required if sizes exist; show error if user tries to add to cart without selecting.

FR-7 Quantity Selector
- FR-7.1: Default quantity: 1.
- FR-7.2: Increment button (+): Increase quantity by 1 (max: product.maxStock or 10 if not specified).
- FR-7.3: Decrement button (-): Decrease quantity by 1 (min: 1, disable button if quantity is 1).
- FR-7.4: Input field: Allow direct numeric input; validate on blur (must be integer between 1 and maxStock).
- FR-7.5: Style: Compact horizontal layout (- | number | +); buttons 40x40px, input 60px width.

FR-8 Add to Cart Button
- FR-8.1: Validate required options: if availableColors exists, selectedColor must be set; if availableSizes exists, selectedSize must be set.
- FR-8.2: Button disabled (grey background) if validation fails.
- FR-8.3: Button enabled (purple background, white text) if validation passes.
- FR-8.4: On click: Add {productId, title, price, selectedColor, selectedSize, selectedQuantity, imageUrl} to cart state/service.
- FR-8.5: Show success feedback: Snackbar or toast "Added to cart!".

FR-9 Buy Now Button
- FR-9.1: Validate required options (same as Add to Cart).
- FR-9.2: Button disabled (grey border/text) if validation fails.
- FR-9.3: Button enabled (purple border/text, white background) if validation passes.
- FR-9.4: On click: Navigate to checkout page with product configuration as route arguments or state.
- FR-9.5: Route: '/checkout' with arguments {productId, selectedColor, selectedSize, selectedQuantity}.

FR-10 Product Description
- FR-10.1: Display full product description text below buttons.
- FR-10.2: Support line breaks and basic formatting (plain text or Markdown).
- FR-10.3: Scrollable if content exceeds viewport; responsive width.
- FR-10.4: Style: 16px font, grey text, line height 1.5.

FR-11 Navigation & Routing
- FR-11.1: Route: '/product/:id' or '/product' with product ID in route arguments.
- FR-11.2: On load: Fetch product data by ID from catalog/provider or use passed product object.
- FR-11.3: Back navigation: Browser back button or app navigation returns to previous page (Sale, Clothing, etc.).
- FR-11.4: Product cards on Sale/Clothing pages navigate to ProductPage with correct product ID.

Non-Functional Requirements

NFR-1 Performance
- Product data loads in <500ms (if fetching from API/database).
- Image loads efficiently; use cached images where possible.
- State updates (color, size, quantity) respond immediately (<50ms).

NFR-2 Maintainability
- Reuse existing components: AppScaffold, dropdowns (or create reusable ProductOptionDropdown widget).
- Extract product card navigation logic into shared utility/service.
- Keep ProductPage logic simple and testable; separate UI and business logic.

NFR-3 Consistency
- Match design patterns from Sale/Clothing pages: colors, fonts, spacing, button styles.
- Use purple theme color (#4d2963) for primary actions and accents.
- Maintain responsive breakpoints: >800px desktop, 600-800px tablet, <600px mobile.

Implementation Notes & Examples

Product Model (Example)
```dart
class Product {
  final String id;
  final String title;
  final double price;
  final double? originalPrice; // Null if not on sale
  final String imageUrl;
  final List<String> availableColors;
  final List<String> availableSizes;
  final String description;
  final int maxStock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.availableColors = const [],
    this.availableSizes = const [],
    required this.description,
    this.maxStock = 10,
  });
}
```

State Management (Example using setState)
```dart
class _ProductPageState extends State<ProductPage> {
  late Product _product;
  String? _selectedColor;
  String? _selectedSize;
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    // Load product data from route arguments or provider
    _product = _loadProduct();
  }

  bool get _canAddToCart {
    if (_product.availableColors.isNotEmpty && _selectedColor == null) return false;
    if (_product.availableSizes.isNotEmpty && _selectedSize == null) return false;
    return true;
  }

  void _addToCart() {
    if (!_canAddToCart) {
      _showError('Please select all required options');
      return;
    }
    // Add to cart logic
    CartService.instance.addItem(
      productId: _product.id,
      color: _selectedColor,
      size: _selectedSize,
      quantity: _selectedQuantity,
    );
    _showSuccess('Added to cart!');
  }

  void _buyNow() {
    if (!_canAddToCart) {
      _showError('Please select all required options');
      return;
    }
    // Navigate to checkout
    Navigator.pushNamed(context, '/checkout', arguments: {
      'productId': _product.id,
      'color': _selectedColor,
      'size': _selectedSize,
      'quantity': _selectedQuantity,
    });
  }
}
```

UI Layout (Example structure)
```dart
@override
Widget build(BuildContext context) {
  final isDesktop = MediaQuery.of(context).size.width > 800;

  return AppScaffold(
    currentRoute: '/product',
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: isDesktop
            ? Row( // Desktop: Two columns
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildProductImage()),
                  const SizedBox(width: 40),
                  Expanded(child: _buildProductDetails()),
                ],
              )
            : Column( // Mobile: Single column
                children: [
                  _buildProductImage(),
                  const SizedBox(height: 24),
                  _buildProductDetails(),
                ],
              ),
      ),
    ),
  );
}
```

Subtasks (Actionable)

- [ ] **Subtask 1**: Define Product model with all required fields (id, title, price, originalPrice, imageUrl, availableColors, availableSizes, description, maxStock).

- [ ] **Subtask 2**: Update ProductPage to StatefulWidget and add state variables (selectedColor, selectedSize, selectedQuantity).

- [ ] **Subtask 3**: Implement product data loading (from route arguments or product ID lookup).

- [ ] **Subtask 4**: Build responsive layout (two-column desktop, single-column mobile).

- [ ] **Subtask 5**: Implement product image section with placeholder and error handling.

- [ ] **Subtask 6**: Implement product title and price display (with sale price support).

- [ ] **Subtask 7**: Create color dropdown widget (conditionally rendered, updates selectedColor state).

- [ ] **Subtask 8**: Create size dropdown widget (conditionally rendered, updates selectedSize state).

- [ ] **Subtask 9**: Implement quantity selector (increment/decrement buttons + numeric input with validation).

- [ ] **Subtask 10**: Implement Add to Cart button (validation, state update, success feedback).

- [ ] **Subtask 11**: Implement Buy Now button (validation, navigation to checkout).

- [ ] **Subtask 12**: Implement product description display (multi-line text with formatting).

- [ ] **Subtask 13**: Add validation logic (ensure required options selected before enabling buttons).

- [ ] **Subtask 14**: Add accessibility features (semantic labels, keyboard navigation, focus indicators).

- [ ] **Subtask 15**: Wire navigation from product cards (Sale, Clothing pages) to ProductPage with product ID.

- [ ] **Subtask 16**: Add widget tests:
  - Test: Selecting color/size updates state.
  - Test: Quantity selector increments/decrements correctly.
  - Test: Add to Cart button disabled until options selected.
  - Test: Add to Cart adds correct item to cart.
  - Test: Buy Now navigates to checkout with correct data.

---

End of prompt.