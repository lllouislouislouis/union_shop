import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:union_shop/models/product.dart';

/// Base interface for Firebase service functionality. Allows injecting
/// test doubles that don't rely on real Firebase instances.
abstract class FirebaseServiceBase {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product?> getProductById(String productId);
  Future<String> getImageUrl(String imagePath);
  Stream<List<Product>> watchAllProducts();
}

/// Firebase Service for managing product data and images
///
/// Handles:
/// - Fetching products from Firestore
/// - Getting image URLs from Firebase Storage
/// - Error handling and logging
class FirebaseService implements FirebaseServiceBase {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection reference
  static const String productsCollection = 'products';
  static const String storageFolder = 'products'; // products/ folder in Storage

  /// Get all products from Firestore
  ///
  /// Returns a list of Product objects
  /// Throws exception if fetch fails
  @override
  Future<List<Product>> getAllProducts() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection(productsCollection).get();

      final List<Product> products = [];

      for (var doc in snapshot.docs) {
        try {
          final product = _productFromFirestore(doc);
          products.add(product);
        } catch (e) {
          debugPrint('Error parsing product ${doc.id}: $e');
        }
      }

      debugPrint('Fetched ${products.length} products from Firestore');
      return products;
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow;
    }
  }

  /// Get products by category
  ///
  /// [category] - The category name to filter by
  /// Returns list of products in that category
  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(productsCollection)
          .where('category', isEqualTo: category)
          .get();

      final List<Product> products = [];

      for (var doc in snapshot.docs) {
        try {
          final product = _productFromFirestore(doc);
          products.add(product);
        } catch (e) {
          debugPrint('Error parsing product ${doc.id}: $e');
        }
      }

      debugPrint('Fetched ${products.length} products in category: $category');
      return products;
    } catch (e) {
      debugPrint('Error fetching products by category: $e');
      rethrow;
    }
  }

  /// Get a single product by ID
  ///
  /// [productId] - The ID of the product to fetch
  /// Returns Product object or null if not found
  @override
  Future<Product?> getProductById(String productId) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection(productsCollection).doc(productId).get();

      if (!doc.exists) {
        debugPrint('Product $productId not found');
        return null;
      }

      final product = _productFromFirestore(doc);
      debugPrint('Fetched product: ${product.title}');
      return product;
    } catch (e) {
      debugPrint('Error fetching product $productId: $e');
      rethrow;
    }
  }

  /// Get image URL from Firebase Storage
  ///
  /// [imagePath] - Path to image in Storage (e.g., 'products/hoodie.jpg')
  /// Returns download URL as string
  /// Throws exception if file not found
  @override
  Future<String> getImageUrl(String imagePath) async {
    try {
      final String url = await _storage.ref(imagePath).getDownloadURL();
      debugPrint('Got image URL for: $imagePath');
      return url;
    } catch (e) {
      debugPrint('Error getting image URL for $imagePath: $e');
      rethrow;
    }
  }

  /// Upload product image to Firebase Storage
  ///
  /// [file] - The image file to upload
  /// [fileName] - Name for the file (e.g., 'hoodie.jpg')
  /// Returns download URL
  Future<String> uploadProductImage(dynamic file, String fileName) async {
    try {
      final Reference ref = _storage.ref('$storageFolder/$fileName');

      // Handle different file types (web uses Uint8List)
      if (file is String) {
        // File path (mobile/desktop)
        await ref.putFile(file as dynamic);
      } else {
        // Uint8List (web)
        await ref.putData(file as dynamic);
      }

      final String url = await ref.getDownloadURL();
      debugPrint('Uploaded image: $fileName');
      return url;
    } catch (e) {
      debugPrint('Error uploading image $fileName: $e');
      rethrow;
    }
  }

  /// Convert Firestore document to Product object
  ///
  /// [doc] - Firestore document snapshot
  /// Returns Product object with data from Firestore
  Product _productFromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Product(
      id: doc.id,
      title: data['title'] ?? 'Unknown Product',
      price: (data['price'] ?? 0.0).toDouble(),
      originalPrice: data['originalPrice'] != null
          ? (data['originalPrice'] as num).toDouble()
          : null,
      imageUrl: data['imageUrl'] ?? '',
      availableColors: List<String>.from(data['availableColors'] ?? []),
      availableSizes: List<String>.from(data['availableSizes'] ?? []),
      description: data['description'] ?? '',
      maxStock: data['maxStock'] ?? 10,
    );
  }

  /// Add a product to Firestore (for testing/admin)
  ///
  /// [product] - Product object to add
  /// Returns the product ID
  Future<String> addProduct(Product product) async {
    try {
      final docRef = await _firestore.collection(productsCollection).add({
        'title': product.title,
        'price': product.price,
        'originalPrice': product.originalPrice,
        'imageUrl': product.imageUrl,
        'availableColors': product.availableColors,
        'availableSizes': product.availableSizes,
        'description': product.description,
        'maxStock': product.maxStock,
      });

      debugPrint('Added product with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      debugPrint('Error adding product: $e');
      rethrow;
    }
  }

  /// Delete a product from Firestore (for testing/admin)
  ///
  /// [productId] - ID of product to delete
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(productsCollection).doc(productId).delete();
      debugPrint('Deleted product: $productId');
    } catch (e) {
      debugPrint('Error deleting product: $e');
      rethrow;
    }
  }

  /// Listen to real-time updates for all products
  ///
  /// Returns a Stream of product lists
  /// Useful for live updates when products change
  @override
  Stream<List<Product>> watchAllProducts() {
    return _firestore.collection(productsCollection).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          try {
            return _productFromFirestore(doc);
          } catch (e) {
            debugPrint('Error parsing product ${doc.id}: $e');
            rethrow;
          }
        }).toList();
      },
    );
  }

  /// Test Firebase connection
  ///
  /// Returns true if connection successful
  Future<bool> testConnection() async {
    try {
      // Try to read a single document
      await _firestore.collection(productsCollection).limit(1).get();
      debugPrint('Firebase connection test: SUCCESS');
      return true;
    } catch (e) {
      debugPrint('Firebase connection test FAILED: $e');
      return false;
    }
  }
}
