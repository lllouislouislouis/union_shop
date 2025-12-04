import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // State variables for product customization
  late Product _product;
  String? _selectedColor; // Null if not selected
  String? _selectedSize; // Null if not selected
  int _selectedQuantity = 1; // Default quantity is 1

  // Flag to track if page has been initialized with product data
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Product data will be loaded in didChangeDependencies
    // Using didChangeDependencies instead of initState because we need ModalRoute context
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load product data from route arguments only once
    if (!_isInitialized) {
      try {
        // Get the route settings from the current route
        final route = ModalRoute.of(context);
        if (route != null && route.settings.arguments is Product) {
          _product = route.settings.arguments as Product;
          _isInitialized = true;
        } else {
          _product = mockProducts.first;
          _isInitialized = true;
        }
      } catch (e) {
        // Fallback: use a default product if route arguments are missing
        _product = mockProducts.first;
        _isInitialized = true;
      }
    }
  }

  /// Validates if all required options are selected before adding to cart or checkout
  bool get _canAddToCart {
    // If product requires color selection, color must be selected
    if (_product.requiresColorSelection && _selectedColor == null) {
      return false;
    }
    // If product requires size selection, size must be selected
    if (_product.requiresSizeSelection && _selectedSize == null) {
      return false;
    }
    // All required options are selected
    return true;
  }

  /// Update selected color and notify listeners
  void _onColorChanged(String? newColor) {
    setState(() {
      _selectedColor = newColor;
    });
  }

  /// Update selected size and notify listeners
  void _onSizeChanged(String? newSize) {
    setState(() {
      _selectedSize = newSize;
    });
  }

  /// Increment quantity (up to maxStock)
  void _incrementQuantity() {
    setState(() {
      if (_selectedQuantity < _product.maxStock) {
        _selectedQuantity++;
      }
    });
  }

  /// Decrement quantity (minimum 1)
  void _decrementQuantity() {
    setState(() {
      if (_selectedQuantity > 1) {
        _selectedQuantity--;
      }
    });
  }

  /// Update quantity from direct input
  void _onQuantityChanged(String value) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= _product.maxStock) {
      setState(() {
        _selectedQuantity = parsed;
      });
    }
  }

  /// Handle Add to Cart button press
  void _onAddToCartPressed() {
    if (!_canAddToCart) {
      _showErrorMessage('Please select all required options');
      return;
    }

    // TODO: Implement Add to Cart logic
    // For now, just show success message
    _showSuccessMessage('Added to cart!');
  }

  /// Handle Buy Now button press
  void _onBuyNowPressed() {
    if (!_canAddToCart) {
      _showErrorMessage('Please select all required options');
      return;
    }

    // TODO: Implement Buy Now navigation to checkout
    // Navigator.pushNamed(context, '/checkout', arguments: {
    //   'productId': _product.id,
    //   'color': _selectedColor,
    //   'size': _selectedSize,
    //   'quantity': _selectedQuantity,
    // });
  }

  /// Show error message in snackbar
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show success message in snackbar
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const AppScaffold(
        currentRoute: '/product',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    // Determine padding based on screen size
    double horizontalPadding;
    if (screenWidth > 800) {
      horizontalPadding = 40.0; // Desktop
    } else if (screenWidth > 600) {
      horizontalPadding = 32.0; // Tablet
    } else {
      horizontalPadding = 24.0; // Mobile
    }

    return AppScaffold(
      currentRoute: '/product',
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              // Top spacing
              const SizedBox(height: 64),

              // Responsive layout: Desktop (Row) vs Mobile (Column)
              isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),

              // Bottom spacing
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  /// Build two-column layout for desktop (>800px)
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: Product image (50% width)
        Expanded(
          flex: 1,
          child: _buildProductImageSection(),
        ),

        // Spacing between columns
        const SizedBox(width: 40),

        // Right column: Product details (50% width)
        Expanded(
          flex: 1,
          child: _buildProductDetailsSection(),
        ),
      ],
    );
  }

  /// Build single-column layout for mobile/tablet (≤800px)
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Product image (full width)
        _buildProductImageSection(),

        // Spacing between sections
        const SizedBox(height: 32),

        // Product details (full width)
        _buildProductDetailsSection(),
      ],
    );
  }

  /// Build product image section (used in both layouts)
  Widget _buildProductImageSection() {
    return SizedBox(
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.grey[100],
          child: Image.asset(
            _product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 64,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Build product details section (used in both layouts)
  Widget _buildProductDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product title
        Text(
          _product.title,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
            height: 1.2,
          ),
        ),

        const SizedBox(height: 16),

        // Product price (with sale price support)
        _buildPriceSection(),

        const SizedBox(height: 32),

        // Color dropdown (if colors available)
        if (_product.requiresColorSelection) _buildColorDropdown(),

        if (_product.requiresColorSelection) const SizedBox(height: 16),

        // Size dropdown (if sizes available)
        if (_product.requiresSizeSelection) _buildSizeDropdown(),

        if (_product.requiresSizeSelection) const SizedBox(height: 16),

        // Quantity selector
        _buildQuantitySelector(),

        const SizedBox(height: 24),

        // Action buttons
        _buildActionButtons(),

        const SizedBox(height: 32),

        // Product description
        _buildProductDescription(),
      ],
    );
  }

  /// Build price section with sale price support
  Widget _buildPriceSection() {
    return Row(
      children: [
        // Original price (if on sale)
        if (_product.isOnSale)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '£${_product.originalPrice!.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey[600],
              ),
            ),
          ),

        // Current price (sale price if on sale, regular price otherwise)
        Text(
          '£${_product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),
      ],
    );
  }

  /// Build color dropdown widget
  Widget _buildColorDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedColor,
              isExpanded: true,
              hint: const Text('Select Color'),
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              items: _product.availableColors.map((String color) {
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(color),
                );
              }).toList(),
              onChanged: _onColorChanged,
            ),
          ),
        ),
      ],
    );
  }

  /// Build size dropdown widget
  Widget _buildSizeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSize,
              isExpanded: true,
              hint: const Text('Select Size'),
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              items: _product.availableSizes.map((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: _onSizeChanged,
            ),
          ),
        ),
      ],
    );
  }

  /// Build quantity selector widget
  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Decrement button
            IconButton(
              onPressed: _selectedQuantity > 1 ? _decrementQuantity : null,
              icon: const Icon(Icons.remove),
              tooltip: 'Decrease quantity',
              disabledColor: Colors.grey[300],
            ),

            // Quantity input field
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: _selectedQuantity.toString(),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: _onQuantityChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),

            // Increment button
            IconButton(
              onPressed: _selectedQuantity < _product.maxStock
                  ? _incrementQuantity
                  : null,
              icon: const Icon(Icons.add),
              tooltip: 'Increase quantity',
              disabledColor: Colors.grey[300],
            ),
          ],
        ),
      ],
    );
  }

  /// Build action buttons (Add to Cart and Buy Now)
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Add to Cart button
        Expanded(
          child: ElevatedButton(
            onPressed: _canAddToCart ? _onAddToCartPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              disabledBackgroundColor: Colors.grey[300],
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.grey[600],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Buy Now button
        Expanded(
          child: OutlinedButton(
            onPressed: _canAddToCart ? _onBuyNowPressed : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color:
                    _canAddToCart ? const Color(0xFF4d2963) : Colors.grey[300]!,
              ),
              foregroundColor:
                  _canAddToCart ? const Color(0xFF4d2963) : Colors.grey[600],
              disabledForegroundColor: Colors.grey[400],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build product description section
  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _product.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
