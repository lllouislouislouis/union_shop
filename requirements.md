# Shopping Cart Feature Requirements Document

## 1. Feature Description

### Overview
The Shopping Cart Feature adds comprehensive cart management functionality to the Union Shop application. Users can view, modify, and manage items in their shopping cart through an intuitive interface accessible via the shopping bag icon in the header. This implementation includes state management, UI components, and interaction patterns for a complete cart experience.

### Purpose
- Enable users to review items they intend to purchase
- Allow quantity adjustments and item removal from cart
- Display real-time pricing calculations (subtotal, shipping, total)
- Provide clear feedback for all cart operations
- Maintain cart state across navigation and sessions
- Prepare foundation for future checkout functionality

### Scope
- Global cart state management using Provider pattern
- Shopping bag icon with item count badge
- Dedicated cart page with empty and populated states
- Cart item display with product details and controls
- Quantity adjustment controls with validation
- Item removal with confirmation dialogs
- Cart summary with pricing breakdown
- Placeholder checkout button
- Responsive design for mobile and desktop
- Mock data for testing cart functionality

---

## 2. User Stories

### User Story 1: View Shopping Bag Badge
**As a** user browsing the Union Shop  
**I want to** see a badge on the shopping bag icon showing the number of items in my cart  
**So that** I can quickly know how many items I have without opening the cart

**Acceptance Criteria:**
- Badge appears on shopping bag icon when cart has items (count > 0)
- Badge displays total quantity of all items (sum of individual quantities)
- Badge has primary color background (0xFF4d2963) with white text
- Badge is positioned at top-right corner of shopping bag icon
- Badge updates immediately when cart contents change
- Badge disappears when cart becomes empty

---

### User Story 2: Access Cart Page
**As a** user with items in my cart  
**I want to** click the shopping bag icon  
**So that** I can view and manage my cart contents

**Acceptance Criteria:**
- Clicking shopping bag icon navigates to `/cart` route
- Cart page loads with AppScaffold wrapper
- Page displays "Shopping Cart" title when cart has items
- Navigation works from any page in the app
- Current route shows as `/cart` in header

---

### User Story 3: View Empty Cart
**As a** user with an empty cart  
**I want to** see a clear message and call-to-action  
**So that** I understand my cart is empty and can start shopping

**Acceptance Criteria:**
- Large shopping bag icon displayed (80px, grey color)
- Message "Your cart is empty" centered and prominent (24px, bold)
- Subtitle "Add items to get started" displayed (14px, grey)
- "CONTINUE SHOPPING" button visible with outline style
- Button uses primary color border (0xFF4d2963)
- Clicking button navigates to home page `/`
- Empty state is vertically and horizontally centered
- No cart summary or item list displayed

---

### User Story 4: View Cart Items
**As a** user with items in my cart  
**I want to** see all cart items with their details  
**So that** I can review what I'm about to purchase

**Acceptance Criteria:**
- Each cart item displays in a white card with subtle shadow
- Product image shown as 80x80px thumbnail on left
- Product name displayed (16px, bold, black)
- Unit price shown in format "£19.99" (14px, grey)
- Current quantity displayed with +/- controls
- Item subtotal shown (quantity × price) in format "£39.98"
- Variant details shown if available (e.g., "Size: M, Color: Blue")
- Trash icon button visible in top-right corner of each card
- Cards have 12px padding and 12px margin between them
- Items displayed in scrollable list

---

### User Story 5: Increase Item Quantity
**As a** user managing my cart  
**I want to** click the plus (+) button on an item  
**So that** I can increase the quantity I want to purchase

**Acceptance Criteria:**
- Plus button displays as IconButton with `Icons.add`
- Button has grey border and is 32x32px
- Clicking increases quantity by 1 (up to max 99)
- Quantity display updates immediately
- Item subtotal recalculates and updates
- Cart subtotal and total update
- Shopping bag badge updates to new total count
- Button has hover effect on desktop (darker border)
- No page reload or navigation occurs
- Change persists when navigating away and back

---

### User Story 6: Decrease Item Quantity (Quantity > 1)
**As a** user managing my cart  
**I want to** click the minus (-) button when quantity is greater than 1  
**So that** I can reduce the quantity I want to purchase

**Acceptance Criteria:**
- Minus button displays as IconButton with `Icons.remove`
- Button has grey border and is 32x32px
- Clicking decreases quantity by 1
- Quantity display updates immediately
- Item subtotal recalculates and updates
- Cart subtotal and total update
- Shopping bag badge updates to new total count
- Button has hover effect on desktop (darker border)
- No confirmation dialog shown when quantity > 1
- Change persists across navigation

---

### User Story 7: Decrease Quantity to Remove (Quantity = 1)
**As a** user with an item at quantity 1  
**I want to** be asked to confirm when clicking the minus button  
**So that** I don't accidentally remove items from my cart

**Acceptance Criteria:**
- Confirmation dialog appears when minus clicked at quantity 1
- Dialog title: "Remove from cart?"
- Dialog message: "Are you sure you want to remove [Product Name] from your cart?"
- Dialog shows two buttons: "CANCEL" and "REMOVE"
- CANCEL button dismisses dialog without changes
- REMOVE button removes item and closes dialog
- Item quantity unchanged until confirmation
- Dialog positioned centered on screen

---

### User Story 8: Remove Item via Trash Icon
**As a** user managing my cart  
**I want to** click the trash icon on any cart item  
**So that** I can remove unwanted items regardless of quantity

**Acceptance Criteria:**
- Trash icon visible in top-right corner of each cart item card
- Same confirmation dialog appears as quantity decrease at 1
- Dialog message includes specific product name
- CANCEL preserves item in cart
- REMOVE deletes item from cart
- SnackBar appears: "Item removed from cart"
- Cart totals update immediately
- Shopping bag badge updates
- If last item, cart shows empty state

---

### User Story 9: Confirm Item Removal
**As a** user removing an item  
**I want to** click the REMOVE button in the confirmation dialog  
**So that** I can complete the removal action

**Acceptance Criteria:**
- Dialog closes immediately
- Item disappears from cart list
- SnackBar displays: "Item removed from cart" (2-3 seconds)
- Cart subtotal recalculates
- Cart total recalculates
- Shopping bag badge decrements by removed item quantity
- If cart becomes empty, empty state displays
- Removal persists across navigation
- No page reload occurs

---

### User Story 10: Cancel Item Removal
**As a** user who changed my mind  
**I want to** click CANCEL in the removal confirmation dialog  
**So that** the item stays in my cart

**Acceptance Criteria:**
- Dialog closes immediately
- Item remains in cart unchanged
- Quantity unchanged
- Cart totals unchanged
- Shopping bag badge unchanged
- No SnackBar message shown
- No visual changes to cart

---

### User Story 11: View Cart Summary
**As a** user reviewing my cart  
**I want to** see a summary of costs  
**So that** I know the total amount I'll pay

**Acceptance Criteria:**
- Summary section displays in white container with border
- "Order Summary" header shown (18px, bold)
- Subtotal row: label "Subtotal" + calculated amount
- Shipping row: label "Shipping" + "FREE"
- Divider line between shipping and total (grey, 1px)
- Total row: label "Total" (bold) + total amount (bold, 20px)
- All prices formatted as "£XX.XX" with 2 decimals
- Subtotal equals sum of all item subtotals
- Total equals subtotal (shipping currently free)
- Summary updates immediately when cart changes
- 12px spacing between rows, 16px around divider

---

### User Story 12: View Responsive Layout
**As a** user on different devices  
**I want to** see an optimized cart layout for my screen size  
**So that** the cart is easy to use on any device

**Acceptance Criteria:**
- **Mobile (< 900px):**
  - Single column layout
  - Cart items displayed full width
  - Cart summary below items
  - Items stack vertically in cards
  - 16px horizontal padding
- **Desktop (≥ 900px):**
  - Two column layout (60/40 split)
  - Cart items in left column
  - Cart summary in right column (sticky)
  - Items display horizontally in cards
  - 24px horizontal padding
- Layout transitions smoothly between breakpoints

---

### User Story 13: Attempt Checkout
**As a** user ready to purchase  
**I want to** click the checkout button  
**So that** I can proceed to payment (future functionality)

**Acceptance Criteria:**
- "PROCEED TO CHECKOUT" button at bottom of cart summary
- Button full width of summary container (48px height)
- Primary color background (0xFF4d2963)
- White bold text (16px)
- Rounded corners (8px)
- Hover effect on desktop (darker shade)
- Clicking shows SnackBar: "Checkout functionality coming soon!"
- User remains on cart page
- Cart state unchanged
- Button disabled (grey) when cart is empty

---

### User Story 14: Navigate Away and Return
**As a** user browsing the site  
**I want to** navigate away from cart and return later  
**So that** my cart contents are preserved

**Acceptance Criteria:**
- Cart state persists when navigating to other pages
- Item quantities preserved
- Cart totals remain accurate
- Shopping bag badge shows correct count on all pages
- Returning to cart displays same items
- No data loss during session
- Cart state maintained until manually cleared or session ends

---

### User Story 15: Continue Shopping from Empty Cart
**As a** user with an empty cart  
**I want to** click "Continue Shopping"  
**So that** I can browse products and add items

**Acceptance Criteria:**
- Button visible in empty cart state
- Button text: "CONTINUE SHOPPING"
- Outline button style with primary color border
- Clicking navigates to home page `/`
- Navigation is immediate
- Cart remains empty after navigation
- User can access product pages to add items (future feature)

## 3. Acceptance Criteria

### Functional Requirements

#### FR-23: Cart State Management
- ✅ `CartProvider` created using Provider package
- ✅ CartProvider extends `ChangeNotifier`
- ✅ `CartItem` model created with all required fields
- ✅ Provider stores list of `CartItem` objects
- ✅ `removeItem(String productId)` method implemented
- ✅ `updateQuantity(String productId, int newQuantity)` method implemented
- ✅ `clearCart()` method implemented
- ✅ `getTotalItems()` returns sum of all quantities
- ✅ `getSubtotal()` returns sum of all item subtotals
- ✅ Mock data (2-3 products) added for testing
- ✅ `notifyListeners()` called after all state changes
- ✅ Cart state persists across page navigation in session

#### FR-24: Shopping Bag Icon & Badge
- ✅ Shopping bag icon in `app_header.dart` identified (line ~310)
- ✅ Badge widget wraps shopping bag icon
- ✅ Badge displays `getTotalItems()` count
- ✅ Badge background color: `0xFF4d2963`
- ✅ Badge text color: white, 12px, bold
- ✅ Badge positioned at top-right of icon
- ✅ Badge only shows when `getTotalItems() > 0`
- ✅ Badge hides when cart becomes empty
- ✅ Shopping bag icon `onPressed` navigates to `/cart`
- ✅ Badge updates in real-time with cart changes

#### FR-25: Cart Page - Empty State
- ✅ `CartPage` widget created in `lib/views/cart_page.dart`
- ✅ Page wrapped with `AppScaffold(currentRoute: '/cart')`
- ✅ Empty state shows when `getTotalItems() == 0`
- ✅ Large shopping bag icon displayed (`Icons.shopping_bag_outlined`, 80px, grey)
- ✅ "Your cart is empty" message (24px, bold, centered)
- ✅ "Add items to get started" subtitle (14px, grey, centered)
- ✅ "CONTINUE SHOPPING" button displayed
- ✅ Button has outline style with primary color border
- ✅ Button navigates to home `/` on press
- ✅ Empty state vertically and horizontally centered
- ✅ 16px padding on mobile, 24px on desktop

#### FR-26: Cart Page - With Items
- ✅ Two-column layout on desktop (≥ 900px)
- ✅ Single-column layout on mobile (< 900px)
- ✅ Left column shows cart items list
- ✅ Right column shows cart summary (desktop only)
- ✅ "Shopping Cart" title displayed at top
- ✅ Cart items in `ListView` or scrollable `Column`
- ✅ Layout split 60/40 on desktop
- ✅ Summary below items on mobile
- ✅ Responsive breakpoint at 900px width

#### FR-27: Cart Item Card
- ✅ Each item in white card with subtle shadow
- ✅ Product image: 80x80px thumbnail on left
- ✅ Product name: 16px, bold, black
- ✅ Variant details shown if available (12px, grey)
- ✅ Unit price: 14px, grey, format "£19.99"
- ✅ Quantity controls: minus, display, plus buttons
- ✅ Item subtotal: 14px, bold, black, format "£39.98"
- ✅ Trash icon button at top-right corner
- ✅ Card padding: 12px
- ✅ Card margin: 12px between cards
- ✅ Horizontal row layout on desktop
- ✅ Vertical stack layout on mobile

#### FR-28: Quantity Controls
- ✅ Minus button: IconButton with `Icons.remove`, grey border, 32x32px
- ✅ Quantity display: centered text, 40px wide, bold
- ✅ Plus button: IconButton with `Icons.add`, grey border, 32x32px
- ✅ Minus at quantity > 1: decreases by 1, updates totals
- ✅ Minus at quantity = 1: shows confirmation dialog
- ✅ Plus button: increases by 1 (max 99), updates totals
- ✅ Buttons have hover effect on desktop (darker border)
- ✅ Quantity changes call `updateQuantity()` in CartProvider
- ✅ Changes update immediately without page reload
- ✅ Badge updates with quantity changes

#### FR-29: Remove Item Confirmation
- ✅ Dialog shows when minus clicked at quantity 1
- ✅ Dialog shows when trash icon clicked
- ✅ Dialog title: "Remove from cart?"
- ✅ Dialog content includes product name
- ✅ CANCEL button dismisses dialog, no changes
- ✅ REMOVE button has red text color
- ✅ REMOVE button calls `removeItem()`, dismisses dialog
- ✅ SnackBar shows after removal: "Item removed from cart"
- ✅ Cart badge updates immediately
- ✅ Empty state shows if last item removed

#### FR-30: Cart Summary Section
- ✅ Summary in white container with subtle border
- ✅ Container has 16px padding
- ✅ "Order Summary" header (18px, bold)
- ✅ Subtotal row with label and amount
- ✅ Shipping row showing "FREE"
- ✅ Grey divider line (1px) between shipping and total
- ✅ Total row with bold label and amount (20px)
- ✅ All prices formatted "£XX.XX" with 2 decimals
- ✅ Subtotal calculated from all item subtotals
- ✅ Total equals subtotal (free shipping)
- ✅ 12px spacing between rows
- ✅ 16px spacing around divider
- ✅ Summary updates in real-time

#### FR-31: Checkout Button
- ✅ Button at bottom of cart summary
- ✅ Text: "PROCEED TO CHECKOUT" (white, bold, 16px)
- ✅ Background: `0xFF4d2963` (primary color)
- ✅ Full width of summary container
- ✅ Height: 48px
- ✅ Rounded corners: 8px
- ✅ Hover effect on desktop (darker shade)
- ✅ Click shows SnackBar: "Checkout functionality coming soon!"
- ✅ User remains on cart page after click
- ✅ Button disabled (grey) when cart empty

#### FR-32: Route Configuration
- ✅ `/cart` route added to routes map in `main.dart`
- ✅ Route returns `const CartPage()`
- ✅ `CartPage` import added to `main.dart`
- ✅ `CartProvider` import added to `main.dart`
- ✅ Navigation to `/cart` works from all pages

#### FR-33: Provider Setup
- ✅ `MaterialApp` wrapped with `ChangeNotifierProvider<CartProvider>`
- ✅ `lib/providers/cart_provider.dart` file created
- ✅ CartProvider extends `ChangeNotifier`
- ✅ `lib/models/cart_item.dart` file created
- ✅ CartItem model has all required fields
- ✅ Mock data added in CartProvider constructor
- ✅ Mock data includes 2-3 products with varying properties
- ✅ Provider accessible throughout app via `Provider.of<CartProvider>(context)`

### Non-Functional Requirements

- **State Management**: Cart state managed globally via Provider pattern
- **Responsiveness**: Layout adapts between 320px and 2560px screen widths
- **Performance**: UI updates immediately without lag or page reloads
- **Consistency**: Design matches existing app styling (colors, fonts, spacing)
- **Data Persistence**: Cart state persists during app session navigation
- **Code Quality**: Code follows project conventions with clear comments
- **Error Handling**: Graceful handling of edge cases (empty cart, max quantity)

### Testing Checklist

- ✅ Shopping bag badge displays correct count
- ✅ Badge shows/hides based on cart contents
- ✅ Clicking shopping bag navigates to cart page
- ✅ Empty cart state displays correctly
- ✅ "Continue Shopping" button navigates to home
- ✅ Cart items display all required information
- ✅ Product images load correctly
- ✅ Plus button increases quantity up to 99
- ✅ Minus button decreases quantity when > 1
- ✅ Minus button shows dialog when quantity = 1
- ✅ Trash icon shows removal confirmation
- ✅ CANCEL button dismisses dialog without changes
- ✅ REMOVE button deletes item from cart
- ✅ SnackBar appears after item removal
- ✅ Item subtotals calculate correctly
- ✅ Cart subtotal equals sum of item subtotals
- ✅ Prices format correctly with £ symbol
- ✅ Summary updates in real-time with changes
- ✅ Checkout button shows placeholder message
- ✅ Layout responsive on mobile viewports
- ✅ Layout responsive on desktop viewports
- ✅ Cart state persists across navigation
- ✅ No console errors during cart operations
- ✅ All provider methods work correctly
- ✅ Badge updates with all cart changes

---

## 4. Definition of Done

The Shopping Cart Feature is considered complete when:

1. ✅ All files created and modified per requirements
2. ✅ CartItem model implemented with required fields
3. ✅ CartProvider implemented with all methods
4. ✅ Provider integrated into app via main.dart
5. ✅ CartPage created with empty and populated states
6. ✅ Cart item cards display all required information
7. ✅ Quantity controls work with proper validation
8. ✅ Remove confirmation dialog implemented
9. ✅ Cart summary calculates and displays correctly
10. ✅ Checkout button shows placeholder feedback
11. ✅ Shopping bag badge updates in real-time
12. ✅ Route configuration complete
13. ✅ Responsive layout works on mobile and desktop
14. ✅ All user stories verified
15. ✅ All acceptance criteria met
16. ✅ No regressions in existing features
17. ✅ Code passes linting and follows style guide
18. ✅ Feature reviewed and approved
19. ✅ No console errors or warnings
20. ✅ Cart state persists correctly during navigation
