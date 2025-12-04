import 'package:flutter/material.dart';

/// Reusable product count display widget
/// Shows the number of products (e.g., "15 products" or "1 product")
class ProductCountDisplay extends StatelessWidget {
  final int count;

  const ProductCountDisplay({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final productText = count == 1 ? 'product' : 'products';
    return Text(
      '$count $productText',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }
}
