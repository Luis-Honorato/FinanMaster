import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/delete_entry_dialog.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/edit_entry_dialog.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class EntryItem extends StatelessWidget {
  final bool isCoust;
  final String entryCategory;
  final double entryValue;
  final String? comment;
  final DateTime dateTime;
  final int entryId;
  final FinanceBloc bloc;
  const EntryItem({
    super.key,
    required this.isCoust,
    required this.entryCategory,
    required this.entryValue,
    this.comment,
    required this.dateTime,
    required this.entryId,
    required this.bloc,
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
              '${dateTime.day}/${dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month}/${dateTime.year}',
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
                          entryCategory,
                          style: TextStyle(color: color),
                        ),
                        Text(
                          '${isCoust ? '-' : '+'} ${entryValue.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(color: color),
                        ),
                      ],
                    ),
                    if (comment != null) ...[
                      const SizedBox(width: 15),
                      FittedBox(
                        child: Text(
                          comment!,
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
                          builder: (ctx) => const EditEntrydialog(),
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
                            entryId: entryId,
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
