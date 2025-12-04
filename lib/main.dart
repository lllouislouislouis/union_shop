import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:union_shop/models/carousel_slide.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/constants/featured_products.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/sale_page.dart';
import 'package:union_shop/views/shop_category_page.dart';
import 'package:union_shop/views/print_shack_about_page.dart';
import 'package:union_shop/views/personalisation_page.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/views/terms_and_conditions_page.dart';
import 'package:union_shop/widgets/app_scaffold.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/views/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FR-33.1: Wrap MaterialApp with ChangeNotifierProvider<CartProvider>
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Union Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Roboto',
        ),
        home: const HomeScreen(),
        // By default, the app starts at the '/' route, which is the HomeScreen
        initialRoute: '/',
        // Define all application routes
        routes: {
          '/product': (context) => const ProductPage(),
          '/about': (context) => const AboutPage(),
          '/sale': (context) => const SalePage(),

          // NEW FR-14.1: Collections route
          '/collections': (context) => const CollectionsPage(
                items: kCollectionItems,
              ),

          // Shop category routes (FR-16)
          // Clothing page with filters and sorting (matching Sale page exactly)
          '/shop/clothing': (context) => const ShopCategoryPage(
                category: 'clothing',
                enableFiltersAndSort: true,
                filterOptions: [
                  'All Categories',
                  'Clothing',
                  'Merchandise',
                  'PSUT',
                ],
                initialFilter: 'All Categories',
                sortOptions: [
                  'Featured',
                  'Best Selling',
                  'Alphabetically, A-Z',
                  'Alphabetically, Z-A',
                  'Price: Low to High',
                  'Price: High to Low',
                  'Date, old to new',
                  'Date, new to old',
                ],
                initialSort: 'Featured',
              ),
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

          // NEW: Additional collection routes
          '/shop/stationery': (context) =>
              const ShopCategoryPage(category: 'stationery'),
          '/shop/sports': (context) =>
              const ShopCategoryPage(category: 'sports'),

          // Print Shack routes (FR-17)
          '/print-shack/about': (context) => const PrintShackAboutPage(),
          '/print-shack/personalisation': (context) =>
              const PersonalisationPage(),

          // Footer routes (NEW)
          '/search': (context) => const SearchPage(),
          '/policies/terms': (context) => const TermsAndConditionsPage(),

          // NEW FR-22: Login route
          '/login': (context) => const LoginPage(),

          // FR-32.1, FR-32.2: Cart route
          '/cart': (context) => const CartPage(),
        },
      ),
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
  // Carousel state - define 4 slides with content (FR-1.2, FR-1.3)
  late final List<CarouselSlide> _carouselSlides;

  // Auto-play state management (FR-2)
  int _currentSlide = 0; // FR-2.3: Track current slide index (0-3)
  bool _isAutoPlayEnabled = true; // FR-2.6: Control auto-play on/off
  bool _isHovering = false; // NEW FR-10: Track hover state (desktop only)
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
    // FR-10.3: Don't restart if hovering
    if (_isAutoPlayEnabled && !_isHovering) {
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
        // Resume auto-play (but not if hovering)
        if (!_isHovering) {
          _autoPlayController.forward();
        }
      } else {
        // Pause auto-play
        _autoPlayController.stop();
      }
    });
  }

  // FR-10.2: Handle mouse enter (pause auto-play)
  void _onCarouselHoverEnter() {
    setState(() {
      _isHovering = true;
    });
    // Pause auto-play timer while hovering
    _autoPlayController.stop();
  }

  // FR-10.3: Handle mouse exit (resume auto-play)
  void _onCarouselHoverExit() {
    setState(() {
      _isHovering = false;
    });
    // Resume auto-play if enabled
    if (_isAutoPlayEnabled) {
      _autoPlayController.forward();
    }
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/',
      child: Column(
        children: [
          //Hero Carousel Section
          _buildHeroCarousel(),

          // Featured Products Section
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Text(
                    'FEATURED PRODUCTS',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: kFeaturedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: kFeaturedProducts[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FR-3, FR-4, FR-10: Build hero carousel with responsive layout and hover detection
  Widget _buildHeroCarousel() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800; // FR-4.5: Responsive breakpoint
    final currentSlide = _carouselSlides[_currentSlide];

    return MouseRegion(
      // FR-10.1: Wrap carousel in MouseRegion for hover detection
      onEnter: (_) => _onCarouselHoverEnter(), // FR-10.2
      onExit: (_) => _onCarouselHoverExit(), // FR-10.3
      child: SizedBox(
        height: isDesktop ? 500 : 400, // FR-3.1, FR-4.1: Responsive height
        width: double.infinity,
        child: Stack(
          children: [
            // FR-5: AnimatedSwitcher for crossfade transition between slides
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600), // FR-5.2
              switchInCurve: Curves.easeInOut, // FR-5.3
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                // FR-5.5: Use FadeTransition for crossfade effect
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _buildSlideContent(currentSlide, isDesktop),
            ),

            // FR-6, FR-7, FR-8, FR-9: Navigation controls
            _buildCarouselControls(isDesktop),
          ],
        ),
      ),
    );
  }

  // Build individual slide content with responsive layout
  Widget _buildSlideContent(CarouselSlide slide, bool isDesktop) {
    return SizedBox(
      key: ValueKey(_currentSlide), // FR-5.4: Key by index to trigger animation
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // FR-3.3, FR-15.1: Background image
          Image.asset(
            slide.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // FR-15.2, FR-15.3: Error handling for missing images
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey[600],
                  ),
                ),
              );
            },
          ),

          // FR-3.4: Dark overlay (desktop only for text readability)
          if (isDesktop)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),

          // FR-3: Desktop content overlay (text + button)
          // FR-4: Mobile shows image only (no text/button)
          if (isDesktop)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // FR-3.5
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // FR-3.6: Heading text
                  Text(
                    slide.heading,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // FR-3.7, FR-13: CTA Button
                  ElevatedButton(
                    onPressed: () {
                      // FR-13.2: Navigate to slide route
                      _autoPlayController.stop(); // FR-13.3: Stop auto-play
                      Navigator.pushNamed(context, slide.buttonRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963), // FR-13.4
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 48), // FR-3.7
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // FR-13.5
                      ),
                      elevation: 4,
                    ).copyWith(
                      // FR-13.6: Hover effect (desktop)
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.hovered)) {
                            return const Color(0xFF3d1f4d); // 10% darker
                          }
                          return const Color(0xFF4d2963);
                        },
                      ),
                    ),
                    child: Text(
                      slide.buttonLabel,
                      style: const TextStyle(
                        fontSize: 18,
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

  // FR-6, FR-7, FR-8, FR-9: Build navigation controls
  Widget _buildCarouselControls(bool isDesktop) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: isDesktop ? 16 : 12, // FR-3.8, FR-4.4: Responsive bottom spacing
      child: Center(
        child: Container(
          // FR-9.1: Semi-transparent dark background
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(24), // FR-9.3: Fully rounded
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12, // FR-9.2
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FR-6.1, FR-6.2: Previous arrow button
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: _previousSlide, // FR-6.4: Navigate to previous
                tooltip: 'Previous slide',
              ),

              const SizedBox(width: 12), // FR-9.5: Spacing

              // FR-7: Dot indicators
              _buildDotIndicators(),

              const SizedBox(width: 12), // FR-9.5: Spacing

              // FR-6.3, FR-6.4: Next arrow button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: _nextSlide, // FR-6.4: Navigate to next
                tooltip: 'Next slide',
              ),

              const SizedBox(
                  width: 16), // FR-8.4: Extra spacing before pause button

              // FR-8: Pause/Play button with animated icon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200), // FR-8.6
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: IconButton(
                  key: ValueKey(
                      _isAutoPlayEnabled), // Trigger animation on state change
                  icon: Icon(
                    _isAutoPlayEnabled
                        ? Icons.pause // FR-8.1
                        : Icons.play_arrow, // FR-8.2
                    color: Colors.white, // FR-8.3
                    size: 24,
                  ),
                  onPressed: _toggleAutoPlay, // FR-8.5: Toggle auto-play
                  tooltip: _isAutoPlayEnabled ? 'Pause' : 'Play',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FR-7: Build dot indicators for slide navigation
  Widget _buildDotIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        _carouselSlides.length,
        (index) {
          final isActive = index == _currentSlide;
          return GestureDetector(
            onTap: () => _goToSlide(index), // FR-7.5: Jump to clicked slide
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 4), // FR-7.1: 8px total spacing
              width:
                  isActive ? 12 : 8, // FR-7.2, FR-7.3: Active vs inactive size
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(
                  alpha: isActive ? 1.0 : 0.5, // FR-7.2, FR-7.3: Opacity
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnSale = product.isOnSale;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              product.imageUrl,
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
                product.title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              if (isOnSale) ...[
                // Show both original and sale price
                Row(
                  children: [
                    Text(
                      '£${product.originalPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4d2963),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Show regular price only
                Text(
                  '£${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
