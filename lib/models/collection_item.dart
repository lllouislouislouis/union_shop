/// Model representing a collection tile on the Collections page.
class CollectionItem {
  /// URL-safe identifier for the collection (e.g., "clothing", "graduation").
  final String slug;

  /// Display name for the collection (e.g., "Clothing").
  final String title;

  /// Optional short description (one line).
  final String? description;

  /// Asset path for the collection image.
  final String imagePath;

  /// Optional explicit route; if null, defaults to '/collections/<slug>'.
  final String? route;

  const CollectionItem({
    required this.slug,
    required this.title,
    required this.imagePath,
    this.description,
    this.route,
  });

  /// Returns the navigation route for this collection.
  /// Defaults to '/collections/<slug>' when [route] is not provided.
  String get resolvedRoute => route ?? '/collections/$slug';

  @override
  String toString() => 'CollectionItem(slug: $slug, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionItem &&
          runtimeType == other.runtimeType &&
          slug == other.slug &&
          title == other.title &&
          description == other.description &&
          imagePath == other.imagePath &&
          route == other.route;

  @override
  int get hashCode =>
      slug.hashCode ^
      title.hashCode ^
      (description?.hashCode ?? 0) ^
      imagePath.hashCode ^
      (route?.hashCode ?? 0);
}