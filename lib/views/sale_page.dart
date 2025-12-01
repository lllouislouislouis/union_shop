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

    // Determine padding based on screen size
    double horizontalPadding;
    if (screenWidth > 800) {
      horizontalPadding = 40.0; // Desktop
    } else if (screenWidth > 600) {
      horizontalPadding = 32.0; // Tablet
    } else {
      horizontalPadding = 24.0; // Mobile
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

                    // TODO: Product Grid (Phase 3)

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
}
