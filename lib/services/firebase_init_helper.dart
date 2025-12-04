import 'package:flutter/material.dart';
import 'package:union_shop/services/firebase_service.dart';
import 'package:union_shop/constants/firebase_sample_products.dart';
import 'package:union_shop/models/product.dart';

/// Helper class for initializing Firebase with sample data
///
/// Used for development/testing purposes to populate Firestore
/// with sample products
class FirebaseInitHelper {
  static final FirebaseService _firebaseService = FirebaseService();

  /// Upload all sample products to Firestore
  ///
  /// This should be called once during app setup or manually via admin panel
  /// Returns the number of products uploaded
  static Future<int> uploadSampleProducts() async {
    try {
      debugPrint('Starting upload of sample products...');

      int uploadedCount = 0;

      for (var productData in sampleProducts) {
        try {
          // Create a Product object from the map data
          final product = _createProductFromMap(productData);

          // Add to Firestore (Firebase will assign the ID)
          final productId = await _firebaseService.addProduct(product);

          debugPrint(
              'Uploaded product: ${productData['title']} (ID: $productId)');
          uploadedCount++;
        } catch (e) {
          debugPrint('Failed to upload ${productData['title']}: $e');
        }
      }

      debugPrint('Sample products upload complete. Total: $uploadedCount');
      return uploadedCount;
    } catch (e) {
      debugPrint('Error during sample products upload: $e');
      rethrow;
    }
  }

  /// Check if Firestore already has products
  ///
  /// Returns true if products collection is not empty
  static Future<bool> hasExistingProducts() async {
    try {
      final products = await _firebaseService.getAllProducts();
      debugPrint('Existing products found: ${products.length}');
      return products.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking for existing products: $e');
      return false;
    }
  }

  /// Clear all products from Firestore (for testing/reset)
  ///
  /// WARNING: This deletes all products!
  static Future<void> clearAllProducts() async {
    try {
      final products = await _firebaseService.getAllProducts();

      for (var product in products) {
        await _firebaseService.deleteProduct(product.id);
      }

      debugPrint('All products cleared from Firestore');
    } catch (e) {
      debugPrint('Error clearing products: $e');
      rethrow;
    }
  }

  /// Create a Product object from a map
  ///
  /// Helper method to convert sample product data to Product objects
  /// Returns a Product that matches the actual Product model
  static Product _createProductFromMap(Map<String, dynamic> data) {
    return Product(
      id: '', // Will be set by Firestore when added
      title: data['title'] ?? 'Unknown',
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
}
