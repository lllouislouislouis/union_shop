# Product Page — Feature Requirements

## 1. Feature Overview

### Description
- Implement a fully functional Product Page that displays detailed information for a single product.
- Page includes: product image, title, price, customization options (color, size), quantity selection, and purchase actions (Add to Cart, Buy Now).
- Support dynamic product data loading from route arguments or product ID lookup.
- Ensure responsive design for desktop, tablet, and mobile devices.
- Reuse existing app components (AppScaffold, color scheme, typography) for consistency.

### Purpose
- Provide users with a detailed view of individual products with all necessary information for purchase decisions.
- Enable product customization (color, size selection) before adding to cart or checkout.
- Create a clear, accessible product browsing and purchasing experience.
- Support navigation from collection pages (Sale, Clothing) to individual product details.

### Scope
- Build Product Page as a StatefulWidget to manage product selection state.
- Create/extend Product model with all required fields (id, title, price, originalPrice, imageUrl, availableColors, availableSizes, description, maxStock).
- Implement responsive layout: two-column desktop, single-column mobile.
- Add validation for required product options (color, size) before purchase actions.
- Integrate with cart service/state management for "Add to Cart" functionality.
- Wire navigation to checkout page for "Buy Now" action.
- Include widget tests and manual QA.

## 2. User Stories

### US-1: View Product Details (Visitor/Shopper)
- **As a** shopper, **I want to** view detailed information about a product (image, title, price, description) **so that** I can make an informed purchasing decision.
- **Expected:** Product page displays all details clearly; image is prominent; price is easy to find; description is readable.

### US-2: Select Product Color (Shopper)
- **As a** shopper, **I want to** select a product color from a dropdown **so that** I can customize my purchase.
- **Expected:** Color dropdown is visible (if product has colors); selecting a color updates the selection state; Add to Cart and Buy Now buttons remain disabled until color is selected (if required).

### US-3: Select Product Size (Shopper)
- **As a** shopper, **I want to** select a product size from a dropdown **so that** I can ensure the product fits my needs.
- **Expected:** Size dropdown is visible (if product has sizes); selecting a size updates the selection state; Add to Cart and Buy Now buttons remain disabled until size is selected (if required).

### US-4: Choose Quantity (Shopper)
- **As a** shopper, **I want to** choose how many items to purchase using increment/decrement buttons or direct input **so that** I can buy the correct quantity.
- **Expected:** Quantity selector shows 1 by default; + button increases quantity (up to stock limit); - button decreases quantity (minimum 1); direct input validates on blur (1-maxStock range).

### US-5: Add Product to Cart (Shopper)
- **As a** shopper, **I want to** click "Add to Cart" with my selected options **so that** I can save items for later purchase or checkout.
- **Expected:** Add to Cart button is disabled until all required options selected; clicking adds product to cart; success message appears ("Added to cart!").

### US-6: Buy Product Now (Shopper)
- **As a** shopper, **I want to** click "Buy Now" to proceed directly to checkout **so that** I can complete my purchase without additional steps.
- **Expected:** Buy Now button is disabled until all required options selected; clicking navigates to checkout page with product details.

### US-7: View Sale Price (Sale Shopper)
- **As a** shopper, **I want to** see both original and sale prices for discounted items **so that** I can understand the savings.
- **Expected:** Original price shown struck through; sale price shown in bold purple; discount percentage visible (if applicable).

### US-8: Browse on Mobile (Mobile User)
- **As a** mobile user, **I want to** view product details on a single column layout **so that** I can comfortably browse on my phone.
- **Expected:** Image, details, buttons stack vertically; no horizontal overflow; buttons are touch-friendly (large tap targets).

### US-10: Navigate from Product Cards (Visitor)
- **As a** visitor, **I want to** click on a product card from Sale or Clothing pages **so that** I can view detailed product information.
- **Expected:** Product cards are clickable; clicking navigates to Product Page with correct product data; page loads immediately.

## 3. Acceptance Criteria

### Page Structure & Layout
- **AC-1:** Product page uses AppScaffold with currentRoute='/product'.
- **AC-2:** Desktop layout (>800px): Two-column layout with image on left (50%), details on right (50%).
- **AC-3:** Mobile/Tablet layout (≤800px): Single-column layout with image top, details below.
- **AC-4:** Consistent padding (24-40px horizontal) matches Sale/Clothing pages.
- **AC-5:** Page includes: image, title, price, color dropdown, size dropdown, quantity selector, Add to Cart button, Buy Now button, and description.

### Product Image
- **AC-6:** Large product image displays from imageUrl.
- **AC-7:** Placeholder icon shows while image loads.
- **AC-8:** Error icon displays if image fails to load.
- **AC-9:** Image responsive: max width 100%, maintains aspect ratio.

### Product Title & Price
- **AC-10:** Product title displays as h1 heading (48px, bold, purple #4d2963).
- **AC-11:** Current price displays as large text (32px, bold, purple).
- **AC-12:** For sale items: original price shown struck through (18px, grey), sale price shown bold (32px, purple).

### Color Dropdown
- **AC-13:** Color dropdown renders only if product.availableColors is not empty.
- **AC-14:** Dropdown shows "Select Color" placeholder initially.
- **AC-15:** Dropdown lists all available colors from product.availableColors.
- **AC-16:** Selecting a color updates selectedColor state.
- **AC-17:** Selected color value displays in dropdown.

### Size Dropdown
- **AC-18:** Size dropdown renders only if product.availableSizes is not empty.
- **AC-19:** Dropdown shows "Select Size" placeholder initially.
- **AC-20:** Dropdown lists all available sizes from product.availableSizes.
- **AC-21:** Selecting a size updates selectedSize state.
- **AC-22:** Selected size value displays in dropdown.

### Quantity Selector
- **AC-23:** Quantity selector shows: [- button] [input field] [+ button].
- **AC-24:** Initial quantity: 1.
- **AC-25:** + button: increases quantity by 1 (max: product.maxStock or 10).
- **AC-26:** - button: decreases quantity by 1 (min: 1); disabled when quantity is 1.
- **AC-27:** Input field: accepts numeric input; validates on blur (must be 1-maxStock).
- **AC-28:** Invalid input (zero, negative, non-numeric) rejected; error message shown.

### Add to Cart Button
- **AC-29:** Button text: "Add to Cart".
- **AC-30:** Button disabled (grey) if required options not selected (color if colors exist, size if sizes exist).
- **AC-31:** Button enabled (purple background, white text) when all required options selected.
- **AC-32:** Clicking button: validates options, adds {productId, title, price, selectedColor, selectedSize, selectedQuantity, imageUrl} to cart.
- **AC-33:** On success: snackbar/toast displays "Added to cart!".
- **AC-34:** On error: error message displays (e.g., "Please select a color and size").

### Buy Now Button
- **AC-35:** Button text: "Buy Now".
- **AC-36:** Button disabled (white with grey border) if required options not selected.
- **AC-37:** Button enabled (white background, purple border/text) when all required options selected.
- **AC-38:** Clicking button: validates options, navigates to '/checkout' with {productId, selectedColor, selectedSize, selectedQuantity} as route arguments.
- **AC-39:** On error: error message displays (e.g., "Please select a color and size").

### Product Description
- **AC-40:** Description displays below buttons as multi-line text.
- **AC-41:** Description text size: 16px, grey (#888), line height 1.5.
- **AC-42:** Description supports line breaks and basic formatting (plain text).
- **AC-43:** Long descriptions are scrollable or wrapped; no horizontal overflow.

### Navigation & Routing
- **AC-44:** Route '/product' maps to ProductPage; product data passed via route arguments.
- **AC-45:** On page load: Product data fetched by ID from route arguments or provider.
- **AC-46:** Back button (browser or app navigation) returns to previous page (Sale, Clothing, etc.).
- **AC-47:** Product cards on Sale/Clothing pages include onTap that navigates to '/product' with product data.

### Responsiveness
- **AC-48:** At 360px width (mobile): single-column layout, buttons full width, no overflow.
- **AC-48:** At 800px width (tablet): verify layout transitions correctly, controls visible.
- **AC-49:** At 1200px width (desktop): two-column layout, image and details side-by-side.

### Performance
- **AC-60:** Product page loads and renders in <500ms.
- **AC-61:** Image loads efficiently; lazy loading or caching used if applicable.
- **AC-62:** State updates (color, size, quantity) respond immediately (<50ms).

## 4. Functional Requirements (Summary)

### FR-1 Page Structure & Layout
- FR-1.1: Use AppScaffold with currentRoute='/product' and back navigation.
- FR-1.2: Desktop (>800px): Render Row with Expanded(child: image) + Expanded(child: details).
- FR-1.3: Mobile (≤800px): Render Column with image first, details below.
- FR-1.4: Padding: 24px mobile, 32px tablet, 40px desktop.
- FR-1.5: SingleChildScrollView wraps content for vertical scrolling.

### FR-2 Data & State
- FR-2.1: Product model includes: id, title, price, originalPrice (nullable), imageUrl, availableColors[], availableSizes[], description, maxStock, discountPercentage (computed).
- FR-2.2: State: selectedColor (nullable), selectedSize (nullable), selectedQuantity (default 1).
- FR-2.3: Load product from route arguments: `ModalRoute.of<Product>(context)?.settings.arguments as Product`.
- FR-2.4: Getter _canAddToCart: validates color (if colors exist), size (if sizes exist).

### FR-3 Product Image
- FR-3.1: Image.asset(product.imageUrl, fit: BoxFit.cover).
- FR-3.2: ClipRRect(borderRadius: 8) for rounded corners.
- FR-3.3: ErrorBuilder: show grey container + shopping bag icon.
- FR-3.4: SizedBox(height: 300) for consistent image area size.

### FR-4 Product Title & Price
- FR-4.1: Title: Text(product.title, style: TextStyle(fontSize: 48, bold, purple)).
- FR-4.2: Price display: if originalPrice exists, show struck-through original + bold sale price; else show price only.
- FR-4.3: Price Row layout: [original struck] [SizedBox 8] [sale price bold].

### FR-5 Color Dropdown
- FR-5.1: Conditionally render: `if (product.availableColors.isNotEmpty) { ... }`.
- FR-5.2: DropdownButton<String> with items from product.availableColors.
- FR-5.3: Placeholder: "Select Color".
- FR-5.4: onChanged: setState(() { selectedColor = value; }).
- FR-5.5: Semantics wrapper with label "Choose product color".

### FR-6 Size Dropdown
- FR-6.1: Conditionally render: `if (product.availableSizes.isNotEmpty) { ... }`.
- FR-6.2: DropdownButton<String> with items from product.availableSizes.
- FR-6.3: Placeholder: "Select Size".
- FR-6.4: onChanged: setState(() { selectedSize = value; }).
- FR-6.5: Semantics wrapper with label "Choose product size".

### FR-7 Quantity Selector
- FR-7.1: Row layout: [IconButton(-)] [TextField] [IconButton(+)].
- FR-7.2: IconButton(-): onPressed decrement (min 1, disable if at 1).
- FR-7.3: IconButton(+): onPressed increment (max product.maxStock or 10).
- FR-7.4: TextField: TextInputType.number, validator (1-maxStock), onChanged setState.
- FR-7.5: Semantics wrappers for buttons: "Increase quantity", "Decrease quantity".

### FR-8 Add to Cart Button
- FR-8.1: ElevatedButton with text "Add to Cart".
- FR-8.2: enabled: _canAddToCart.
- FR-8.3: onPressed: validate, add to cart, show snackbar.
- FR-8.4: Call CartService.instance.addItem({productId, selectedColor, selectedSize, selectedQuantity}) or update state.
- FR-8.5: ScaffoldMessenger.of(context).showSnackBar(...) on success.
- FR-8.6: Style: purple background, white text, full width mobile, fixed width desktop.

### FR-9 Buy Now Button
- FR-9.1: OutlinedButton with text "Buy Now".
- FR-9.2: enabled: _canAddToCart.
- FR-9.3: onPressed: validate, navigate to '/checkout' with route arguments.
- FR-9.4: Navigator.pushNamed(context, '/checkout', arguments: {productId, selectedColor, selectedSize, selectedQuantity}).
- FR-9.5: Style: white background, purple border/text, full width mobile, fixed width desktop.

### FR-10 Product Description
- FR-10.1: Text(product.description, style: TextStyle(fontSize: 16, grey, height: 1.5)).
- FR-10.2: Support line breaks: use '\n' in description text.
- FR-10.3: Padding: 24px horizontal, responsive layout.

### FR-11 Navigation & Routing
- FR-11.1: ProductPage StatefulWidget with Product parameter or route arguments.
- FR-11.2: initState: retrieve product from route arguments or provider.
- FR-11.3: Product cards (Sale, Clothing) navigate: Navigator.pushNamed(context, '/product', arguments: product).
- FR-11.4: main.dart route: '/product': (context) => ProductPage().

## 5. Non-Functional Requirements

### NFR-1 Performance
- Product page loads and renders in <500ms.
- Image loads efficiently; lazy load or cache if necessary.
- State updates respond immediately (<50ms).
- Avoid unnecessary rebuilds; use const widgets where possible.

### NFR-2 Maintainability
- Reuse AppScaffold, existing dropdown widgets, or create ProductOptionDropdown.
- Keep ProductPage simple; separate UI logic from business logic.
- Extract product card navigation logic into utility if shared across pages.
- Use clear variable names and comments for complex logic.

### NFR-3 Consistency
- Match design patterns from Sale/Clothing pages (colors, fonts, spacing, button styles).
- Use purple theme color (#4d2963) for primary actions and accents.
- Maintain responsive breakpoints: >800px desktop, 600-800px tablet, <600px mobile.
- Button styles: purple primary, outlined secondary, white text primary, grey text secondary.

## 6. Implementation Notes & Examples

### Product Model (Dart Example)
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

  // Computed property for discount percentage
  int get discountPercentage {
    if (originalPrice == null || originalPrice == 0) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  bool get isOnSale => originalPrice != null && originalPrice! > price;
}
```

### State Management Pattern (Example)
```dart
class _ProductPageState extends State<ProductPage> {
  late Product _product;
  String? _selectedColor;
  String? _selectedSize;
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    _product = ModalRoute.of<Product>(context)?.settings.arguments as Product;
  }

  bool get _canAddToCart {
    if (_product.availableColors.isNotEmpty && _selectedColor == null) return false;
    if (_product.availableSizes.isNotEmpty && _selectedSize == null) return false;
    return true;
  }

  void _addToCart() {
    if (!_canAddToCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all required options')),
      );
      return;
    }
    // Add to cart logic
    CartService.instance.addItem({
      'productId': _product.id,
      'title': _product.title,
      'price': _product.price,
      'color': _selectedColor,
      'size': _selectedSize,
      'quantity': _selectedQuantity,
      'imageUrl': _product.imageUrl,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
  }

  void _buyNow() {
    if (!_canAddToCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all required options')),
      );
      return;
    }
    Navigator.pushNamed(context, '/checkout', arguments: {
      'productId': _product.id,
      'color': _selectedColor,
      'size': _selectedSize,
      'quantity': _selectedQuantity,
    });
  }
}
```

## 7. Subtasks (Actionable)

- [ ] **Subtask 1**: Define or extend Product model with all required fields (id, title, price, originalPrice, imageUrl, availableColors, availableSizes, description, maxStock, discountPercentage getter).

- [ ] **Subtask 2**: Convert ProductPage from StatelessWidget to StatefulWidget; add state variables (selectedColor, selectedSize, selectedQuantity).

- [ ] **Subtask 3**: Implement product data loading from route arguments in initState().

- [ ] **Subtask 4**: Build responsive layout structure:
  - Desktop (>800px): Row with two Expanded columns.
  - Mobile (≤800px): Column with stacked widgets.
  - Use MediaQuery.of(context).size.width for breakpoint detection.

- [ ] **Subtask 5**: Implement product image section with ClipRRect, error handling, and placeholder.

- [ ] **Subtask 6**: Implement product title and price display with sale price support (originalPrice struck through, salePrice bold).

- [ ] **Subtask 7**: Create color dropdown widget (conditionally rendered if colors exist, updates selectedColor on change).

- [ ] **Subtask 8**: Create size dropdown widget (conditionally rendered if sizes exist, updates selectedSize on change).

- [ ] **Subtask 9**: Implement quantity selector (Row with - button, TextField, + button; validation and state updates).

- [ ] **Subtask 10**: Implement Add to Cart button (validation check via _canAddToCart, call CartService, show success snackbar).

- [ ] **Subtask 11**: Implement Buy Now button (validation check, navigate to /checkout with route arguments).

- [ ] **Subtask 12**: Implement product description display (multi-line text, responsive width, line breaks supported).

- [ ] **Subtask 13**: Add validation logic (_canAddToCart getter, error messages for missing required options).

- [ ] **Subtask 15**: Wire navigation from product cards (Sale, Clothing pages):
  - Update onTap to navigate to '/product' with product as argument.
  - Verify route is registered in main.dart.

- [ ] **Subtask 16**: Add widget tests:
  - Test: Selecting color updates selectedColor state.
  - Test: Selecting size updates selectedSize state.
  - Test: Quantity increment/decrement works correctly (min 1, max stock).
  - Test: Add to Cart button disabled until options selected.
  - Test: Clicking Add to Cart calls CartService and shows snackbar.
  - Test: Buy Now button disabled until options selected.
  - Test: Clicking Buy Now navigates to /checkout with correct arguments.
  - Test: Product image shows error icon on load failure.

- [ ] **Subtask 17**: Manual QA:
  - Test at widths: 360px (mobile), 800px (tablet), 1200px (desktop).
  - Verify layout transitions, responsiveness, no overflow.
  - Verify product navigation from Sale/Clothing pages.
  - Test Add to Cart and Buy Now flows.

- [ ] **Subtask 18**: Performance check:
  - Profile product page load time (<500ms target).
  - Verify image loading performance.
  - Test state updates respond immediately.

--- 

End of requirements.
