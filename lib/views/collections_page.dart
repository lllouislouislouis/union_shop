import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/collections',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FR-14.4: Heading (48px, purple, bold)
            const Text(
              'Collections',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(height: 16),

            // FR-14.5: Placeholder text
            const Text(
              'Browse all our product collections here.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),

            // Placeholder for future collection grid
            Text(
              'Collection categories will be displayed here.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
