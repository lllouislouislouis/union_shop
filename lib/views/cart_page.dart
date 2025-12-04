import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/widgets/cart_item_card.dart';

/// Shopping cart page displaying cart items or empty state
/// 
/// FR-25: Cart Page UI with empty and populated states
/// FR-26: Cart Page layout with items
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // FR-23.3: Access cart state via Provider
    final cartProvider = context.watch<CartProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    // FR-25.2: Wrap with AppScaffold
    return AppScaffold(
      currentRoute: '/cart',
      child: cartProvider.isEmpty
          ? _buildEmptyCart(context, isMobile)
          : _buildCartWithItems(context, cartProvider, isMobile),
    );
  }

  /// Build empty cart state
  /// FR-25: Cart Page - Empty State
  Widget _buildEmptyCart(BuildContext context, bool isMobile) {
    return Center(
      child: Padding(
        // FR-25.5: 16px padding on mobile, 24px on desktop
        padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FR-25.3: Large shopping bag icon
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),

            // FR-25.3: "Your cart is empty" message
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // FR-25.3: Subtitle message
            Text(
              'Add items to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // FR-25.3: "Continue Shopping" button
            OutlinedButton(
              onPressed: () {
                // FR-25.3: Navigate to home page
                Navigator.pushReplacementNamed(context, '/');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF4d2963),
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CONTINUE SHOPPING',
                style: TextStyle(
                  color: Color(0xFF4d2963),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build cart with items
  /// FR-26: Cart Page - With Items
  Widget _buildCartWithItems(
    BuildContext context,
    CartProvider cartProvider,
    bool isMobile,
  ) {
    return SingleChildScrollView(
      child: Padding(
        // FR-26.4: 16px padding on mobile, 24px on desktop
        padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FR-26.2: Page title "Shopping Cart"
            const Text(
              'Shopping Cart',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // FR-26.1, FR-26.4: Responsive layout
            isMobile
                ? _buildMobileLayout(context, cartProvider)
                : _buildDesktopLayout(context, cartProvider),
          ],
        ),
      ),
    );
  }

  /// Build mobile layout (single column)
  /// FR-26.4: Mobile layout - items above summary
  Widget _buildMobileLayout(BuildContext context, CartProvider cartProvider) {
    return Column(
      children: [
        // Cart items list
        _buildCartItemsList(context, cartProvider),
        const SizedBox(height: 24),
        // Cart summary below items
        _buildCartSummary(context, cartProvider),
      ],
    );
  }

  /// Build desktop layout (two columns)
  /// FR-26.4: Desktop layout - 60/40 split
  Widget _buildDesktopLayout(BuildContext context, CartProvider cartProvider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: Cart items (60%)
        Expanded(
          flex: 60,
          child: _buildCartItemsList(context, cartProvider),
        ),
        const SizedBox(width: 24),
        // Right column: Cart summary (40%)
        Expanded(
          flex: 40,
          child: _buildCartSummary(context, cartProvider),
        ),
      ],
    );
  }

  /// Build list of cart items
  /// FR-26.3: Cart items in scrollable list
  Widget _buildCartItemsList(BuildContext context, CartProvider cartProvider) {
    return Column(
      children: [
        // FR-27: Display cart items using CartItemCard widget
        for (var item in cartProvider.items)
          CartItemCard(
            item: item,
            isMobile: MediaQuery.of(context).size.width < 900,
          ),
      ],
    );
  }

  /// Build cart summary section
  /// FR-30: Cart Summary Section
  Widget _buildCartSummary(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // FR-30.3: "Order Summary" header
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // FR-30.3: Subtotal row
          _buildSummaryRow(
            'Subtotal',
            cartProvider.getFormattedSubtotal(),
          ),
          const SizedBox(height: 12),

          // FR-30.3: Shipping row
          _buildSummaryRow(
            'Shipping',
            cartProvider.getFormattedShipping(),
            valueColor: Colors.green[700],
          ),
          const SizedBox(height: 16),

          // FR-30.3: Divider line
          Divider(color: Colors.grey[300], thickness: 1),
          const SizedBox(height: 16),

          // FR-30.3: Total row
          _buildSummaryRow(
            'Total',
            cartProvider.getFormattedTotal(),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            valueStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          // FR-31: Checkout button
          ElevatedButton(
            onPressed: () {
              // FR-31.4: Show placeholder message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Checkout functionality coming soon!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Color(0xFF4d2963),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              // FR-31.2: Primary color background
              backgroundColor: const Color(0xFF4d2963),
              // FR-31.2: Height 48px
              padding: const EdgeInsets.symmetric(vertical: 14),
              // FR-31.2: Rounded corners 8px
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'PROCEED TO CHECKOUT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build summary row
  /// FR-30.6: Consistent spacing between rows
  Widget _buildSummaryRow(
    String label,
    String value, {
    TextStyle? labelStyle,
    TextStyle? valueStyle,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
        ),
      ],
    );
  }
}