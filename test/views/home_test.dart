import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/widgets/app_header.dart';

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
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(4));

      // Check footer
      expect(find.text('Placeholder Footer'), findsOneWidget);
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

      // Check product titles
      expect(find.text('Placeholder Product 1'), findsOneWidget);
      expect(find.text('Placeholder Product 2'), findsOneWidget);
      expect(find.text('Placeholder Product 3'), findsOneWidget);
      expect(find.text('Placeholder Product 4'), findsOneWidget);

      // Check product prices
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
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
      expect(find.text('Placeholder Footer'), findsOneWidget);
    });

    testWidgets('should be scrollable', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that page is wrapped in scrollable widget
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
