import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
    this.onSearchPressed,
    this.onTermsPressed,
    this.breakpoint = 800,
    this.backgroundColor,
    this.primaryColor = const Color(0xFF4d2963),
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    this.columnGap = 32,
    this.itemSpacing = 16,
  });

  final VoidCallback? onSearchPressed;
  final VoidCallback? onTermsPressed;

  // Layout/styling
  final double breakpoint;
  final Color? backgroundColor;
  final Color primaryColor;
  final EdgeInsetsGeometry padding;
  final double columnGap;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? Colors.grey[200];
    const textColor = Colors.black87;

    return Material(
      color: bg,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth <= breakpoint;

          final openingHours = _FooterSection(
            title: 'Opening hours',
            titleStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            spacing: itemSpacing,
            children: const [
              SelectableText('Monday–Friday: 9:00–17:00'),
              SelectableText('Saturday: 10:00–16:00'),
              SelectableText('Sunday: Closed'),
            ],
          );

          final helpInfo = _FooterSection(
            title: 'Help & information',
            titleStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            spacing: itemSpacing,
            children: [
              // Search button
              Semantics(
                button: true,
                label: 'Search',
                child: ElevatedButton.icon(
                  onPressed: onSearchPressed,
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 48), // >= 44x44
                  ),
                ),
              ),
              // Terms button
              Semantics(
                button: true,
                label: 'Terms & Conditions of Sale',
                child: OutlinedButton(
                  onPressed: onTermsPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor),
                    minimumSize: const Size(120, 48), // >= 44x44
                  ),
                  child: const Text('Terms & Conditions of Sale'),
                ),
              ),
            ],
          );

          if (isMobile) {
            return Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  openingHours,
                  SizedBox(height: columnGap / 2),
                  helpInfo,
                ],
              ),
            );
          }

          return Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: openingHours),
                SizedBox(width: columnGap),
                Expanded(child: helpInfo),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection({
    required this.title,
    required this.children,
    this.titleStyle,
    this.spacing = 16,
  });

  final String title;
  final List<Widget> children;
  final TextStyle? titleStyle;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              title,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
          ),
          SizedBox(height: spacing),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
                  .expand((w) => [w, SizedBox(height: spacing)])
                  .toList()
                ..removeLast(),
            ),
          ),
        ],
      ),
    );
  }
}
