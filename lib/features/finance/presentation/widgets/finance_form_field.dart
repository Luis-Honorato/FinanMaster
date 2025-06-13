import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class FinanceFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;

  const FinanceFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      style: const TextStyle(
        color: AppColors.grayDefault,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        fillColor: AppColors.blueSecondary,
        filled: true,
        focusedBorder: _border,
        enabledBorder: _border,
        errorBorder: _border,
        labelStyle: const TextStyle(
          color: AppColors.grayDefault,
        ),
        contentPadding: const EdgeInsets.all(18),
      ),
      onTap: onTap,
      onChanged: onChanged,
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(
          color: AppColors.blueSecondary,
        ),
      );
}
