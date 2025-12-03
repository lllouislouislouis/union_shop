# Hero Image Carousel Implementation

I'm working on a Flutter online shop app and need to implement an auto-playing image carousel on the home page, replacing the current static hero section. The carousel should showcase key areas of the shop with call-to-action buttons.

## Current Code Context

- **Main File**: `lib/main.dart`
- **Header Component**: `lib/widgets/app_header.dart` (already implemented)
- **Home Page**: `HomeScreen` in `lib/main.dart` (see attached file)
- **Existing Hero Section**: Static hero with placeholder title, text, and "SHOP NOW" button
- **Navigation**: Uses named routes with `Navigator.pushNamed()`
- **Theme Color**: `Color(0xFF4d2963)` (purple)
- **Responsive Breakpoint**: 800px (desktop vs mobile)

## Requirements

### 1. Carousel Structure

**Number of Slides**: 4

**Slide Content** (in order):

| Slide # | Background Image | Heading Text | Button Label | Button Route |
|---------|-----------------|--------------|--------------|--------------|
| 1 | `assets/images/carousel_collections.jpg` | "Browse Our Collections" | "EXPLORE" | `/collections` |
| 2 | `assets/images/carousel_printshack.jpg` | "The Print Shack" | "GET PERSONALISED" | `/print-shack/about` |
| 3 | `assets/images/carousel_sale.jpg` | "Big Sale On Now!" | "SHOP SALE" | `/sale` |
| 4 | `assets/images/carousel_about.jpg` | "About Union Shop" | "LEARN MORE" | `/about` |

### 2. Desktop Carousel Behavior (width > 800px)

**Visual Design**:
- Height: 500px
- Width: 100% of screen
- Background image covers entire carousel area with dark overlay (`Colors.black.withValues(alpha: 0.5)`)
- Content centered vertically and horizontally
- Smooth crossfade transition between slides (600ms duration)

**Content Layout**:
- Heading text at top center, white color, bold, 32px
- Subheading text below heading, light grey color, 16px
- Call-to-action button below text, purple background, white text, rounded corners
- Button size: 200px width, 50px height
- Centered alignment for all content

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| No interaction required | Carousel auto-plays every 5 seconds |
| Hover over carousel | Pause auto-play |
| Click on button | Navigate to specified route (e.g., `/collections`) |
| Swipe left/right | Navigate to next/previous slide |
| (Mobile-specific) Tap on slide | Navigate to next slide, if not linked |

### 3. Mobile Carousel Behavior (width ≤ 800px)

**Visual Design**:
- Height: 300px
- Width: 100% of screen
- Background image covers entire carousel area
- Content centered vertically and horizontally
- No dark overlay

**Content Layout**:
- Heading text at top center, black color, bold, 24px
- Subheading text below heading, dark grey color, 14px
- Call-to-action button below text, purple background, white text, rounded corners
- Button size: 180px width, 40px height
- Centered alignment for all content

**User Actions**:
| User Action | Expected Behavior |
|-------------|-------------------|
| No interaction required | Carousel auto-plays every 5 seconds |
| Tap on button | Navigate to specified route (e.g., `/collections`) |
| Swipe left/right | Navigate to next/previous slide |

### 4. Implementation Details

**Carousel Widget**:
- Create a new `HeroCarousel` widget
- Use `PageView` for swipeable slides
- Use `Timer` for auto-play functionality
- Use `GestureDetector` for tap/swipe interactions

**Slide Model**:
```dart
class CarouselSlide {
  final String image;
  final String heading;
  final String subheading;
  final String buttonLabel;
  final String buttonRoute;
}
```

**State Management**:
- Maintain current slide index in state
- Update index on slide change (swipe or auto-play)
- Reset auto-play timer on user interaction (hover/tap)

**Animation**:
- Crossfade transition between slides
- Duration: 600ms
- Curve: `Curves.easeInOut`

### 5. Route Setup in main.dart

**New Routes to Add**:
```dart
// Collections route
'/collections': (context) => CollectionsPage(),
```

**Note**: Create a placeholder collections page for now

### 6. Visual Design Specifications

**Desktop Carousel**:
```
┌────────────────────────────────────────────────┐
│ ┌───────────────┐  ┌───────────────┐  ┌───────────────┐
│ │ Slide 1       │  │ Slide 2       │  │ Slide 3       │
│ │               │  │               │  │               │
│ │               │  │               │  │               │
│ └───────────────┘  └───────────────┘  └───────────────┘
│                                               
│ ┌───────────────┐  ┌───────────────┐
│ │ Slide 4       │  │ Slide 5       │
│ │               │  │               │
│ │               │  │               │
│ └───────────────┘  └───────────────┘
└────────────────────────────────────────────────┘
```

**Mobile Carousel**:
```
┌─────────────────────────┐
│ ← Swipe   Slide 1      │
│                         │
│  Browse Our Collections │
│  EXPLORE               │
│                         │
└─────────────────────────┘
```

**Color Specifications**:
- Purple: `Color(0xFF4d2963)`
- White: `Colors.white`
- Black: `Colors.black`
- Dark grey: `Colors.grey[850]`
- Light grey: `Colors.grey[300]`

### 7. Code Structure Recommendations

**Create HeroCarousel Widget**:
```dart
class HeroCarousel extends StatefulWidget {
  @override
  _HeroCarouselState createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  int _currentSlide = 0;
  Timer? _autoPlayTimer;

  final List<CarouselSlide> _slides = [
    // Define slides here
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _nextSlide();
    });
  }

  void _nextSlide() {
    setState(() {
      _currentSlide = (_currentSlide + 1) % _slides.length;
    });
  }

  void _onSlideTap(int index) {
    Navigator.pushNamed(context, _slides[index].buttonRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: PageView.builder(
        itemCount: _slides.length,
        onPageChanged: (index) {
          setState(() {
            _currentSlide = index;
          });
        },
        itemBuilder: (context, index) {
          final slide = _slides[index];
          return GestureDetector(
            onTap: () => _onSlideTap(index),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  slide.image,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      slide.heading,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      slide.subheading,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onSlideTap(index),
                      child: Text(slide.buttonLabel),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4d2963),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### 8. Error Handling

**Handle these scenarios**:
- Image asset not found: Show placeholder image or error indicator
- Route doesn't exist: Show error page or redirect to home
- Rapid tapping of carousel buttons: Debounce or prevent state conflicts

### 9. Testing Checklist

Ensure the following works correctly:

**Carousel**:
- [ ] Carousel auto-plays slides every 5 seconds
- [ ] Hovering over carousel pauses auto-play
- [ ] Clicking button navigates to correct route
- [ ] Swiping left/right navigates to next/previous slide
- [ ] Mobile tap on slide navigates to next slide

### 11. Deliverables

Please provide:

**Carousel - Desktop**:
```
1. User lands on home page → Carousel shows first slide with auto-play
2. User hovers over carousel → Auto-play pauses
3. User clicks "EXPLORE" button → Navigates to /collections
4. User returns to home page → Carousel resumes auto-play
```

**Carousel - Mobile**:
```
1. User lands on home page → Carousel shows first slide with auto-play
2. User taps "GET PERSONALISED" button → Navigates to /print-shack/about
3. User returns to home page → Carousel resumes auto-play
```