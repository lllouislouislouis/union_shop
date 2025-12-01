class SaleProduct {
  final String id;
  final String title;
  final double originalPrice;
  final double salePrice;
  final String imageUrl;
  final String category;
  final DateTime saleEndDate;

  SaleProduct({
    required this.id,
    required this.title,
    required this.originalPrice,
    required this.salePrice,
    required this.imageUrl,
    required this.category,
    required this.saleEndDate,
  });

  // Computed property for discount percentage
  int get discountPercentage {
    if (originalPrice == 0) return 0;
    return (((originalPrice - salePrice) / originalPrice) * 100).round();
  }
}

// Mock data - 15 products across 3 categories
final List<SaleProduct> mockSaleProducts = [
  // Clothing Category (5 products)
  SaleProduct(
    id: 'sale_001',
    title: 'PSUT Hoodie - Purple Edition',
    originalPrice: 35.00,
    salePrice: 24.99,
    imageUrl: 'assets/products/hoodie_purple.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 7)),
  ),
  SaleProduct(
    id: 'sale_002',
    title: 'Union Shop T-Shirt Classic',
    originalPrice: 15.00,
    salePrice: 9.99,
    imageUrl: 'assets/products/tshirt_classic.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 5)),
  ),
  SaleProduct(
    id: 'sale_003',
    title: 'Campus Crew Neck Sweatshirt',
    originalPrice: 28.00,
    salePrice: 19.99,
    imageUrl: 'assets/products/sweatshirt.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 10)),
  ),
  SaleProduct(
    id: 'sale_004',
    title: 'University Track Jacket',
    originalPrice: 42.00,
    salePrice: 29.99,
    imageUrl: 'assets/products/track_jacket.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 3)),
  ),
  SaleProduct(
    id: 'sale_005',
    title: 'PSUT Baseball Cap',
    originalPrice: 12.00,
    salePrice: 7.99,
    imageUrl: 'assets/products/baseball_cap.jpg',
    category: 'Clothing',
    saleEndDate: DateTime.now().add(const Duration(days: 14)),
  ),

  // Merchandise Category (5 products)
  SaleProduct(
    id: 'sale_006',
    title: 'Union Shop Water Bottle - Insulated',
    originalPrice: 18.00,
    salePrice: 12.99,
    imageUrl: 'assets/products/water_bottle.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 7)),
  ),
  SaleProduct(
    id: 'sale_007',
    title: 'Campus Tote Bag - Large',
    originalPrice: 14.00,
    salePrice: 8.99,
    imageUrl: 'assets/products/tote_bag.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 12)),
  ),
  SaleProduct(
    id: 'sale_008',
    title: 'University Notebook Set (3-Pack)',
    originalPrice: 10.00,
    salePrice: 5.99,
    imageUrl: 'assets/products/notebook_set.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 6)),
  ),
  SaleProduct(
    id: 'sale_009',
    title: 'PSUT Coffee Mug - Ceramic',
    originalPrice: 9.00,
    salePrice: 5.99,
    imageUrl: 'assets/products/coffee_mug.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 9)),
  ),
  SaleProduct(
    id: 'sale_010',
    title: 'Union Shop Backpack - Classic',
    originalPrice: 45.00,
    salePrice: 32.99,
    imageUrl: 'assets/products/backpack.jpg',
    category: 'Merchandise',
    saleEndDate: DateTime.now().add(const Duration(days: 8)),
  ),

  // PSUT Category (5 products)
  SaleProduct(
    id: 'sale_011',
    title: 'PSUT Pin Badge Collection',
    originalPrice: 8.00,
    salePrice: 4.99,
    imageUrl: 'assets/products/pin_badges.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 15)),
  ),
  SaleProduct(
    id: 'sale_012',
    title: 'University Lanyard - Premium',
    originalPrice: 6.00,
    salePrice: 3.99,
    imageUrl: 'assets/products/lanyard.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 11)),
  ),
  SaleProduct(
    id: 'sale_013',
    title: 'PSUT Sticker Pack (10 Designs)',
    originalPrice: 5.00,
    salePrice: 2.99,
    imageUrl: 'assets/products/sticker_pack.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 4)),
  ),
  SaleProduct(
    id: 'sale_014',
    title: 'Campus Map Poster - Framed',
    originalPrice: 22.00,
    salePrice: 14.99,
    imageUrl: 'assets/products/campus_poster.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 13)),
  ),
  SaleProduct(
    id: 'sale_015',
    title: 'PSUT Pennant Flag - Large',
    originalPrice: 16.00,
    salePrice: 10.99,
    imageUrl: 'assets/products/pennant_flag.jpg',
    category: 'PSUT',
    saleEndDate: DateTime.now().add(const Duration(days: 7)),
  ),
];
