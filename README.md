# Union Shop (University Union Shop)

A Flutter-based e-commerce app for a university union shop. The app provides catalog/collection browsing, category views, sale listings, and a shopping cart with responsive UI. It uses Provider for state management and is structured for easy extension (e.g., Firebase-backed products).

Key features
- Collections grid (Clothing, Merchandise, Graduation, Print Shack, etc.)
- Category / shop pages with filter, sort and pagination
- Sale page showcasing discount items
- Product details and a shopping cart with summary and checkout placeholder
- Responsive layouts for mobile, tablet and desktop
- Accessible interactive tiles and keyboard/hover support

Installation & setup

Prerequisites
- OS: macOS, Windows or Linux
- Flutter SDK (>= 3.x recommended). Install: https://flutter.dev/docs/get-started/install
- Dart (bundled with Flutter)
- Android Studio / Xcode (for device emulation / iOS build)
- Optional: Firebase CLI if you integrate Firebase later

Clone repository
1. Open a terminal and run:
   git clone <https://github.com/lllouislouislouis/union_shop>
   cd ".\union_shop"

Install dependencies
1. From project root run:
   flutter pub get

Run the app
1. Launch an emulator or connect a device.
2. Run:
   flutter run

Usage — main flows

Collections page
- Displays a responsive grid of collections (see lib/views/collections_page.dart).
- Tap a tile to open a category or a dedicated route (some items use explicit routes, e.g., Print Shack).

Category / Shop page
- File: lib/views/shop_category_page.dart
- Shows products for a selected category, with optional filter & sort controls.
- Pagination is implemented; projection uses ProductsProvider (Provider + Firebase possible).
- Click a product to open product detail (route: `/product` with Product object as argument).

Sale page
- File: lib/views/sale_page.dart
- Displays sale items with original price struck through and sale price highlighted.
- Filter / Sort and pagination available.

Cart
- File: lib/views/cart_page.dart
- Shows empty and populated states, item list, and order summary.
- Checkout currently shows placeholder snackbar.

Product model & mock data
- File: lib/models/product.dart
- Contains Product model and mock sample products for development.

How to run tests
- Run: flutter test

Configuration options
- Theme colors and paddings are defined inline in widgets; you can refactor to a central theme file.
- Product data uses Provider (`lib/providers/products_provider.dart`) — swap the data source for Firebase or other APIs as required.
- Routes: app uses Navigator (named and MaterialPageRoute). Update routes in your main.dart for new pages.

Project structure (high level)
- lib/
  - views/
    - collections_page.dart        (collections grid & tiles)
    - shop_category_page.dart      (category view, filters, pagination)
    - sale_page.dart               (sale listing and SaleProductCard)
    - cart_page.dart               (cart UI and summary)
  - models/
    - product.dart                 (Product model + mock data)
    - sale_product.dart            (sale-specific model)
    - collection_item.dart         (collection metadata)
  - providers/
    - products_provider.dart       (product state, Firebase integration point)
    - cart_provider.dart           (cart state management)
  - widgets/
    - app_scaffold.dart            (global scaffold/header/footer)
    - sale_product_card.dart
    - cart_item_card.dart
    - category_filter_dropdown.dart
    - sort_dropdown.dart
    - product_count_display.dart
  - main.dart                      (app entry — wire routes and providers)

Key dependencies
- flutter (SDK)
- provider (state management)
- (optional) firebase_core, cloud_firestore, firebase_auth — integrate for backend

Known issues & limitations
- Some images referenced in code (assets/images/...) may be placeholders; ensure assets are added and declared in pubspec.yaml.
- ProductsProvider expects a Firebase-backed source in some implementations; currently mock data is used for development in several places.
- Checkout flow is a placeholder; no payment integration yet.
- Accessibility: basic semantics and focus handling exist, but thorough testing (screen readers, keyboard nav) is recommended.

Planned improvements
- Full Firebase integration for products and user carts
- User authentication and order history
- Payment gateway integration
- Centralised theme and localization support

Contribution
1. Fork the repo.
2. Create a branch: git checkout -b feature/your-feature
3. Commit changes: git commit -m "Add feature"
4. Push and open a PR.

Coding guidelines
- Follow Flutter/Dart style: dartfmt, avoid large widgets, extract reusable widgets.
- Include tests for new features where feasible.

Contact
- Developer: Louis Daniels-SMith
- Email: up2266268@myport.ac.uk
- Repository / Profile: https://github.com/lllouislouislouis

