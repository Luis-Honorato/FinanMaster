import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_category.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class EntryCategoryDropdown extends StatelessWidget {
  final EntryType entryType;
  final EntryCategory? selectedCategory;
  final void Function(EntryCategory?) onChanged;
  final String? Function(EntryCategory?)? validator;

  const EntryCategoryDropdown({
    super.key,
    required this.entryType,
    required this.selectedCategory,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final List<EntryCategory> categories = entryType == EntryType.income
        ? IncomeCategory.values as List<EntryCategory>
        : ExpenseCategory.values;

    return DropdownButtonFormField<EntryCategory>(
      value: selectedCategory,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: AppColors.grayDefault),
        filled: true,
        fillColor: entryType == EntryType.income
            ? AppColors.bluePrimary
            : AppColors.red,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      dropdownColor:
          entryType == EntryType.income ? AppColors.bluePrimary : AppColors.red,
      borderRadius: BorderRadius.circular(12),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      items: categories.map((cat) {
        return DropdownMenuItem<EntryCategory>(
          value: cat,
          child: Text(cat.label),
        );
      }).toList(),
    );
  }
}
