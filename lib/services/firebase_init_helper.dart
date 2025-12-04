import 'package:flutter/material.dart';
import 'package:union_shop/services/firebase_service.dart';
import 'package:union_shop/constants/firebase_sample_products.dart';

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
          // Create a mock Product object to pass to addProduct
          final productId = await _firebaseService.addProduct(
            _createProductFromMap(productData),
          );
          
          debugPrint('Uploaded product: ${productData['title']} (ID: $productId)');
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
  static _MockProduct _createProductFromMap(Map<String, dynamic> data) {
    return _MockProduct(
      id: '', // Will be set by Firestore
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

/// Temporary mock Product class for initialization
/// Matches the structure of the real Product model
class _MockProduct {
  final String id;
  final String title;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> availableColors;
  final List<String> availableSizes;
  final String description;
  final int maxStock;

  _MockProduct({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.availableColors,
    required this.availableSizes,
    required this.description,
    this.maxStock = 10,
  });
}