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
        _product =
            ModalRoute.of<Product>(context)?.settings.arguments as Product;
        _isInitialized = true;
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

    return AppScaffold(
      currentRoute: '/product',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_product.title}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Price: £${_product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              if (_product.requiresColorSelection)
                Text('Selected Color: ${_selectedColor ?? "Not selected"}'),
              if (_product.requiresSizeSelection)
                Text('Selected Size: ${_selectedSize ?? "Not selected"}'),
              Text('Quantity: $_selectedQuantity'),
              const SizedBox(height: 16),
              Text(
                'Can Add to Cart: $_canAddToCart',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _onAddToCartPressed,
                    child: const Text('Add to Cart'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _onBuyNowPressed,
                    child: const Text('Buy Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
