import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';

class SelectedEntryTypeNotifier {
  final ValueNotifier<EntryType> entryType =
      ValueNotifier<EntryType>(EntryType.income);

  void setEntryType(EntryType? entryType) {
    this.entryType.value = entryType ?? EntryType.income;
  }
}
