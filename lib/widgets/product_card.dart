import 'package:flutter/material.dart';

/// Generic product card widget that works with any product model
/// Expects products to have: title, imageUrl, and price properties
class ProductCard extends StatefulWidget {
  final dynamic product; // Generic product (SaleProduct, ClothingProduct, etc.)
  final String priceLabel; // e.g., "£19.99" or "£24.99"
  final String? originalPriceLabel; // Optional original price for sales
  final VoidCallback onTap;
  final Widget? badge; // Optional badge widget (e.g., "Sale" label)

  const ProductCard({
    super.key,
    required this.product,
    required this.priceLabel,
    required this.onTap,
    this.originalPriceLabel,
    this.badge,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
                // Product Image with optional badge
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Image.asset(
                            widget.product.imageUrl as String,
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
                      // Optional badge
                      if (widget.badge != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: widget.badge!,
                        ),
                    ],
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
                        widget.product.title as String,
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
                          // Original price (if provided, struck through)
                          if (widget.originalPriceLabel != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                widget.originalPriceLabel!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey[600],
                                ),
                              ),
                            ),

                          // Sale/current price (bold purple)
                          Text(
                            widget.priceLabel,
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

// class SaleProduct {
//   final String id;
//   final String title;
//   final double originalPrice;
//   final double salePrice;
//   final String imageUrl;
//   final String category;
//   final DateTime saleEndDate;

//   SaleProduct({
//     required this.id,
//     required this.title,
//     required this.originalPrice,
//     required this.salePrice,
//     required this.imageUrl,
//     required this.category,
//     required this.saleEndDate,
//   });

//   // Computed property for discount percentage
//   int get discountPercentage {
//     if (originalPrice == 0) return 0;
//     return (((originalPrice - salePrice) / originalPrice) * 100).round();
//   }
// }

// // Mock data - 15 products across 3 categories
// final List<SaleProduct> mockSaleProducts = [
//   // Clothing Category (5 products)
//   SaleProduct(
//     id: 'sale_001',
//     title: 'PSUT Hoodie - Purple Edition',
//     originalPrice: 35.00,
//     salePrice: 24.99,
//     imageUrl: 'assets/images/hoodie_purple.jpg',
//     category: 'Clothing',
//     saleEndDate: DateTime.now().add(const Duration(days: 7)),
//   ),
//   SaleProduct(
//     id: 'sale_002',
//     title: 'Union Shop T-Shirt Classic',
//     originalPrice: 15.00,
//     salePrice: 9.99,
//     imageUrl: 'assets/images/tshirt_classic.jpg',
//     category: 'Clothing',
//     saleEndDate: DateTime.now().add(const Duration(days: 5)),
//   ),
//   SaleProduct(
//     id: 'sale_003',
//     title: 'Campus Crew Neck Sweatshirt',
//     originalPrice: 28.00,
//     salePrice: 19.99,
//     imageUrl: 'assets/images/sweatshirt.jpg',
//     category: 'Clothing',
//     saleEndDate: DateTime.now().add(const Duration(days: 10)),
//   ),
//   SaleProduct(
//     id: 'sale_004',
//     title: 'University Track Jacket',
//     originalPrice: 42.00,
//     salePrice: 29.99,
//     imageUrl: 'assets/images/track_jacket.jpg',
//     category: 'Clothing',
//     saleEndDate: DateTime.now().add(const Duration(days: 3)),
//   ),
//   SaleProduct(
//     id: 'sale_005',
//     title: 'PSUT Baseball Cap',
//     originalPrice: 12.00,
//     salePrice: 7.99,
//     imageUrl: 'assets/images/baseball_cap.jpg',
//     category: 'Clothing',
//     saleEndDate: DateTime.now().add(const Duration(days: 14)),
//   ),

//   // Merchandise Category (5 products)
//   SaleProduct(
//     id: 'sale_006',
//     title: 'Union Shop Water Bottle - Insulated',
//     originalPrice: 18.00,
//     salePrice: 12.99,
//     imageUrl: 'assets/images/water_bottle.jpg',
//     category: 'Merchandise',
//     saleEndDate: DateTime.now().add(const Duration(days: 7)),
//   ),
//   SaleProduct(
//     id: 'sale_007',
//     title: 'Campus Tote Bag - Large',
//     originalPrice: 14.00,
//     salePrice: 8.99,
//     imageUrl: 'assets/images/tote_bag.jpg',
//     category: 'Merchandise',
//     saleEndDate: DateTime.now().add(const Duration(days: 12)),
//   ),
//   SaleProduct(
//     id: 'sale_008',
//     title: 'University Notebook Set (3-Pack)',
//     originalPrice: 10.00,
//     salePrice: 5.99,
//     imageUrl: 'assets/images/notebook_set.jpg',
//     category: 'Merchandise',
//     saleEndDate: DateTime.now().add(const Duration(days: 6)),
//   ),
//   SaleProduct(
//     id: 'sale_009',
//     title: 'PSUT Coffee Mug - Ceramic',
//     originalPrice: 9.00,
//     salePrice: 5.99,
//     imageUrl: 'assets/images/coffee_mug.jpg',
//     category: 'Merchandise',
//     saleEndDate: DateTime.now().add(const Duration(days: 9)),
//   ),
//   SaleProduct(
//     id: 'sale_010',
//     title: 'Union Shop Backpack - Classic',
//     originalPrice: 45.00,
//     salePrice: 32.99,
//     imageUrl: 'assets/images/backpack.jpg',
//     category: 'Merchandise',
//     saleEndDate: DateTime.now().add(const Duration(days: 8)),
//   ),

//   // PSUT Category (5 products)
//   SaleProduct(
//     id: 'sale_011',
//     title: 'PSUT Pin Badge Collection',
//     originalPrice: 8.00,
//     salePrice: 4.99,
//     imageUrl: 'assets/images/pin_badges.jpg',
//     category: 'PSUT',
//     saleEndDate: DateTime.now().add(const Duration(days: 15)),
//   ),
//   SaleProduct(
//     id: 'sale_012',
//     title: 'University Lanyard - Premium',
//     originalPrice: 6.00,
//     salePrice: 3.99,
//     imageUrl: 'assets/images/lanyard.jpg',
//     category: 'PSUT',
//     saleEndDate: DateTime.now().add(const Duration(days: 11)),
//   ),
//   SaleProduct(
//     id: 'sale_013',
//     title: 'PSUT Sticker Pack (10 Designs)',
//     originalPrice: 5.00,
//     salePrice: 2.99,
//     imageUrl: 'assets/images/sticker_pack.jpg',
//     category: 'PSUT',
//     saleEndDate: DateTime.now().add(const Duration(days: 4)),
//   ),
//   SaleProduct(
//     id: 'sale_014',
//     title: 'Campus Map Poster - Framed',
//     originalPrice: 22.00,
//     salePrice: 14.99,
//     imageUrl: 'assets/images/campus_poster.jpg',
//     category: 'PSUT',
//     saleEndDate: DateTime.now().add(const Duration(days: 13)),
//   ),
//   SaleProduct(
//     id: 'sale_015',
//     title: 'PSUT Pennant Flag - Large',
//     originalPrice: 16.00,
//     salePrice: 10.99,
//     imageUrl: 'assets/images/pennant_flag.jpg',
//     category: 'PSUT',
//     saleEndDate: DateTime.now().add(const Duration(days: 7)),
//   ),
// ];
