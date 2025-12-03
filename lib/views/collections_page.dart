import 'package:flutter/material.dart';
import 'package:union_shop/models/collection_item.dart';
import 'package:union_shop/views/shop_category_page.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

// FR-3.2: Sample collection items
const List<CollectionItem> kCollectionItems = [
  CollectionItem(
    slug: 'clothing',
    title: 'Clothing',
    description: 'Official university apparel and fashion',
    imagePath: 'assets/images/collections/clothing.jpg',
  ),
  CollectionItem(
    slug: 'merchandise',
    title: 'Merchandise',
    description: 'Gifts, accessories, and branded items',
    imagePath: 'assets/images/collections/merchandise.jpg',
  ),
  CollectionItem(
    slug: 'graduation',
    title: 'Graduation',
    description: 'Gowns, hoods, and ceremony essentials',
    imagePath: 'assets/images/collections/graduation.jpg',
  ),
  CollectionItem(
    slug: 'personalisation',
    title: 'Personalisation',
    description: 'Custom embroidery and printing services',
    imagePath: 'assets/images/collections/personalisation.jpg',
    route: '/print-shack/personalisation',
  ),
  CollectionItem(
    slug: 'print-shack',
    title: 'Print Shack',
    description: 'Professional printing and design services',
    imagePath: 'assets/images/collections/print_shack.jpg',
    route: '/print-shack/about',
  ),
  CollectionItem(
    slug: 'portsmouth',
    title: 'Portsmouth',
    description: 'City-themed merchandise and souvenirs',
    imagePath: 'assets/images/collections/portsmouth.jpg',
  ),
  CollectionItem(
    slug: 'pride',
    title: 'Pride',
    description: 'Inclusive and celebratory collection',
    imagePath: 'assets/images/collections/pride.jpg',
  ),
  CollectionItem(
    slug: 'stationery',
    title: 'Stationery',
    description: 'Notebooks, pens, and study essentials',
    imagePath: 'assets/images/collections/stationery.jpg',
  ),
  CollectionItem(
    slug: 'sports',
    title: 'Sports',
    description: 'Athletic wear and team merchandise',
    imagePath: 'assets/images/collections/sports.jpg',
  ),
];

/// CollectionsPage
/// Displays a responsive grid of collection items.
/// - > 800px width => 3 columns
/// - <= 800px => 1 column
class CollectionsPage extends StatelessWidget {
  static const double _breakpoint = 800;
  static const double _padding = 24;
  static const double _spacing = 16;
  static const double _childAspectRatio = 4 / 3;

  final List<CollectionItem> items;

  const CollectionsPage({
    super.key,
    required this.items,
  });

  // FR-4.1, AC-7: Navigate to collection view
  void _navigateToCollection(BuildContext context, CollectionItem item) {
    // Try to use the resolved route (either explicit or default '/collections/<slug>')
    final route = item.resolvedRoute;

    // Check if the route exists in named routes by attempting navigation
    // If it fails, fall back to ShopCategoryPage
    try {
      Navigator.pushNamed(context, route).catchError((_) {
        // FR-4.2, AC-7: Fallback to ShopCategoryPage if route doesn't exist
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShopCategoryPage(category: item.slug),
          ),
        );
      });
    } catch (e) {
      // If pushNamed throws immediately, use fallback
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ShopCategoryPage(category: item.slug),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width > _breakpoint ? 3 : 1;

    return AppScaffold(
      currentRoute: '/collections',
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: GridView.builder(
          key: const Key('collections_grid'),
          // FR: Disable GridView's own scrolling since AppScaffold handles it
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: _spacing,
            mainAxisSpacing: _spacing,
            childAspectRatio: _childAspectRatio,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CollectionTile(
              key: Key('collection_tile_${item.slug}'),
              item: item,
              onTap: () => _navigateToCollection(context, item), // AC-7
            );
          },
        ),
      ),
    );
  }
}

/// CollectionTile
/// An accessible, interactive tile displaying a collection image and title.
/// Supports tap, keyboard activation (Enter/Space), and hover effects.
class CollectionTile extends StatefulWidget {
  final CollectionItem item;
  final VoidCallback onTap;

  const CollectionTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  bool _isHovering = false;
  bool _isFocused = false;

  void _handleActivation() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Open ${widget.item.title} collection',
      button: true,
      enabled: true,
      child: Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
        },
        child: Builder(
          builder: (context) {
            return MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: _isHovering || _isFocused
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleActivation,
                          focusNode: FocusNode(skipTraversal: false),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Background image with fallback
                              Image.asset(
                                widget.item.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Gradient overlay for contrast
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.7),
                                    ],
                                    stops: const [0.5, 1.0],
                                  ),
                                ),
                              ),
                              // Title overlay
                              Positioned(
                                left: 12,
                                right: 12,
                                bottom: 12,
                                child: Text(
                                  widget.item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 3,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Focus indicator
                              if (_isFocused)
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
