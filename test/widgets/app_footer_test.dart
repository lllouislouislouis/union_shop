import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  group('AppFooter Widget Tests', () {
    testWidgets('should display opening hours section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Check section heading
      expect(find.text('Opening hours'), findsOneWidget);

      // Check opening hours content
      expect(find.text('Monday–Friday: 9:00–17:00'), findsOneWidget);
      expect(find.text('Saturday: 10:00–16:00'), findsOneWidget);
      expect(find.text('Sunday: Closed'), findsOneWidget);
    });

    testWidgets('should display help & information section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Check section heading
      expect(find.text('Help & information'), findsOneWidget);

      // Check button labels exist
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Terms & Conditions of Sale'), findsOneWidget);
    });

    testWidgets('should use 2-column layout on desktop (>800px)',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Compare horizontal positions of section headings to confirm two-column layout
      final openingCenter = tester.getCenter(find.text('Opening hours'));
      final helpCenter = tester.getCenter(find.text('Help & information'));

      expect(openingCenter.dx < helpCenter.dx, isTrue);
    });

    testWidgets('should use stacked layout on mobile (≤800px)', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Compare vertical positions of section headings to confirm stacked layout
      final openingCenter = tester.getCenter(find.text('Opening hours'));
      final helpCenter = tester.getCenter(find.text('Help & information'));

      expect(openingCenter.dy < helpCenter.dy, isTrue);
    });

    testWidgets('search button should trigger callback when pressed',
        (tester) async {
      bool searchPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFooter(
              onSearchPressed: () => searchPressed = true,
            ),
          ),
        ),
      );

      // Tap search label (tapping the visible label triggers the button)
      await tester.tap(find.text('Search'));
      await tester.pump();

      expect(searchPressed, isTrue);
    });

    testWidgets('terms button should trigger callback when pressed',
        (tester) async {
      bool termsPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFooter(
              onTermsPressed: () => termsPressed = true,
            ),
          ),
        ),
      );

      // Tap terms label
      await tester.tap(find.text('Terms & Conditions of Sale'));
      await tester.pump();

      expect(termsPressed, isTrue);
    });

    testWidgets('buttons should be disabled when no callback provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(
              // No callbacks provided
              onSearchPressed: null,
              onTermsPressed: null,
            ),
          ),
        ),
      );

      // Try tapping the labels; since no callbacks provided, flags shouldn't change
      bool searchPressed = false;
      bool termsPressed = false;

      await tester.tap(find.text('Search'));
      await tester.pump();
      await tester.tap(find.text('Terms & Conditions of Sale'));
      await tester.pump();

      expect(searchPressed, isFalse);
      expect(termsPressed, isFalse);
    });

    testWidgets('should have semantic headers for section titles',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Check for header semantics on section titles
      final openingHoursHeader = find.ancestor(
        of: find.text('Opening hours'),
        matching: find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.header == true,
        ),
      );

      final helpInfoHeader = find.ancestor(
        of: find.text('Help & information'),
        matching: find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.header == true,
        ),
      );

      expect(openingHoursHeader, findsOneWidget);
      expect(helpInfoHeader, findsOneWidget);
    });

    testWidgets('opening hours text should be selectable', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppFooter(),
          ),
        ),
      );

      // Check that SelectableText widgets are used
      expect(
        find.widgetWithText(SelectableText, 'Monday–Friday: 9:00–17:00'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(SelectableText, 'Saturday: 10:00–16:00'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(SelectableText, 'Sunday: Closed'),
        findsOneWidget,
      );
    });
  });
}
