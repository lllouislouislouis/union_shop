import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class PersonalisationPage extends StatelessWidget {
  const PersonalisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      currentRoute: '/print-shack/personalisation',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Personalisation Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Create your personalised products here.'),
            ],
          ),
        ),
      ),
    );
  }
}
