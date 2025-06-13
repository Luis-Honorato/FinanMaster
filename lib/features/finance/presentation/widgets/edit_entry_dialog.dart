import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/date_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/finance_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';
import 'package:intl/intl.dart';

class EditEntrydialog extends StatefulWidget {
  final Entry entry;
  final FinanceBloc bloc;
  const EditEntrydialog({
    super.key,
    required this.entry,
    required this.bloc,
  });

  @override
  State<EditEntrydialog> createState() => _EditEntrydialogState();
}

class _EditEntrydialogState extends State<EditEntrydialog> {
  late final TextEditingController _dateController;
  late final TextEditingController _valueController;
  late final TextEditingController _commentController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
        text:
            "${widget.entry.entryDate.day}/${widget.entry.entryDate.month}/${widget.entry.entryDate.year}");
    _valueController = TextEditingController(
      text: widget.entry.value.toString().replaceAll('.', ','),
    );
    _commentController = TextEditingController(
      text: widget.entry.description,
    );
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.grayDark,
      content: SizedBox(
        width: 380,
        height: 380,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Editar Lançamento',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 22),
              FinanceFormField(
                label: 'Valor*',
                controller: _valueController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                  return null;
                },
                prefixIcon: const Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.grayDefault,
                ),
              ),
              const SizedBox(height: 22),
              DateFormField(
                  initialValue: widget.entry.entryDate,
                  label: 'Data Movimentação*',
                  controller: _dateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  }),
              const SizedBox(height: 22),
              FinanceFormField(
                controller: _commentController,
                label: 'Comentário',
              ),
              const SizedBox(height: 44),
              OutlinedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final newEntry = EntriesCompanion.insert(
                    entryType: widget.entry.entryType,
                    entryCategory: widget.entry.entryCategory,
                    entryDate:
                        DateFormat('dd/MM/yyyy').parse(_dateController.text),
                    value: double.parse(
                        _valueController.text.replaceAll(',', '.')),
                    description: drift.Value(_commentController.text),
                    id: drift.Value<int>(widget.entry.id),
                  );

                  widget.bloc.add(UpdateEntryEvent(entry: newEntry));
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.bluePrimary,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
