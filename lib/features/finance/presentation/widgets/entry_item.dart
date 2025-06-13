import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/delete_entry_dialog.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/edit_entry_dialog.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class EntryItem extends StatelessWidget {
  final Entry entry;
  final FinanceBloc bloc;
  const EntryItem({
    super.key,
    required this.entry,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final isCoust = entry.entryType == EntryType.expense.name;
    final color = isCoust ? Colors.red.shade300 : Colors.green.shade300;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.entryDate.day}/${entry.entryDate.month < 10 ? '0${entry.entryDate.month}' : entry.entryDate.month}/${entry.entryDate.year}',
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
                          entry.entryCategory,
                          style: TextStyle(color: color),
                        ),
                        Text(
                          '${isCoust ? '-' : '+'} ${entry.value.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(color: color),
                        ),
                      ],
                    ),
                    if (entry.description != null) ...[
                      const SizedBox(width: 15),
                      FittedBox(
                        child: Text(
                          entry.description!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grayDefault,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => EditEntrydialog(
                            entry: entry,
                            bloc: bloc,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.grayDefault,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => DeleteEntryDialog(
                            entryId: entry.id,
                            bloc: bloc,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.grayDefault,
                      ),
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
