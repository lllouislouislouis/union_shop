import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Hamburger Menu Tests', () {
    testWidgets('Hamburger menu icon is visible on mobile screens',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump(); // Extra pump to settle

      // Find hamburger menu icon
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Hamburger menu icon is NOT visible on desktop screens',
        (WidgetTester tester) async {
      // Set desktop screen size
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Hamburger menu should not be visible
      expect(find.byIcon(Icons.menu), findsNothing);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu opens when hamburger icon is tapped',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Initially, mobile menu items should not be visible
      expect(find.text('Shop'), findsNothing);
      expect(find.text('The Print Shack'), findsNothing);

      // Tap hamburger menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Mobile menu items should now be visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget);
      expect(find.text('The Print Shack'), findsOneWidget);
      expect(find.text('SALE!'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Hamburger icon changes to close icon when menu is open',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Initially shows hamburger menu icon
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);

      // Tap to open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Now shows close icon
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.byIcon(Icons.close), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu closes when close icon is tapped',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify menu is open
      expect(find.text('Shop'), findsOneWidget);

      // Tap close icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Menu should be closed
      expect(find.text('Shop'), findsNothing);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu closes when tapping outside overlay',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify menu is open
      expect(find.text('Shop'), findsOneWidget);

      // Tap on overlay (outside menu) - find the GestureDetector with the semi-transparent background
      final overlay = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is Container &&
            (widget.child as Container).color != null,
      );
      await tester.tap(overlay.last);
      await tester.pumpAndSettle();

      // Menu should be closed
      expect(find.text('Shop'), findsNothing);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Tapping Home in mobile menu navigates and closes menu',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Find and tap the first 'Home' text in the menu (not the button in header)
      final homeMenuItems = find.text('Home');
      expect(homeMenuItems, findsWidgets);

      // Tap the Home text directly within the visible menu
      await tester.tap(homeMenuItems.first, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Menu should be closed
      expect(find.text('Shop'), findsNothing);
      // Should still be on home screen
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu overlay is positioned below header',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Find the positioned menu overlay
      final positioned = find.byWidgetPredicate(
        (widget) =>
            widget is Positioned &&
            widget.top == 100 && // Header height
            widget.left == 0 &&
            widget.right == 0,
      );
      expect(positioned, findsWidgets);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Desktop navigation buttons are visible on wide screens',
        (WidgetTester tester) async {
      // Set desktop screen size
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Desktop navigation buttons should be visible
      expect(find.widgetWithText(TextButton, 'Home').hitTestable(),
          findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Shop').hitTestable(),
          findsOneWidget);
      expect(find.widgetWithText(TextButton, 'The Print Shack').hitTestable(),
          findsOneWidget);
      expect(find.widgetWithText(TextButton, 'SALE!').hitTestable(),
          findsOneWidget);
      expect(find.widgetWithText(TextButton, 'About').hitTestable(),
          findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Desktop navigation buttons are NOT visible on mobile',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Desktop navigation buttons should not be visible (not hitTestable)
      expect(
          find.widgetWithText(TextButton, 'Home').hitTestable(), findsNothing);
      expect(
          find.widgetWithText(TextButton, 'Shop').hitTestable(), findsNothing);

      // Reset screen size
      addTearDown(tester.view.reset);
    });
  });
}
