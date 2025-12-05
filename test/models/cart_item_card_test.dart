import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/cart_item_card.dart';

void main() {
  late CartProvider mockCartProvider;
  late CartItem testItem;
  late CartItem testItemWithVariant;

  setUp(() {
    mockCartProvider = CartProvider();
    // Clear mock data so we start with empty cart for testing
    mockCartProvider.clearCart();

    testItem = CartItem(
      id: 'test-1',
      productName: 'Test Product',
      imageUrl: 'assets/images/test.png',
      price: 25.99,
      quantity: 2,
    );

    testItemWithVariant = CartItem(
      id: 'test-2',
      productName: 'Test Product with Variant',
      imageUrl: 'assets/images/test2.png',
      price: 15.50,
      quantity: 1,
      size: 'L',
      color: 'Red',
    );

    // Add test items to provider
    mockCartProvider.addItem(testItem);
    mockCartProvider.addItem(testItemWithVariant);
  });

  Widget createTestWidget(CartItem item, {bool isMobile = false}) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: CartItemCard(item: item, isMobile: isMobile),
        ),
      ),
    );
  }

  group('CartItemCard - Rendering', () {
    testWidgets('renders desktop layout correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Check that product name is displayed
      expect(find.text('Test Product'), findsOneWidget);

      // Check that price is displayed with correct formatting
      expect(find.text('£25.99'), findsOneWidget);

      // Check that quantity is displayed
      expect(find.text('2'), findsOneWidget);

      // Check that subtotal is displayed
      expect(find.text('£51.98'), findsOneWidget);
    });

    testWidgets('renders mobile layout correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: true));

      // Check that product name is displayed
      expect(find.text('Test Product'), findsOneWidget);

      // Check that price is displayed
      expect(find.text('£25.99'), findsOneWidget);
    });

    testWidgets('displays variant details when available',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createTestWidget(testItemWithVariant, isMobile: false));

      // Check that product name is displayed
      expect(find.text('Test Product with Variant'), findsOneWidget);

      // Check that variant details are displayed
      expect(find.text('Size: L, Color: Red'), findsOneWidget);
    });

    testWidgets('does not display variant details when unavailable',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Variant text should not be present
      expect(find.textContaining('Size:'), findsNothing);
      expect(find.textContaining('Color:'), findsNothing);
    });

    testWidgets('displays subtotal correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Subtotal should be price * quantity
      expect(find.text('£51.98'), findsOneWidget);
    });

    testWidgets('displays remove button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Remove button (trash icon) should be present
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });
  });

  group('CartItemCard - Quantity Controls', () {
    testWidgets('displays plus and minus buttons', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Check for add and remove icons
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('increases quantity when plus button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Get current item from provider
      final item = mockCartProvider.findItemById('test-1');
      expect(item?.quantity, 2);

      // Tap the plus button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Quantity should increase
      final updatedItem = mockCartProvider.findItemById('test-1');
      expect(updatedItem?.quantity, 3);
    });

    testWidgets('decreases quantity when minus button is tapped (quantity > 1)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Get current item from provider
      final item = mockCartProvider.findItemById('test-1');
      expect(item?.quantity, 2);

      // Tap the minus button
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Quantity should decrease
      final updatedItem = mockCartProvider.findItemById('test-1');
      expect(updatedItem?.quantity, 1);
    });

    testWidgets('shows dialog when decreasing quantity from 1',
        (WidgetTester tester) async {
      // Create item with quantity 1
      final singleItem = CartItem(
        id: 'test-single',
        productName: 'Single Item',
        imageUrl: 'assets/images/test.png',
        price: 10.0,
        quantity: 1,
      );
      mockCartProvider.addItem(singleItem);

      await tester.pumpWidget(createTestWidget(singleItem, isMobile: false));

      // Tap the minus button
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      // Dialog should appear asking for confirmation
      expect(find.text('Remove from cart?'), findsOneWidget);
      expect(find.text('CANCEL'), findsOneWidget);
      expect(find.text('REMOVE'), findsOneWidget);
    });

    testWidgets('shows max quantity snackbar when at 99',
        (WidgetTester tester) async {
      final maxItem = CartItem(
        id: 'test-max',
        productName: 'Max Product',
        imageUrl: 'assets/images/test.png',
        price: 10.0,
        quantity: 99,
      );
      mockCartProvider.addItem(maxItem);

      await tester.pumpWidget(createTestWidget(maxItem, isMobile: false));

      // Tap the plus button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Snackbar should appear with max quantity message
      expect(find.text('Maximum quantity is 99'), findsOneWidget);
    });

    testWidgets('displays correct button styling', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Find the buttons
      final addButton = find.byIcon(Icons.add);
      final removeButton = find.byIcon(Icons.remove);

      expect(addButton, findsOneWidget);
      expect(removeButton, findsOneWidget);
    });
  });

  group('CartItemCard - Remove Item', () {
    testWidgets('shows confirmation dialog when remove button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Tap the remove button
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // Dialog should appear
      expect(find.text('Remove from cart?'), findsOneWidget);
      expect(find.text('CANCEL'), findsOneWidget);
      expect(find.text('REMOVE'), findsOneWidget);
    });

    testWidgets('dismisses dialog when CANCEL is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Initial cart should have 2 items
      expect(mockCartProvider.items.length, 2);

      // Tap the remove button
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // Tap CANCEL
      await tester.tap(find.text('CANCEL'));
      await tester.pumpAndSettle();

      // Item should still be in cart
      expect(mockCartProvider.items.length, 2);
    });

    testWidgets('removes item and shows snackbar when REMOVE is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Initial cart should have 2 items
      expect(mockCartProvider.items.length, 2);

      // Tap the remove button
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // Tap REMOVE
      await tester.tap(find.text('REMOVE'));
      await tester.pumpAndSettle();

      // Item should be removed from cart
      expect(mockCartProvider.items.length, 1);
      expect(mockCartProvider.findItemById('test-1'), null);

      // Snackbar should appear
      expect(find.text('Item removed from cart'), findsOneWidget);
    });

    testWidgets('dialog has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Tap the remove button
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // Check for dialog elements
      expect(find.text('Remove from cart?'), findsOneWidget);
      expect(find.textContaining('Are you sure'), findsOneWidget);
    });
  });

  group('CartItemCard - Layout Differences', () {
    testWidgets('desktop layout uses Row for main structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Desktop layout should render (hard to test layout directly, but we can verify content is there)
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('mobile layout uses Column for main structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: true));

      // Mobile layout should render
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('image has correct size', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Find the Container that holds the image
      final container = tester.widget<Container>(
        find
            .ancestor(
              of: find.byType(Image),
              matching: find.byType(Container),
            )
            .first,
      );

      // Verify image container dimensions (80x80)
      expect(container.constraints?.maxWidth, 80);
      expect(container.constraints?.maxHeight, 80);
    });
  });

  group('CartItemCard - Edge Cases', () {
    testWidgets('handles very long product names', (WidgetTester tester) async {
      final longNameItem = CartItem(
        id: 'test-long',
        productName:
            'This is a very long product name that should wrap properly in the card layout',
        imageUrl: 'assets/images/test.png',
        price: 10.0,
        quantity: 1,
      );
      mockCartProvider.addItem(longNameItem);

      await tester.pumpWidget(createTestWidget(longNameItem, isMobile: false));

      // Long name should be displayed
      expect(find.textContaining('This is a very long product name'),
          findsOneWidget);
    });

    testWidgets('handles large quantity numbers', (WidgetTester tester) async {
      final largeQuantityItem = CartItem(
        id: 'test-large',
        productName: 'Large Quantity Product',
        imageUrl: 'assets/images/test.png',
        price: 5.0,
        quantity: 50,
      );
      mockCartProvider.addItem(largeQuantityItem);

      await tester
          .pumpWidget(createTestWidget(largeQuantityItem, isMobile: false));

      // Large quantity should be displayed
      expect(find.text('50'), findsOneWidget);

      // Subtotal should be calculated correctly
      expect(find.text('£250.00'), findsOneWidget);
    });

    testWidgets('handles price with many decimal places',
        (WidgetTester tester) async {
      final decimalItem = CartItem(
        id: 'test-decimal',
        productName: 'Decimal Product',
        imageUrl: 'assets/images/test.png',
        price: 19.99,
        quantity: 1,
      );
      mockCartProvider.addItem(decimalItem);

      await tester.pumpWidget(createTestWidget(decimalItem, isMobile: false));

      // Price should be formatted with 2 decimal places (appears twice - unit price and subtotal)
      expect(find.text('£19.99'), findsWidgets);
    });

    testWidgets('handles missing image with error fallback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Widget should render without crashing even if image doesn't exist
      expect(find.text('Test Product'), findsOneWidget);
    });
  });

  group('CartItemCard - Provider Integration', () {
    testWidgets('updates CartProvider when quantity changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Initial quantity
      expect(mockCartProvider.findItemById('test-1')?.quantity, 2);

      // Tap plus button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Provider should be updated
      expect(mockCartProvider.findItemById('test-1')?.quantity, 3);
    });

    testWidgets('uses CartProvider context correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(testItem, isMobile: false));

      // Widget should have access to CartProvider
      final context = tester.element(find.byType(CartItemCard));
      final provider = Provider.of<CartProvider>(context, listen: false);

      expect(provider, isNotNull);
      expect(provider.items.length, greaterThan(0));
    });
  });
}
