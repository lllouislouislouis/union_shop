# Hero Image Carousel Feature Requirements

## 1. Feature Overview

### Description
Replace the current static hero section on the home page with an auto-playing image carousel that showcases 4 key areas of the Union Shop: Collections, Print Shack, Sale, and About. The carousel will feature full-width images with overlay text and call-to-action buttons on desktop, while displaying image-only slides with navigation controls on mobile.

### Purpose
- **Highlight Multiple Offerings**: Showcase different shop sections without requiring page scrolls
- **Drive Navigation**: Provide direct paths to key pages through prominent CTAs
- **Visual Appeal**: Create dynamic, engaging landing experience with professional transitions
- **Mobile Optimization**: Deliver fast-loading, touch-friendly experience on smaller screens
- **Auto-Discovery**: Expose users to all major site sections within 20 seconds of landing

### Technical Context
- **Modified File**: `lib/main.dart` HomeScreen widget will be updated
- **Current State**: Static hero section with single image, placeholder text, and "SHOP NOW" button
- **New Component**: HeroCarousel StatefulWidget with PageView and Timer-based auto-play
- **Framework**: Flutter web with Material widgets
- **Theme**: Purple (`Color(0xFF4d2963)`) for all CTAs
- **Responsive Breakpoint**: 800px (desktop vs mobile)
- **Routes**: 1 new route (`/collections`), 3 existing routes reused

---

## 2. User Stories

### US-1: Desktop User Experiences Auto-Playing Carousel
**As a** desktop user (screen > 800px)  
**I want to** see an auto-rotating carousel with images, headings, and buttons  
**So that** I can discover different shop sections without scrolling

**Acceptance Criteria:**
- Carousel displays 4 slides in sequence: Collections → Print Shack → Sale → About
- Each slide shows background image, centered heading text (56px white bold), and CTA button
- Dark overlay (50% opacity black) ensures text readability over images
- Auto-advances to next slide every 5 seconds with smooth crossfade (600ms)
- Button displays appropriate label ("EXPLORE", "GET PERSONALISED", "SHOP SALE", "LEARN MORE")
- Clicking button navigates to correct route and stops carousel
- Hovering over carousel pauses auto-play (resumes on mouse leave)
- Carousel loops back to slide 1 after slide 4

---

### US-2: Desktop User Manually Controls Carousel
**As a** desktop user  
**I want to** manually navigate slides using arrows and pause auto-play  
**So that** I can explore at my own pace

**Acceptance Criteria:**
- Navigation controls appear at bottom center (16px from edge)
- Left arrow navigates to previous slide, restarts 5-second timer
- Right arrow navigates to next slide, restarts timer
- 4 dot indicators show current slide (active dot is white, others 50% opacity)
- Clicking any dot jumps to that slide, restarts timer
- Pause button (⏸) stops auto-play, changes to play icon (▶)
- Play button resumes auto-play from current slide
- Controls have semi-transparent dark background for visibility
- All controls show hover effects (slight brightness increase)

---

### US-3: Mobile User Views Image-Only Carousel
**As a** mobile user (screen ≤ 800px)  
**I want to** see a simplified carousel with just images and controls  
**So that** I get fast load times and clear navigation

**Acceptance Criteria:**
- Carousel displays 4 slides in sequence (same order as desktop)
- Each slide shows full-width background image only (no text overlay, no button)
- Height reduced to 400px (vs 500px desktop)
- Auto-advances every 5 seconds with crossfade transition
- Navigation controls at bottom center (12px from edge)
- Same arrow buttons, dot indicators, and pause/play button as desktop
- Tapping carousel image pauses briefly (1 second), then resumes
- Swipe left/right gestures navigate to next/previous slide
- Carousel loops continuously

---

### US-4: User Navigates from Carousel to Collections Page
**As a** user on the home page  
**I want to** click "EXPLORE" button on slide 1  
**So that** I can browse all product collections

**Acceptance Criteria:**
- Slide 1 shows background image: `carousel_collections.jpg`
- Heading text: "Browse Our Collections"
- Button label: "EXPLORE"
- Clicking button navigates to `/collections` route
- Collections page displays with AppHeader showing current route
- Placeholder page includes heading "Collections" and placeholder text
- Browser back button returns to home page
- Carousel resets to slide 1 on return (no state persistence)

---

### US-5: User Accesses Print Shack from Carousel
**As a** user interested in personalization  
**I want to** click "GET PERSONALISED" button on slide 2  
**So that** I can learn about print services

**Acceptance Criteria:**
- Slide 2 shows background image: `carousel_printshack.jpg`
- Heading text: "The Print Shack"
- Button label: "GET PERSONALISED"
- Clicking button navigates to `/print-shack/about` (existing route)
- Print Shack about page loads with correct AppHeader active state
- Carousel stops auto-playing after navigation

---

### US-6: User Explores Sale from Carousel
**As a** user looking for deals  
**I want to** click "SHOP SALE" button on slide 3  
**So that** I can view discounted items

**Acceptance Criteria:**
- Slide 3 shows background image: `carousel_sale.jpg`
- Heading text: "Big Sale On Now!"
- Button label: "SHOP SALE"
- Clicking button navigates to `/sale` (existing route)
- Sale page loads with correct AppHeader active state

---

### US-7: User Learns About Shop from Carousel
**As a** new visitor  
**I want to** click "LEARN MORE" button on slide 4  
**So that** I can understand what Union Shop offers

**Acceptance Criteria:**
- Slide 4 shows background image: `carousel_about.jpg`
- Heading text: "About Union Shop"
- Button label: "LEARN MORE"
- Clicking button navigates to `/about` (existing route)
- About page loads with correct AppHeader active state

---

### US-8: User Pauses and Resumes Carousel
**As a** user reading carousel content  
**I want to** pause auto-play to read at my own pace  
**So that** I don't miss information

**Acceptance Criteria:**
- Clicking pause button (⏸) stops auto-play immediately
- Icon changes to play (▶)
- Current slide remains visible indefinitely
- Manual navigation (arrows, dots) still works while paused
- Clicking play button resumes auto-play from current slide
- Timer restarts from 0 seconds (not from where it paused)
- Pause state is visual-only (no accessibility announcement needed)

---

## 3. Functional Requirements

### FR-1: Carousel Data Structure
- **FR-1.1**: Create CarouselSlide model with properties: imagePath, heading, buttonLabel, buttonRoute
- **FR-1.2**: Define 4 slides in order:
  1. Collections: `carousel_collections.jpg`, "Browse Our Collections", "EXPLORE", `/collections`
  2. Print Shack: `carousel_printshack.jpg`, "The Print Shack", "GET PERSONALISED", `/print-shack/about`
  3. Sale: `carousel_sale.jpg`, "Big Sale On Now!", "SHOP SALE", `/sale`
  4. About: `carousel_about.jpg`, "About Union Shop", "LEARN MORE", `/about`
- **FR-1.3**: Store slides in List<CarouselSlide> in _HomeScreenState
- **FR-1.4**: Slides immutable after initialization

### FR-2: Auto-Play Functionality
- **FR-2.1**: Use Timer.periodic with 5-second duration
- **FR-2.2**: Auto-play starts immediately on page load (slide 1 visible for 5 seconds)
- **FR-2.3**: Increment _currentSlide on each timer tick
- **FR-2.4**: Loop to slide 0 after slide 3 using modulo operator
- **FR-2.5**: Cancel timer in dispose() to prevent memory leaks
- **FR-2.6**: Pause auto-play when _isAutoPlayEnabled = false
- **FR-2.7**: Restart 5-second timer when user manually changes slide

### FR-3: Desktop Carousel Layout
- **FR-3.1**: Container height: 500px, width: double.infinity
- **FR-3.2**: Use Stack with Positioned.fill for layering
- **FR-3.3**: Background: Image.asset with BoxFit.cover
- **FR-3.4**: Overlay: Container with Colors.black.withValues(alpha: 0.5)
- **FR-3.5**: Content Column centered (MainAxisAlignment.center, CrossAxisAlignment.center)
- **FR-3.6**: Heading: 56px, FontWeight.bold, white color
- **FR-3.7**: Button: 48px height, purple background, white text, 20px horizontal padding
- **FR-3.8**: Navigation controls positioned at bottom center (Positioned: left: 0, right: 0, bottom: 16)

### FR-4: Mobile Carousel Layout
- **FR-4.1**: Container height: 400px, width: double.infinity
- **FR-4.2**: Background image only (no overlay, no text, no button)
- **FR-4.3**: Same Stack structure for controls overlay
- **FR-4.4**: Navigation controls positioned at bottom: 12px from edge
- **FR-4.5**: Determine layout using MediaQuery.of(context).size.width > 800

### FR-5: Slide Transition Animation
- **FR-5.1**: Use AnimatedSwitcher for crossfade effect
- **FR-5.2**: Duration: 600ms
- **FR-5.3**: Curve: Curves.easeInOut
- **FR-5.4**: Key each slide by _currentSlide index to trigger animation
- **FR-5.5**: FadeTransition as default transitionBuilder
- **FR-5.6**: No slide animation (no vertical/horizontal movement)

### FR-6: Navigation Controls - Arrows
- **FR-6.1**: Left arrow: Icons.arrow_back_ios, white color, 24px size
- **FR-6.2**: Right arrow: Icons.arrow_forward_ios, white color, 24px size
- **FR-6.3**: Wrap in IconButton with transparent background
- **FR-6.4**: OnPressed: decrement/increment _currentSlide, call _restartTimer()
- **FR-6.5**: Use modulo for looping: (_currentSlide - 1 + slides.length) % slides.length
- **FR-6.6**: Arrows spaced 16px from dot indicators

### FR-7: Navigation Controls - Dot Indicators
- **FR-7.1**: Display 4 dots horizontally with 8px spacing
- **FR-7.2**: Active dot: white circle, 12px diameter, 100% opacity
- **FR-7.3**: Inactive dots: white circle, 8px diameter, 50% opacity
- **FR-7.4**: Wrap each dot in GestureDetector
- **FR-7.5**: OnTap: set _currentSlide to dot index, call _restartTimer()
- **FR-7.6**: Use Row with MainAxisAlignment.center for layout

### FR-8: Navigation Controls - Pause/Play Button
- **FR-8.1**: Display Icons.pause when _isAutoPlayEnabled = true
- **FR-8.2**: Display Icons.play_arrow when _isAutoPlayEnabled = false
- **FR-8.3**: White color, 24px size
- **FR-8.4**: Positioned 16px right of arrow buttons
- **FR-8.5**: OnPressed: toggle _isAutoPlayEnabled, cancel/restart timer
- **FR-8.6**: Use AnimatedSwitcher for icon transition (200ms)

### FR-9: Navigation Controls - Container Styling
- **FR-9.1**: Background: Colors.black.withValues(alpha: 0.3)
- **FR-9.2**: Padding: 12px horizontal, 8px vertical
- **FR-9.3**: BorderRadius: 24px (fully rounded ends)
- **FR-9.4**: Row layout: [← Arrow] [Dots] [→ Arrow] [⏸ Button]
- **FR-9.5**: Spacing between elements: 12px
- **FR-9.6**: Centered horizontally using Positioned(left: 0, right: 0)

### FR-10: Hover Behavior (Desktop Only)
- **FR-10.1**: Wrap carousel Stack in MouseRegion
- **FR-10.2**: OnEnter: set _isHovering = true, cancel auto-play timer
- **FR-10.3**: OnExit: set _isHovering = false, restart timer if _isAutoPlayEnabled
- **FR-10.4**: Pause button icon unchanged during hover pause
- **FR-10.5**: Manual navigation still works while hovering

### FR-11: Touch Gestures (Mobile)
- **FR-11.1**: Wrap carousel in GestureDetector
- **FR-11.2**: OnTap: pause for 1 second, then resume (mini-pause feedback)
- **FR-11.3**: OnHorizontalDragEnd: detect swipe direction (velocity.pixelsPerSecond.dx)
- **FR-11.4**: Swipe left (velocity < -500): next slide
- **FR-11.5**: Swipe right (velocity > 500): previous slide
- **FR-11.6**: Call _restartTimer() after swipe navigation

### FR-12: Image Preloading
- **FR-12.1**: In initState(), loop through all slides
- **FR-12.2**: Call precacheImage(AssetImage(slide.imagePath), context) for each
- **FR-12.3**: Prevents white flash on first display of each slide
- **FR-12.4**: Load all 4 images before first auto-advance

### FR-13: Button Navigation
- **FR-13.1**: Wrap button in GestureDetector or use ElevatedButton.onPressed
- **FR-13.2**: OnTap: Navigator.pushNamed(context, slide.buttonRoute)
- **FR-13.3**: Cancel auto-play timer before navigation
- **FR-13.4**: Button styling: purple background, white text, FontWeight.w600, 18px font
- **FR-13.5**: BorderRadius: 8px
- **FR-13.6**: Hover effect (desktop): darken purple by 10%

### FR-14: Collections Page Route
- **FR-14.1**: Add '/collections' to MaterialApp routes in main.dart
- **FR-14.2**: Create lib/views/collections_page.dart
- **FR-14.3**: CollectionsPage includes AppHeader(currentRoute: '/collections')
- **FR-14.4**: Display "Collections" heading (48px, purple, bold)
- **FR-14.5**: Placeholder text: "Browse all our product collections here"
- **FR-14.6**: White background, consistent padding with other pages
- **FR-14.7**: Scrollable Column structure

### FR-15: Error Handling - Missing Images
- **FR-15.1**: Use Image.asset with errorBuilder parameter
- **FR-15.2**: On error, display Container with grey background (Colors.grey[300])
- **FR-15.3**: Center Icon(Icons.image_not_supported, size: 64, color: grey[600])
- **FR-15.4**: No app crash if asset missing
- **FR-15.5**: Continue auto-play even if one image fails to load

### FR-16: State Management
- **FR-16.1**: _currentSlide (int): tracks active slide index (0-3)
- **FR-16.2**: _isAutoPlayEnabled (bool): tracks pause/play state
- **FR-16.3**: _isHovering (bool, desktop only): tracks mouse hover state
- **FR-16.4**: _autoPlayTimer (Timer?): reference to active timer
- **FR-16.5**: All setState() calls wrapped properly
- **FR-16.6**: Timer cancelled in dispose() and before creating new timer

---

## 4. Non-Functional Requirements

### NFR-1: Performance
- Slide transitions render at 60 FPS without dropped frames
- Image preloading completes within 1 second on typical connection
- Auto-play timer consumes minimal CPU (no unnecessary rebuilds)
- Hover detection responds within 50ms
- Manual navigation (arrows, dots) responds instantly (<100ms)

### NFR-2: Responsive Design
- Carousel scales correctly from 320px to 2560px width
- Breakpoint at 800px switches cleanly between desktop/mobile layouts
- No horizontal scrollbars at any width
- Images maintain aspect ratio without distortion
- Controls remain visible and clickable at all widths

### NFR-4: Animation Quality
- Crossfade transition smooth and natural (no jarring cuts)
- No white flashes between slides
- Control hover effects smooth (100ms transition)
- Button press feedback immediate
- No animation stuttering during window resize

### NFR-5: Code Maintainability
- Carousel extracted to _buildHeroCarousel() method
- Slide data separate from widget code
- Control widgets extracted to helper methods
- Clear comments on timer management
- Consistent naming: _currentSlide, _isAutoPlayEnabled, _restartTimer()
- Easy to add/remove slides by modifying List<CarouselSlide>

---

## 5. Acceptance Criteria Summary

The feature is **complete** when:

### Desktop Carousel
- [ ] 4 slides display with correct images, headings, and buttons
- [ ] Auto-play advances slides every 5 seconds
- [ ] Crossfade transition smooth (600ms)
- [ ] Hovering pauses auto-play
- [ ] Clicking button navigates to correct route
- [ ] Left/right arrows navigate slides
- [ ] Dot indicators show active slide and support click navigation
- [ ] Pause/play button toggles auto-play
- [ ] Controls have semi-transparent background
- [ ] All hover effects work

### Mobile Carousel
- [ ] 4 slides display with images only (no text/button)
- [ ] Height 400px, full width
- [ ] Auto-play works (5 seconds)
- [ ] Tapping pauses briefly (1 second)
- [ ] Swipe left/right navigates slides
- [ ] Controls functional and sized for touch (48x48px minimum)
- [ ] Same navigation controls as desktop

### Navigation
- [ ] "EXPLORE" button goes to `/collections`
- [ ] "GET PERSONALISED" button goes to `/print-shack/about`
- [ ] "SHOP SALE" button goes to `/sale`
- [ ] "LEARN MORE" button goes to `/about`
- [ ] Collections page displays correctly
- [ ] All routes registered in main.dart
- [ ] Browser back button returns to home

### State & Performance
- [ ] Auto-play restarts after manual navigation
- [ ] Timer cancelled on page dispose
- [ ] No memory leaks after multiple page visits
- [ ] Images preloaded (no white flashes)
- [ ] Hover pause doesn't affect pause button state
- [ ] Rapid clicking doesn't break state
- [ ] 60 FPS transitions maintained

### Responsive
- [ ] Desktop layout shows text/buttons (>800px)
- [ ] Mobile layout shows images only (≤800px)
- [ ] Transition smooth when resizing window
- [ ] Controls positioned correctly at all widths
- [ ] No layout breaking at breakpoint

### Error Handling
- [ ] Missing images show placeholder (no crash)
- [ ] Invalid routes handle gracefully
- [ ] Rapid button clicks debounced
- [ ] State remains consistent under stress testing
