import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/providers/products_provider.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      // Provide the same providers used by the real app so AppHeader/AppFooter work
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(
            create: (_) => ProductsProvider()..fetchAllProducts(),
          ),
        ],
        child: const MaterialApp(home: ProductPage()),
      );
    }

    testWidgets('should display product page with basic elements', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that basic UI elements are present (match mock product data)
      expect(find.text('PSUT Premium Hoodie'), findsOneWidget);
      expect(find.text('£24.99'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('should display product option controls', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Product requires color and size selection for the mock product
      expect(find.text('Color'), findsOneWidget);
      expect(find.text('Size'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(find.text('Buy Now'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that header icons are present (desktop shows search, profile and shopping bag)
      expect(find.byIcon(Icons.search), findsWidgets);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
      expect(find.byIcon(Icons.person_outline), findsWidgets);
    });

    testWidgets('should display footer', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that footer sections are present
      expect(find.text('Opening hours'), findsOneWidget);
      expect(find.text('Help & information'), findsOneWidget);
      expect(find.text('Search'), findsWidgets);
      expect(find.text('Terms & Conditions of Sale'), findsWidgets);
    });
  });
}
