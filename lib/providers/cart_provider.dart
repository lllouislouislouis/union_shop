import 'package:flutter/material.dart';
import 'package:union_shop/models/cart_item.dart';

/// Global cart state management using Provider pattern
/// 
/// FR-23: Manages cart items, quantities, and provides calculation methods
class CartProvider extends ChangeNotifier {
  // Private list of cart items
  List<CartItem> _items = [];

  /// Constructor with mock data for testing
  /// FR-23.5: Cart should have mock data for initial testing (2-3 products)
  CartProvider() {
    _initializeMockData();
  }

  /// Initialize mock cart data for testing
  void _initializeMockData() {
    _items = [
      CartItem(
        id: '1',
        productName: 'Union Shop T-Shirt',
        imageUrl: 'assets/images/products/tshirt.jpg',
        price: 19.99,
        quantity: 2,
        size: 'M',
        color: 'Navy',
      ),
      CartItem(
        id: '2',
        productName: 'Union Hoodie',
        imageUrl: 'assets/images/products/hoodie.jpg',
        price: 39.99,
        quantity: 1,
        size: 'L',
      ),
      CartItem(
        id: '3',
        productName: 'Union Tote Bag',
        imageUrl: 'assets/images/products/tote.jpg',
        price: 12.99,
        quantity: 1,
      ),
    ];
  }

  /// Get immutable copy of cart items
  /// FR-23.3: Cart state accessible across the app
  List<CartItem> get items => List.unmodifiable(_items);

  /// Get total number of items in cart (sum of all quantities)
  /// FR-23.4: getTotalItems() - return total number of items
  /// FR-24.3: Used for shopping bag badge count
  int getTotalItems() {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get cart subtotal (sum of all item subtotals)
  /// FR-23.4: getSubtotal() - return sum of all item subtotals
  /// FR-30.4: Used in cart summary calculations
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  /// Get formatted subtotal as currency string
  /// FR-30.5: Format all prices with £ symbol and 2 decimal places
  String getFormattedSubtotal() {
    return '£${getSubtotal().toStringAsFixed(2)}';
  }

  /// Get shipping cost (currently free)
  /// FR-30.3: Shipping row in cart summary
  double getShipping() {
    return 0.0; // Free shipping for now
  }

  /// Get formatted shipping as string
  String getFormattedShipping() {
    return getShipping() == 0.0 ? 'FREE' : '£${getShipping().toStringAsFixed(2)}';
  }

  /// Get cart total (subtotal + shipping)
  /// FR-30.3: Total calculation for cart summary
  double getTotal() {
    return getSubtotal() + getShipping();
  }

  /// Get formatted total as currency string
  /// FR-30.5: Format all prices with £ symbol and 2 decimal places
  String getFormattedTotal() {
    return '£${getTotal().toStringAsFixed(2)}';
  }

  /// Check if cart is empty
  /// FR-25.3: Used to determine which cart state to display
  bool get isEmpty => _items.isEmpty;

  /// Check if cart has items
  bool get isNotEmpty => _items.isNotEmpty;

  /// Find cart item by product ID
  CartItem? findItemById(String productId) {
    try {
      return _items.firstWhere((item) => item.id == productId);
    } catch (e) {
      return null;
    }
  }

  /// Update quantity of an existing cart item
  /// FR-23.4: updateQuantity(String productId, int newQuantity)
  /// FR-28.5: Quantity changes should call updateQuantity() in CartProvider
  void updateQuantity(String productId, int newQuantity) {
    // Validate quantity (must be between 1 and 99)
    if (newQuantity < 1 || newQuantity > 99) {
      debugPrint('Invalid quantity: $newQuantity. Must be between 1 and 99.');
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.id == productId);
    if (itemIndex != -1) {
      _items[itemIndex].quantity = newQuantity;
      notifyListeners(); // FR-23: Notify listeners after state change
      debugPrint('Updated quantity for ${_items[itemIndex].productName} to $newQuantity');
    } else {
      debugPrint('Item with id $productId not found in cart');
    }
  }

  /// Remove item from cart
  /// FR-23.4: removeItem(String productId)
  /// FR-29.7: Called when user confirms removal
  void removeItem(String productId) {
    final itemIndex = _items.indexWhere((item) => item.id == productId);
    if (itemIndex != -1) {
      final removedItem = _items[itemIndex];
      _items.removeAt(itemIndex);
      notifyListeners(); // FR-23: Notify listeners after state change
      debugPrint('Removed ${removedItem.productName} from cart');
    } else {
      debugPrint('Item with id $productId not found in cart');
    }
  }

  /// Add new item to cart (for future use)
  /// Not part of current requirements but useful for completeness
  void addItem(CartItem item) {
    // Check if item already exists
    final existingItem = findItemById(item.id);
    if (existingItem != null) {
      // If exists, increase quantity
      updateQuantity(item.id, existingItem.quantity + item.quantity);
    } else {
      // Otherwise add new item
      _items.add(item);
      notifyListeners();
      debugPrint('Added ${item.productName} to cart');
    }
  }

  /// Clear all items from cart
  /// FR-23.4: clearCart() - empty the entire cart
  void clearCart() {
    _items.clear();
    notifyListeners(); // FR-23: Notify listeners after state change
    debugPrint('Cart cleared');
  }

  /// Reset cart to mock data (useful for testing)
  void resetToMockData() {
    _initializeMockData();
    notifyListeners();
    debugPrint('Cart reset to mock data');
  }
}