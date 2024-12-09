import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/delete_entry_dialog.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/edit_entry_dialog.dart';

class EntryItem extends StatelessWidget {
  final bool isCoust;
  final String entryType;
  final double entryValue;
  final String comment;
  final DateTime dateTime;
  const EntryItem({
    super.key,
    required this.isCoust,
    required this.entryType,
    required this.entryValue,
    required this.comment,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCoust ? Colors.red.shade300 : Colors.green.shade300;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isCoust ? Icons.arrow_downward : Icons.arrow_upward,
                      color: color,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entryType,
                          style: TextStyle(color: color),
                        ),
                        Text(
                          '${isCoust ? '-' : '+'} ${entryValue.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(color: color),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    FittedBox(
                      child: Text(
                        comment,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => const EditEntrydialog(),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => const DeleteEntryDialog(),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
