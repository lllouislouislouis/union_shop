import 'package:flutter/material.dart';

/// Reusable header component that includes:
/// - Purple banner with sale announcement
/// - Navigation bar with logo, buttons, and utility icons
/// - Responsive mobile menu
/// - Active page highlighting
class AppHeader extends StatefulWidget {
  /// The current route path (e.g., '/', '/about', '/product')
  /// Used to highlight the active navigation button
  final String currentRoute;

  const AppHeader({
    super.key,
    required this.currentRoute,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  // Track whether the mobile menu is open
  bool _isMobileMenuOpen = false;

  // Navigation helper methods
  void navigateToHome(BuildContext context) {
    _closeMobileMenu();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToAbout(BuildContext context) {
    _closeMobileMenu();
    Navigator.pushNamed(context, '/about');
  }

  void navigateToProduct(BuildContext context) {
    _closeMobileMenu();
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
    _closeMobileMenu();
  }

  // Toggle mobile menu
  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
    });
  }

  // Close mobile menu
  void _closeMobileMenu() {
    if (_isMobileMenuOpen) {
      setState(() {
        _isMobileMenuOpen = false;
      });
    }
  }

  // Helper method to build navigation buttons
  // isActive parameter highlights the current page
  Widget _buildNavButton(String label, VoidCallback onPressed, bool isActive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor:
              isActive ? const Color(0xFF4d2963) : Colors.grey[700],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(0xFF4d2963).withValues(alpha: 0.1);
              }
              return null;
            },
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // Helper method to build mobile menu items
  Widget _buildMobileMenuItem(String label, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xFF4d2963).withValues(alpha: 0.1),
      highlightColor: const Color(0xFF4d2963).withValues(alpha: 0.05),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
          color:
              isActive ? const Color(0xFF4d2963).withValues(alpha: 0.05) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.5,
            color: isActive ? const Color(0xFF4d2963) : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive behavior
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          // Header content
          Container(
            height: 100,
            color: Colors.white,
            child: Column(
              children: [
                // Top banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: const Color(0xFF4d2963),
                  child: const Text(
                    'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                // Main header
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        // Logo
                        GestureDetector(
                          onTap: () {
                            _closeMobileMenu();
                            navigateToHome(context);
                          },
                          child: Image.asset(
                            'assets/images/upsu.png',
                            height: 40,
                          ),
                        ),
                        const Spacer(),

                        // Desktop Navigation Buttons (only show on wide screens)
                        if (isDesktop) ...[
                          _buildNavButton(
                            'Home',
                            () => navigateToHome(context),
                            widget.currentRoute == '/',
                          ),
                          _buildNavButton(
                            'Shop',
                            placeholderCallbackForButtons,
                            false,
                          ),
                          _buildNavButton(
                            'The Print Shack',
                            placeholderCallbackForButtons,
                            false,
                          ),
                          _buildNavButton(
                            'SALE!',
                            placeholderCallbackForButtons,
                            false,
                          ),
                          _buildNavButton(
                            'About',
                            () => navigateToAbout(context),
                            widget.currentRoute == '/about',
                          ),
                          const SizedBox(width: 16),
                        ],

                        // Utility Icons (search, profile, cart)
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: placeholderCallbackForButtons,
                          tooltip: 'Search',
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_outline),
                          onPressed: placeholderCallbackForButtons,
                          tooltip: 'Account',
                        ),
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: placeholderCallbackForButtons,
                          tooltip: 'Cart',
                        ),

                        // Mobile Hamburger Menu
                        if (!isDesktop)
                          IconButton(
                            icon: Icon(
                                _isMobileMenuOpen ? Icons.close : Icons.menu),
                            onPressed: _toggleMobileMenu,
                            tooltip: 'Menu',
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Mobile dropdown menu overlay (appears below header)
          if (!isDesktop && _isMobileMenuOpen)
            Positioned(
              top: 100, // Position below the header
              left: 0,
              right: 0,
              child: Material(
                elevation: 8,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMobileMenuItem(
                          'Home',
                          () => navigateToHome(context),
                          widget.currentRoute == '/',
                        ),
                        _buildMobileMenuItem(
                          'Shop',
                          placeholderCallbackForButtons,
                          false,
                        ),
                        _buildMobileMenuItem(
                          'The Print Shack',
                          placeholderCallbackForButtons,
                          false,
                        ),
                        _buildMobileMenuItem(
                          'SALE!',
                          placeholderCallbackForButtons,
                          false,
                        ),
                        _buildMobileMenuItem(
                          'About',
                          () => navigateToAbout(context),
                          widget.currentRoute == '/about',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Overlay to close menu when tapping outside
          if (!isDesktop && _isMobileMenuOpen)
            Positioned.fill(
              top: 100, // Start below header
              child: GestureDetector(
                onTap: _closeMobileMenu,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
