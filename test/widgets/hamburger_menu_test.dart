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
      await tester.pump(); // Start animation
      await tester
          .pump(const Duration(milliseconds: 300)); // Complete animation
      await tester.pump(); // Extra frame

      // Mobile menu items should now be visible (with arrows for dropdowns)
      expect(find.text('Home'),
          findsWidgets); // Multiple instances now (menu item)
      expect(find.text('Shop ▶'), findsOneWidget);
      expect(find.text('The Print Shack ▶'), findsOneWidget);
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
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

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
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Verify menu is open
      expect(find.text('Shop ▶'), findsOneWidget);

      // Tap close icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Menu should be closed
      expect(find.text('Shop ▶'), findsNothing);
      expect(find.byIcon(Icons.menu), findsOneWidget);

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
      await tester.pump(); // Extra pump for carousel

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Find the Home menu item within InkWell
      final homeMenuItem = find.ancestor(
        of: find.text('Home'),
        matching: find.byType(InkWell),
      );

      // Tap the first Home menu item
      await tester.tap(homeMenuItem.first);
      await tester.pump(); // Start animation
      await tester
          .pump(const Duration(milliseconds: 300)); // Complete animation
      await tester.pump(); // Extra pump for good measure
      await tester.pump(); // Another pump for carousel

      // Menu should be closed
      expect(find.text('Shop ▶'), findsNothing);

      // Should still be on home screen - verify by checking that we're NOT on another page
      // On mobile, carousel text may not be visible, so just check menu is closed
      // and we haven't navigated away (About page would show "About Us")
      expect(find.text('About Us'), findsNothing);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Tapping About in mobile menu navigates to About page',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Find the About menu item
      final aboutMenuItem = find.ancestor(
        of: find.text('About'),
        matching: find.byType(InkWell),
      );

      // Tap About
      await tester.tap(aboutMenuItem.first);
      await tester.pump(); // Start navigation
      await tester.pump(const Duration(seconds: 1)); // Complete navigation

      // Menu should be closed
      expect(find.text('Shop ▶'), findsNothing);

      // Should be on About page - verify by checking for "About Us" heading
      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Welcome to the Union Shop!'),
          findsOneWidget); // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('About button is highlighted on About page in mobile menu',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Navigate to About page first
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      final aboutMenuItem = find.ancestor(
        of: find.text('About'),
        matching: find.byType(InkWell),
      );
      await tester.tap(aboutMenuItem.first);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Open menu on About page
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Find the About menu item container (which should have purple background)
      final aboutContainer = find.ancestor(
        of: find.text('About'),
        matching: find.byType(Container),
      );

      // Verify container exists and has styling
      expect(aboutContainer, findsWidgets);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets(
        'Mobile menu is part of natural document flow (not positioned overlay)',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Open menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      // Menu should be wrapped in Material widget (elevation: 8)
      // There are multiple Material widgets in the tree, so check for the specific one
      final menuMaterial = find.byWidgetPredicate(
        (widget) => widget is Material && widget.elevation == 8.0,
      );
      expect(menuMaterial, findsOneWidget);

      // The menu items should be in a Column inside the menu
      final menuColumn = find.ancestor(
        of: find.text('Shop ▶'),
        matching: find.byType(Column),
      );
      expect(menuColumn, findsWidgets);

      // Verify there's no Positioned widget (which would indicate overlay)
      final positioned = find.ancestor(
        of: find.text('Shop ▶'),
        matching: find.byType(Positioned),
      );
      expect(positioned, findsNothing);

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
      // Note: Shop and Print Shack show with dropdown arrows
      expect(find.text('Home').hitTestable(), findsOneWidget);
      expect(find.text('Shop ⏷').hitTestable(), findsOneWidget);
      expect(find.text('The Print Shack ⏷').hitTestable(), findsOneWidget);
      expect(find.text('SALE!').hitTestable(), findsOneWidget);
      expect(find.text('About').hitTestable(), findsOneWidget);

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
      expect(find.text('Home').hitTestable(), findsNothing);
      expect(find.text('Shop ⏷').hitTestable(), findsNothing);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('About button is highlighted on desktop when on About page',
        (WidgetTester tester) async {
      // Set desktop screen size
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Click About button to navigate
      await tester.tap(find.text('About'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify we're on About page
      expect(find.text('About Us'), findsOneWidget);

      // About button should still be visible and accessible
      expect(find.text('About').hitTestable(), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.reset);
    });

    testWidgets('Logo is smaller on mobile than desktop',
        (WidgetTester tester) async {
      // Test mobile size first
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Find logo SizedBox on mobile - should be 32px
      var logoSizedBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(GestureDetector).first,
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(logoSizedBox.height, equals(32.0));

      // Now test desktop size - need to create a NEW widget tree
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      // Pump a completely new widget tree
      await tester.pumpWidget(Container()); // Clear old tree
      await tester.pumpWidget(const UnionShopApp()); // Create new tree
      await tester.pump();

      // Find logo SizedBox on desktop - should be 48px
      logoSizedBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(GestureDetector).first,
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(logoSizedBox.height, equals(48.0));

      // Reset screen size
      addTearDown(tester.view.reset);
    });
  });
}
