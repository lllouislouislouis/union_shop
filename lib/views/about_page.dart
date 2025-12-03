import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/about',
      child: Padding(
        padding: const EdgeInsets.all(40.0),
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
                  'Welcome to the Union Shop!',
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
                  'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
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
                  'All online purchases are available for delivery or instore collection!',
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
                  'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.grey[800],
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 16),

                // Body text - Paragraph 5
                Text(
                  'Happy shopping!',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.grey[800],
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 16),

                // Body text - Paragraph 6
                Text(
                  'The Union Shop & Reception Team',
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
    );
  }
}
