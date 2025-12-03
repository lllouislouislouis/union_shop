import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/app_header.dart';

/// Shared layout scaffold that includes AppHeader, page content, and AppFooter.
/// Use this to wrap all page views for consistent header/footer across the app.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.currentRoute = '/',
  });

  /// The main content of the page
  final Widget child;

  /// Current route for header navigation highlighting
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          AppHeader(currentRoute: currentRoute),

          // Main content (scrollable)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  child,

                  // Footer
                  AppFooter(
                    onSearchPressed: () => _handleSearch(context),
                    onTermsPressed: () => _handleTerms(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle Search button press
  void _handleSearch(BuildContext context) {
    // Try to use SearchDelegate if available, otherwise navigate to /search
    // For now, just navigate to /search (SearchDelegate will be added in subtask 3)
    Navigator.pushNamed(context, '/search');
  }

  /// Handle Terms & Conditions button press
  void _handleTerms(BuildContext context) {
    Navigator.pushNamed(context, '/policies/terms');
  }
}