import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/add_entry_modal.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_label.dart';

class InfosView extends StatelessWidget {
  const InfosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Text(
                  'Movimentações',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EntryLabel(entry: 5000.00, label: 'Receitas'),
                        EntryLabel(entry: -1760.00, label: 'Despesas'),
                        EntryLabel(entry: 3240.00, label: 'Saldo'),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: MediaQuery.sizeOf(context).height / 1.1,
                        ),
                        builder: (ctx) => const AddEntryModal(),
                      );
                    },
                    child: const Text('Novo Lançamento'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
