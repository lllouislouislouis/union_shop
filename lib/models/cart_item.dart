/// Represents a single item in the shopping cart
/// 
/// FR-23.2: Cart item contains product reference, quantity, price, and optional variants
class CartItem {
  /// Unique identifier for the cart item (typically matches product ID)
  final String id;

  /// Name of the product
  final String productName;

  /// URL or asset path to the product image
  final String imageUrl;

  /// Price per unit in GBP
  final double price;

  /// Current quantity of this item in cart (mutable)
  int quantity;

  /// Optional size variant (e.g., "S", "M", "L", "XL")
  final String? size;

  /// Optional color variant (e.g., "Red", "Blue", "Black")
  final String? color;

  CartItem({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.size,
    this.color,
  });

  /// Calculate subtotal for this item (price × quantity)
  /// FR-23.4: Used in cart summary calculations
  double get subtotal => price * quantity;

  /// Format price as currency string (e.g., "£19.99")
  /// FR-30.5: All prices formatted with £ symbol and 2 decimal places
  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  /// Format subtotal as currency string (e.g., "£39.98")
  /// FR-30.5: All prices formatted with £ symbol and 2 decimal places
  String get formattedSubtotal => '£${subtotal.toStringAsFixed(2)}';

  /// Get variant details as a formatted string
  /// Returns null if no variants, otherwise "Size: M, Color: Blue"
  /// FR-27.2: Display variant details in cart item card
  String? get variantDetails {
    final List<String> details = [];
    if (size != null) details.add('Size: $size');
    if (color != null) details.add('Color: $color');
    return details.isEmpty ? null : details.join(', ');
  }

  /// Create a copy of this cart item with updated fields
  /// Useful for immutable state updates
  CartItem copyWith({
    String? id,
    String? productName,
    String? imageUrl,
    double? price,
    int? quantity,
    String? size,
    String? color,
  }) {
    return CartItem(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, name: $productName, quantity: $quantity, price: $formattedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}