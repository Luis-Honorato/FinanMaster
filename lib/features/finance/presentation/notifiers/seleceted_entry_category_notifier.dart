import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_category.dart';

class SelectedEntryCategoryNotifier {
  final ValueNotifier<EntryCategory> category =
      ValueNotifier<EntryCategory>(IncomeCategory.salary);

  void setCategoryType(EntryCategory? category) {
    this.category.value = category ?? IncomeCategory.salary;
  }
}
