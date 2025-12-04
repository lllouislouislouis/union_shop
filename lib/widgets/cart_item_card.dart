import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/providers/cart_provider.dart';

/// Cart item card displaying product details and quantity controls
/// 
/// FR-27: Cart Item Card with all product information and controls
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final bool isMobile;

  const CartItemCard({
    super.key,
    required this.item,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    // FR-27.1: White card with subtle shadow
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  /// Build desktop horizontal layout
  /// FR-27.2: Horizontal row layout on desktop
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        _buildProductImage(),
        const SizedBox(width: 16),

        // Product details (flexible to take available space)
        Expanded(
          child: _buildProductDetails(),
        ),
        const SizedBox(width: 16),

        // Quantity controls and subtotal
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildRemoveButton(context),
            const SizedBox(height: 8),
            _buildQuantityControls(context),
            const SizedBox(height: 8),
            _buildSubtotal(),
          ],
        ),
      ],
    );
  }

  /// Build mobile vertical layout
  /// FR-27.4: Stack elements vertically on mobile
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            _buildProductImage(),
            const SizedBox(width: 12),

            // Product details
            Expanded(
              child: _buildProductDetails(),
            ),

            // Remove button
            _buildRemoveButton(context),
          ],
        ),
        const SizedBox(height: 12),

        // Quantity controls and subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuantityControls(context),
            _buildSubtotal(),
          ],
        ),
      ],
    );
  }

  /// Build product image thumbnail
  /// FR-27.2: 80x80px thumbnail on left
  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          item.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if image doesn't exist
            return Icon(
              Icons.shopping_bag_outlined,
              size: 40,
              color: Colors.grey[400],
            );
          },
        ),
      ),
    );
  }

  /// Build product details section
  /// FR-27.2: Product name, variant details, unit price
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FR-27.2: Product name (16px, bold, black)
        Text(
          item.productName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),

        // FR-27.2: Variant details if available (12px, grey)
        if (item.variantDetails != null) ...[
          Text(
            item.variantDetails!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
        ],

        // FR-27.2: Unit price (14px, grey)
        Text(
          item.formattedPrice,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Build quantity controls
  /// FR-28: Quantity selector with +/- buttons
  Widget _buildQuantityControls(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Row(
      children: [
        // FR-28.1: Minus button
        _buildQuantityButton(
          context,
          icon: Icons.remove,
          onPressed: () => _handleDecreaseQuantity(context, cartProvider),
        ),
        const SizedBox(width: 8),

        // FR-28.1: Quantity display (40px wide, centered)
        SizedBox(
          width: 40,
          child: Text(
            '${item.quantity}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 8),

        // FR-28.1: Plus button
        _buildQuantityButton(
          context,
          icon: Icons.add,
          onPressed: () => _handleIncreaseQuantity(context, cartProvider),
        ),
      ],
    );
  }

  /// Build individual quantity button
  /// FR-28.1: 32x32px button with grey border
  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(color: Colors.grey[400]!, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // FR-28.4: Hover effect on desktop
        hoverColor: Colors.grey[200],
      ),
    );
  }

  /// Build item subtotal display
  /// FR-27.2: Item subtotal (14px, bold, black)
  Widget _buildSubtotal() {
    return Text(
      item.formattedSubtotal,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// Build remove button (trash icon)
  /// FR-27.2: Trash icon button at top-right corner
  Widget _buildRemoveButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline, size: 20),
      onPressed: () => _showRemoveConfirmation(context),
      color: Colors.grey[600],
      tooltip: 'Remove item',
    );
  }

  /// Handle increase quantity
  /// FR-28.3: Plus button increases quantity by 1 (max 99)
  void _handleIncreaseQuantity(BuildContext context, CartProvider cartProvider) {
    if (item.quantity < 99) {
      // FR-28.5: Call updateQuantity() in CartProvider
      cartProvider.updateQuantity(item.id, item.quantity + 1);
    } else {
      // Show message if at max quantity
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum quantity is 99'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  /// Handle decrease quantity
  /// FR-28.2: Minus button behavior based on quantity
  void _handleDecreaseQuantity(BuildContext context, CartProvider cartProvider) {
    if (item.quantity > 1) {
      // FR-28.2: If quantity > 1, decrease by 1
      cartProvider.updateQuantity(item.id, item.quantity - 1);
    } else {
      // FR-28.2: If quantity = 1, show confirmation dialog
      _showRemoveConfirmation(context);
    }
  }

  /// Show remove confirmation dialog
  /// FR-29: Remove Item Confirmation
  void _showRemoveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // FR-29.2: Dialog title
          title: const Text('Remove from cart?'),
          
          // FR-29.3: Dialog content with product name
          content: Text(
            'Are you sure you want to remove ${item.productName} from your cart?',
          ),
          
          // FR-29.4: Dialog actions
          actions: [
            // CANCEL button
            TextButton(
              onPressed: () {
                // FR-29.4: Dismiss dialog, no changes
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            // REMOVE button
            TextButton(
              onPressed: () {
                // FR-29.4: Remove item and dismiss dialog
                Navigator.of(dialogContext).pop();
                
                // FR-29.5: Call removeItem() from CartProvider
                final cartProvider = Provider.of<CartProvider>(
                  context,
                  listen: false,
                );
                cartProvider.removeItem(item.id);
                
                // FR-29.5: Show SnackBar feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from cart'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'REMOVE',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}