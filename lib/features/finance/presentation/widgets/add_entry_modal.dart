import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_category.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/notifiers/seleceted_entry_category_notifier.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/notifiers/selected_entry_type_notifier.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/date_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_type_buttons.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/finance_form_field.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';
import 'package:intl/intl.dart';

class AddEntryModal extends StatefulWidget {
  final FinanceBloc financeBloc;
  const AddEntryModal({
    super.key,
    required this.financeBloc,
  });

  @override
  State<AddEntryModal> createState() => _AddEntryModalState();
}

class _AddEntryModalState extends State<AddEntryModal> {
  late final TextEditingController _dateController;
  late final TextEditingController _valueController;
  late final TextEditingController _commentController;

  late final GlobalKey<FormState> _formKey;
  late final SelectedEntryTypeNotifier _selectedEntryTypeNotifier;
  late final SelectedEntryCategoryNotifier _selectedEntryCategoryNotifier;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _valueController = TextEditingController();
    _commentController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    _selectedEntryTypeNotifier = SelectedEntryTypeNotifier();
    _selectedEntryCategoryNotifier = SelectedEntryCategoryNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [
            Color(0xFF2B2F59),
            Color(0xFF1C1E3A),
            Color(0xFF0F1123),
          ],
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: EntryTypeButtons(
                selectedEntryTypeNotifier: _selectedEntryTypeNotifier,
                selectedEntryCategoryNotifier: _selectedEntryCategoryNotifier,
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: FinanceFormField(
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
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: DateFormField(
                  label: 'Data Movimentação*',
                  controller: _dateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FinanceFormField(
                controller: _commentController,
                label: 'Comentário',
              ),
            ),
            const SizedBox(height: 44),
            OutlinedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                final selectedCategory =
                    _selectedEntryCategoryNotifier.category.value;
                if (selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, selecione uma categoria.')),
                  );
                  return;
                }

                final newEntry = EntriesCompanion.insert(
                  entryType: entryTypeToString(
                    _selectedEntryTypeNotifier.entryType.value,
                  ),
                  entryCategory: categoryToLabel(
                    _selectedEntryCategoryNotifier.category.value,
                  ),
                  entryDate:
                      DateFormat('dd/MM/yyyy').parse(_dateController.text),
                  value:
                      double.parse(_valueController.text.replaceAll(',', '.')),
                  description: drift.Value(_commentController.text),
                );

                widget.financeBloc.add(
                  InsertEntryEvent(
                    entry: newEntry,
                  ),
                );

                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.bluePrimary,
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
