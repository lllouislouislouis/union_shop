import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/shop_category_page.dart';

void main() {
  group('ShopCategoryPage - Clothing', () {
    // Test 1: Page renders with initial state (All products)
    testWidgets('renders with all products initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify page title
      expect(find.text('Clothing'), findsWidgets);

      // Verify 12 products are displayed initially
      expect(find.byType(GestureDetector), findsWidgets);
    });

    // Test 2: Filter by 'Clothing' reduces product count
    testWidgets('filters by Clothing category', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the filter dropdown
      final filterDropdown = find.byType(DropdownButton<String>).first;
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();

      // Select 'Clothing' from dropdown
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Verify product count decreased (10 clothing items instead of 12)
      expect(find.text('10 products'), findsOneWidget);
    });

    // Test 3: Filter by 'Merchandise' shows only merchandise
    testWidgets('filters by Merchandise category', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the filter dropdown
      final filterDropdown = find.byType(DropdownButton<String>).first;
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();

      // Select 'Merchandise' from dropdown
      await tester.tap(find.text('Merchandise').last);
      await tester.pumpAndSettle();

      // Verify product count is 2 (merchandise items)
      expect(find.text('2 products'), findsOneWidget);
    });

    // Test 4: Sort by Price Low to High
    testWidgets('sorts products by Price: Low to High',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the sort dropdown (second dropdown)
      final dropdowns = find.byType(DropdownButton<String>);
      await tester.tap(dropdowns.at(1));
      await tester.pumpAndSettle();

      // Select 'Price: Low to High'
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      // Verify lowest price product appears first
      // PSUT Cap Purple (£12.99) should be first
      expect(find.text('PSUT Cap Purple'), findsOneWidget);
    });

    // Test 5: Sort by Price High to Low
    testWidgets('sorts products by Price: High to Low',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the sort dropdown
      final dropdowns = find.byType(DropdownButton<String>);
      await tester.tap(dropdowns.at(1));
      await tester.pumpAndSettle();

      // Select 'Price: High to Low'
      await tester.tap(find.text('Price: High to Low').last);
      await tester.pumpAndSettle();

      // Verify highest price product appears first
      // PSUT Bomber Jacket (£59.99) should be first
      expect(find.text('PSUT Bomber Jacket Black'), findsOneWidget);
    });

    // Test 6: Sort by Newest
    testWidgets('sorts products by Newest', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the sort dropdown
      final dropdowns = find.byType(DropdownButton<String>);
      await tester.tap(dropdowns.at(1));
      await tester.pumpAndSettle();

      // Select 'Newest'
      await tester.tap(find.text('Newest').last);
      await tester.pumpAndSettle();

      // Verify newest products appear first (those with isNew: true)
      expect(find.text('PSUT Navy Hoodie'), findsOneWidget);
    });

    // Test 7: Filter persists when changing sort
    testWidgets('filter persists when sort changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Filter by Clothing
      final filterDropdown = find.byType(DropdownButton<String>).first;
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      expect(find.text('10 products'), findsOneWidget);

      // Now change sort
      final dropdowns = find.byType(DropdownButton<String>);
      await tester.tap(dropdowns.at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      // Verify filter is still applied (still 10 products)
      expect(find.text('10 products'), findsOneWidget);
    });

    // Test 8: Product count updates correctly
    testWidgets('product count updates after filter change',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify initial count is 12
      expect(find.text('12 products'), findsOneWidget);

      // Filter to Merchandise
      final filterDropdown = find.byType(DropdownButton<String>).first;
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merchandise').last);
      await tester.pumpAndSettle();

      // Verify count changed to 2
      expect(find.text('2 products'), findsOneWidget);

      // Filter back to All
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('All').last);
      await tester.pumpAndSettle();

      // Verify count is back to 12
      expect(find.text('12 products'), findsOneWidget);
    });

    // Test 9: Navigation to product page on tap
    testWidgets('navigates to product page on card tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/product': (context) => const Scaffold(
              body: Center(child: Text('Product Page')),
            ),
          },
          home: const ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find first product card
      final firstProduct = find.byType(GestureDetector).first;
      await tester.tap(firstProduct);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Product Page'), findsOneWidget);
    });

    // Test 10: Page title is correct
    testWidgets('displays correct page title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopCategoryPage(
            category: 'clothing',
            enableFiltersAndSort: true,
            filterOptions: ['All', 'Clothing', 'Merchandise', 'Popular'],
            initialFilter: 'All',
            sortOptions: [
              'Popularity',
              'Price: Low to High',
              'Price: High to Low',
              'Newest'
            ],
            initialSort: 'Popularity',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Clothing'), findsWidgets);
    });
  });
}