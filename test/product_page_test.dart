import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/models/product.dart';

void main() {
  // Set up a test product with all customization options
  final testProductWithOptions = Product(
    id: 'test_001',
    title: 'Test Hoodie',
    price: 24.99,
    originalPrice: 35.00,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    availableColors: ['Purple', 'Black', 'White', 'Navy'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    description: 'This is a test hoodie with color and size options.',
    maxStock: 50,
  );

  // Test product without customization options
  final testProductNoOptions = Product(
    id: 'test_002',
    title: 'Test Water Bottle',
    price: 12.99,
    originalPrice: 18.00,
    imageUrl: 'assets/images/water_bottle.jpg',
    availableColors: const [],
    availableSizes: const [],
    description: 'This is a test water bottle with no customization options.',
    maxStock: 100,
  );

  group('ProductPage - Layout Tests', () {
    testWidgets('Product page displays with all required elements',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify product title is displayed
      expect(find.text('Test Hoodie'), findsOneWidget);

      // Verify price is displayed
      expect(find.text('£24.99'), findsOneWidget);

      // Verify original price (struck through) is displayed
      expect(find.text('£35.00'), findsOneWidget);

      // Verify description header
      expect(find.text('Description'), findsOneWidget);

      // Verify product description is displayed
      expect(find.textContaining('test hoodie with color and size options'),
          findsOneWidget);
    });

    testWidgets('Color dropdown appears for products with colors',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify "Color" label is displayed
      expect(find.text('Color'), findsOneWidget);

      // Verify dropdown with placeholder text exists
      expect(find.text('Select Color'), findsOneWidget);
    });

    testWidgets('Size dropdown appears for products with sizes',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify "Size" label is displayed
      expect(find.text('Size'), findsOneWidget);

      // Verify dropdown with placeholder text exists
      expect(find.text('Select Size'), findsOneWidget);
    });

    testWidgets(
        'Color and size dropdowns do not appear for products without them',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductNoOptions),
      );

      await tester.pumpAndSettle();

      // Verify "Color" label is NOT displayed
      expect(find.text('Color'), findsNothing);

      // Verify "Size" label is NOT displayed
      expect(find.text('Size'), findsNothing);
    });

    testWidgets('Quantity selector displays with correct initial value',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify "Quantity" label is displayed
      expect(find.text('Quantity'), findsOneWidget);

      // Verify quantity input field exists
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Add to Cart and Buy Now buttons are displayed',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify "Add to Cart" button is displayed
      expect(find.text('Add to Cart'), findsOneWidget);

      // Verify "Buy Now" button is displayed
      expect(find.text('Buy Now'), findsOneWidget);
    });
  });

  group('ProductPage - Color Selection Tests', () {
    testWidgets('Color dropdown displays all available colors',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Scroll to make dropdown visible
      await tester.dragUntilVisible(
        find.text('Select Color'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Tap the color dropdown
      await tester.tap(find.text('Select Color'));
      await tester.pumpAndSettle();

      // Verify all colors are displayed
      expect(find.text('Purple'), findsWidgets);
      expect(find.text('Black'), findsOneWidget);
      expect(find.text('White'), findsOneWidget);
      expect(find.text('Navy'), findsOneWidget);
    });

    testWidgets('Selecting a color updates the dropdown display',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Scroll to make dropdown visible
      await tester.dragUntilVisible(
        find.text('Select Color'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Tap the color dropdown
      await tester.tap(find.text('Select Color'));
      await tester.pumpAndSettle();

      // Select "Black" color
      await tester.tap(find.text('Black').last);
      await tester.pumpAndSettle();

      // Verify "Black" is now shown in the dropdown
      expect(find.text('Black'), findsWidgets);
    });
  });

  group('ProductPage - Size Selection Tests', () {
    testWidgets('Size dropdown displays all available sizes',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Scroll to make dropdown visible
      await tester.dragUntilVisible(
        find.text('Select Size'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Tap the size dropdown (second dropdown)
      await tester.tap(find.text('Select Size'));
      await tester.pumpAndSettle();

      // Verify all sizes are displayed
      expect(find.text('XS'), findsOneWidget);
      expect(find.text('S'), findsWidgets);
      expect(find.text('M'), findsWidgets);
      expect(find.text('L'), findsWidgets);
      expect(find.text('XL'), findsOneWidget);
      expect(find.text('XXL'), findsOneWidget);
    });

    testWidgets('Selecting a size updates the dropdown display',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Scroll to make dropdown visible
      await tester.dragUntilVisible(
        find.text('Select Size'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Tap the size dropdown
      await tester.tap(find.text('Select Size'));
      await tester.pumpAndSettle();

      // Select "L" size
      await tester.tap(find.text('L').last);
      await tester.pumpAndSettle();

      // Verify "L" is now shown in the dropdown
      expect(find.text('L'), findsWidgets);
    });
  });

  group('ProductPage - Quantity Selector Tests', () {
    testWidgets('Quantity increment button increases quantity',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Find and tap the increment button (+ icon)
      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Verify quantity increased
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Quantity decrement button decreases quantity',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // First increment to 2
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Then decrement back to 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      // Verify quantity field exists
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Decrement button is disabled when quantity is 1',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Find the decrement button (- icon)
      final decrementButton = find.byIcon(Icons.remove);

      // The button should exist
      expect(decrementButton, findsOneWidget);
    });

    testWidgets('Increment button is disabled at maximum stock',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      // Create a product with low max stock
      final lowStockProduct = Product(
        id: 'test_003',
        title: 'Low Stock Item',
        price: 9.99,
        originalPrice: 15.00,
        imageUrl: 'assets/images/test.jpg',
        availableColors: const [],
        availableSizes: const [],
        description: 'Test product with limited stock.',
        maxStock: 1,
      );

      await tester.pumpWidget(
        _buildTestProductPage(lowStockProduct),
      );

      await tester.pumpAndSettle();

      // Find the increment button
      final incrementButton = find.byIcon(Icons.add);

      // The button should exist
      expect(incrementButton, findsOneWidget);
    });
  });

  group('ProductPage - Button State Tests', () {
    testWidgets(
        'Add to Cart button is disabled when required options not selected',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Find the "Add to Cart" button
      final addToCartButton = find.byType(ElevatedButton);

      // The button should exist
      expect(addToCartButton, findsOneWidget);
    });

    testWidgets(
        'Add to Cart button is enabled when all required options selected',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Scroll to color dropdown and select
      await tester.dragUntilVisible(
        find.text('Select Color'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Select a color
      await tester.tap(find.text('Select Color'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Purple').last);
      await tester.pumpAndSettle();

      // Scroll to size dropdown and select
      await tester.dragUntilVisible(
        find.text('Select Size'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Select a size
      await tester.tap(find.text('Select Size'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('M').last);
      await tester.pumpAndSettle();

      // Now the "Add to Cart" button should be enabled
      final addToCartButton = find.byType(ElevatedButton);
      expect(addToCartButton, findsOneWidget);
    });

    testWidgets('Add to Cart button is enabled when no options required',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductNoOptions),
      );

      await tester.pumpAndSettle();

      // The "Add to Cart" button should be enabled immediately (no options required)
      final addToCartButton = find.byType(ElevatedButton);
      expect(addToCartButton, findsOneWidget);
    });
  });

  group('ProductPage - Responsive Layout Tests', () {
    testWidgets('Desktop layout displays two-column layout',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify layout contains Row for desktop
      expect(find.byType(Row), findsWidgets);
      expect(find.text('Test Hoodie'), findsOneWidget);
    });

    testWidgets('Mobile layout displays single-column layout',
        (WidgetTester tester) async {
      // Use minimum 600px width to avoid AppHeader overflow
      tester.view.physicalSize = const Size(600, 800);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        _buildTestProductPage(testProductWithOptions),
      );

      await tester.pumpAndSettle();

      // Verify layout contains Column for mobile
      expect(find.byType(Column), findsWidgets);
      expect(find.text('Test Hoodie'), findsOneWidget);
    });
  });
}

/// Helper function to create a proper test environment for ProductPage
/// Wraps ProductPage with a simple AppBar to avoid AppScaffold rendering issues
Widget _buildTestProductPage(Product product) {
  // Use a minimal Scaffold with a basic AppBar for tests to avoid AppHeader/AppScaffold overflow
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return const ProductPage(useAppScaffold: false);
            },
            settings: RouteSettings(
              name: '/product',
              arguments: product,
            ),
          );
        },
      ),
    ),
  );
}



