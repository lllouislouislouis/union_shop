# Homepage Featured Products — Feature Implementation Prompt

## Goal
- Replace the 4 placeholder products on the homepage with real, curated featured products from the catalog.
- Each product should display accurate information (image, title, price) and navigate to its respective Product Page when clicked.
- Products should be hardcoded/selected as featured items to showcase popular or promotional items.
- Ensure the product grid is responsive, maintains the existing design, and integrates seamlessly with the current homepage layout.

## Page Structure
- Location: Homepage (`HomeScreen` widget in `main.dart`)
- Section: "PRODUCTS SECTION" — appears below the hero carousel
- Layout:
  - Desktop (>600px): 2-column grid
  - Mobile (≤600px): 1-column grid
  - Grid spacing: 24px horizontal, 48px vertical
  - Section padding: 40px all sides

## Data/State
- Inputs:
  - Featured products list: 4 hardcoded `Product` objects (use existing Product model)
  - Each product includes: id, title, price, originalPrice (optional for sale items), imageUrl, availableColors, availableSizes, description, maxStock
- Source:
  - Define a constant list `kFeaturedProducts` at the top of `main.dart` or in a separate `constants/featured_products.dart` file
  - Products should represent a diverse mix (e.g., clothing item, merchandise, sale item, signature product)
- State Management:
  - No local state required (static list)
  - Product data is immutable and defined at compile time

## Behavior & Actions

### 1. Product Display
- **Description**: Each product card displays product image, title, and price in the existing `ProductCard` widget style.
- **Action**: On page load, render 4 featured products in a responsive grid layout.
- **Behavior**:
  - Product image fills the card's image area (maintain aspect ratio, cover fit)
  - Title displays below image (max 2 lines, ellipsis if overflow)
  - Price displays below title in grey text
  - If product is on sale, display originalPrice (struck through) and salePrice (bold, purple)
- **Visual**: Match existing `ProductCard` component design exactly

### 2. Product Card Click
- **Description**: User clicks anywhere on a product card to view full product details.
- **Action**: On tap/click, navigate to Product Page (`/product`) with the selected product's ID or full product object.
- **Behavior**:
  - Navigation uses `Navigator.pushNamed(context, '/product', arguments: product)` or similar routing mechanism
  - Product Page receives product data via route arguments
  - Browser back button returns user to homepage

### 3. Product Image Loading
- **Description**: Product images load from asset paths specified in `imageUrl`.
- **Action**: On render, display product image using `Image.asset()` with error handling.
- **Behavior**:
  - Show grey placeholder while image loads (if loading async)
  - Show image-not-supported icon if image fails to load (existing error handling in `ProductCard`)
  - Images should be optimized and load quickly (<500ms)
- **Error Handling**: Use `errorBuilder` to display fallback icon/placeholder if asset is missing

### 4. Responsive Grid Layout
- **Description**: Product grid adapts to screen width for optimal viewing on all devices.
- **Action**: Automatically adjust grid columns based on viewport width.
- **Behavior**:
  - Desktop/Tablet (>600px): 2 columns with 24px gap
  - Mobile (≤600px): 1 column, full width
  - Grid uses `shrinkWrap: true` and `NeverScrollableScrollPhysics` (embedded in scrollable page)
  - Maintain consistent card heights within each row
- **Responsive Breakpoint**: 600px (matches existing MediaQuery check in `main.dart`)

## Performance
- Product data loads instantly (hardcoded, no API calls)
- Images load efficiently; use optimized asset sizes (recommended: 800x800px)
- Navigation to Product Page is immediate (<100ms)
- Avoid unnecessary rebuilds; use `const` constructors where possible

## Acceptance Criteria
- **AC-1**: Homepage displays 4 real featured products (not placeholders) with accurate images, titles, and prices.
- **AC-2**: Clicking a product card navigates to Product Page with correct product data.
- **AC-3**: Product Page displays full details for the selected product (handled by existing Product Page implementation).
- **AC-4**: Product grid is responsive: 2 columns on desktop, 1 column on mobile.
- **AC-5**: Product images load correctly; missing images show error placeholder.
- **AC-6**: Sale items display both original price (struck through) and sale price (bold, purple).
- **AC-7**: Product cards maintain existing visual design (no style regressions).
- **AC-8**: Navigation back to homepage from Product Page

## Functional Requirements (Summary)

### FR-1 Featured Products Data
- **FR-1.1**: Define a constant list `kFeaturedProducts` containing 4 `Product` objects.
- **FR-1.2**: Each product must include:
  - `id` (String): Unique identifier (e.g., "clothing-001", "merch-hoodie-purple")
  - `title` (String): Product name (e.g., "Portsmouth University Hoodie")
  - `price` (double): Current price in GBP (e.g., 25.00)
  - `originalPrice` (double?): Original price if on sale (null if not on sale)
  - `imageUrl` (String): Asset path (e.g., "assets/images/hoodie_purple.jpg")
  - `availableColors` (List<String>): Available colors (e.g., ["Purple", "Black", "White"])
  - `availableSizes` (List<String>): Available sizes (e.g., ["XS", "S", "M", "L", "XL"])
  - `description` (String): Product description (used on Product Page)
  - `maxStock` (int): Maximum purchasable quantity (e.g., 10)
- **FR-1.3**: Products should represent a diverse mix:
  - Product 1: Clothing item (e.g., hoodie or t-shirt)
  - Product 2: Merchandise item (e.g., mug, tote bag, stationery)
  - Product 3: Sale item (with originalPrice and discounted price)
  - Product 4: Signature/essential item (popular product)
- **FR-1.4**: All product images must exist in `assets/images/` directory and be declared in `pubspec.yaml`.

### FR-2 Homepage Integration
- **FR-2.1**: Replace placeholder `ProductCard` widgets in `HomeScreen` with dynamic cards generated from `kFeaturedProducts`.
- **FR-2.2**: Use `GridView.builder` or map over `kFeaturedProducts` list to generate cards.
- **FR-2.3**: Pass product data to `ProductCard` widget via constructor parameters.
- **FR-2.4**: Remove hardcoded placeholder data (current title/price/imageUrl strings).

### FR-3 ProductCard Enhancement
- **FR-3.1**: Update `ProductCard` widget to accept full `Product` object instead of individual strings.
- **FR-3.2**: If product has `originalPrice`, display both originalPrice (struck through, grey, smaller font) and price (bold, purple, larger font).
- **FR-3.3**: Price display format: "£XX.XX" (e.g., "£25.00", "£19.99").
- **FR-3.4**: On tap, navigate to Product Page with product object: `Navigator.pushNamed(context, '/product', arguments: product)`.

### FR-4 Product Page Navigation
- **FR-4.1**: Update Product Page to receive product data from route arguments.
- **FR-4.2**: Extract product object using `ModalRoute.of(context)!.settings.arguments as Product`.
- **FR-4.3**: Display received product data in Product Page UI (image, title, price, colors, sizes, description).

### FR-5 Image Handling
- **FR-5.1**: All product images must be added to `assets/images/` directory.

- **FR-5.3**: Use `Image.asset()` with `fit: BoxFit.cover` and `errorBuilder` for fallback.
- **FR-5.4**: Optimize images for web/mobile (recommended size: 800x800px, format: JPEG or PNG).

### FR-6 Styling & Consistency
- **FR-6.1**: Maintain existing `ProductCard` visual design (no style changes).
- **FR-6.2**: Use purple theme color (#4d2963) for sale prices and accents.
- **FR-6.3**: Match font sizes and weights with existing homepage typography:
  - Product title: 14px, normal weight, black
  - Regular price: 13px, normal weight, grey
  - Sale price: 13px, bold weight, purple
  - Original price: 11px, normal weight, grey, strikethrough
- **FR-6.4**: Maintain responsive grid spacing: 24px horizontal, 48px vertical.

## Non-Functional Requirements

### NFR-1 Performance
- Featured products list loads instantly (no async operations).
- Product images load in <500ms (optimized assets).
- Navigation to Product Page is immediate (<100ms).
- No unnecessary re-renders; use `const` constructors for static widgets.

### NFR-2 Maintainability
- Featured products list is defined in a single location (easy to update).
- Use existing `Product` model (no new data structures).
- Reuse existing `ProductCard` widget with minimal modifications.
- Code is well-commented and follows existing app patterns.

### NFR-3 Consistency
- Featured products section matches homepage design (colors, spacing, typography).
- Product cards match design of cards on Sale/Clothing pages.
- Navigation behavior is consistent with rest of app.
- Use existing purple theme color (#4d2963) for branding.

### NFR-4 Scalability
- Featured products list can easily be expanded (e.g., to 6 or 8 products).
- Product selection can be changed by updating `kFeaturedProducts` list.
- System supports future dynamic product loading (e.g., from API or database).

## Implementation Notes & Examples

### Example: Featured Products Data
```dart
// filepath: lib/constants/featured_products.dart
import 'package:union_shop/models/product.dart';

const List<Product> kFeaturedProducts = [
  // Product 1: Clothing (Hoodie)
  Product(
    id: 'clothing-hoodie-purple-001',
    title: 'Portsmouth University Hoodie',
    price: 35.00,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    availableColors: ['Purple', 'Black', 'Navy'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    description: 'Stay warm and stylish with our classic Portsmouth University hoodie. Made from premium cotton blend fabric with embroidered logo.',
    maxStock: 10,
  ),

  // Product 2: Merchandise (Mug)
  Product(
    id: 'merch-mug-portsmouth-001',
    title: 'Portsmouth City Mug',
    price: 8.99,
    imageUrl: 'assets/images/PortsmouthCityMagnet1.jpg',
    availableColors: ['White'],
    availableSizes: [],
    description: 'Enjoy your morning coffee in style with our Portsmouth City mug. Features iconic Portsmouth landmarks.',
    maxStock: 50,
  ),

  // Product 3: Sale Item (T-Shirt)
  Product(
    id: 'clothing-tshirt-signature-sale',
    title: 'Signature Portsmouth T-Shirt',
    price: 12.99,
    originalPrice: 18.99,
    imageUrl: 'assets/images/tshirt_signature.jpg',
    availableColors: ['Purple', 'White', 'Black'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
    description: 'Classic Portsmouth University t-shirt with signature logo. Now on sale!',
    maxStock: 20,
  ),

  // Product 4: Popular Item (Tote Bag)
  Product(
    id: 'merch-tote-bag-001',
    title: 'Portsmouth University Tote Bag',
    price: 9.99,
    imageUrl: 'assets/images/tote_bag.jpg',
    availableColors: ['Natural', 'Purple'],
    availableSizes: [],
    description: 'Eco-friendly cotton tote bag perfect for carrying books, groceries, or gym gear. Features embroidered Portsmouth logo.',
    maxStock: 30,
  ),
];
```

### Example: Homepage Integration
```dart
// filepath: lib/main.dart
// ...existing imports...
import 'package:union_shop/constants/featured_products.dart';

class _HomeScreenState extends State<HomeScreen> {
  // ...existing code...

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/',
      child: Column(
        children: [
          _buildHeroCarousel(),

          // Products Section
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Text(
                    'FEATURED PRODUCTS',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      childAspectRatio: 0.75, // Adjust based on card height
                    ),
                    itemCount: kFeaturedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: kFeaturedProducts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### Example: Updated ProductCard
```dart
// filepath: lib/main.dart
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
                // Show both original and sale price
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
                // Show regular price only
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

### Example: Product Page Route Handling
```dart
// filepath: lib/views/product_page.dart
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product _product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract product from route arguments
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Product) {
      _product = args;
    } else {
      // Fallback or error handling
      throw Exception('Product data not provided to ProductPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/product',
      child: SingleChildScrollView(
        child: // ...build product page UI using _product data...
      ),
    );
  }
}
```

## Subtasks (Actionable)

- [ ] **Subtask 1**: Ensure `Product` model exists with all required fields (id, title, price, originalPrice, imageUrl, availableColors, availableSizes, description, maxStock). If not, create it in `lib/models/product.dart`.

- [ ] **Subtask 2**: Create featured products data file (`lib/constants/featured_products.dart`) with `kFeaturedProducts` list containing 4 diverse products.

- [ ] **Subtask 3**: Add 4 new product images to `assets/images/` directory (e.g., hoodie, mug, t-shirt, tote bag).

- [ ] **Subtask 4**: Update `pubspec.yaml` to include new image assets (or ensure `assets/images/` directory is already included).

- [ ] **Subtask 5**: Update `ProductCard` widget to accept `Product` object instead of individual string parameters.

- [ ] **Subtask 6**: Add sale price display logic to `ProductCard` (show originalPrice struck through if present).

- [ ] **Subtask 7**: Update `ProductCard` `onTap` handler to navigate to Product Page with product object as route argument.

- [ ] **Subtask 8**: Replace hardcoded `ProductCard` widgets in `HomeScreen` with `GridView.builder` that maps over `kFeaturedProducts`.

- [ ] **Subtask 9**: Update section title from "PRODUCTS SECTION" to "FEATURED PRODUCTS" (optional, for clarity).

- [ ] **Subtask 10**: Update Product Page to receive and display product data from route arguments (extract using `ModalRoute.of(context)!.settings.arguments`).

- [ ] **Subtask 11**: Test navigation: Verify clicking each featured product card navigates to Product Page with correct data.

- [ ] **Subtask 12**: Test responsive layout: Verify grid displays 2 columns on desktop, 1 column on mobile.

- [ ] **Subtask 13**: Test image loading: Verify all product images load correctly; missing images show error placeholder.

- [ ] **Subtask 14**: Test sale price display: Verify sale items show both original (struck through) and sale price (bold, purple).

---

End of prompt.