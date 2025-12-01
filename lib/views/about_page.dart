import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';

/// About page that provides information about the Union Shop
/// Uses the reusable AppHeader component for consistent navigation
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive padding
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final contentPadding = isDesktop ? 40.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with About highlighted as active
            const AppHeader(currentRoute: '/about'),

            // Content Area
            Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Center(
                child: ConstrainedBox(
                  // Limit content width for better readability
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top spacing
                      const SizedBox(height: 64),

                      // "About Us" Heading
                      const Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),

                      // Spacing between heading and body
                      const SizedBox(height: 24),

                      // Body text - Paragraph 1
                      Text(
                        'Welcome to the Union Shop, your go-to destination for quality products and merchandise. '
                        'We are committed to providing our community with exceptional goods and services that meet '
                        'your everyday needs.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Body text - Paragraph 2
                      Text(
                        'Our mission is to serve the student community by offering a wide range of products, '
                        'from essential supplies to unique merchandise. We pride ourselves on competitive pricing, '
                        'quality products, and excellent customer service.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Body text - Paragraph 3
                      Text(
                        'Whether you\'re looking for course materials, university branded items, or everyday essentials, '
                        'the Union Shop is here to support you throughout your academic journey. Visit us online or '
                        'in-store to discover our full range of offerings.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Body text - Paragraph 4
                      Text(
                        'Thank you for choosing the Union Shop. We look forward to serving you and being part of '
                        'your university experience.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                          letterSpacing: 0.2,
                        ),
                      ),

                      // Bottom spacing
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ),

            // Footer (same as HomeScreen)
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: const Text(
                'Placeholder Footer',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
