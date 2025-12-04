import 'package:flutter/material.dart';

/// Reusable category filter dropdown widget
/// Used by Sale page and Clothing page to filter products by category
class CategoryFilterDropdown extends StatelessWidget {
  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onChanged;
  final bool fullWidth;

  const CategoryFilterDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null && newValue != selectedCategory) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
