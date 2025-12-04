import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/widgets/filter_bar.dart';
import 'package:union_shop/widgets/sort_dropdown.dart';
import 'package:union_shop/widgets/product_count.dart';
import 'package:union_shop/widgets/product_card.dart';

class ShopCategoryPage extends StatefulWidget {
  final String category;
  final bool enableFiltersAndSort; // Enable filter/sort controls
  final List<String>?
      filterOptions; // e.g., ['All', 'Clothing', 'Hoodies', ...]
  final String? initialFilter;
  final List<String>?
      sortOptions; // e.g., ['Popularity', 'Price: Low to High', ...]
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
  late String _selectedFilter;
  late String _selectedSort;
  late List<dynamic> _allProducts;
  late List<dynamic> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _selectedFilter =
        widget.initialFilter ?? (widget.filterOptions?.first ?? 'All');
    _selectedSort =
        widget.initialSort ?? (widget.sortOptions?.first ?? 'Popularity');
    _loadProducts();
    _applyFiltersAndSort();
  }

  void _loadProducts() {
    // FR-3.1: Load products for the category
    // TODO: Replace with actual product service/API call
    _allProducts = _getMockProductsForCategory(widget.category);
  }

  void _applyFiltersAndSort() {
    // FR-3.3, FR-4.3: Apply filtering and sorting
    _filteredProducts = List.from(_allProducts);

    // Apply filter
    if (widget.enableFiltersAndSort && _selectedFilter != 'All') {
      _filteredProducts = _filteredProducts
          .where((p) => (p.category as String?) == _selectedFilter)
          .toList();
    }

    // Apply sort
    if (widget.enableFiltersAndSort) {
      _filteredProducts.sort((a, b) {
        switch (_selectedSort) {
          case 'Price: Low to High':
            return (a.price as num).compareTo(b.price as num);
          case 'Price: High to Low':
            return (b.price as num).compareTo(a.price as num);
          case 'Newest':
            return (b.dateAdded as DateTime?)
                    ?.compareTo(a.dateAdded as DateTime? ?? DateTime.now()) ??
                0;
          case 'Popularity':
          default:
            return 0; // Maintain original order
        }
      });
    }
  }

  void _onFilterChanged(String newFilter) {
    setState(() {
      _selectedFilter = newFilter;
      _applyFiltersAndSort();
    });
  }

  void _onSortChanged(String newSort) {
    setState(() {
      _selectedSort = newSort;
      _applyFiltersAndSort();
    });
  }

  List<dynamic> _getMockProductsForCategory(String category) {
    // TODO: Replace with actual product data from service
    // For now, return mock products
    return [
      MockProduct(
        id: '1',
        title: 'Product 1',
        price: 25.00,
        imageUrl: 'assets/images/product1.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now(),
      ),
      MockProduct(
        id: '2',
        title: 'Product 2',
        price: 35.00,
        imageUrl: 'assets/images/product2.jpg',
        category: 'Hoodies',
        dateAdded: DateTime.now().subtract(const Duration(days: 1)),
      ),
      MockProduct(
        id: '3',
        title: 'Product 3',
        price: 15.00,
        imageUrl: 'assets/images/product3.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle =
        widget.category[0].toUpperCase() + widget.category.substring(1);

    return AppScaffold(
      currentRoute: '/shop/${widget.category}',
      child: CustomScrollView(
        slivers: [
          // Header with title
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(pageTitle),
            centerTitle: false,
          ),

          // Filter and Sort Controls (if enabled)
          if (widget.enableFiltersAndSort)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Controls Row
                    Row(
                      children: [
                        // Filter Bar
                        if (widget.filterOptions != null)
                          Expanded(
                            child: FilterBar(
                              label: 'Filter By',
                              selectedValue: _selectedFilter,
                              options: widget.filterOptions!,
                              onChanged: _onFilterChanged,
                              fullWidth: true,
                            ),
                          ),
                        const SizedBox(width: 16),

                        // Sort Dropdown
                        if (widget.sortOptions != null)
                          Expanded(
                            child: SortDropdown(
                              selectedValue: _selectedSort,
                              options: widget.sortOptions!,
                              onChanged: _onSortChanged,
                              fullWidth: true,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Product Count and Clear Filters
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductCount(count: _filteredProducts.length),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Product Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(
                    product: product,
                    priceLabel: '£${(product.price as num).toStringAsFixed(2)}',
                    onTap: () {
                      // Navigate to product page
                      debugPrint('Tapped product: ${product.id}');
                    },
                  );
                },
                childCount: _filteredProducts.length,
              ),
            ),
          ),

          // Empty state
          if (_filteredProducts.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 16),
                    Text(
                      'No products found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}

// Mock product model for now
class MockProduct {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  final DateTime dateAdded;

  MockProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.dateAdded,
  });
}
