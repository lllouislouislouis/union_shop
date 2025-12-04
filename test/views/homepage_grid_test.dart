import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/constants/featured_products.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Homepage Featured Products Grid Tests', () {
    testWidgets('grid renders 4 product cards', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      expect(find.byType(ProductCard), findsNWidgets(4));
    });

    testWidgets('grid displays "FEATURED PRODUCTS" title',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
    });

    testWidgets('grid uses kFeaturedProducts data',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert - check that product titles from kFeaturedProducts are displayed
      for (final product in kFeaturedProducts) {
        expect(find.text(product.title), findsOneWidget);
      }
    });

    testWidgets('grid layout is 2 columns at 800px width',
        (WidgetTester tester) async {
      // Arrange
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      // Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
      expect(delegate.crossAxisSpacing, 24);
      expect(delegate.mainAxisSpacing, 48);

      // Clean up
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    // testWidgets('grid layout is 1 column at 400px width', (WidgetTester tester) async {
    //   // Arrange
    //   tester.view.physicalSize = const Size(400, 800);
    //   tester.view.devicePixelRatio = 1.0;

    //   // Act
    //   await tester.pumpWidget(
    //     const MaterialApp(
    //       home: HomeScreen(),
    //     ),
    //   );

    //   // Assert
    //   final gridView = tester.widget<GridView>(find.byType(GridView));
    //   final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    //   expect(delegate.crossAxisCount, 1);
    //   expect(delegate.crossAxisSpacing, 24);
    //   expect(delegate.mainAxisSpacing, 48);

    //   // Clean up
    //   addTearDown(() {
    //     tester.view.resetPhysicalSize();
    //     tester.view.resetDevicePixelRatio();
    //   });
    // });

    testWidgets('grid uses shrinkWrap and NeverScrollableScrollPhysics',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      final gridView = tester.widget<GridView>(find.byType(GridView));
      expect(gridView.shrinkWrap, isTrue);
      expect(gridView.physics, isA<NeverScrollableScrollPhysics>());
    });

    testWidgets('grid has correct childAspectRatio',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.childAspectRatio, 0.75);
    });

    testWidgets('section has correct padding', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Arrange & Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert - find the Padding widget containing the products section
      final paddingFinder = find
          .ancestor(
            of: find.text('FEATURED PRODUCTS'),
            matching: find.byType(Padding),
          )
          .first;

      final padding = tester.widget<Padding>(paddingFinder);
      expect(padding.padding, const EdgeInsets.all(40.0));
    });

    testWidgets('first product card displays correct data',
        (WidgetTester tester) async {
      // Arrange
      final firstProduct = kFeaturedProducts[0];
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      expect(find.text(firstProduct.title), findsOneWidget);
      expect(find.text('£${firstProduct.price.toStringAsFixed(2)}'),
          findsOneWidget);
    });

    testWidgets('sale product displays both original and sale price',
        (WidgetTester tester) async {
      // Arrange
      final saleProduct = kFeaturedProducts.firstWhere((p) => p.isOnSale);
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Act
      await tester.pumpWidget(const UnionShopApp());

      // Assert
      expect(find.text('£${saleProduct.originalPrice!.toStringAsFixed(2)}'),
          findsOneWidget);
      expect(find.text('£${saleProduct.price.toStringAsFixed(2)}'),
          findsOneWidget);
    });
  });
}
