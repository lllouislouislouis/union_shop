# Collections Page — Feature Requirements

## 1. Feature overview
Description
- Implement a responsive Collections page that displays site collections (e.g., Clothing, Merchandise, Graduation, Personalisation, Print Shack, Portsmouth, Pride) as a tiled grid. Each tile shows an image and short label/description and navigates to the appropriate collection/category view when activated.

Purpose
- Provide an easy, visual way for users to discover and navigate major collections.
- Maintain consistency with app theming and accessibility requirements.

Scope
- Add a CollectionsPage view at lib/views/collections_page.dart.
- Provide a reusable CollectionTile widget and a small model (CollectionItem).
- Ensure routing/navigation to collection/category screens (via existing ShopCategoryPage or new routes).
- Add tests verifying rendering, navigation and accessibility.

## 2. User stories

US-1: Discover collections (visitor)
- As a visitor, I want to scan a grid of collection tiles so I can quickly find collections to browse.
- Expected: Tiles show image and title; tapping a tile opens that collection.

US-2: Mobile browsing (mobile user)
- As a mobile user, I want the layout to stack vertically so tiles are easy to read and tap.
- Expected: Single column on narrow screens; tiles maintain minimum tappable size.

US-3: Desktop browsing (desktop user)
- As a desktop user, I want a denser grid so more collections are visible at once.
- Expected: Three columns on wide screens; hover/focus states provide affordance.

US-4: Developer / maintainer
- As a developer, I want a small model and sample data so it’s easy to add or update collections and write tests.

## 3. Acceptance criteria

Layout & responsiveness
- AC-1: Desktop/tablet (width > 800px) shows 3 columns; mobile (≤ 800px) shows 1 column.
- AC-2: Grid spacing: 16px between tiles; 24px outer padding.
- AC-3: Tiles maintain consistent aspect ratio (recommend childAspectRatio e.g., 4/3 or square) and do not overflow horizontally at common widths.

Tile content & visuals
- AC-4: Each tile displays an image (BoxFit.cover) plus a title overlay (bold, 16–18px). Optional short description shown beneath or in overlay.
- AC-5: Images use a dark gradient or semi-transparent overlay to keep text readable.
- AC-6: If an image fails to load, a fallback placeholder (icon + neutral background) is shown.

Interaction & navigation
- AC-7: Tapping/clicking a tile navigates to the collection view for that slug:
  - Preferred: Navigator.pushNamed(context, '/collections/<slug>') OR Navigator.push(context, MaterialPageRoute(builder: (_) => ShopCategoryPage(category: slug))).
- AC-8: Tile activation supports mouse click, touch
- AC-9: Tiles provide hover/press visual feedback on supported platforms (scale, elevation, or overlay).

Accessibility
- AC-10: Each tile has a Semantics label: "Open {title} collection".
- AC-11: Controls meet minimum touch target of 44x44 px.
- AC-12: Contrast of text on overlay meets WCAG AA.
- AC-13: Focus order is logical; keyboard focus visible.

Data & routing
- AC-14: The page uses a static const List<CollectionItem> model with fields: slug, title, description (optional), imagePath, route (optional).
- AC-15: Known slugs are mapped to existing ShopCategoryPage routes or registered in app routes.
- AC-16: If route is missing, navigation falls back to ShopCategoryPage(category: slug).

Testing & QA
- AC-17: Widget tests confirm:
  - Grid renders expected number of items from the sample list.
  - Tapping the first tile triggers Navigator.push (use WidgetTester with mock navigator).
  - Semantics label present for at least one tile.
- AC-18: Manual checks at widths: 360px, 800px, 1200px show no overflow and correct layout.

## 4. Functional requirements (summary)

FR-1 Layout
- FR-1.1: Use GridView.count or SliverGrid with crossAxisCount = (width > 800 ? 3 : 1).
- FR-1.2: crossAxisSpacing and mainAxisSpacing = 16px; padding = 24px.
- FR-1.3: childAspectRatio tuned for consistent tile shape.

FR-2 Tile
- FR-2.1: Implement CollectionTile widget using InkWell (for ripple), Stack (Image + overlay), and Semantics + FocusableActionDetector.
- FR-2.2: Provide keyboard activation and hover/press visuals.
- FR-2.3: Expose semanticLabel: "Open {title} collection".

FR-3 Data & model
- FR-3.1: Add CollectionItem model:
  - final String slug;
  - final String title;
  - final String? description;
  - final String imagePath;
  - final String? route;
- FR-3.2: Provide a const sample list of items used by CollectionsPage.

FR-4 Navigation
- FR-4.1: Primary navigation via named routes '/collections/<slug>' if possible; otherwise push ShopCategoryPage.
- FR-4.2: Ensure Navigator is used consistently with app routes.

FR-5 Assets
- FR-5.1: Images placed under assets/images/collections/*. Use placeholders if real assets are not available.
- FR-5.2: Add fallback UI for missing assets.

## 5. Non-functional requirements

NFR-1 Performance
- Avoid expensive build-time work; prefer const widgets and preloaded assets where feasible.

NFR-2 Maintainability
- Keep model and sample data near the page (lib/views/collections_page.dart) or in a small model file.
- Keep widgets small and testable.

NFR-3 Accessibility
- Follow semantics and ensure contrast and keyboard navigation.

## 6. Implementation notes & examples (brief)
- Use a small const list of CollectionItem.
- Grid implementation example: GridView.count(crossAxisCount: columns, childAspectRatio: 4/3,...)
- Tile: InkWell -> Semantics -> Stack(Image.asset, Positioned overlay Text).

## 7. Subtasks (actionable)

- [ ] Create model: lib/models/collection_item.dart or define inside collections_page.dart.
- [ ] Implement CollectionsPage: lib/views/collections_page.dart with responsive GridView.
- [ ] Implement CollectionTile widget with InkWell, Semantics, FocusableActionDetector and fallback image handling.
- [ ] Add sample const List<CollectionItem> with at least 6 items (clothing, merchandise, graduation, personalisation, print-shack, ports mouth/pride).
- [ ] Ensure image assets exist at assets/images/collections/* or use placeholders and update pubspec.yaml.
- [ ] Wire navigation: add routes or ensure fallback to ShopCategoryPage(category: slug).
- [ ] Add widget tests:
  - Grid renders sample count.
  - Tap triggers navigation.
  - Semantics label exists.
- [ ] Manual QA: test at widths 360px, 800px, 1200px for layout and accessibility checks.

--- 

End of requirements.
