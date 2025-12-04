# Homepage Featured Products — Feature Requirements

## 1. Feature Overview

### Description
- Replace the 4 placeholder products on the homepage with real, curated featured products from the catalog.
- Each featured product displays accurate product information (image, title, price) in a visually appealing card format.
- Products are hardcoded as featured items to showcase popular, promotional, or signature products to visitors.
- Clicking any product card navigates to a detailed Product Page with full product information and purchase options.
- Feature maintains the existing homepage design and responsive grid layout.

### Purpose
- Showcase key products to visitors immediately upon landing on the homepage.
- Provide quick access to popular or promotional items without requiring navigation through category pages.
- Increase product discoverability and conversion by highlighting curated items.
- Create an engaging homepage experience that encourages users to explore the catalog.
- Support diverse product types (clothing, merchandise, sale items) to appeal to different shopper preferences.

### Scope
- Update the existing "PRODUCTS SECTION" on the homepage with real product data.
- Define a constant list of 4 featured products (hardcoded, not fetched from API).
- Enhance the existing `ProductCard` widget to support full `Product` objects and sale price display.
- Integrate navigation from product cards to the Product Page with route arguments.
- Ensure responsive design maintains 2-column desktop and 1-column mobile layouts.
- Support sale items with original price (struck through) and discounted price display.
- No backend integration required (products defined in code).

## 2. User Stories

### US-1: View Featured Products on Homepage (Visitor)
- **As a** first-time visitor, **I want to** see featured products immediately on the homepage **so that** I can quickly discover popular items without navigating through categories.
- **Acceptance:**
  - Homepage displays 4 product cards with images, titles, and prices.
  - Products represent a diverse mix (clothing, merchandise, sale items).
  - Products are visible below the hero carousel without scrolling (on desktop).

### US-2: View Product Details (Shopper)
- **As a** shopper, **I want to** click on a featured product card **so that** I can view full details, select options, and purchase the item.
- **Acceptance:**
  - Clicking any product card navigates to the Product Page.
  - Product Page displays the correct product data (image, title, price, colors, sizes, description).
  - Back navigation returns to the homepage.

### US-3: Identify Sale Items (Bargain Shopper)
- **As a** bargain shopper, **I want to** see which featured products are on sale with clear pricing **so that** I can identify savings opportunities.
- **Acceptance:**
  - Sale items display both original price (struck through, grey) and sale price (bold, purple).
  - Non-sale items display regular price only.
  - Sale price is visually distinct (larger font, purple color).

### US-4: Browse on Mobile Devices (Mobile User)
- **As a** mobile user, **I want to** view featured products in a single-column layout **so that** I can comfortably browse on my phone.
- **Acceptance:**
  - On screens ≤600px wide, product grid displays 1 column.
  - Product cards are touch-friendly (adequate tap target size).
  - Images and text are readable without zooming.
  - No horizontal scrolling required.

### US-5: Browse on Desktop (Desktop User)
- **As a** desktop user, **I want to** view featured products in a multi-column grid **so that** I can see more products at once and compare options efficiently.
- **Acceptance:**
  - On screens >600px wide, product grid displays 2 columns.
  - Cards are evenly spaced with consistent sizing.
  - Grid layout utilizes screen width efficiently.

### US-6: View Product Images (Visual Shopper)
- **As a** visual shopper, **I want to** see clear product images on the homepage **so that** I can quickly assess if a product interests me.
- **Acceptance:**
  - Each product card displays a large, high-quality image.
  - Images maintain aspect ratio and fill card space appropriately.
  - Missing images display a fallback placeholder icon.

### US-7: Understand Product Pricing (Budget-Conscious Shopper)
- **As a** budget-conscious shopper, **I want to** see product prices clearly on the homepage **so that** I can quickly determine if items fit my budget.
- **Acceptance:**
  - Prices display in consistent format: £XX.XX (e.g., £25.00).
  - Price text is readable with adequate contrast.
  - Sale prices are visually emphasized (bold, purple color).

## 3. Acceptance Criteria

### Homepage Integration
- **AC-1:** Homepage "PRODUCTS SECTION" displays 4 featured products (not placeholder data).
- **AC-2:** Products are rendered dynamically from a constant list `kFeaturedProducts`.
- **AC-3:** Section title can be updated to "FEATURED PRODUCTS".
- **AC-4:** Products display below the hero carousel in the existing homepage layout.
- **AC-5:** Section maintains consistent padding (40px all sides).

### Product Data
- **AC-6:** Each featured product includes:
  - Unique ID (String)
  - Title (String)
  - Price (double)
  - Original price if on sale (double, nullable)
  - Image URL/path (String)
  - Available colors (List<String>)
  - Available sizes (List<String>)
  - Description (String)
  - Max stock quantity (int)
- **AC-7:** Featured products represent a diverse mix:
  - Product 1: Clothing item (e.g., hoodie, t-shirt)
  - Product 2: Merchandise item (e.g., mug, tote bag, stationery)
  - Product 3: Sale item (with originalPrice and discounted price)
  - Product 4: Signature/popular item
- **AC-8:** All product images exist in `assets/images/` directory.

### ProductCard Component
- **AC-9:** `ProductCard` widget accepts a full `Product` object (not individual string properties).
- **AC-10:** Card displays product image with `BoxFit.cover` (fills card area, maintains aspect ratio).
- **AC-11:** Card displays product title below image (max 2 lines, ellipsis if overflow).
- **AC-12:** Card displays price below title.
- **AC-13:** For non-sale items: price displays in 13px grey text.
- **AC-14:** For sale items: original price displays struck through (11px grey), sale price displays bold (13px purple).
- **AC-15:** Missing/failed images display grey placeholder container with error icon.
- **AC-16:** Entire card is tappable/clickable (visual feedback on hover/press).

### Navigation
- **AC-17:** Clicking a product card navigates to `/product` route.
- **AC-18:** Product data is passed via route arguments: `Navigator.pushNamed(context, '/product', arguments: product)`.
- **AC-19:** Product Page receives product object and displays full details.
- **AC-20:** Browser/app back navigation returns to homepage from Product Page.
- **AC-21:** Navigation is immediate (<100ms response time).

### Responsive Layout
- **AC-22:** Desktop (>600px width): 2-column grid with 24px horizontal spacing, 48px vertical spacing.
- **AC-23:** Mobile (≤600px width): 1-column grid with 48px vertical spacing.
- **AC-24:** Grid uses `shrinkWrap: true` and `NeverScrollableScrollPhysics` (embedded in scrollable page).
- **AC-25:** Product cards maintain consistent height within each row.
- **AC-26:** Layout transitions smoothly at breakpoint (600px).

### Visual Design & Styling
- **AC-27:** Product cards match existing design (no style regressions from current placeholder cards).
- **AC-28:** Sale prices use purple theme color (#4d2963).
- **AC-29:** Font sizes match specification:
  - Product title: 14px, normal weight, black
  - Regular price: 13px, normal weight, grey
  - Sale price: 13px, bold, purple (#4d2963)
  - Original price (struck through): 11px, normal weight, grey, strikethrough decoration
- **AC-30:** Grid spacing matches specification (24px horizontal, 48px vertical).
- **AC-31:** Cards have clean borders, adequate padding, and consistent styling.

### Performance
- **AC-32:** Homepage loads with featured products in <500ms (no API calls required).
- **AC-33:** Product images load efficiently (optimized assets, <500ms per image).
- **AC-34:** No unnecessary widget rebuilds (use `const` constructors where possible).
- **AC-35:** Navigation to Product Page is immediate (<100ms).

## 4. Functional Requirements

### FR-1 Featured Products Data Structure
- **FR-1.1:** Create a `Product` model class (or use existing) with fields:
  - `id` (String): Unique product identifier
  - `title` (String): Product name
  - `price` (double): Current selling price in GBP
  - `originalPrice` (double?): Original price if on sale, null otherwise
  - `imageUrl` (String): Asset path (e.g., "assets/images/hoodie_purple.jpg")
  - `availableColors` (List<String>): List of available color options
  - `availableSizes` (List<String>): List of available size options
  - `description` (String): Full product description
  - `maxStock` (int): Maximum purchasable quantity
- **FR-1.2:** Define constant list `kFeaturedProducts` containing 4 `Product` instances.
- **FR-1.3:** Place constant in `lib/constants/featured_products.dart` or at top of `main.dart`.
- **FR-1.4:** Products must be `const` constructors for compile-time constant list.

### FR-2 Product Selection & Diversity
- **FR-2.1:** Select 4 products representing different categories:
  - 1 clothing item (hoodie, t-shirt, or similar)
  - 1 merchandise item (mug, tote bag, stationery)
  - 1 sale item (must have originalPrice > price)
  - 1 signature/popular item (best-seller or university-branded item)
- **FR-2.2:** Ensure visual diversity in product images (different colors, styles).
- **FR-2.3:** Include at least 1 product with multiple color options.
- **FR-2.4:** Include at least 1 product with size options.

### FR-3 Image Asset Management
- **FR-3.1:** Add 4 product images to `assets/images/` directory.
- **FR-3.2:** Image filenames should be descriptive (e.g., `hoodie_purple.jpg`, `mug_portsmouth.jpg`).
- **FR-3.3:** Images should be optimized for web/mobile (recommended: 800x800px, JPEG or PNG).
- **FR-3.4:** Ensure `pubspec.yaml` includes `assets/images/` directory declaration.
- **FR-3.5:** Verify all image paths in `kFeaturedProducts` match actual asset paths.

### FR-4 ProductCard Widget Enhancement
- **FR-4.1:** Update `ProductCard` constructor to accept `Product product` parameter (remove individual string params).
- **FR-4.2:** Extract product properties inside build method:
  - `product.title` for title text
  - `product.price` for price display
  - `product.originalPrice` for sale price logic
  - `product.imageUrl` for image asset path
- **FR-4.3:** Implement sale price conditional logic:
  ```dart
  final bool isOnSale = product.originalPrice != null;
  ```
- **FR-4.4:** If `isOnSale == true`, render Row with:
  - Text(originalPrice) with strikethrough decoration
  - SizedBox(width: 8) for spacing
  - Text(price) in bold purple
- **FR-4.5:** If `isOnSale == false`, render single Text(price) in grey.
- **FR-4.6:** Format prices: `'£${product.price.toStringAsFixed(2)}'`.

### FR-5 Homepage Grid Implementation
- **FR-5.1:** Replace hardcoded `ProductCard` widgets with `GridView.builder`.
- **FR-5.2:** Grid configuration:
  ```dart
  GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
      crossAxisSpacing: 24,
      mainAxisSpacing: 48,
      childAspectRatio: 0.75, // Adjust based on actual card dimensions
    ),
    itemCount: kFeaturedProducts.length,
    itemBuilder: (context, index) {
      return ProductCard(product: kFeaturedProducts[index]);
    },
  )
  ```
- **FR-5.3:** Import `kFeaturedProducts` at top of `main.dart`:
  ```dart
  import 'package:union_shop/constants/featured_products.dart';
  ```
- **FR-5.4:** Remove placeholder data (strings for title/price/imageUrl).

### FR-6 Navigation Implementation
- **FR-6.1:** Update `ProductCard` `onTap` handler:
  ```dart
  onTap: () {
    Navigator.pushNamed(
      context,
      '/product',
      arguments: product,
    );
  }
  ```
- **FR-6.2:** Ensure `/product` route is registered in `main.dart` routes map.
- **FR-6.3:** Product Page must retrieve product from route arguments:
  ```dart
  final product = ModalRoute.of(context)!.settings.arguments as Product;
  ```
- **FR-6.4:** Product Page displays received product data (image, title, price, colors, sizes, description).

### FR-7 Error Handling
- **FR-7.1:** Image error handling (already implemented in existing `ProductCard`):
  ```dart
  errorBuilder: (context, error, stackTrace) {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
  ```
- **FR-7.2:** If Product Page navigation fails (null arguments), display error message or navigate to homepage.
- **FR-7.3:** If featured products list is empty, display fallback message (edge case, should not occur with const data).

## 5. Non-Functional Requirements

### NFR-1 Performance
- **NFR-1.1:** Homepage renders featured products immediately (no async data fetching).
- **NFR-1.2:** Product images load in <500ms each (use optimized assets).
- **NFR-1.3:** Navigation to Product Page responds in <100ms.
- **NFR-1.4:** No frame drops or jank during grid rendering or scrolling.
- **NFR-1.5:** Use `const` constructors for `ProductCard` and `Product` instances where possible to reduce rebuilds.

### NFR-2 Maintainability
- **NFR-2.1:** Featured products list is defined in a single location (`kFeaturedProducts`).
- **NFR-2.2:** Updating featured products requires editing only the constant list (no code logic changes).
- **NFR-2.3:** Product model is reusable across app (Sale page, Clothing page, Product Page).
- **NFR-2.4:** Code follows existing app patterns and style conventions.
- **NFR-2.5:** Clear comments explain key logic (sale price display, navigation).

### NFR-3 Scalability
- **NFR-3.1:** Grid supports variable product counts (can easily change to 6, 8, or more products).
- **NFR-3.2:** System can transition to dynamic product loading (API/database) in future with minimal refactoring.
- **NFR-3.3:** Product model supports extension (e.g., adding rating, review count, tags).

### NFR-4 Consistency
- **NFR-4.1:** Featured products section matches homepage design (colors, spacing, typography).
- **NFR-4.2:** Product cards visually consistent with cards on Sale and Clothing pages.
- **NFR-4.3:** Navigation behavior matches rest of app (consistent routing pattern).
- **NFR-4.4:** Purple theme color (#4d2963) used consistently for branding and CTAs.
- **NFR-4.5:** Font sizes, weights, and colors match app-wide style guide.

### NFR-6 Responsiveness
- **NFR-6.1:** Layout adapts smoothly to viewport changes (no sudden jumps or overflow).
- **NFR-6.2:** Grid transitions cleanly at 600px breakpoint (2 columns ↔ 1 column).
- **NFR-6.3:** Cards scale proportionally on different screen sizes.
- **NFR-6.4:** No horizontal scrolling required on any device width (320px - 1920px+).

## 6. Technical Implementation Details

### Product Model Example
```dart
// filepath: lib/models/product.dart
class Product {
  final String id;
  final String title;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> availableColors;
  final List<String> availableSizes;
  final String description;
  final int maxStock;

  const Product({
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

  bool get isOnSale => originalPrice != null && originalPrice! > price;

  int get discountPercentage {
    if (originalPrice == null || originalPrice == 0) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
}
```

### Featured Products Data Example
```dart
// filepath: lib/constants/featured_products.dart
import 'package:union_shop/models/product.dart';

const List<Product> kFeaturedProducts = [
  Product(
    id: 'clothing-hoodie-purple-001',
    title: 'Portsmouth University Hoodie',
    price: 35.00,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    availableColors: ['Purple', 'Black', 'Navy'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    description: 'Stay warm and stylish with our classic Portsmouth University hoodie...',
    maxStock: 10,
  ),
  Product(
    id: 'merch-mug-portsmouth-001',
    title: 'Portsmouth City Mug',
    price: 8.99,
    imageUrl: 'assets/images/mug_portsmouth.jpg',
    availableColors: ['White'],
    availableSizes: [],
    description: 'Enjoy your morning coffee with our Portsmouth City mug...',
    maxStock: 50,
  ),
  Product(
    id: 'clothing-tshirt-signature-sale',
    title: 'Signature Portsmouth T-Shirt',
    price: 12.99,
    originalPrice: 18.99,
    imageUrl: 'assets/images/tshirt_signature.jpg',
    availableColors: ['Purple', 'White', 'Black'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
    description: 'Classic Portsmouth University t-shirt. Now on sale!',
    maxStock: 20,
  ),
  Product(
    id: 'merch-tote-bag-001',
    title: 'Portsmouth University Tote Bag',
    price: 9.99,
    imageUrl: 'assets/images/tote_bag.jpg',
    availableColors: ['Natural', 'Purple'],
    availableSizes: [],
    description: 'Eco-friendly cotton tote bag with embroidered logo...',
    maxStock: 30,
  ),
];
```

### Enhanced ProductCard Example
```dart
// filepath: lib/main.dart (within file)
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnSale = product.originalPrice != null;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                product.title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              if (isOnSale) ...[
                Row(
                  children: [
                    Text(
                      '£${product.originalPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4d2963),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  '£${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
```

## 7. Testing Requirements

### Unit Tests
- **UT-1:** Test `Product` model instantiation with all fields.
- **UT-2:** Test `Product.isOnSale` getter returns true when originalPrice exists.
- **UT-3:** Test `Product.isOnSale` getter returns false when originalPrice is null.
- **UT-4:** Test `Product.discountPercentage` calculates correctly (e.g., £18.99 → £12.99 = 32% off).
- **UT-5:** Test `kFeaturedProducts` list contains 4 products.
- **UT-6:** Test all products in `kFeaturedProducts` have valid imageUrl paths.

### Widget Tests
- **WT-1:** Test `ProductCard` renders product title correctly.
- **WT-2:** Test `ProductCard` displays regular price for non-sale item.
- **WT-3:** Test `ProductCard` displays original price (struck through) and sale price for sale item.
- **WT-4:** Test `ProductCard` shows error icon when image fails to load.
- **WT-5:** Test tapping `ProductCard` calls navigation with correct arguments.
- **WT-6:** Test homepage grid renders 4 product cards.
- **WT-7:** Test grid layout changes from 2 columns to 1 column at 600px breakpoint.

### Integration Tests
- **IT-1:** Test navigation from homepage featured product to Product Page.
- **IT-2:** Test Product Page displays correct product data received from route arguments.
- **IT-3:** Test back navigation returns to homepage.

### Manual QA Checklist
- [ ] Homepage displays 4 featured products with images, titles, and prices.
- [ ] Product images load correctly; missing images show error icon.
- [ ] Sale item displays struck-through original price and bold purple sale price.
- [ ] Non-sale items display regular grey price.
- [ ] Clicking any product card navigates to Product Page with correct data.
- [ ] Product Page shows full details (image, title, price, colors, sizes, description).
- [ ] Back button returns to homepage.
- [ ] Desktop (>600px): Grid shows 2 columns with 24px spacing.
- [ ] Mobile (≤600px): Grid shows 1 column with full-width cards.
- [ ] Layout transitions smoothly at 600px breakpoint (resize browser window).
- [ ] No horizontal scrolling at any screen width (320px - 1920px).
- [ ] Product cards maintain consistent styling (fonts, colors, spacing).
- [ ] Purple theme color (#4d2963) used for sale prices.
- [ ] Price format is consistent: £XX.XX.
- [ ] Product cards are keyboard navigable (tab through cards).
- [ ] Focus indicators visible on keyboard navigation.

## 8. Subtasks (Actionable)

- [ ] **Subtask 1:** Create or verify `Product` model exists in `lib/models/product.dart` with all required fields:
  - id, title, price, originalPrice (nullable), imageUrl, availableColors, availableSizes, description, maxStock
  - Add `isOnSale` getter and `discountPercentage` getter

- [ ] **Subtask 2:** Create `lib/constants/featured_products.dart` file with `kFeaturedProducts` constant list containing 4 `Product` instances:
  - Product 1: Clothing item (e.g., hoodie with colors and sizes)
  - Product 2: Merchandise item (e.g., mug, no sizes)
  - Product 3: Sale item (with originalPrice > price)
  - Product 4: Signature item (popular product)

- [ ] **Subtask 3:** Add 4 product images to `assets/images/` directory:
  - Use descriptive filenames (e.g., `hoodie_purple.jpg`, `mug_portsmouth.jpg`, `tshirt_signature.jpg`, `tote_bag.jpg`)
  - Optimize images to ~800x800px, JPEG or PNG format
  - Ensure image paths match imageUrl values in `kFeaturedProducts`

- [ ] **Subtask 4:** Verify `pubspec.yaml` includes `assets/images/` directory:
  ```yaml
  flutter:
    assets:
      - assets/images/
  ```

- [ ] **Subtask 5:** Update `ProductCard` widget in `main.dart`:
  - Change constructor to accept `Product product` parameter (remove individual title/price/imageUrl params)
  - Extract properties from product object inside build method
  - Implement sale price conditional logic (if originalPrice != null, show struck-through original + bold sale price)
  - Update onTap to navigate with product object: `Navigator.pushNamed(context, '/product', arguments: product)`

- [ ] **Subtask 6:** Update homepage "PRODUCTS SECTION" in `main.dart`:
  - Import `kFeaturedProducts` from constants file
  - Replace hardcoded `ProductCard` widgets with `GridView.builder`
  - Configure grid: crossAxisCount based on screen width (2 if >600px, 1 otherwise), crossAxisSpacing 24, mainAxisSpacing 48
  - itemCount: `kFeaturedProducts.length`, itemBuilder: `ProductCard(product: kFeaturedProducts[index])`
  - Optionally update section title to "FEATURED PRODUCTS"

- [ ] **Subtask 7:** Update Product Page (`lib/views/product_page.dart`) to receive product data:
  - In `didChangeDependencies()` or `initState()`, extract product from route arguments: `ModalRoute.of(context)!.settings.arguments as Product`
  - Display received product data (image, title, price, colors, sizes, description) in UI
  - Handle null/invalid arguments gracefully (show error or navigate to homepage)

- [ ] **Subtask 8:** Verify `/product` route is registered in `main.dart` routes map:
  ```dart
  '/product': (context) => const ProductPage(),
  ```

- [ ] **Subtask 9:** Write unit tests for `Product` model:
  - Test instantiation with all fields
  - Test `isOnSale` getter (true when originalPrice exists, false otherwise)
  - Test `discountPercentage` calculation

- [ ] **Subtask 10:** Write widget tests for `ProductCard`:
  - Test renders title correctly
  - Test displays regular price for non-sale item
  - Test displays original price (struck through) and sale price for sale item
  - Test shows error icon when image fails to load
  - Test tapping card calls navigation with correct arguments

- [ ] **Subtask 11:** Write widget tests for homepage grid:
  - Test grid renders 4 product cards
  - Test grid layout is 2 columns at 800px width
  - Test grid layout is 1 column at 400px width

- [ ] **Subtask 12:** Write integration tests:
  - Test navigation from featured product card to Product Page
  - Test Product Page displays correct data from route arguments
  - Test back navigation returns to homepage

- [ ] **Subtask 13:** Perform manual QA testing:
  - Test at multiple screen widths (320px, 600px, 800px, 1200px)
  - Verify responsive grid layout transitions correctly
  - Test product card navigation and Product Page data display
  - Verify sale price display for sale items
  - Test image loading and error handling
  - Verify keyboard navigation and accessibility

- [ ] **Subtask 14:** Performance testing:
  - Profile homepage load time (target: <500ms)
  - Verify image loading performance (target: <500ms per image)
  - Test navigation responsiveness (target: <100ms)
  - Check for frame drops during scrolling or grid rendering

- [ ] **Subtask 15:** Accessibility review:
  - Verify product cards have semantic labels
  - Test keyboard navigation (tab order logical, focus indicators visible)
  - Test with screen reader (prices announced correctly, images have alt text)
  - Verify color contrast meets WCAG AA standards
  - Ensure tap targets are at least 44x44px on mobile

---

End of requirements document.
