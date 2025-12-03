import 'package:flutter/material.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/sale_page.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/views/shop_category_page.dart';
import 'package:union_shop/views/print_shack_about_page.dart';
import 'package:union_shop/views/personalisation_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // Define all application routes
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/sale': (context) => const SalePage(),

        // Shop category routes (FR-16)
        '/shop/clothing': (context) =>
            const ShopCategoryPage(category: 'clothing'),
        '/shop/merchandise': (context) =>
            const ShopCategoryPage(category: 'merchandise'),
        '/shop/halloween': (context) =>
            const ShopCategoryPage(category: 'halloween'),
        '/shop/signature-essential': (context) =>
            const ShopCategoryPage(category: 'signature-essential'),
        '/shop/portsmouth': (context) =>
            const ShopCategoryPage(category: 'portsmouth'),
        '/shop/pride': (context) => const ShopCategoryPage(category: 'pride'),
        '/shop/graduation': (context) =>
            const ShopCategoryPage(category: 'graduation'),

        // Print Shack routes (FR-17)
        '/print-shack/about': (context) => const PrintShackAboutPage(),
        '/print-shack/personalisation': (context) =>
            const PersonalisationPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // MODIFIED: Added mixin
  // Carousel state - define 4 slides with content (FR-1.2, FR-1.3)
  late final List<CarouselSlide> _carouselSlides;

  // NEW: Auto-play state management (FR-2)
  int _currentSlide = 0; // FR-2.3: Track current slide index (0-3)
  bool _isAutoPlayEnabled = true; // FR-2.6: Control auto-play on/off
  late AnimationController _autoPlayController; // FR-2.1: Animation-based timer

  @override
  void initState() {
    super.initState();

    // Initialize carousel slides (FR-1.4: immutable after initialization)
    _carouselSlides = const [
      // Slide 1: Collections
      CarouselSlide(
        imagePath: 'assets/images/carousel_collections.jpg',
        heading: 'Browse Our Collections',
        buttonLabel: 'EXPLORE',
        buttonRoute: '/collections',
      ),
      // Slide 2: Print Shack
      CarouselSlide(
        imagePath: 'assets/images/carousel_printshack.jpg',
        heading: 'The Print Shack',
        buttonLabel: 'GET PERSONALISED',
        buttonRoute: '/print-shack/about',
      ),
      // Slide 3: Sale
      CarouselSlide(
        imagePath: 'assets/images/carousel_sale.jpg',
        heading: 'Big Sale On Now!',
        buttonLabel: 'SHOP SALE',
        buttonRoute: '/sale',
      ),
      // Slide 4: About
      CarouselSlide(
        imagePath: 'assets/images/carousel_about.jpg',
        heading: 'About Union Shop',
        buttonLabel: 'LEARN MORE',
        buttonRoute: '/about',
      ),
    ];

    // FR-2.1, FR-2.2: Initialize auto-play controller with 5-second duration
    _autoPlayController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // FR-2.3, FR-2.4: Listen for animation completion to advance slides
    _autoPlayController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_isAutoPlayEnabled) {
          setState(() {
            // Loop to slide 0 after slide 3 using modulo
            _currentSlide = (_currentSlide + 1) % _carouselSlides.length;
          });
          // Restart timer for next slide
          _autoPlayController.reset();
          _autoPlayController.forward();
        }
      }
    });

    // FR-2.2: Start auto-play immediately
    _autoPlayController.forward();
  }

  @override
  void dispose() {
    // FR-2.5: Clean up controller to prevent memory leaks
    _autoPlayController.dispose();
    super.dispose();
  }

  // FR-2.7: Restart timer when user manually changes slide
  void _restartAutoPlayTimer() {
    if (_isAutoPlayEnabled) {
      _autoPlayController.reset();
      _autoPlayController.forward();
    }
  }

  // Helper method to change to specific slide
  void _goToSlide(int index) {
    setState(() {
      _currentSlide = index;
    });
    _restartAutoPlayTimer();
  }

  // Helper method to go to next slide
  void _nextSlide() {
    setState(() {
      _currentSlide = (_currentSlide + 1) % _carouselSlides.length;
    });
    _restartAutoPlayTimer();
  }

  // Helper method to go to previous slide
  void _previousSlide() {
    setState(() {
      _currentSlide =
          (_currentSlide - 1 + _carouselSlides.length) % _carouselSlides.length;
    });
    _restartAutoPlayTimer();
  }

  // Toggle auto-play on/off
  void _toggleAutoPlay() {
    setState(() {
      _isAutoPlayEnabled = !_isAutoPlayEnabled;
      if (_isAutoPlayEnabled) {
        // Resume auto-play
        _autoPlayController.forward();
      } else {
        // Pause auto-play
        _autoPlayController.stop();
      }
    });
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                // Header - Now using reusable AppHeader component
                const AppHeader(currentRoute: '/'),

                // Hero Section
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/PortsmouthCityPostcard2.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ),
                      // Content overlay
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Placeholder Hero Title',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is placeholder text for the hero section.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: placeholderCallbackForButtons,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: const Text(
                                'SHOP NOW',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // NEW: Carousel Section (FR-1.1)
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      // Carousel header
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF4d2963),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        child: const Text(
                          'Welcome to Union Shop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Carousel slider (FR-1.5)
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: _carouselSlides.length,
                          itemBuilder: (context, index) {
                            final slide = _carouselSlides[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the route defined in the slide
                                Navigator.pushNamed(context, slide.buttonRoute);
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // Slide image
                                  Image.asset(
                                    slide.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported,
                                              color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                  // Gradient overlay
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.black.withOpacity(0.3),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  // Slide content
                                  Positioned(
                                    left: 24,
                                    right: 24,
                                    top: 40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          slide.heading,
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            height: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigate to the route defined in the slide
                                            Navigator.pushNamed(
                                                context, slide.buttonRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                const Color(0xFF4d2963),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                          ),
                                          child: Text(
                                            slide.buttonLabel,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Products Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Text(
                          'PRODUCTS SECTION',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 48),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: const [
                            ProductCard(
                              title: 'Placeholder Product 1',
                              price: '£10.00',
                              imageUrl:
                                  'assets/images/PortsmouthCityMagnet1.jpg',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 2',
                              price: '£15.00',
                              imageUrl:
                                  'assets/images/PortsmouthCityMagnet1.jpg',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 3',
                              price: '£20.00',
                              imageUrl:
                                  'assets/images/PortsmouthCityMagnet1.jpg',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 4',
                              price: '£25.00',
                              imageUrl:
                                  'assets/images/PortsmouthCityMagnet1.jpg',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                Container(
                  width: double.infinity,
                  color: Colors.grey[50],
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    'Placeholder Footer',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
