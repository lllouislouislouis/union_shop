import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class ShopCategoryPage extends StatelessWidget {
  final String category;
  const ShopCategoryPage({super.key, required this.category});

  String get route => '/shop/$category';
  String get title => category.replaceAll('-', ' ').splitMapJoin(
        RegExp(r'\b\w'),
        onMatch: (m) => m.group(0)!.toUpperCase(),
        onNonMatch: (n) => n,
      );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: route,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4d2963),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Products for $title will appear here.',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
