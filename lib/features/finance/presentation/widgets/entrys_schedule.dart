import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_item.dart';

class EntrysSchedule extends StatelessWidget {
  const EntrysSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                  ),
                ),
                const Text(
                  'novembro de 2024',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              children: [
                EntryItem(
                  isCoust: false,
                  entryType: 'Salário',
                  entryValue: 3000,
                  comment: 'Sem o vale refeição',
                  dateTime: DateTime(2024, 11, 5),
                ),
                EntryItem(
                  isCoust: true,
                  entryType: 'Contas básicas',
                  entryValue: 300,
                  comment: 'Energia',
                  dateTime: DateTime(2024, 11, 5),
                ),
                EntryItem(
                  isCoust: true,
                  entryType: 'Contas básicas',
                  entryValue: 120,
                  comment: 'Internet',
                  dateTime: DateTime(2024, 11, 8),
                ),
                EntryItem(
                  isCoust: true,
                  entryType: 'Moradia',
                  entryValue: 1200,
                  comment: 'Aluguel',
                  dateTime: DateTime(2024, 11, 10),
                ),
                EntryItem(
                  isCoust: true,
                  entryType: 'Lazer',
                  entryValue: 20,
                  comment: 'Cinema',
                  dateTime: DateTime(2024, 11, 11),
                ),
                EntryItem(
                  isCoust: false,
                  entryType: 'Investimentos',
                  entryValue: 5000,
                  comment: 'Dividendos',
                  dateTime: DateTime(2024, 11, 11),
                ),
                EntryItem(
                  isCoust: true,
                  entryType: 'Outros',
                  entryValue: 120,
                  comment: 'Doação',
                  dateTime: DateTime(2024, 11, 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
