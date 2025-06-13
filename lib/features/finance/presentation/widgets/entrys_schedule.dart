import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/model/entry_type_enum.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entry_item.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class EntrysSchedule extends StatefulWidget {
  const EntrysSchedule({super.key});

  @override
  State<EntrysSchedule> createState() => _EntrysScheduleState();
}

class _EntrysScheduleState extends State<EntrysSchedule>
    with AutomaticKeepAliveClientMixin {
  late final FinanceBloc _bloc;
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<FinanceBloc>(
      context,
      listen: false,
    )..add(
        GetEntriesEvent(),
      );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FinanceBloc, FinanceState>(
      bloc: _bloc,
      buildWhen: (previous, current) =>
          previous.entriesRequestState != current.entriesRequestState,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => _bloc.add(RewindSelectedDateTime()),
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: AppColors.grayDefault,
                    ),
                  ),
                  Text(
                    '${nomeDoMes(state.selectedDateTime.month)} de ${state.selectedDateTime.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _bloc.add(ForwardSelectedDateTime()),
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: AppColors.grayDefault,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Entry>>(
                  stream: state.entriesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final entries = snapshot.data;
                      if (entries == null || entries.isEmpty) {
                        return const Center(
                          child: Text(
                            'Ainda sem movimentações neste mês',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          controller: ScrollController(initialScrollOffset: 0),
                          shrinkWrap: true,
                          itemCount: entries.length,
                          itemBuilder: (context, index) {
                            final currentEntry = entries[index];
                            return EntryItem(
                              isCoust: currentEntry.entryType ==
                                  EntryType.expense.name,
                              entryCategory: currentEntry.entryCategory,
                              entryValue: currentEntry.value,
                              comment: currentEntry.description,
                              dateTime: currentEntry.entryDate,
                              entryId: currentEntry.id,
                              bloc: _bloc,
                            );
                          });
                    }
                    return const SizedBox(
                      height: 50,
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        );
      },
    );
  }

  String nomeDoMes(int mes) {
    const meses = [
      '',
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    if (mes < 1 || mes > 12) {
      throw ArgumentError('Mês inválido: $mes. Use um valor de 1 a 12.');
    }

    return meses[mes];
  }

  @override
  bool get wantKeepAlive => true;
}
