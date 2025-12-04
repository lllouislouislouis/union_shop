import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/widgets/category_filter_dropdown.dart';
import 'package:union_shop/widgets/sort_dropdown.dart';
import 'package:union_shop/widgets/product_count_display.dart';
import 'package:union_shop/widgets/sale_product_card.dart';
import '../models/sale_product.dart';

class ShopCategoryPage extends StatefulWidget {
  final String category;
  final bool enableFiltersAndSort;
  final List<String>? filterOptions;
  final String? initialFilter;
  final List<String>? sortOptions;
  final String? initialSort;

  const ShopCategoryPage({
    super.key,
    required this.category,
    this.enableFiltersAndSort = false,
    this.filterOptions,
    this.initialFilter,
    this.sortOptions,
    this.initialSort,
  });

  @override
  State<ShopCategoryPage> createState() => _ShopCategoryPageState();
}

class _ShopCategoryPageState extends State<ShopCategoryPage> {
  // State variables for filtering, sorting, and pagination
  List<SaleProduct> _allProducts = [];
  List<SaleProduct> _filteredProducts = [];
  List<SaleProduct> _displayedProducts = [];

  late String _selectedCategory;
  late String _selectedSort;
  int _currentPage = 1;
  int _totalPages = 1;

  static const int _productsPerPage = 9;

  // ScrollController to handle scroll-to-top on page change
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize selected filter and sort with provided defaults or fallbacks
    _selectedCategory = widget.initialFilter ??
        (widget.filterOptions?.first ?? 'All Categories');
    _selectedSort =
        widget.initialSort ?? (widget.sortOptions?.first ?? 'Featured');

    // Load products for this category
    _loadProducts();
    _applyFilters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Load products based on category
  void _loadProducts() {
    // Load all products - filtering will be handled by the filter dropdown
    _allProducts = List.from(mockSaleProducts);
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

  String get route => '/shop/${widget.category}';

  String get title => widget.category.replaceAll('-', ' ').splitMapJoin(
        RegExp(r'\b\w'),
        onMatch: (m) => m.group(0)!.toUpperCase(),
        onNonMatch: (n) => n,
      );

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

    return AppScaffold(
      currentRoute: route,
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

              // Filter & Sort Controls (only if enabled)
              if (widget.enableFiltersAndSort) ...[
                _buildFilterSortControls(isMobile),
                const SizedBox(height: 24),
              ],

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
    );
  }

  // Build the heading section with title
  Widget _buildHeadingSection() {
    return Column(
      children: [
        // Main heading
        Text(
          title,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963), // Purple theme color
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

  // Build filter and sort controls (matching Sale page)
  Widget _buildFilterSortControls(bool isMobile) {
    if (!widget.enableFiltersAndSort) return const SizedBox.shrink();

    final filterOptions = widget.filterOptions ?? ['All Categories'];
    final sortOptions = widget.sortOptions ?? ['Featured'];

    if (isMobile) {
      // Stack vertically on mobile
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter row with label
          Row(
            children: [
              Text(
                'Filter by',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CategoryFilterDropdown(
                  selectedCategory: _selectedCategory,
                  categories: filterOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      _applyFilters();
                    });
                  },
                  fullWidth: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sort row with label
          Row(
            children: [
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SortDropdown(
                  selectedSort: _selectedSort,
                  sortOptions: sortOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSort = newValue;
                      _applySorting();
                    });
                  },
                  fullWidth: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Product count
          ProductCountDisplay(count: _filteredProducts.length),
        ],
      );
    } else {
      // Horizontal row on desktop/tablet - wrapped in SingleChildScrollView to prevent overflow
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Filter and Sort with labels
            Row(
              children: [
                // Filter with label
                Row(
                  children: [
                    Text(
                      'Filter by',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(width: 12),
                    CategoryFilterDropdown(
                      selectedCategory: _selectedCategory,
                      categories: filterOptions,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          _applyFilters();
                        });
                      },
                      fullWidth: false,
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Sort with label
                Row(
                  children: [
                    Text(
                      'Sort by',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(width: 12),
                    SortDropdown(
                      selectedSort: _selectedSort,
                      sortOptions: sortOptions,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSort = newValue;
                          _applySorting();
                        });
                      },
                      fullWidth: false,
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Product count
                ProductCountDisplay(count: _filteredProducts.length),
              ],
            ),
          ],
        ),
      );
    }
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
                  ? 'Check back soon for new items!'
                  : 'Try selecting a different category',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (widget.enableFiltersAndSort &&
                _selectedCategory != 'All Categories') ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory =
                        widget.filterOptions?.first ?? 'All Categories';
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
