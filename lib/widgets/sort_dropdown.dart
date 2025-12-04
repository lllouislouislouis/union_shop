import 'package:flutter/material.dart';

/// Reusable sort dropdown widget
/// Used by Sale page and Clothing page to sort products
class SortDropdown extends StatelessWidget {
  final String selectedSort;
  final List<String> sortOptions;
  final ValueChanged<String> onChanged;
  final bool fullWidth;

  const SortDropdown({
    super.key,
    required this.selectedSort,
    required this.sortOptions,
    required this.onChanged,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 220,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedSort,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[900],
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Colors.white,
          items: sortOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null && newValue != selectedSort) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
