import 'package:flutter/material.dart';

// Menu item model for dropdown/submenu items
class MenuItem {
  final String label;
  final String route;

  const MenuItem({
    required this.label,
    required this.route,
  });

  // Check if this item is active based on current route
  bool isActive(String currentRoute) {
    return currentRoute == route;
  }
}

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

  // Shop category menu items
  static const List<MenuItem> shopMenuItems = [
    MenuItem(label: 'Clothing', route: '/shop/clothing'),
    MenuItem(label: 'Merchandise', route: '/shop/merchandise'),
    MenuItem(label: 'Halloween', route: '/shop/halloween'),
    MenuItem(
      label: 'Signature & Essential Range',
      route: '/shop/signature-essential',
    ),
    MenuItem(
      label: 'Portsmouth City Collection',
      route: '/shop/portsmouth',
    ),
    MenuItem(label: 'Pride Collection', route: '/shop/pride'),
    MenuItem(label: 'Graduation', route: '/shop/graduation'),
  ];

  // Print Shack menu items
  static const List<MenuItem> printShackMenuItems = [
    MenuItem(label: 'About', route: '/print-shack/about'),
    MenuItem(label: 'Personalisation', route: '/print-shack/personalisation'),
  ];

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  // Track whether the mobile menu is open
  bool _isMobileMenuOpen = false;

  // Dropdown state management (FR-1.1)
  bool _isShopDropdownOpen = false;
  bool _isPrintShackDropdownOpen = false;
  bool _isMobileSubmenuOpen = false;
  String _currentSubmenu = ''; // Values: '', 'shop', 'printshack'

  // GlobalKeys to track button positions
  final GlobalKey _shopButtonKey = GlobalKey();
  final GlobalKey _printShackButtonKey = GlobalKey();
  OverlayEntry? _shopOverlayEntry;
  OverlayEntry? _printOverlayEntry;

  @override
  void dispose() {
    _removeDropdownOverlays();
    super.dispose();
  }

  void _removeDropdownOverlays() {
    _shopOverlayEntry?.remove();
    _shopOverlayEntry = null;
    _printOverlayEntry?.remove();
    _printOverlayEntry = null;
  }

  void _showShopDropdownOverlay(Rect buttonRect) {
    _shopOverlayEntry?.remove();
    _shopOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeAllDropdowns,
            ),
          ),
          Positioned(
            top: buttonRect.bottom,
            left: buttonRect.left,
            child: Material(
              elevation: 8,
              child: _buildDesktopDropdown(AppHeader.shopMenuItems, true)!,
            ),
          ),
        ],
      ),
    );
    final overlay =
        Navigator.of(context).overlay ?? Overlay.of(context, rootOverlay: true);
    overlay.insert(_shopOverlayEntry!);
  }

  void _showPrintDropdownOverlay(Rect buttonRect) {
    _printOverlayEntry?.remove();
    _printOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeAllDropdowns,
            ),
          ),
          Positioned(
            top: buttonRect.bottom,
            left: buttonRect.left,
            child: Material(
              elevation: 8,
              child:
                  _buildDesktopDropdown(AppHeader.printShackMenuItems, true)!,
            ),
          ),
        ],
      ),
    );
    final overlay =
        Navigator.of(context).overlay ?? Overlay.of(context, rootOverlay: true);
    overlay.insert(_printOverlayEntry!);
  }

  // Navigation helper methods
  void navigateToHome(BuildContext context) {
    _closeMobileMenu();
    _closeAllDropdowns();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToAbout(BuildContext context) {
    _closeMobileMenu();
    _closeAllDropdowns();
    Navigator.pushNamed(context, '/about');
  }

  void navigateToProduct(BuildContext context) {
    _closeMobileMenu();
    _closeAllDropdowns();
    Navigator.pushNamed(context, '/product');
  }

  void navigateToSale(BuildContext context) {
    _closeMobileMenu();
    _closeAllDropdowns();
    Navigator.pushNamed(context, '/sale');
  }

  void placeholderCallbackForButtons() {
    _closeMobileMenu();
    _closeAllDropdowns();
  }

  // Toggle mobile menu
  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
    });
  }

  // Dropdown state management methods (FR-1.2)
  /// Toggle Shop dropdown - closes Print Shack dropdown if open
  void _toggleShopDropdown() {
    setState(() {
      final willOpen = !_isShopDropdownOpen;
      _isShopDropdownOpen = willOpen;
      _isPrintShackDropdownOpen = false;
    });
    _printOverlayEntry?.remove();
    if (_isShopDropdownOpen) {
      final rect = _getButtonRect(_shopButtonKey);
      if (rect != null) _showShopDropdownOverlay(rect);
    } else {
      _shopOverlayEntry?.remove();
      _shopOverlayEntry = null;
    }
  }

  /// Toggle Print Shack dropdown - closes Shop dropdown if open
  void _togglePrintShackDropdown() {
    setState(() {
      final willOpen = !_isPrintShackDropdownOpen;
      _isPrintShackDropdownOpen = willOpen;
      _isShopDropdownOpen = false;
    });
    _shopOverlayEntry?.remove();
    if (_isPrintShackDropdownOpen) {
      final rect = _getButtonRect(_printShackButtonKey);
      if (rect != null) _showPrintDropdownOverlay(rect);
    } else {
      _printOverlayEntry?.remove();
      _printOverlayEntry = null;
    }
  }

  /// Close all dropdowns (desktop)
  void _closeAllDropdowns() {
    if (_isShopDropdownOpen || _isPrintShackDropdownOpen) {
      setState(() {
        _isShopDropdownOpen = false;
        _isPrintShackDropdownOpen = false;
      });
      _removeDropdownOverlays();
    }
  }

  /// Open mobile submenu - closes main menu and opens submenu (FR-1.4)
  void _openMobileSubmenu(String submenu) {
    setState(() {
      _currentSubmenu = submenu;
      _isMobileSubmenuOpen = true;
      // Keep mobile menu open, submenu will slide over it
    });
  }

  /// Close mobile submenu - returns to main mobile menu (FR-1.4)
  void _closeMobileSubmenu() {
    if (_isMobileSubmenuOpen) {
      setState(() {
        _isMobileSubmenuOpen = false;
        _currentSubmenu = '';
      });
    }
  }

  // Update _closeMobileMenu to also close submenus (FR-1.5)
  void _closeMobileMenu() {
    if (_isMobileMenuOpen || _isMobileSubmenuOpen) {
      setState(() {
        _isMobileMenuOpen = false;
        _isMobileSubmenuOpen = false;
        _currentSubmenu = '';
      });
    }
  }

  // Get button position and size
  Rect? _getButtonRect(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final pos = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    return Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      // Logo section
                      InkWell(
                        onTap: () => navigateToHome(context),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4d2963),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'US',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Union Shop',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4d2963),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Desktop Navigation
                      if (isDesktop) ...[
                        _buildNavButton(
                          'Home',
                          () => navigateToHome(context),
                          widget.currentRoute == '/',
                        ),
                        // Shop button with key
                        Container(
                          key: _shopButtonKey,
                          child: _buildNavButton(
                            'Shop ⏷',
                            _toggleShopDropdown,
                            widget.currentRoute.startsWith('/shop/'),
                          ),
                        ),
                        // Print Shack button with key
                        Container(
                          key: _printShackButtonKey,
                          child: _buildNavButton(
                            'The Print Shack ⏷',
                            _togglePrintShackDropdown,
                            widget.currentRoute.startsWith('/print-shack/'),
                          ),
                        ),
                        _buildNavButton(
                          'SALE!',
                          () => navigateToSale(context),
                          widget.currentRoute == '/sale',
                        ),
                        _buildNavButton(
                          'About',
                          () => navigateToAbout(context),
                          widget.currentRoute == '/about',
                        ),
                      ],

                      const Spacer(),

                      // Right side icons
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: placeholderCallbackForButtons,
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_outline),
                        onPressed: placeholderCallbackForButtons,
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: placeholderCallbackForButtons,
                      ),

                      // Mobile menu button
                      if (!isDesktop)
                        IconButton(
                          icon: Icon(
                            _isMobileMenuOpen ? Icons.close : Icons.menu,
                          ),
                          onPressed: _toggleMobileMenu,
                        ),

                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mobile menu with slide animation (FR-15)
          if (!isDesktop && _isMobileMenuOpen)
            Material(
              elevation: 8,
              child: Container(
                color: Colors.white,
                child: ClipRect(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      // Slide from right when opening submenu, slide from left when closing
                      final inFromRight =
                          child.key == const ValueKey('submenu');
                      final offsetAnimation = Tween<Offset>(
                        begin: Offset(inFromRight ? 1.0 : -1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ));

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    child: _isMobileSubmenuOpen
                        ? _buildMobileSubmenu()
                        : _buildMainMobileMenu(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Main mobile menu (FR-15.1)
  Widget _buildMainMobileMenu() {
    return Container(
      key: const ValueKey('main'),
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
            () => _openMobileSubmenu('shop'),
            widget.currentRoute.startsWith('/shop/'),
          ),
          _buildMobileMenuItem(
            'The Print Shack',
            () => _openMobileSubmenu('printshack'),
            widget.currentRoute.startsWith('/print-shack/'),
          ),
          _buildMobileMenuItem(
            'SALE!',
            () => navigateToSale(context),
            widget.currentRoute == '/sale',
          ),
          _buildMobileMenuItem(
            'About',
            () => navigateToAbout(context),
            widget.currentRoute == '/about',
          ),
        ],
      ),
    );
  }

  // Mobile submenu (FR-15.2)
  Widget _buildMobileSubmenu() {
    // Determine which submenu to show
    final items = _currentSubmenu == 'shop'
        ? AppHeader.shopMenuItems
        : AppHeader.printShackMenuItems;

    final title = _currentSubmenu == 'shop' ? 'Shop' : 'The Print Shack';

    return Container(
      key: const ValueKey('submenu'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Back button header (FR-15.3)
          InkWell(
            onTap: _closeMobileSubmenu,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF4d2963).withValues(alpha: 0.05),
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF4d2963),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Submenu items (FR-15.4)
          ...items.map((item) {
            return _buildMobileSubmenuItem(
              item: item,
              isActive: item.isActive(widget.currentRoute),
            );
          }),
        ],
      ),
    );
  }

  // Helper method to build mobile submenu items (FR-15.5)
  Widget _buildMobileSubmenuItem({
    required MenuItem item,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        _closeMobileMenu();
        Navigator.pushNamed(context, item.route);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Text(
          item.label,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? const Color(0xFF4d2963) : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to build navigation buttons
  Widget _buildNavButton(String label, VoidCallback onPressed, bool isActive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isActive ? const Color(0xFF4d2963) : Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to build mobile menu items
  Widget _buildMobileMenuItem(String label, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? const Color(0xFF4d2963) : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to build desktop dropdown menu
  Widget? _buildDesktopDropdown(List<MenuItem> items, bool isOpen) {
    if (!isOpen) return null;

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return _buildDropdownMenuItem(
            item: item,
            isActive: item.isActive(widget.currentRoute),
            isLast: isLast,
          );
        }).toList(),
      ),
    );
  }

  // Helper method to build individual dropdown menu items
  Widget _buildDropdownMenuItem({
    required MenuItem item,
    required bool isActive,
    required bool isLast,
  }) {
    return InkWell(
      onTap: () {
        _closeAllDropdowns();
        _closeMobileMenu();
        Navigator.pushNamed(context, item.route);
      },
      hoverColor: const Color(0xFF4d2963).withValues(alpha: 0.1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isActive ? const Color(0xFF4d2963).withValues(alpha: 0.05) : null,
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: Colors.grey[200]!),
                ),
        ),
        child: Text(
          item.label,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? const Color(0xFF4d2963) : Colors.grey[800],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
