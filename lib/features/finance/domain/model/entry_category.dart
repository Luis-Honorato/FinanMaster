abstract interface class EntryCategory {
  String get label;
  bool get isIncome;
}

enum IncomeCategory implements EntryCategory {
  salary(label: 'Salário'),
  bonus(label: 'Bônus'),
  investment(label: 'Investimento'),
  others(label: 'Outros');

  @override
  final String label;

  const IncomeCategory({required this.label});

  @override
  bool get isIncome => true;
}

enum ExpenseCategory implements EntryCategory {
  food(label: 'Alimentação'),
  transport(label: 'Transporte'),
  entertainment(label: 'Lazer'),
  living(label: 'Moradia'),
  education(label: 'Educação'),
  basicExpenses(label: 'Contas Básicas'),
  others(label: 'Outros');

  @override
  final String label;

  const ExpenseCategory({required this.label});

  @override
  bool get isIncome => false;
}

EntryCategory categoryFromLabel(String label, bool isIncome) {
  if (isIncome) {
    return IncomeCategory.values.firstWhere((e) => e.label == label,
        orElse: () => IncomeCategory.others);
  } else {
    return ExpenseCategory.values.firstWhere((e) => e.label == label,
        orElse: () => ExpenseCategory.others);
  }
}

String categoryToLabel(EntryCategory category) => category.label;
