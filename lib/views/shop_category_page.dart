import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/widgets/filter_bar.dart';
import 'package:union_shop/widgets/sort_dropdown.dart';
import 'package:union_shop/widgets/product_count.dart';
import 'package:union_shop/widgets/product_card.dart';

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
  late String _selectedFilter;
  late String _selectedSort;
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter ?? (widget.filterOptions?.first ?? 'All');
    _selectedSort = widget.initialSort ?? (widget.sortOptions?.first ?? 'Popularity');
    _loadProducts();
    _applyFiltersAndSort();
  }

  void _loadProducts() {
    // FR-3.1: Load products for the category from mock data
    _allProducts = [
      Product(
        id: 'clothing_001',
        title: 'PSUT Purple Hoodie',
        price: 34.99,
        imageUrl: 'assets/images/clothing/hoodie_purple.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 10)),
        popularity: 95,
        isNew: false,
      ),
      Product(
        id: 'clothing_002',
        title: 'PSUT Black Hoodie',
        price: 34.99,
        imageUrl: 'assets/images/clothing/hoodie_black.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 8)),
        popularity: 88,
        isNew: false,
      ),
      Product(
        id: 'clothing_003',
        title: 'PSUT Navy Hoodie',
        price: 34.99,
        imageUrl: 'assets/images/clothing/hoodie_navy.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now(),
        popularity: 75,
        isNew: true,
      ),
      Product(
        id: 'clothing_004',
        title: 'PSUT Classic T-Shirt Purple',
        price: 14.99,
        imageUrl: 'assets/images/clothing/tshirt_purple.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 15)),
        popularity: 92,
        isNew: false,
      ),
      Product(
        id: 'clothing_005',
        title: 'PSUT Classic T-Shirt White',
        price: 14.99,
        imageUrl: 'assets/images/clothing/tshirt_white.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 12)),
        popularity: 85,
        isNew: false,
      ),
      Product(
        id: 'clothing_006',
        title: 'PSUT Vintage T-Shirt Black',
        price: 16.99,
        imageUrl: 'assets/images/clothing/tshirt_vintage_black.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 2)),
        popularity: 70,
        isNew: true,
      ),
      Product(
        id: 'clothing_007',
        title: 'PSUT Vintage T-Shirt Navy',
        price: 16.99,
        imageUrl: 'assets/images/clothing/tshirt_vintage_navy.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 1)),
        popularity: 68,
        isNew: true,
      ),
      Product(
        id: 'clothing_008',
        title: 'PSUT Windbreaker Purple',
        price: 49.99,
        imageUrl: 'assets/images/clothing/jacket_windbreaker.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 20)),
        popularity: 82,
        isNew: false,
      ),
      Product(
        id: 'clothing_009',
        title: 'PSUT Bomber Jacket Black',
        price: 59.99,
        imageUrl: 'assets/images/clothing/jacket_bomber_black.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
        popularity: 79,
        isNew: false,
      ),
      Product(
        id: 'clothing_010',
        title: 'PSUT Bomber Jacket Navy',
        price: 59.99,
        imageUrl: 'assets/images/clothing/jacket_bomber_navy.jpg',
        category: 'Clothing',
        dateAdded: DateTime.now(),
        popularity: 71,
        isNew: true,
      ),
      Product(
        id: 'clothing_011',
        title: 'PSUT Sweatpants Purple',
        price: 24.99,
        imageUrl: 'assets/images/clothing/sweatpants.jpg',
        category: 'Merchandise',
        dateAdded: DateTime.now().subtract(const Duration(days: 7)),
        popularity: 76,
        isNew: false,
      ),
      Product(
        id: 'clothing_012',
        title: 'PSUT Cap Purple',
        price: 12.99,
        imageUrl: 'assets/images/clothing/cap.jpg',
        category: 'Merchandise',
        dateAdded: DateTime.now().subtract(const Duration(days: 3)),
        popularity: 65,
        isNew: false,
      ),
    ];
  }

  void _applyFiltersAndSort() {
    // FR-3.3, FR-4.3: Apply filtering and sorting
    _filteredProducts = List.from(_allProducts);

    // Apply filter
    if (widget.enableFiltersAndSort && _selectedFilter != 'All') {
      if (_selectedFilter == 'Popular') {
        // Just show random 6 products
        _filteredProducts.shuffle();
        _filteredProducts = _filteredProducts.take(6).toList();
      } else {
        // Filter by category
        _filteredProducts = _filteredProducts
            .where((p) => p.category == _selectedFilter)
            .toList();
      }
    }

    // Apply sort
    if (widget.enableFiltersAndSort) {
      _filteredProducts.sort((a, b) {
        switch (_selectedSort) {
          case 'Price: Low to High':
            return a.price.compareTo(b.price);
          case 'Price: High to Low':
            return b.price.compareTo(a.price);
          case 'Newest':
            return b.dateAdded.compareTo(a.dateAdded);
          case 'Popularity':
          default:
            return (b.popularity ?? 0).compareTo(a.popularity ?? 0);
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
                    priceLabel: '£${product.price.toStringAsFixed(2)}',
                    badge: product.isNew
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4d2963),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      // FR-4.2: Navigate to product page
                      Navigator.pushNamed(
                        context,
                        '/product',
                        arguments: {'productId': product.id},
                      );
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
