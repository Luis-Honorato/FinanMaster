import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/finance_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class DateFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final DateTime? initialValue;

  const DateFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.initialValue,
  });

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FinanceFormField(
      controller: widget.controller,
      validator: widget.validator,
      label: widget.label,
      prefixIcon: const Icon(
        Icons.calendar_today,
        color: AppColors.grayDefault,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }
}
