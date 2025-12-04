import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/firebase_service.dart';

/// Provider for managing product data from Firebase
///
/// Handles:
/// - Fetching products from Firestore
/// - Caching products locally
/// - Filtering by category
/// - Loading states
class ProductsProvider extends ChangeNotifier {
  final FirebaseServiceBase _firebaseService;

  /// Allow injecting a FirebaseServiceBase for easier testing.
  ProductsProvider({FirebaseServiceBase? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  // Product list cache
  List<Product> _allProducts = [];

  // Loading state
  bool _isLoading = false;

  // Error message
  String? _errorMessage;

  // Getters
  List<Product> get allProducts => _allProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetch all products from Firebase
  ///
  /// Called on app startup or when refresh is needed
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allProducts = await _firebaseService.getAllProducts();
      debugPrint('Fetched ${_allProducts.length} products from Firebase');
    } catch (e) {
      _errorMessage = 'Failed to load products: $e';
      debugPrint(_errorMessage);
      _allProducts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get products by category
  ///
  /// [category] - Category name to filter by
  /// Returns filtered list of products
  List<Product> getProductsByCategory(String category) {
    if (category.isEmpty || category == 'all') {
      return _allProducts;
    }

    return _allProducts.where((product) {
      // Parse category from imageUrl or other field
      // For now, filter by description or other logic
      return true; // Update based on your category logic
    }).toList();
  }

  /// Search products by title
  ///
  /// [query] - Search query string
  /// Returns matching products
  List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return _allProducts;
    }

    final lowerQuery = query.toLowerCase();
    return _allProducts
        .where((product) =>
            product.title.toLowerCase().contains(lowerQuery) ||
            product.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Get featured products (e.g., on sale)
  ///
  /// Returns products with originalPrice set (on sale)
  List<Product> getFeaturedProducts() {
    return _allProducts
        .where((product) => product.originalPrice != null)
        .toList();
  }

  /// Get a single product by ID
  ///
  /// [productId] - Product ID to fetch
  /// Returns the product or null if not found
  Future<Product?> getProductById(String productId) async {
    try {
      return await _firebaseService.getProductById(productId);
    } catch (e) {
      debugPrint('Error fetching product $productId: $e');
      return null;
    }
  }

  /// Refresh products from Firebase
  ///
  /// Clears cache and fetches fresh data
  Future<void> refreshProducts() async {
    _allProducts = [];
    await fetchAllProducts();
  }
}
