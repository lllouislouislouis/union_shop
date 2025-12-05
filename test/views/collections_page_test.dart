import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection_item.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/shop_category_page.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/firebase_service.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/providers/products_provider.dart';

/// Lightweight fake FirebaseService for tests that returns empty data.
class _FakeFirebaseService implements FirebaseServiceBase {
  @override
  Future<List<Product>> getAllProducts() async => [];
  @override
  Future<List<Product>> getProductsByCategory(String category) async => [];
  @override
  Future<Product?> getProductById(String id) async => null;
  @override
  Future<String> getImageUrl(String path) async => '';
  @override
  Stream<List<Product>> watchAllProducts() => Stream.value([]);
}

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Inject a fake FirebaseService to avoid initializing Firebase in tests
        ChangeNotifierProvider(
            create: (_) => ProductsProvider(
                  firebaseService: _FakeFirebaseService(),
                )..fetchAllProducts()),
      ],
      child: MaterialApp(
        routes: routes,
        home: CollectionsPage(items: items),
      ),
    );
  }

  testWidgets('CollectionsPage renders correct number of tiles',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // No named route for '/collections/clothing' provided, should fallback to ShopCategoryPage
    await tester.pumpWidget(
      buildTestApp(testItems, {
        // Provide nothing for '/collections/clothing' to trigger fallback
      }),
    );

    await tester.pumpAndSettle();

    // Ensure visible and tap the clothing tile
    await tester
        .ensureVisible(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();

    // Expect ShopCategoryPage pushed
    expect(find.byType(ShopCategoryPage), findsOneWidget);
  });

  testWidgets('Tapping a tile uses named route when provided', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Provide an items list where the clothing item has an explicit route
    final itemsWithRoute = [
      const CollectionItem(
        slug: 'clothing',
        title: 'Clothing',
        imagePath: 'assets/images/collections/clothing.jpg',
        route: '/collections/clothing',
      ),
      testItems[1],
    ];

    await tester.pumpWidget(
      buildTestApp(itemsWithRoute, {
        '/collections/clothing': (context) => const Scaffold(
              body: Center(child: Text('Clothing Route')),
            ),
      }),
    );

    await tester.pumpAndSettle();

    // Ensure visible and tap the clothing tile
    await tester
        .ensureVisible(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('collection_tile_clothing')));
    await tester.pumpAndSettle();

    // Expect the named route page
    expect(find.text('Clothing Route'), findsOneWidget);
  });

  testWidgets('First tile has a semantics label', (tester) async {
    // Enable semantics for the test
    final handle = tester.ensureSemantics();

    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
