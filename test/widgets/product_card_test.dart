import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/main.dart'; // Import ProductCard

void main() {
  group('ProductCard Widget Tests', () {
    testWidgets('renders product title correctly', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'test-001',
        title: 'Test Product Title',
        price: 25.00,
        imageUrl: 'assets/images/test.jpg',
        description: 'Test description',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Product Title'), findsOneWidget);
    });

    testWidgets('displays regular price for non-sale item', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'regular-001',
        title: 'Regular Product',
        price: 15.99,
        imageUrl: 'assets/images/regular.jpg',
        description: 'Regular item',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      // Assert
      expect(find.text('£15.99'), findsOneWidget);
      
      // Verify the text style (grey color)
      final textWidget = tester.widget<Text>(find.text('£15.99'));
      expect(textWidget.style?.color, Colors.grey);
      expect(textWidget.style?.fontSize, 13);
    });

    testWidgets('displays original price (struck through) and sale price for sale item',
        (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'sale-001',
        title: 'Sale Product',
        price: 12.99,
        originalPrice: 18.99,
        imageUrl: 'assets/images/sale.jpg',
        description: 'On sale',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      // Assert - original price with strikethrough
      expect(find.text('£18.99'), findsOneWidget);
      final originalPriceWidget = tester.widget<Text>(find.text('£18.99'));
      expect(originalPriceWidget.style?.decoration, TextDecoration.lineThrough);
      expect(originalPriceWidget.style?.color, Colors.grey);
      expect(originalPriceWidget.style?.fontSize, 11);

      // Assert - sale price in bold purple
      expect(find.text('£12.99'), findsOneWidget);
      final salePriceWidget = tester.widget<Text>(find.text('£12.99'));
      expect(salePriceWidget.style?.color, const Color(0xFF4d2963));
      expect(salePriceWidget.style?.fontWeight, FontWeight.bold);
      expect(salePriceWidget.style?.fontSize, 13);
    });

    testWidgets('truncates long title with ellipsis', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'long-001',
        title: 'This is a very long product title that should be truncated with ellipsis after two lines',
        price: 20.00,
        imageUrl: 'assets/images/long.jpg',
        description: 'Long title test',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ProductCard(product: product),
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text(product.title));
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('shows error icon when image fails to load', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'missing-001',
        title: 'Missing Image Product',
        price: 10.00,
        imageUrl: 'assets/images/nonexistent.jpg',
        description: 'Image will fail',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      // Wait for image to fail loading
      await tester.pump();

      // Assert - error icon is displayed
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      
      // Assert - grey container background
      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byIcon(Icons.image_not_supported),
          matching: find.byType(Container),
        ).first,
      );
      expect(container.color, Colors.grey[300]);
    });

    testWidgets('tapping card calls navigation with correct product', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'nav-001',
        title: 'Navigation Test Product',
        price: 30.00,
        imageUrl: 'assets/images/nav.jpg',
        description: 'Test navigation',
      );

      Product? navigatedProduct;
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
          onGenerateRoute: (settings) {
            if (settings.name == '/product') {
              navigatedProduct = settings.arguments as Product?;
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Text('Product Page'),
                ),
              );
            }
            return null;
          },
        ),
      );

      // Find the GestureDetector and tap it directly
      final gestureDetectorFinder = find.byType(GestureDetector);
      expect(gestureDetectorFinder, findsOneWidget);
      
      // Tap on the title text instead (which is inside the tappable area)
      await tester.tap(find.text('Navigation Test Product'));
      await tester.pumpAndSettle();

      // Assert
      expect(navigatedProduct, isNotNull);
      expect(navigatedProduct?.id, 'nav-001');
      expect(navigatedProduct?.title, 'Navigation Test Product');
      expect(find.text('Product Page'), findsOneWidget);
    });

    testWidgets('card is tappable and has gesture detector', (WidgetTester tester) async {
      // Arrange
      final product = Product(
        id: 'tap-001',
        title: 'Tappable Product',
        price: 25.00,
        imageUrl: 'assets/images/tap.jpg',
        description: 'Tap test',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      // Assert
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });
}
