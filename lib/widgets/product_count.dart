import 'package:flutter/material.dart';

/// Reusable product count display widget
class ProductCount extends StatelessWidget {
  final int count;
  final String? label;

  const ProductCount({
    super.key,
    required this.count,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final productText = count == 1 ? 'product' : 'products';
    final displayLabel = label ?? productText;

    return Text(
      '$count $displayLabel',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }
}