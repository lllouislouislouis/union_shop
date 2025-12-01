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

  // ScrollController to handle scroll-to-top on page change
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize with mock data
    _allProducts = List.from(mockSaleProducts);
    _applyFilters(); // Apply initial filter (All Categories)
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Apply category filter to products
  void _applyFilters() {
    setState(() {
      // Filter products based on selected category
      if (_selectedCategory == 'All Categories') {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((product) => product.category == _selectedCategory)
            .toList();
      }

      // Reset to page 1 when filter changes
      _currentPage = 1;

      // Apply sorting to filtered products
      _applySorting();
    });
  }

  // Apply sorting to filtered products
  void _applySorting() {
    setState(() {
      switch (_selectedSort) {
        case 'Featured':
          // Keep original order (no sorting needed)
          break;
        case 'Best Selling':
          // For now, same as Featured (could add a salesCount field later)
          break;
        case 'Alphabetically, A-Z':
          _filteredProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Alphabetically, Z-A':
          _filteredProducts.sort((a, b) => b.title.compareTo(a.title));
          break;
        case 'Price: Low to High':
          _filteredProducts.sort((a, b) => a.salePrice.compareTo(b.salePrice));
          break;
        case 'Price: High to Low':
          _filteredProducts.sort((a, b) => b.salePrice.compareTo(a.salePrice));
          break;
        case 'Date, old to new':
          _filteredProducts
              .sort((a, b) => a.saleEndDate.compareTo(b.saleEndDate));
          break;
        case 'Date, new to old':
          _filteredProducts
              .sort((a, b) => b.saleEndDate.compareTo(a.saleEndDate));
          break;
      }

      // Validate current page is still valid after sorting
      final maxPage = (_filteredProducts.length / _productsPerPage).ceil();
      if (_currentPage > maxPage && maxPage > 0) {
        _currentPage = maxPage;
      }

      // Update displayed products and pagination
      _updateDisplayedProducts();
    });
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

  // Change to a specific page
  void _changePage(int newPage) {
    if (newPage < 1 || newPage > _totalPages) return;

    setState(() {
      _currentPage = newPage;
      _updateDisplayedProducts();
    });

    // Scroll to top of page
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine padding and grid columns based on screen size
    double horizontalPadding;
    int gridColumns;
    bool isMobile = screenWidth <= 600;

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
              controller: _scrollController,
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

                    // Filter & Sort Controls
                    _buildFilterSortControls(isMobile),

                    const SizedBox(height: 24),

                    // Product Grid
                    _buildProductGrid(gridColumns),

                    // Pagination Controls
                    if (_totalPages > 1) ...[
                      const SizedBox(height: 48),
                      _buildPaginationControls(),
                    ],

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

  // Build filter and sort controls
  Widget _buildFilterSortControls(bool isMobile) {
    if (isMobile) {
      // Stack vertically on mobile
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCategoryFilter(fullWidth: true),
          const SizedBox(height: 16),
          _buildSortDropdown(fullWidth: true),
        ],
      );
    } else {
      // Horizontal row on desktop/tablet
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryFilter(fullWidth: false),
          _buildSortDropdown(fullWidth: false),
        ],
      );
    }
  }

  // Build category filter dropdown
  Widget _buildCategoryFilter({required bool fullWidth}) {
    return Container(
      width: fullWidth ? double.infinity : 200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          items: const [
            DropdownMenuItem(
              value: 'All Categories',
              child: Text('All Categories'),
            ),
            DropdownMenuItem(
              value: 'Clothing',
              child: Text('Clothing'),
            ),
            DropdownMenuItem(
              value: 'Merchandise',
              child: Text('Merchandise'),
            ),
            DropdownMenuItem(
              value: 'PSUT',
              child: Text('PSUT'),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue != null && newValue != _selectedCategory) {
              setState(() {
                _selectedCategory = newValue;
                _applyFilters();
              });
            }
          },
        ),
      ),
    );
  }

  // Build sort dropdown
  Widget _buildSortDropdown({required bool fullWidth}) {
    return Container(
      width: fullWidth ? double.infinity : 220,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSort,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          items: const [
            DropdownMenuItem(
              value: 'Featured',
              child: Text('Featured'),
            ),
            DropdownMenuItem(
              value: 'Best Selling',
              child: Text('Best Selling'),
            ),
            DropdownMenuItem(
              value: 'Alphabetically, A-Z',
              child: Text('Alphabetically, A-Z'),
            ),
            DropdownMenuItem(
              value: 'Alphabetically, Z-A',
              child: Text('Alphabetically, Z-A'),
            ),
            DropdownMenuItem(
              value: 'Price: Low to High',
              child: Text('Price: Low to High'),
            ),
            DropdownMenuItem(
              value: 'Price: High to Low',
              child: Text('Price: High to Low'),
            ),
            DropdownMenuItem(
              value: 'Date, old to new',
              child: Text('Date, old to new'),
            ),
            DropdownMenuItem(
              value: 'Date, new to old',
              child: Text('Date, new to old'),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue != null && newValue != _selectedSort) {
              setState(() {
                _selectedSort = newValue;
                _applySorting();
              });
            }
          },
        ),
      ),
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
              _selectedCategory == 'All Categories'
                  ? 'No products found'
                  : 'No products found in this category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedCategory == 'All Categories'
                  ? 'Check back soon for amazing deals!'
                  : 'Try selecting a different category',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (_selectedCategory != 'All Categories') ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = 'All Categories';
                    _applyFilters();
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4d2963),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'View All Products',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Build pagination controls
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          onPressed:
              _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Previous Page',
          iconSize: 24,
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          color: _currentPage > 1 ? const Color(0xFF4d2963) : Colors.grey[400],
          disabledColor: Colors.grey[300],
        ),

        const SizedBox(width: 16),

        // Page indicator
        Text(
          'Page $_currentPage of $_totalPages',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 16),

        // Next button
        IconButton(
          onPressed: _currentPage < _totalPages
              ? () => _changePage(_currentPage + 1)
              : null,
          icon: const Icon(Icons.arrow_forward),
          tooltip: 'Next Page',
          iconSize: 24,
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          color: _currentPage < _totalPages
              ? const Color(0xFF4d2963)
              : Colors.grey[400],
          disabledColor: Colors.grey[300],
        ),
      ],
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
