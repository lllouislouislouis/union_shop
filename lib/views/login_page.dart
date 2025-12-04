import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // FR-20: Controllers for form fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // FR-20.6: Password visibility toggle state
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return AppScaffold(
      currentRoute: '/login',
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 24.0,
              vertical: 24.0,
            ),
            // FR-19.2, FR-19.3: Login form container
            child: Container(
              width: isMobile ? double.infinity : 400,
              decoration: BoxDecoration(
                color: Colors.white, // FR-19.3: White background
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Page title
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Username field will be added in next subtask
                  // Password field will be added in next subtask
                  // Login button will be added in next subtask

                  // Placeholder for form fields (to be implemented)
                  Container(
                    height: 200,
                    color: Colors.grey[100],
                    child: const Center(
                      child: Text('Form fields coming next...'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
