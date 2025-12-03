import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      currentRoute: '/product',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Product Page Placeholder',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  'This is where the product details will be displayed.'),
            ],
          ),
        ),
      ),
    );
  }
}
