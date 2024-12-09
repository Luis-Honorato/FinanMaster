import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const DateFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
  }) : super(key: key);

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
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
