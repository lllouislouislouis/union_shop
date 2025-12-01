import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../models/sale_product.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  // State variables for filtering, sorting, and pagination
  List<SaleProduct> _allProducts = [];
  List<SaleProduct> _filteredProducts = [];
  List<SaleProduct> _displayedProducts = [];

  String _selectedCategory = 'All Categories';
  String _selectedSort = 'Featured';
  int _currentPage = 1;
  int _totalPages = 1;

  static const int _productsPerPage = 9;

  @override
  void initState() {
    super.initState();
    // Initialize with mock data
    _allProducts = List.from(mockSaleProducts);
    _filteredProducts = List.from(_allProducts);
    _updateDisplayedProducts();
  }

  // Update the products displayed on current page
  void _updateDisplayedProducts() {
    final startIndex = (_currentPage - 1) * _productsPerPage;
    final endIndex = startIndex + _productsPerPage;

    _displayedProducts =
        _filteredProducts.skip(startIndex).take(_productsPerPage).toList();

    _totalPages = (_filteredProducts.length / _productsPerPage).ceil();
    if (_totalPages == 0) _totalPages = 1;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine padding and grid columns based on screen size
    double horizontalPadding;
    int gridColumns;

    if (screenWidth > 800) {
      horizontalPadding = 40.0; // Desktop
      gridColumns = 3;
    } else if (screenWidth > 600) {
      horizontalPadding = 32.0; // Tablet
      gridColumns = 2;
    } else {
      horizontalPadding = 24.0; // Mobile
      gridColumns = 1;
    }

    return Scaffold(
      body: Column(
        children: [
          // App Header
          const AppHeader(currentRoute: '/sale'),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    // Top spacing
                    const SizedBox(height: 64),

                    // Heading Section
                    _buildHeadingSection(),

                    const SizedBox(height: 32),

                    // TODO: Filter & Sort Controls (Phase 4 & 5)
                    const SizedBox(height: 24),

                    // Product Grid
                    _buildProductGrid(gridColumns),

                    // TODO: Pagination Controls (Phase 6)

                    // Bottom spacing
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the heading section with title and subheading
  Widget _buildHeadingSection() {
    return Column(
      children: [
        // Main heading
        const Text(
          'SALE!',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963), // Purple theme color
          ),
        ),

        const SizedBox(height: 16),

        // Subheading
        Text(
          'Don\'t miss out on our amazing deals! Limited time offers on selected items.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  // Build the product grid
  Widget _buildProductGrid(int columns) {
    if (_displayedProducts.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 24,
        mainAxisSpacing: 32,
        childAspectRatio: 0.75, // Adjust based on card content
      ),
      itemCount: _displayedProducts.length,
      itemBuilder: (context, index) {
        return SaleProductCard(
          product: _displayedProducts[index],
          onTap: () {
            Navigator.pushNamed(context, '/product');
          },
        );
      },
    );
  }

  // Build empty state when no products
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back soon for amazing deals!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
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
                  child: Stack(
                    children: [
                      // Image
                      ClipRRect(
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

                      // Discount badge (top-right corner)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4d2963),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '-${widget.product.discountPercentage}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
