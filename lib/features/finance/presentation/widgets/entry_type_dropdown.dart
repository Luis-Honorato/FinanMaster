import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class EntryTypeDropdown extends StatelessWidget {
  final EntryType? value;
  final void Function(EntryType?) onChanged;
  final String? Function(EntryType?)? validator;

  const EntryTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<EntryType>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: AppColors.grayDefault),
        filled: true,
        fillColor:
            value == EntryType.income ? AppColors.bluePrimary : AppColors.red,
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
          value == EntryType.income ? AppColors.bluePrimary : AppColors.red,
      borderRadius: BorderRadius.circular(12),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      items: EntryType.values.map((type) {
        return DropdownMenuItem<EntryType>(
          value: type,
          child: Text(
            type == EntryType.income ? 'Receita' : 'Despesa',
          ),
        );
      }).toList(),
    );
  }
}
