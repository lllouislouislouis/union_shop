import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class PersonalisationPage extends StatelessWidget {
  const PersonalisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/print-shack/personalisation',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Personalisation Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Create your personalised products here.'),
            ],
          ),
        ),
      ),
    );
  }
}
