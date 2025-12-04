import 'package:flutter/material.dart';
import '../models/sale_product.dart';

/// Product card widget specifically for sale products
/// Shows image, title, original price (struck through), and sale price
class SaleProductCard extends StatefulWidget {
  final SaleProduct product;
  final VoidCallback onTap;

  const SaleProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<SaleProductCard> createState() => _SaleProductCardState();
}

class _SaleProductCardState extends State<SaleProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, _isHovered ? 0.15 : 0.08),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Image.asset(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[400],
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Prices
                      Row(
                        children: [
                          // Original Price (struck through)
                          Text(
                            '£${widget.product.originalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey[600],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Sale Price (bold purple)
                          Text(
                            '£${widget.product.salePrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4d2963),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
