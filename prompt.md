# Shopping Cart Feature Implementation Prompt

## Feature Overview
Add a shopping cart system to the Union Shop app. Users should be able to view their cart by clicking the shopping bag icon in the header. The cart will display either an empty state or a list of products with their details. This initial implementation focuses on the cart UI and basic state management, with "Add to Cart" functionality to be implemented later.

## Feature Requirements

### FR-23: Cart State Management
- **FR-23.1**: Create a `CartProvider` using Provider package to manage cart state globally
- **FR-23.2**: Cart should store a list of `CartItem` objects containing:
  - Product reference (id, name, image URL)
  - Quantity (integer)
  - Unit price (double)
  - Optional: size and color variants (String?)
- **FR-23.3**: Cart state should persist across page navigation within the session
- **FR-23.4**: Provide methods to:
  - `removeItem(String productId)` - remove item from cart
  - `updateQuantity(String productId, int newQuantity)` - update item quantity
  - `clearCart()` - empty the entire cart
  - `getTotalItems()` - return total number of items (sum of quantities)
  - `getSubtotal()` - return sum of all item subtotals
- **FR-23.5**: Cart should have mock data for initial testing (2-3 products)

### FR-24: Shopping Bag Icon & Badge
- **FR-24.1**: The shopping bag icon already exists in `app_header.dart` (line ~310)
- **FR-24.2**: Wrap the shopping bag icon with a `Badge` widget when cart has items
- **FR-24.3**: Badge should display the total number of items in cart (use `getTotalItems()`)
- **FR-24.4**: Badge styling:
  - Background color: `0xFF4d2963` (primary color)
  - Text color: white
  - Position: top-right corner of icon
  - Font size: 12px, bold
- **FR-24.5**: Badge should only display when `getTotalItems() > 0`
- **FR-24.6**: Update the shopping bag icon's `onPressed` to navigate to `/cart` route

### FR-25: Cart Page - Empty State
- **FR-25.1**: Create a new `CartPage` widget in `lib/views/cart_page.dart`
- **FR-25.2**: Wrap page with `AppScaffold` with `currentRoute: '/cart'`
- **FR-25.3**: When cart is empty (`getTotalItems() == 0`), display:
  - Large shopping bag icon (`Icons.shopping_bag_outlined`, size 80, color grey)
  - Message: "Your cart is empty" (24px, bold, centered)
  - Subtitle: "Add items to get started" (14px, grey, centered)
  - "Continue Shopping" button:
    - Text: "CONTINUE SHOPPING"
    - Style: Outlined button with primary color border
    - Action: Navigate to home page `/`
- **FR-25.4**: Empty state should be vertically and horizontally centered
- **FR-25.5**: Add 16px padding on mobile, 24px on desktop

### FR-26: Cart Page - With Items
- **FR-26.1**: When cart has items, display a two-column layout:
  - Left column (or full width on mobile): List of cart items
  - Right column (or below items on mobile): Cart summary section
- **FR-26.2**: Page should have page title "Shopping Cart" at the top
- **FR-26.3**: Cart items should be displayed in a `ListView` or `Column` with scrolling
- **FR-26.4**: Layout should be responsive:
  - Mobile (< 900px): Single column, items above summary
  - Desktop (≥ 900px): Two columns, 60/40 split

### FR-27: Cart Item Card
- **FR-27.1**: Each cart item should be displayed in a card with white background and subtle shadow
- **FR-27.2**: Card layout (horizontal row):
  - **Product Image**: 80x80px thumbnail on the left
  - **Product Details**: Column in the middle containing:
    - Product name (16px, bold, black)
    - Variant details if available (12px, grey, e.g., "Size: M, Color: Blue")
    - Unit price (14px, grey, format: "£19.99")
  - **Quantity Controls**: Row on the right containing:
    - Minus button (-) to decrease quantity
    - Quantity display (centered, bold)
    - Plus button (+) to increase quantity
  - **Item Subtotal**: Below quantity controls (14px, bold, black, format: "£39.98")
  - **Remove Button**: Trash icon button at top-right corner
- **FR-27.3**: Card should have 12px padding and 12px margin between cards
- **FR-27.4**: On mobile, stack elements vertically instead of horizontally

### FR-28: Quantity Controls
- **FR-28.1**: Quantity selector should have three components:
  - **Minus button**: IconButton with `Icons.remove`, grey border, 32x32px
  - **Quantity display**: Text showing current quantity, centered, 40px wide
  - **Plus button**: IconButton with `Icons.add`, grey border, 32x32px
- **FR-28.2**: Minus button behavior:
  - If quantity > 1: Decrease quantity by 1, update subtotal and totals
  - If quantity = 1: Show confirmation dialog (see FR-29)
- **FR-28.3**: Plus button behavior:
  - Increase quantity by 1 (max 99)
  - Update subtotal and totals immediately
- **FR-28.4**: Buttons should have hover effect on desktop (darker border color)
- **FR-28.5**: Quantity changes should call `updateQuantity()` in CartProvider

### FR-29: Remove Item Confirmation
- **FR-29.1**: When user clicks minus button at quantity 1 OR clicks trash icon, show confirmation dialog
- **FR-29.2**: Dialog title: "Remove from cart?"
- **FR-29.3**: Dialog content: "Are you sure you want to remove [Product Name] from your cart?"
- **FR-29.4**: Dialog actions:
  - **CANCEL** button: TextButton, dismiss dialog, no changes
  - **REMOVE** button: TextButton with red text, call `removeItem()`, dismiss dialog
- **FR-29.5**: After removal:
  - Show SnackBar: "Item removed from cart"
  - Update cart badge immediately
  - If cart becomes empty, show empty state

### FR-30: Cart Summary Section
- **FR-30.1**: Display cart summary in a container with white background and subtle border
- **FR-30.2**: Summary should have 16px padding
- **FR-30.3**: Summary should contain:
  - **Header**: "Order Summary" (18px, bold)
  - **Subtotal row**: "Subtotal" label + amount (format: "£59.97")
  - **Shipping row**: "Shipping" label + "FREE" or amount
  - **Divider line** (grey, 1px)
  - **Total row**: "Total" label (bold) + amount (bold, 20px, format: "£59.97")
- **FR-30.4**: Subtotal should be calculated from all item subtotals
- **FR-30.5**: Format all prices with £ symbol and 2 decimal places
- **FR-30.6**: Spacing: 12px between rows, 16px around divider

### FR-31: Checkout Button
- **FR-31.1**: Place a prominent "Checkout" button at the bottom of cart summary
- **FR-31.2**: Button styling:
  - Background color: `0xFF4d2963` (primary color)
  - Text: "PROCEED TO CHECKOUT" (white, bold, 16px)
  - Full width of summary container
  - Height: 48px
  - Rounded corners: 8px
- **FR-31.3**: Button should have hover effect on desktop (slightly darker shade)
- **FR-31.4**: Button `onPressed` should show a SnackBar: "Checkout functionality coming soon!"
- **FR-31.5**: Button should be disabled (grey color) when cart is empty

### FR-32: Route Configuration
- **FR-32.1**: Add `/cart` route to the routes map in `main.dart`
- **FR-32.2**: Route should return `const CartPage()`
- **FR-32.3**: Import `CartPage` and `CartProvider` in `main.dart`

### FR-33: Provider Setup
- **FR-33.1**: Wrap `MaterialApp` in `main.dart` with `ChangeNotifierProvider<CartProvider>`
- **FR-33.2**: Create `lib/providers/cart_provider.dart` file
- **FR-33.3**: CartProvider should extend `ChangeNotifier`
- **FR-33.4**: Add mock data in CartProvider constructor for testing:
  ```dart
  _items = [
    CartItem(
      id: '1',
      productName: 'Union Shop T-Shirt',
      imageUrl: 'assets/images/products/tshirt.jpg',
      price: 19.99,
      quantity: 2,
    ),
    CartItem(
      id: '2',
      productName: 'Union Hoodie',
      imageUrl: 'assets/images/products/hoodie.jpg',
      price: 39.99,
      quantity: 1,
      size: 'M',
    ),
  ];
  ```

## User Actions & Expected Behavior

### Action 1: User clicks shopping bag icon (empty cart)
**Steps:**
1. User clicks shopping bag icon in header
2. App navigates to `/cart` route
3. Cart page loads

**Expected Behavior:**
- Page displays empty cart state
- Large shopping bag icon centered on screen
- Text: "Your cart is empty"
- "Continue Shopping" button visible
- No cart items or summary section displayed
- Shopping bag icon in header has no badge

---

### Action 2: User clicks shopping bag icon (cart has items)
**Steps:**
1. User clicks shopping bag icon in header (badge shows "3")
2. App navigates to `/cart` route
3. Cart page loads with items

**Expected Behavior:**
- Page displays "Shopping Cart" title
- List of cart items displayed (2 items in mock data)
- Each item shows image, name, price, quantity controls, subtotal
- Cart summary section shows:
  - Subtotal: £59.97 (19.99×2 + 39.99×1)
  - Shipping: FREE
  - Total: £59.97
- "PROCEED TO CHECKOUT" button visible
- Shopping bag badge shows "3" (2 + 1 items)

---

### Action 3: User increases quantity of an item
**Steps:**
1. User is on cart page with items
2. User clicks the "+" button on "Union Shop T-Shirt" (current qty: 2)

**Expected Behavior:**
- Quantity increases to 3 immediately
- Item subtotal updates to £59.97 (19.99 × 3)
- Cart subtotal updates to £79.96
- Cart total updates to £79.96
- Shopping bag badge updates to "4"
- No page reload or navigation

---

### Action 4: User decreases quantity (qty > 1)
**Steps:**
1. User is on cart page
2. "Union Shop T-Shirt" has quantity 3
3. User clicks the "-" button

**Expected Behavior:**
- Quantity decreases to 2 immediately
- Item subtotal updates to £39.98
- Cart totals update
- Shopping bag badge updates to "3"
- No confirmation dialog shown

---

### Action 5: User decreases quantity (qty = 1)
**Steps:**
1. User is on cart page
2. "Union Hoodie" has quantity 1
3. User clicks the "-" button

**Expected Behavior:**
- Confirmation dialog appears
- Dialog title: "Remove from cart?"
- Dialog message: "Are you sure you want to remove Union Hoodie from your cart?"
- Two buttons: "CANCEL" and "REMOVE"
- Cart is not changed until user confirms

---

### Action 6: User confirms item removal (from qty decrease)
**Steps:**
1. Confirmation dialog is open (from Action 5)
2. User clicks "REMOVE" button

**Expected Behavior:**
- Dialog closes
- "Union Hoodie" item is removed from cart list
- SnackBar appears: "Item removed from cart"
- Cart subtotal updates to £39.98 (only T-Shirt remains)
- Shopping bag badge updates to "2"
- If this was the last item, empty cart state appears

---

### Action 7: User cancels item removal
**Steps:**
1. Confirmation dialog is open
2. User clicks "CANCEL" button

**Expected Behavior:**
- Dialog closes
- No changes to cart
- Item quantity remains at 1
- Totals unchanged

---

### Action 8: User clicks trash icon to remove item
**Steps:**
1. User is on cart page with items
2. User clicks trash icon on "Union Shop T-Shirt"

**Expected Behavior:**
- Same confirmation dialog appears as in Action 5
- Dialog message: "Are you sure you want to remove Union Shop T-Shirt from your cart?"
- User can confirm or cancel
- If confirmed, item is removed and totals update

---

### Action 9: User removes last item from cart
**Steps:**
1. Cart has only 1 item remaining
2. User removes that item (trash icon or qty decrease)
3. User confirms removal

**Expected Behavior:**
- Item is removed
- Cart transitions to empty state
- Shopping bag icon in header shows no badge
- Empty cart message and icon displayed
- "Continue Shopping" button appears
- No cart summary section displayed

---

### Action 10: User clicks "Continue Shopping" button
**Steps:**
1. User is viewing empty cart state
2. User clicks "CONTINUE SHOPPING" button

**Expected Behavior:**
- App navigates to home page `/`
- User can browse products
- Cart remains empty
- Shopping bag icon has no badge

---

### Action 11: User clicks "Checkout" button
**Steps:**
1. User is on cart page with items
2. User clicks "PROCEED TO CHECKOUT" button

**Expected Behavior:**
- SnackBar appears: "Checkout functionality coming soon!"
- User remains on cart page
- Cart state unchanged
- No navigation occurs

---

### Action 12: User navigates away and returns to cart
**Steps:**
1. User is on cart page with 3 items
2. User clicks "Union Shop" logo to go home
3. User clicks shopping bag icon again

**Expected Behavior:**
- Cart state is preserved
- Same 3 items still in cart
- Quantities and totals unchanged
- Shopping bag badge still shows "3"
- Cart page displays same items as before

---

## Technical Specifications

### Data Models

Create `lib/models/cart_item.dart`:
```dart
class CartItem {
  final String id;
  final String productName;
  final String imageUrl;
  final double price;
  int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.size,
    this.color,
  });

  double get subtotal => price * quantity;

  String get formattedPrice => '£${price.toStringAsFixed(2)}';
  String get formattedSubtotal => '£${subtotal.toStringAsFixed(2)}';
}
```

### CartProvider Structure

Create `lib/providers/cart_provider.dart`:
```dart
class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  int getTotalItems() {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }
  
  void updateQuantity(String productId, int newQuantity) {
    // Implementation
    notifyListeners();
  }
  
  void removeItem(String productId) {
    // Implementation
    notifyListeners();
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
```

### Responsive Breakpoints
- **Mobile**: width < 900px (single column layout)
- **Desktop**: width ≥ 900px (two column layout)

### Color Scheme
- **Primary Color**: `0xFF4d2963`
- **Background**: `Colors.grey[50]` or white
- **Text Primary**: `Colors.black87`
- **Text Secondary**: `Colors.grey[600]`
- **Border**: `Colors.grey[300]`
- **Error/Remove**: `Colors.red[700]`

## Success Criteria

- ✅ Shopping bag icon in header displays badge when cart has items
- ✅ Badge shows correct total item count at all times
- ✅ Clicking shopping bag icon navigates to cart page
- ✅ Empty cart state displays when cart is empty
- ✅ Cart items display correctly with all information
- ✅ Quantity controls work and update totals immediately
- ✅ Remove confirmation dialog appears when appropriate
- ✅ Item removal works and updates cart state
- ✅ Cart summary displays correct calculations
- ✅ Checkout button shows placeholder feedback
- ✅ Cart state persists during app navigation
- ✅ Layout is responsive on mobile and desktop
- ✅ All prices formatted correctly with £ symbol
- ✅ No console errors during cart operations
- ✅ Provider pattern correctly implemented and accessible globally