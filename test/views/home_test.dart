import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with all major sections',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Check that AppHeader is present
      expect(find.byType(AppHeader), findsOneWidget);

      // Check carousel is visible (first slide)
      expect(find.text('Browse Our Collections'), findsOneWidget);
      expect(find.text('EXPLORE'), findsOneWidget);

      // Check products section
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(4));

      // Check that AppFooter is present
      expect(find.byType(AppFooter), findsOneWidget);
    });

    testWidgets('should display footer with opening hours and help info',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Scroll to bottom to see footer
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -2000),
      );
      await tester.pump();

      // Check footer sections
      expect(find.text('Opening hours'), findsOneWidget);
      expect(find.text('Help & information'), findsOneWidget);

      // Check footer buttons
      // Use label-based checks for robustness
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Terms & Conditions of Sale'), findsOneWidget);
    });

    testWidgets('footer search button should navigate to search page',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Scroll to footer
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -2000),
      );
      await tester.pump();

      // Tap search button
      await tester.tap(find.text('Search'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify navigation to search page
      expect(find.text('Search'), findsWidgets); // Page title
      expect(find.byType(TextField), findsOneWidget); // Search input
    });

    testWidgets('footer terms button should navigate to terms page',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Scroll to footer
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -2000),
      );
      await tester.pump();

      // Tap terms button
      await tester.tap(find.text('Terms & Conditions of Sale'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify navigation to terms page
      expect(find.text('Terms & Conditions of Sale'), findsWidgets);
    });

    testWidgets('should display carousel with navigation controls',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Check carousel navigation controls
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);

      // Check dot indicators (should have 4)
      final gestureDetectors = find.byType(GestureDetector);
      int dotCount = 0;
      for (var element in gestureDetectors.evaluate()) {
        final widget = element.widget as GestureDetector;
        if (widget.child is Container) {
          final container = widget.child as Container;
          if (container.decoration is BoxDecoration) {
            final decoration = container.decoration as BoxDecoration;
            if (decoration.shape == BoxShape.circle) {
              dotCount++;
            }
          }
        }
      }
      expect(dotCount, greaterThanOrEqualTo(4));
    });

    testWidgets('should display 4 product cards with correct data',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that exactly 4 product cards are displayed
      expect(find.byType(ProductCard), findsNWidgets(4));

      // Check product titles (match `kFeaturedProducts`)
      expect(find.text('Portsmouth University Hoodie'), findsOneWidget);
      expect(find.text('Portsmouth City Mug'), findsOneWidget);
      expect(find.text('Signature Portsmouth T-Shirt'), findsOneWidget);
      expect(find.text('Portsmouth University Tote Bag'), findsOneWidget);

      // Check product prices
      expect(find.text('£35.00'), findsOneWidget);
      expect(find.text('£8.99'), findsOneWidget);
      expect(find.text('£12.99'), findsOneWidget);
      expect(find.text('£9.99'), findsOneWidget);
    });

    testWidgets('should show products in 2-column grid on desktop',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Find GridView and check column count
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });

    testWidgets('should show products in 1-column grid on mobile',
        (tester) async {
      // Use 600px width to avoid AppHeader overflow while still triggering mobile layout
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Find GridView and check column count
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 1);
    });

    testWidgets('should display footer section', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that footer is present
      expect(find.byType(AppFooter), findsOneWidget);
    });

    testWidgets('product cards should be tappable and navigate to product page',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Scroll down to see products section
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -600));
      await tester.pump();

      // Find first product card and ensure it's visible
      final productCard = find.byType(ProductCard).first;
      expect(productCard, findsOneWidget);

      // Ensure the widget is now visible before tapping
      await tester.ensureVisible(productCard);
      await tester.pump();

      // Tap the product card
      await tester.tap(productCard);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Should navigate to product page
      expect(find.byType(ProductPage), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });
  });
}
