import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? _product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract product from route arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Product) {
      _product = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle case where no product data is provided
    if (_product == null) {
      return AppScaffold(
        currentRoute: '/product',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Product not found',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Back to Homepage'),
              ),
            ],
          ),
        ),
      );
    }

    // Display product details
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final product = _product!;

    return AppScaffold(
      currentRoute: '/product',
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          color: Colors.white,
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildProductImage(product)),
                    const SizedBox(width: 40),
                    Expanded(child: _buildProductDetails(product)),
                  ],
                )
              : Column(
                  children: [
                    _buildProductImage(product),
                    const SizedBox(height: 24),
                    _buildProductDetails(product),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        product.imageUrl,
        fit: BoxFit.cover,
        height: 400,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 400,
            color: Colors.grey[300],
            child: Center(
              child: Icon(
                Icons.shopping_bag,
                size: 80,
                color: Colors.grey[600],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Title
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 16),

        // Product Price
        if (product.isOnSale) ...[
          Row(
            children: [
              Text(
                '£${product.originalPrice!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '£${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4d2963),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${product.discountPercentage}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ] else ...[
          Text(
            '£${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4d2963),
            ),
          ),
        ],
        const SizedBox(height: 24),

        // Product Description
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Color options (if available)
        if (product.availableColors.isNotEmpty) ...[
          const Text(
            'Available Colors:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: product.availableColors.map((color) {
              return Chip(
                label: Text(color),
                backgroundColor: Colors.grey[200],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // Size options (if available)
        if (product.availableSizes.isNotEmpty) ...[
          const Text(
            'Available Sizes:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: product.availableSizes.map((size) {
              return Chip(
                label: Text(size),
                backgroundColor: Colors.grey[200],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        const SizedBox(height: 24),

        // Placeholder action buttons (full implementation in future subtasks)
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement Add to Cart functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add to Cart - Coming Soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // TODO: Implement Buy Now functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Buy Now - Coming Soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4d2963),
                  side: const BorderSide(color: Color(0xFF4d2963), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
