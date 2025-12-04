import 'package:union_shop/models/product.dart';

/// Featured products displayed on the homepage
/// 
/// This list contains 4 curated products representing different categories:
/// 1. Clothing item (hoodie with color and size options)
/// 2. Merchandise item (mug)
/// 3. Sale item (t-shirt with discount)
/// 4. Signature item (tote bag)
final List<Product> kFeaturedProducts = [
  // Product 1: Clothing - Portsmouth University Hoodie
  Product(
    id: 'clothing-hoodie-purple-001',
    title: 'Portsmouth University Hoodie',
    price: 35.00,
    imageUrl: 'assets/images/hoodie_purple.jpg',
    availableColors: const ['Purple', 'Black', 'Navy'],
    availableSizes: const ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    description:
        'Stay warm and stylish with our classic Portsmouth University hoodie. Made from premium cotton blend fabric with embroidered logo.\n\n'
        'Features:\n'
        '- Premium quality cotton blend\n'
        '- Drawstring hood\n'
        '- Kangaroo pocket\n'
        '- Embroidered Portsmouth logo\n'
        '- Ribbed cuffs and hem\n\n'
        'Care: Machine wash cold, tumble dry low.',
    maxStock: 15,
  ),

  // Product 2: Merchandise - Portsmouth City Mug
  Product(
    id: 'merch-mug-portsmouth-001',
    title: 'Portsmouth City Mug',
    price: 8.99,
    imageUrl: 'assets/images/PortsmouthCityMagnet1.jpg',
    availableColors: ['White'],
    availableSizes: [],
    description:
        'Enjoy your morning coffee in style with our Portsmouth City mug. Features iconic Portsmouth landmarks and vibrant colors.\n\n'
        'Features:\n'
        '- Ceramic construction\n'
        '- 330ml capacity\n'
        '- Dishwasher safe\n'
        '- Microwave safe\n'
        '- Vibrant printed design\n\n'
        'Perfect gift for Portsmouth students and alumni.',
    maxStock: 50,
  ),

  // Product 3: Sale Item - Signature Portsmouth T-Shirt
  Product(
    id: 'clothing-tshirt-signature-sale',
    title: 'Signature Portsmouth T-Shirt',
    price: 12.99,
    originalPrice: 18.99,
    imageUrl: 'assets/images/tshirt_signature.jpg',
    availableColors: ['Purple', 'White', 'Black'],
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
    description:
        'Classic Portsmouth University t-shirt with signature logo. Now on sale!\n\n'
        'Features:\n'
        '- 100% cotton fabric\n'
        '- Crew neck design\n'
        '- Short sleeves\n'
        '- Screen-printed logo\n'
        '- Pre-shrunk for perfect fit\n\n'
        'Save 32% - Limited time offer!\n\n'
        'Care: Machine wash warm, tumble dry low.',
    maxStock: 25,
  ),

  // Product 4: Signature Item - Portsmouth University Tote Bag
  Product(
    id: 'merch-tote-bag-001',
    title: 'Portsmouth University Tote Bag',
    price: 9.99,
    imageUrl: 'assets/images/tote_bag.jpg',
    availableColors: ['Natural', 'Purple'],
    availableSizes: [],
    description:
        'Eco-friendly cotton tote bag perfect for carrying books, groceries, or gym gear. Features embroidered Portsmouth logo.\n\n'
        'Features:\n'
        '- 100% organic cotton\n'
        '- Sturdy reinforced handles\n'
        '- Large capacity (38cm x 42cm)\n'
        '- Embroidered Portsmouth branding\n'
        '- Reusable and sustainable\n\n'
        'Care: Machine wash cold, air dry flat.',
    maxStock: 30,
  ),
];