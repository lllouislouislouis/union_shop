import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection_item.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/shop_category_page.dart';

void main() {
  // Minimal items list for testing
  const testItems = [
    CollectionItem(
      slug: 'clothing',
      title: 'Clothing',
      imagePath: 'assets/images/collections/clothing.jpg',
    ),
    CollectionItem(
      slug: 'merchandise',
      title: 'Merchandise',
      imagePath: 'assets/images/collections/merchandise.jpg',
    ),
  ];

  Widget buildTestApp(
      List<CollectionItem> items, Map<String, WidgetBuilder> routes) {
    return MaterialApp(
      routes: routes,
      home: CollectionsPage(items: items),
    );
  }

  testWidgets('CollectionsPage renders correct number of tiles',
      (tester) async {
    await tester.pumpWidget(
      buildTestApp(testItems, {
        '/collections': (_) => const CollectionsPage(items: testItems),
      }),
    );

    // Allow layout to settle
    await tester.pumpAndSettle();

    // Expect grid widget
    expect(find.byKey(const Key('collections_grid')), findsOneWidget);

    // Expect 2 tiles rendered
    expect(find.byKey(const Key('collection_tile_clothing')), findsOneWidget);
    expect(
        find.byKey(const Key('collection_tile_merchandise')), findsOneWidget);
  });

  testWidgets(
      'Tapping a tile navigates to ShopCategoryPage fallback when route missing',
      (tester) async {
    // No named route for '/collections/clothing' provided, should fallback to ShopCategoryPage
    await tester.pumpWidget(
      buildTestApp(testItems, {
        // Provide nothing for '/collections/clothing' to trigger fallback
      }),
    );

    await tester.pumpAndSettle();

    // Tap the clothing tile
    await tester.tap(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();

    // Expect ShopCategoryPage pushed
    expect(find.byType(ShopCategoryPage), findsOneWidget);
  });

  testWidgets('Tapping a tile uses named route when provided', (tester) async {
    await tester.pumpWidget(
      buildTestApp(testItems, {
        '/collections/clothing': (context) => const Scaffold(
              body: Center(child: Text('Clothing Route')),
            ),
      }),
    );

    await tester.pumpAndSettle();

    // Tap the clothing tile
    await tester.tap(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();

    // Expect the named route page
    expect(find.text('Clothing Route'), findsOneWidget);
  });

  testWidgets('First tile has a semantics label', (tester) async {
    // Enable semantics for the test
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      buildTestApp(testItems, {}),
    );

    await tester.pumpAndSettle();

    final semantics =
        tester.getSemantics(find.byKey(const Key('collection_tile_clothing')));
    // SemanticsNode does not have `hasLabel`; check label presence directly
    expect(semantics.label, isNotNull);
    expect(semantics.label.isNotEmpty, isTrue);
    expect(semantics.label, contains('Open Clothing collection'));

    // Dispose semantics handle
    handle.dispose();
  });
}
