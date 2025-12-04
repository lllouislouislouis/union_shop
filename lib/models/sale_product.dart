/// Sale-specific product model extending base Product with sale pricing
class SaleProduct {
  final String id;
  final String title;
  final double originalPrice;
  final double salePrice;
  final String imageUrl;
  final String category;
  final DateTime saleEndDate;

  const SaleProduct({
    required this.id,
    required this.title,
    required this.originalPrice,
    required this.salePrice,
    required this.imageUrl,
    required this.category,
    required this.saleEndDate,
  });

  /// Computed property for discount percentage
  int get discountPercentage {
    if (originalPrice == 0) return 0;
    return (((originalPrice - salePrice) / originalPrice) * 100).round();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleProduct &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Mock data - 15 products across 3 categories
final List<SaleProduct> mockSaleProducts = [
  // Clothing Category (5 products)
  SaleProduct(
    id: 'sale_001',
    title: 'PSUT Hoodie - Purple Edition',
    originalPrice: 35.00,
    salePrice: 24.99,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 15)),
  ),
  SaleProduct(
    id: 'sale_002',
    title: 'PSUT T-Shirt - White Classic',
    originalPrice: 16.99,
    salePrice: 11.99,
    imageUrl: 'assets/images/tshirt_white.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 10)),
  ),
  SaleProduct(
    id: 'sale_003',
    title: 'PSUT Cap - Purple',
    originalPrice: 15.00,
    salePrice: 9.99,
    imageUrl: 'assets/images/cap_purple.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 20)),
  ),
  SaleProduct(
    id: 'sale_004',
    title: 'PSUT Sweatpants - Black',
    originalPrice: 28.00,
    salePrice: 19.99,
    imageUrl: 'assets/images/sweatpants_black.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 12)),
  ),
  SaleProduct(
    id: 'sale_005',
    title: 'PSUT Jacket - Windbreaker',
    originalPrice: 55.00,
    salePrice: 39.99,
    imageUrl: 'assets/images/jacket_windbreaker.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 8)),
  ),

  // Merchandise Category (5 products)
  SaleProduct(
    id: 'sale_006',
    title: 'PSUT Mug - Purple',
    originalPrice: 8.99,
    salePrice: 5.99,
    imageUrl: 'assets/images/mug_purple.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 18)),
  ),
  SaleProduct(
    id: 'sale_007',
    title: 'PSUT Sticker Pack',
    originalPrice: 4.99,
    salePrice: 2.99,
    imageUrl: 'assets/images/sticker_pack.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 25)),
  ),
  SaleProduct(
    id: 'sale_008',
    title: 'PSUT Water Bottle',
    originalPrice: 18.00,
    salePrice: 12.99,
    imageUrl: 'assets/images/water_bottle.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 14)),
  ),
  SaleProduct(
    id: 'sale_009',
    title: 'PSUT Keychain',
    originalPrice: 6.99,
    salePrice: 3.99,
    imageUrl: 'assets/images/keychain.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 22)),
  ),
  SaleProduct(
    id: 'sale_010',
    title: 'PSUT Badge - Set of 5',
    originalPrice: 7.50,
    salePrice: 4.50,
    imageUrl: 'assets/images/badge_set.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 16)),
  ),

  // PSUT Category (5 products)
  SaleProduct(
    id: 'sale_011',
    title: 'PSUT Graduation Gown',
    originalPrice: 120.00,
    salePrice: 89.99,
    imageUrl: 'assets/images/gown.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 30)),
  ),
  SaleProduct(
    id: 'sale_012',
    title: 'PSUT Graduation Hood',
    originalPrice: 45.00,
    salePrice: 32.99,
    imageUrl: 'assets/images/hood.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 30)),
  ),
  SaleProduct(
    id: 'sale_013',
    title: 'PSUT Certificate Frame',
    originalPrice: 25.00,
    salePrice: 17.99,
    imageUrl: 'assets/images/frame.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 28)),
  ),
  SaleProduct(
    id: 'sale_014',
    title: 'PSUT Hoodie - Black Limited Edition',
    originalPrice: 42.00,
    salePrice: 29.99,
    imageUrl: 'assets/images/hoodie_black_limited.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 11)),
  ),
  SaleProduct(
    id: 'sale_015',
    title: 'PSUT Scarf - Purple & White',
    originalPrice: 22.00,
    salePrice: 15.99,
    imageUrl: 'assets/images/scarf.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 19)),
  ),
];
