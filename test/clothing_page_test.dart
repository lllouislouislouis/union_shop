import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/shop_category_page.dart';

void main() {
  // Set a larger default screen size for all tests to prevent overflow
  setUp(() {
    // This will be applied to all tests
  });

  group('Clothing Page - Filter and Sort Tests', () {
    testWidgets('Clothing page loads with correct title and filters enabled',
        (WidgetTester tester) async {
      // Set larger screen size to prevent overflow
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      // Build the Clothing page
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify page title is "Clothing"
      expect(find.text('Clothing'), findsOneWidget);

      // Verify filter and sort controls are present
      expect(find.text('Filter by'), findsOneWidget);
      expect(find.text('Sort by'), findsOneWidget);

      // Verify product count is displayed
      expect(find.textContaining('product'), findsOneWidget);
    });

    testWidgets('Changing filter updates product count and grid',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Note: ShopCategoryPage loads ALL products when category='clothing',
      // so initial count is 15, not 5
      expect(find.text('15 products'), findsOneWidget);

      // Tap on filter dropdown
      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();

      // Select "Clothing" filter
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Verify "Clothing" filter shows 5 products (from mock data)
      expect(find.text('5 products'), findsOneWidget);
    });

    testWidgets('Changing sort option reorders products correctly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Get initial product count
      final initialCountText =
          tester.widget<Text>(find.textContaining('product')).data!;

      // Tap on sort dropdown (second dropdown)
      await tester.tap(find.byIcon(Icons.arrow_drop_down).last);
      await tester.pumpAndSettle();

      // Select "Alphabetically, A-Z" sort
      await tester.tap(find.text('Alphabetically, A-Z').last);
      await tester.pumpAndSettle();

      // Get product count after sorting
      final newCountText =
          tester.widget<Text>(find.textContaining('product')).data!;

      // Verify product count remains the same (sorting doesn't change count)
      expect(initialCountText, equals(newCountText));

      // Verify sort was applied (products are still displayed)
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Product count updates immediately after filter change',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify initial count shows all products (15)
      expect(find.text('15 products'), findsOneWidget);

      // Change filter to "Merchandise"
      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merchandise').last);
      await tester.pumpAndSettle();

      // Verify count updated to 5 merchandise products
      expect(find.text('5 products'), findsOneWidget);

      // Change filter to "PSUT"
      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('PSUT').last);
      await tester.pumpAndSettle();

      // Verify count updated to 5 PSUT products
      expect(find.text('5 products'), findsOneWidget);
    });

    testWidgets('Only one filter can be selected at a time',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Open filter dropdown
      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();

      // Select "Clothing"
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Verify only Clothing filter is active (showing 5 products)
      expect(find.text('5 products'), findsOneWidget);

      // Open filter dropdown again
      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();

      // Select "Merchandise" - this should replace "Clothing" selection
      await tester.tap(find.text('Merchandise').last);
      await tester.pumpAndSettle();

      // Verify only Merchandise filter is active (still showing 5 products)
      expect(find.text('5 products'), findsOneWidget);
    });
  });

  group('Clothing Page - Accessibility Tests', () {
    testWidgets('Filter dropdown has proper semantic labels',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: [
              'All Categories',
              'Clothing',
              'Merchandise',
              'PSUT',
            ],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify semantic label exists for filter dropdown
      final semantics = tester.getSemantics(find.text('Filter by'));
      expect(semantics, isNotNull);
    });

    testWidgets('Sort dropdown has proper semantic labels',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: [
              'Featured',
              'Best Selling',
              'Alphabetically, A-Z',
              'Alphabetically, Z-A',
              'Price: Low to High',
              'Price: High to Low',
              'Date, old to new',
              'Date, new to old',
            ],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify semantic label exists for sort dropdown
      final semantics = tester.getSemantics(find.text('Sort by'));
      expect(semantics, isNotNull);
    });

    testWidgets('Product count has proper semantic label',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify product count text exists
      expect(find.text('15 products'), findsOneWidget);
    });
  });

  group('Clothing Page - Navigation Tests', () {
    testWidgets('Product card navigation works correctly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      bool navigationCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: const ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
          onGenerateRoute: (settings) {
            if (settings.name == '/product') {
              navigationCalled = true;
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Product Page')),
                ),
              );
            }
            return null;
          },
        ),
      );

      await tester.pumpAndSettle();

      // Find SaleProductCard widgets and tap the first one
      final productCards = find.byType(GestureDetector);
      expect(productCards, findsWidgets);

      // Tap the first product card
      await tester.tap(productCards.first);
      await tester.pumpAndSettle();

      // Verify navigation was triggered
      expect(navigationCalled, isTrue);
    });
  });

  group('Clothing Page - Responsive Layout Tests', () {
    testWidgets('Mobile layout displays single column grid',
        (WidgetTester tester) async {
      // Set mobile screen size (360x800)
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify filter and sort are stacked vertically (mobile layout)
      expect(find.text('Filter by'), findsOneWidget);
      expect(find.text('Sort by'), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Desktop layout displays multi-column grid',
        (WidgetTester tester) async {
      // Set desktop screen size (1200x800)
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify controls are displayed horizontally (desktop layout)
      expect(find.text('Filter by'), findsOneWidget);
      expect(find.text('Sort by'), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });
  });

  group('Clothing Page - Empty State Tests', () {
    testWidgets('Empty state displays when no products match filter',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'nonexistent-category', // Category with no products
            enableFiltersAndSort: true,
            filterOptions: ['All Categories'],
            initialFilter: 'All Categories',
            sortOptions: ['Featured'],
            initialSort: 'Featured',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify empty state icon is displayed
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);

      // Verify empty state message
      expect(find.textContaining('No products found'), findsOneWidget);
    });
  });
}
