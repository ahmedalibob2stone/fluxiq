import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class CreateNewsCategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const CreateNewsCategoryDropdown({
    Key? key,
    required this.selectedCategory,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Select Category',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.category),
      ),
      items: AppConstants.publishCategories
          .map((cat) => DropdownMenuItem(
        value: cat,
        child: Text(cat),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}