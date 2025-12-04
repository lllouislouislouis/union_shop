/// Base Product model with common fields across all categories
class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
  final DateTime dateAdded;
  final double? popularity; // Numeric value for popularity sorting
  final bool isNew;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.dateAdded,
    this.popularity,
    this.isNew = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
