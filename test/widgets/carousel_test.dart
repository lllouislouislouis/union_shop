import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/carousel_slide.dart';

void main() {
  group('Hero Carousel Tests', () {
    testWidgets('Carousel initializes with first slide visible',
        (WidgetTester tester) async {
      // Set desktop size to ensure text is visible
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump(); // Build widget
      await tester.pump(); // Allow one more frame

      // Verify first slide content is visible (desktop view)
      expect(find.text('Browse Our Collections'), findsOneWidget);
      expect(find.text('EXPLORE'), findsOneWidget);
    });

    testWidgets('Carousel auto-advances to next slide after 5 seconds',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // First slide visible
      expect(find.text('Browse Our Collections'), findsOneWidget);

      // Wait for auto-advance (5 seconds)
      await tester.pump(const Duration(seconds: 5));
      // Pump animation frames (600ms crossfade)
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));

      // Second slide should now be visible
      expect(find.text('The Print Shack'), findsOneWidget);
      expect(find.text('GET PERSONALISED'), findsOneWidget);
    });

    testWidgets('Carousel loops from last slide back to first',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Advance through all slides
      for (int i = 0; i < 4; i++) {
        await tester.pump(const Duration(seconds: 5));
        await tester.pump(const Duration(milliseconds: 600));
      }

      // Should be back to first slide
      expect(find.text('Browse Our Collections'), findsOneWidget);
    });

    testWidgets('Next arrow button advances to next slide',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // First slide visible
      expect(find.text('Browse Our Collections'), findsOneWidget);

      // Find and tap next arrow
      final nextButton = find.byIcon(Icons.arrow_forward_ios);
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
      await tester.pump(); // Process tap
      await tester.pump(const Duration(milliseconds: 600)); // Animation

      // Second slide should be visible
      expect(find.text('The Print Shack'), findsOneWidget);
    });

    testWidgets('Previous arrow button goes to previous slide',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Navigate to second slide first
      final nextButton = find.byIcon(Icons.arrow_forward_ios);
      await tester.tap(nextButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      expect(find.text('The Print Shack'), findsOneWidget);

      // Now tap previous arrow
      final prevButton = find.byIcon(Icons.arrow_back_ios);
      await tester.tap(prevButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      // Should be back to first slide
      expect(find.text('Browse Our Collections'), findsOneWidget);
    });

    testWidgets('Previous arrow from first slide loops to last slide',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // On first slide
      expect(find.text('Browse Our Collections'), findsOneWidget);

      // Tap previous arrow
      final prevButton = find.byIcon(Icons.arrow_back_ios);
      await tester.tap(prevButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      // Should show last slide (About)
      expect(find.text('About Union Shop'), findsOneWidget);
    });

    testWidgets('Dot indicators display correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Should have 4 dot indicators (within GestureDetectors with circular Container children)
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

    testWidgets('Pause button stops auto-play', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // First slide visible
      expect(find.text('Browse Our Collections'), findsOneWidget);

      // Find and tap pause button
      final pauseButton = find.byIcon(Icons.pause);
      expect(pauseButton, findsOneWidget);
      await tester.tap(pauseButton);
      await tester.pump();

      // Icon should change to play
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);

      // Wait 5+ seconds - slide should NOT advance
      await tester.pump(const Duration(seconds: 6));

      // Still on first slide
      expect(find.text('Browse Our Collections'), findsOneWidget);
    });

    testWidgets('Play button resumes auto-play', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Pause first
      final pauseButton = find.byIcon(Icons.pause);
      await tester.tap(pauseButton);
      await tester.pump();

      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      // Now tap play button
      final playButton = find.byIcon(Icons.play_arrow);
      await tester.tap(playButton);
      await tester.pump();

      // Icon should change back to pause
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);

      // Wait 5+ seconds - slide SHOULD advance
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(milliseconds: 600));

      // Should be on second slide
      expect(find.text('The Print Shack'), findsOneWidget);
    });

    testWidgets('CTA button navigates to correct route',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Find and tap EXPLORE button
      final exploreButton = find.text('EXPLORE');
      expect(exploreButton, findsOneWidget);
      await tester.tap(exploreButton);
      await tester.pump(); // Start navigation
      await tester.pump(const Duration(seconds: 1)); // Complete navigation

      // Should navigate to Collections page
      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('Browse all our product collections here.'),
          findsOneWidget);
    });

    testWidgets('Mobile view hides text and button overlay',
        (WidgetTester tester) async {
      // Set smaller screen size for mobile
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Text and button should NOT be visible on mobile
      expect(find.text('Browse Our Collections'), findsNothing);
      expect(find.text('EXPLORE'), findsNothing);

      // Controls should still be visible
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);
    });

    testWidgets('Desktop view shows text and button overlay',
        (WidgetTester tester) async {
      // Set larger screen size for desktop
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Text and button SHOULD be visible on desktop
      expect(find.text('Browse Our Collections'), findsOneWidget);
      expect(find.text('EXPLORE'), findsOneWidget);
    });

    testWidgets('Carousel height adjusts for mobile vs desktop',
        (WidgetTester tester) async {
      // Test mobile height (400px)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      var carouselSizeBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(MouseRegion),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(carouselSizeBox.height, 400);

      // Reset and test desktop height (500px)
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      tester.view.physicalSize = const Size(1200, 800);
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      carouselSizeBox = tester.widget<SizedBox>(
        find
            .descendant(
              of: find.byType(MouseRegion),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(carouselSizeBox.height, 500);
    });

    testWidgets('Manual navigation resets auto-play timer',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      // Wait 3 seconds (not enough for auto-advance)
      await tester.pump(const Duration(seconds: 3));

      // Manually click next
      final nextButton = find.byIcon(Icons.arrow_forward_ios);
      await tester.tap(nextButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));

      // On slide 2
      expect(find.text('The Print Shack'), findsOneWidget);

      // Timer should have reset, so wait 5 more seconds
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(milliseconds: 600));

      // Should now be on slide 3 (not slide 1)
      expect(find.text('Big Sale On Now!'), findsOneWidget);
    });

    testWidgets('All 4 slides have correct content',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();
      await tester.pump();

      final expectedSlides = [
        {'heading': 'Browse Our Collections', 'button': 'EXPLORE'},
        {'heading': 'The Print Shack', 'button': 'GET PERSONALISED'},
        {'heading': 'Big Sale On Now!', 'button': 'SHOP SALE'},
        {'heading': 'About Union Shop', 'button': 'LEARN MORE'},
      ];

      for (int i = 0; i < expectedSlides.length; i++) {
        // Verify current slide content
        expect(find.text(expectedSlides[i]['heading']!), findsOneWidget);
        expect(find.text(expectedSlides[i]['button']!), findsOneWidget);

        // Advance to next slide (unless last slide)
        if (i < expectedSlides.length - 1) {
          final nextButton = find.byIcon(Icons.arrow_forward_ios);
          await tester.tap(nextButton);
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 600));
        }
      }
    });
  });

  group('CarouselSlide Model Tests', () {
    test('CarouselSlide creates with correct properties', () {
      const slide = CarouselSlide(
        imagePath: 'test/path.jpg',
        heading: 'Test Heading',
        buttonLabel: 'TEST BUTTON',
        buttonRoute: '/test',
      );

      expect(slide.imagePath, 'test/path.jpg');
      expect(slide.heading, 'Test Heading');
      expect(slide.buttonLabel, 'TEST BUTTON');
      expect(slide.buttonRoute, '/test');
    });

    test('CarouselSlide is immutable', () {
      const slide1 = CarouselSlide(
        imagePath: 'test1.jpg',
        heading: 'Test 1',
        buttonLabel: 'BUTTON 1',
        buttonRoute: '/test1',
      );

      const slide2 = CarouselSlide(
        imagePath: 'test1.jpg',
        heading: 'Test 1',
        buttonLabel: 'BUTTON 1',
        buttonRoute: '/test1',
      );

      // Same values should be equal
      expect(slide1.imagePath, slide2.imagePath);
      expect(slide1.heading, slide2.heading);
      expect(slide1.buttonLabel, slide2.buttonLabel);
      expect(slide1.buttonRoute, slide2.buttonRoute);
    });
  });
}
