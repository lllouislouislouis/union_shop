import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/policies/terms',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page heading
                const Text(
                  'Terms & Conditions of Sale',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963),
                  ),
                ),
                const SizedBox(height: 24),

                // Last updated date
                Text(
                  'Last updated: December 2024',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),

                // Introduction
                _buildSection(
                  title: '1. Introduction',
                  content:
                      'Welcome to Union Shop. By purchasing products from our shop, you agree to be bound by these Terms & Conditions of Sale. Please read them carefully before making a purchase.',
                ),

                // Orders and Payment
                _buildSection(
                  title: '2. Orders and Payment',
                  content:
                      'All orders are subject to acceptance and availability. We reserve the right to refuse any order. Payment must be made in full at the time of purchase. We accept major credit cards, debit cards, and other payment methods as displayed at checkout.',
                ),

                // Delivery and Collection
                _buildSection(
                  title: '3. Delivery and Collection',
                  content:
                      'Products are available for delivery or in-store collection. Delivery times and costs will be displayed at checkout. For in-store collection, you will be notified when your order is ready for pickup.',
                ),

                // Returns and Refunds
                _buildSection(
                  title: '4. Returns and Refunds',
                  content:
                      'We want you to be satisfied with your purchase. If you are not happy with your order, please contact us at hello@upsu.net within 14 days of receipt. Returns must be in original condition with tags attached. Personalized items cannot be returned unless faulty.',
                ),

                // Product Information
                _buildSection(
                  title: '5. Product Information',
                  content:
                      'We strive to provide accurate product descriptions and images. However, we cannot guarantee that colors displayed on your screen will exactly match the actual product colors. All sizes and measurements are approximate.',
                ),

                // Contact Information
                _buildSection(
                  title: '6. Contact Us',
                  content:
                      'If you have any questions about these Terms & Conditions, please contact us at hello@upsu.net or visit our shop during opening hours.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
