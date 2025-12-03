# Collections Page — Feature Implementation Prompt

Goal
- Implement a collections grid for the CollectionsPage that shows a 3xY responsive grid of collection tiles (e.g., Clothing, Merchandise, Graduation, Personalisation, Print Shack, Portsmouth, Pride, etc.).
- Each tile displays an image, a short text label/description, and is tappable/clickable to open that collection page.

UI / Layout Requirements
- Grid: 3 columns on desktop/tablet (width > 800px); 1 column on mobile (≤ 800px). Rows expand as needed (3xY).
- Tile size: keep consistent aspect ratio (e.g., 4:3 or square) with image covering the tile (BoxFit.cover) and a semi-transparent label overlay for readability.
- Spacing: 16px gap between tiles, 24px padding around the grid.
- Tappable target: ensure each tile minimum hit area 44x44 px.
- Accessibility: images must have semantic/alt text; each tile must expose a semantic label like "Open Clothing collection".

Tile Content
- Required fields per tile:
  - id / slug (e.g., "clothing", "merchandise")
  - title (e.g., "Clothing")
  - image asset path (e.g., assets/images/collections/clothing.jpg)
  - optional route (default to '/collections/<slug>' or a common navigator handler)
- Visuals:
  - Title: bold, font size 16–18
  - Image overlay: gradient or dark overlay for contrast

Behavior / Actions
- Tap / Click on tile:
  - Navigate to the collection route for that slug:
    - Preferred route pattern: '/collections/<slug>' (e.g., '/collections/clothing')

Data & Implementation Notes
- Use a static const List<CollectionItem> in collections_page.dart or a small model class:
  - class CollectionItem { final String slug; final String title; final String description; final String imagePath; }
- Generate the grid with GridView.count or SliverGrid.count:
  - crossAxisCount: screenWidth > 800 ? 3 : 1
  - crossAxisSpacing: 16, mainAxisSpacing: 16
  - childAspectRatio to control tile shape
- Each tile widget should:
  - Use InkWell or GestureDetector wrapped in Semantics and FocusableActionDetector to support tap + keyboard.
  - Use Ink.image or Stack with Image.asset and Positioned for label overlay.
  - Provide Semantic label: "Open {title} collection".
  - Ensure minimum size via ConstrainedBox or InkWell padding.

Routing & Navigation
- Preferred: add dynamic route handling for '/collections/:slug' or map known slugs in routes:
  - Add example routes for known slugs (optional) or accept arguments when pushing to '/collections'.
- Example interaction:
  - onTap: Navigator.pushNamed(context, '/shop/$slug') OR Navigator.push(context, MaterialPageRoute(builder: (_) => ShopCategoryPage(category: slug)));

Example Acceptance Criteria (for testing / QA)
- Desktop (width > 800): Grid shows 3 columns with 16px gaps; images fill tiles; titles readable.
- Mobile (≤ 800): Single column stacked tiles, vertical spacing 16px.
- Clicking the Clothing tile navigates to the Clothing collection page (route receives slug).
- Tappable target is at least 44x44 px.
- Images load from assets and show fallback placeholder icon if missing.

Deliverables for the LLM / PR
- Update lib/views/collections_page.dart with:
  - CollectionItem model and sample data list
  - Responsive grid implementation (GridView or SliverGrid)
  - Tile widget implementing accessibility and navigation
- Add or ensure routes exist that accept collection slugs or push to ShopCategoryPage
- Add required image assets under assets/images/collections/* (placeholder images acceptable)
- Add unit/widget test verifying:
  - Grid renders correct number of tiles
  - Tap on the first tile triggers Navigator.push (use mock Navigator or WidgetTester)
  - Accessibility semantics exist for at least one tile