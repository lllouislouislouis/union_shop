/// Product model for displaying detailed product information on ProductPage.
/// Extends beyond SaleProduct to include customization options (colors, sizes).
class Product {
  final String id;
  final String title;
  final double price;
  final double? originalPrice; // Null if not on sale
  final String imageUrl;
  final List<String> availableColors;
  final List<String> availableSizes;
  final String description;
  final int maxStock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.availableColors = const [],
    this.availableSizes = const [],
    required this.description,
    this.maxStock = 10,
  });

  /// Computed property for discount percentage (only if on sale)
  int get discountPercentage {
    if (originalPrice == null || originalPrice == 0) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }

  /// Check if product is on sale
  bool get isOnSale => originalPrice != null && originalPrice! > price;

  /// Check if product requires color selection
  bool get requiresColorSelection => availableColors.isNotEmpty;

  /// Check if product requires size selection
  bool get requiresSizeSelection => availableSizes.isNotEmpty;
}

// Mock data - Example products with customization options
final List<Product> mockProducts = [
  // Example 1: Clothing item with color and size options
  Product(
    id: 'prod_001',
    title: 'PSUT Premium Hoodie',
    price: 24.99,
    originalPrice: 35.00,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    availableColors: ['Purple', 'Black', 'White', 'Navy'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    description:
        'Comfortable and stylish PSUT hoodie made from premium cotton blend. Perfect for campus life.\n\nFeatures:\n- Premium quality fabric\n- Drawstring hood\n- Kangaroo pocket\n- Embroidered PSUT logo\n\nCare: Machine wash cold, tumble dry low.',
    maxStock: 50,
  ),
  // Example 2: Clothing item with size only
  Product(
    id: 'prod_002',
    title: 'Union Shop Classic T-Shirt',
    price: 9.99,
    originalPrice: 15.00,
    imageUrl: 'assets/images/tshirt_classic.jpg',
    availableColors: [],
    availableSizes: ['S', 'M', 'L', 'XL'],
    description:
        'Classic white t-shirt with Union Shop logo.\n\nFeatures:\n- 100% organic cotton\n- Crew neck\n- Short sleeves\n- Durable print\n\nCare: Machine wash warm, hang dry.',
    maxStock: 100,
  ),
  // Example 3: Non-customizable merchandise
  Product(
    id: 'prod_003',
    title: 'Union Shop Water Bottle',
    price: 12.99,
    originalPrice: 18.00,
    imageUrl: 'assets/images/water_bottle.jpg',
    availableColors: [],
    availableSizes: [],
    description:
        'Insulated stainless steel water bottle with Union Shop branding.\n\nFeatures:\n- 500ml capacity\n- Double-wall insulated\n- Keeps drinks cold for 24 hours\n- Stainless steel construction\n- Carry handle\n\nCare: Hand wash only.',
    maxStock: 75,
  ),
];
