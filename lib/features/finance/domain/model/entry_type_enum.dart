enum EntryType { income, expense }

EntryType entryTypeFromString(String value) =>
    EntryType.values.firstWhere((e) => e.toString().split('.').last == value);

String entryTypeToString(EntryType type) => type.toString().split('.').last;
