/// Data model representing a single carousel slide
/// Contains all content needed to render the slide: background image,
/// heading text, button label, and navigation route
class CarouselSlide {
  /// Path to background image asset (e.g., 'assets/images/carousel_collections.jpg')
  final String imagePath;
  
  /// Large heading text displayed on slide (desktop only)
  /// Example: "Browse Our Collections"
  final String heading;
  
  /// Call-to-action button label (desktop only)
  /// Example: "EXPLORE"
  final String buttonLabel;
  
  /// Route to navigate when button clicked
  /// Example: "/collections"
  final String buttonRoute;

  const CarouselSlide({
    required this.imagePath,
    required this.heading,
    required this.buttonLabel,
    required this.buttonRoute,
  });
}