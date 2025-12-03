import 'package:flutter/material.dart';
import 'package:union_shop/models/collection_item.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

/// CollectionsPage
/// Displays a responsive grid of collection items.
/// - > 800px width => 3 columns
/// - <= 800px => 1 column
///
/// Note: This version uses a simple placeholder tile for layout verification.
/// The interactive, accessible CollectionTile will be implemented in the next subtask.
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width > _breakpoint ? 3 : 1;

    return AppScaffold(
      currentRoute: '/collections',
      child: GridView.builder(
        key: const Key('collections_grid'),
        padding: const EdgeInsets.all(_padding),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: _spacing,
          mainAxisSpacing: _spacing,
          childAspectRatio: _childAspectRatio,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _PlaceholderCollectionTile(
            key: Key('collection_tile_${item.slug}'),
            title: item.title,
          );
        },
      ),
    );
  }
}

/// Temporary placeholder tile used only to validate grid layout in this subtask.
/// Will be replaced by the accessible, interactive CollectionTile widget.
class _PlaceholderCollectionTile extends StatelessWidget {
  final String title;

  const _PlaceholderCollectionTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Simple neutral background for now (image + overlay will come later).
          Container(color: Colors.grey.shade200),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
