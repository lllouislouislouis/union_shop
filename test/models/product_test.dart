import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('Product instantiation with all fields', () {
      // Arrange & Act
      final product = Product(
        id: 'test-001',
        title: 'Test Product',
        price: 25.00,
        originalPrice: 35.00,
        imageUrl: 'assets/images/test.jpg',
        availableColors: ['Red', 'Blue'],
        availableSizes: ['S', 'M', 'L'],
        description: 'Test description',
        maxStock: 10,
      );

      // Assert
      expect(product.id, 'test-001');
      expect(product.title, 'Test Product');
      expect(product.price, 25.00);
      expect(product.originalPrice, 35.00);
      expect(product.imageUrl, 'assets/images/test.jpg');
      expect(product.availableColors, ['Red', 'Blue']);
      expect(product.availableSizes, ['S', 'M', 'L']);
      expect(product.description, 'Test description');
      expect(product.maxStock, 10);
    });

    test('Product instantiation with default values', () {
      // Arrange & Act
      final product = Product(
        id: 'test-002',
        title: 'Simple Product',
        price: 10.00,
        imageUrl: 'assets/images/simple.jpg',
        description: 'Simple test',
      );

      // Assert
      expect(product.originalPrice, isNull);
      expect(product.availableColors, isEmpty);
      expect(product.availableSizes, isEmpty);
      expect(product.maxStock, 10); // default value
    });

    group('isOnSale getter', () {
      test('returns true when originalPrice exists and is greater than price', () {
        // Arrange
        final product = Product(
          id: 'sale-001',
          title: 'Sale Product',
          price: 15.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/sale.jpg',
          description: 'On sale',
        );

        // Act & Assert
        expect(product.isOnSale, isTrue);
      });

      test('returns false when originalPrice is null', () {
        // Arrange
        final product = Product(
          id: 'regular-001',
          title: 'Regular Product',
          price: 15.00,
          imageUrl: 'assets/images/regular.jpg',
          description: 'Not on sale',
        );

        // Act & Assert
        expect(product.isOnSale, isFalse);
      });

      test('returns false when originalPrice equals price', () {
        // Arrange
        final product = Product(
          id: 'equal-001',
          title: 'Equal Price Product',
          price: 15.00,
          originalPrice: 15.00,
          imageUrl: 'assets/images/equal.jpg',
          description: 'Same price',
        );

        // Act & Assert
        expect(product.isOnSale, isFalse);
      });

      test('returns false when originalPrice is less than price', () {
        // Arrange
        final product = Product(
          id: 'reverse-001',
          title: 'Reverse Price Product',
          price: 20.00,
          originalPrice: 15.00,
          imageUrl: 'assets/images/reverse.jpg',
          description: 'Price increased',
        );

        // Act & Assert
        expect(product.isOnSale, isFalse);
      });
    });

    group('discountPercentage getter', () {
      test('calculates correct discount percentage', () {
        // Arrange
        final product = Product(
          id: 'discount-001',
          title: 'Discount Product',
          price: 12.99,
          originalPrice: 18.99,
          imageUrl: 'assets/images/discount.jpg',
          description: '32% off',
        );

        // Act
        final discount = product.discountPercentage;

        // Assert
        expect(discount, 32); // (18.99 - 12.99) / 18.99 * 100 = 31.6% rounded to 32%
      });

      test('returns 0 when originalPrice is null', () {
        // Arrange
        final product = Product(
          id: 'no-discount-001',
          title: 'No Discount Product',
          price: 15.00,
          imageUrl: 'assets/images/no-discount.jpg',
          description: 'Regular price',
        );

        // Act & Assert
        expect(product.discountPercentage, 0);
      });

      test('returns 0 when originalPrice is zero', () {
        // Arrange
        final product = Product(
          id: 'zero-original-001',
          title: 'Zero Original Product',
          price: 10.00,
          originalPrice: 0.00,
          imageUrl: 'assets/images/zero.jpg',
          description: 'Zero original',
        );

        // Act & Assert
        expect(product.discountPercentage, 0);
      });

      test('calculates 50% discount correctly', () {
        // Arrange
        final product = Product(
          id: 'half-price-001',
          title: 'Half Price Product',
          price: 10.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/half.jpg',
          description: '50% off',
        );

        // Act & Assert
        expect(product.discountPercentage, 50);
      });

      test('rounds discount percentage to nearest integer', () {
        // Arrange
        final product = Product(
          id: 'rounding-001',
          title: 'Rounding Test Product',
          price: 16.00,
          originalPrice: 25.00,
          imageUrl: 'assets/images/rounding.jpg',
          description: 'Test rounding',
        );

        // Act
        final discount = product.discountPercentage;

        // Assert
        // (25 - 16) / 25 * 100 = 36%
        expect(discount, 36);
      });
    });

    group('requiresColorSelection getter', () {
      test('returns true when colors are available', () {
        // Arrange
        final product = Product(
          id: 'color-001',
          title: 'Colorful Product',
          price: 20.00,
          imageUrl: 'assets/images/color.jpg',
          availableColors: ['Red', 'Blue', 'Green'],
          description: 'Multiple colors',
        );

        // Act & Assert
        expect(product.requiresColorSelection, isTrue);
      });

      test('returns false when no colors are available', () {
        // Arrange
        final product = Product(
          id: 'no-color-001',
          title: 'Single Color Product',
          price: 20.00,
          imageUrl: 'assets/images/single.jpg',
          description: 'No color options',
        );

        // Act & Assert
        expect(product.requiresColorSelection, isFalse);
      });
    });

    group('requiresSizeSelection getter', () {
      test('returns true when sizes are available', () {
        // Arrange
        final product = Product(
          id: 'size-001',
          title: 'Sized Product',
          price: 30.00,
          imageUrl: 'assets/images/sized.jpg',
          availableSizes: ['S', 'M', 'L', 'XL'],
          description: 'Multiple sizes',
        );

        // Act & Assert
        expect(product.requiresSizeSelection, isTrue);
      });

      test('returns false when no sizes are available', () {
        // Arrange
        final product = Product(
          id: 'no-size-001',
          title: 'One Size Product',
          price: 15.00,
          imageUrl: 'assets/images/onesize.jpg',
          description: 'No size options',
        );

        // Act & Assert
        expect(product.requiresSizeSelection, isFalse);
      });
    });
  });
}
