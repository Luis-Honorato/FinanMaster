import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_category.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/notifiers/seleceted_entry_category_notifier.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/notifiers/selected_entry_type_notifier.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_category_dropdown.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_type_dropdown.dart';

class EntryTypeButtons extends StatelessWidget {
  final SelectedEntryTypeNotifier selectedEntryTypeNotifier;
  final SelectedEntryCategoryNotifier selectedEntryCategoryNotifier;
  const EntryTypeButtons({
    super.key,
    required this.selectedEntryTypeNotifier,
    required this.selectedEntryCategoryNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EntryType>(
        valueListenable: selectedEntryTypeNotifier.entryType,
        builder: (context, entryType, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.25,
                child: EntryTypeDropdown(
                  value: entryType,
                  onChanged: (type) {
                    selectedEntryTypeNotifier.setEntryType(type);
                    if (type == EntryType.income) {
                      selectedEntryCategoryNotifier
                          .setCategoryType(IncomeCategory.salary);
                    } else {
                      selectedEntryCategoryNotifier
                          .setCategoryType(ExpenseCategory.food);
                    }
                  },
                  validator: (type) {
                    if (type == null) return 'Selecione o tipo';
                    return null;
                  },
                ),
              ),
              ValueListenableBuilder<EntryCategory>(
                valueListenable: selectedEntryCategoryNotifier.category,
                builder: (context, category, _) {
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.25,
                    child: EntryCategoryDropdown(
                      entryType: entryType,
                      selectedCategory: category,
                      onChanged: (cat) =>
                          selectedEntryCategoryNotifier.setCategoryType(cat),
                      validator: (cat) =>
                          cat == null ? 'Selecione a categoria' : null,
                    ),
                  );
                },
              ),
            ],
          );
        });
  }
}
