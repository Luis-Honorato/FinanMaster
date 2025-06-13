import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/add_entry_modal.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class InfosView extends StatefulWidget {
  const InfosView({super.key});

  @override
  State<InfosView> createState() => _InfosViewState();
}

class _InfosViewState extends State<InfosView> {
  final now = DateTime.now();
  late final FinanceBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<FinanceBloc>(
      context,
      listen: false,
    )..add(GetMonthlyBalanceEvent(
        dateTime: now,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seja Bem vindo!',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${now.day}/${now.month < 10 ? '0${now.month}' : now.month}/${now.year}',
                    style: const TextStyle(
                      color: AppColors.grayDefault,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: MediaQuery.sizeOf(context).height / 1.1,
                    ),
                    builder: (ctx) => AddEntryModal(
                      financeBloc: _bloc,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.bluePrimary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Saldo Mensal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<FinanceBloc, FinanceState>(
                        bloc: _bloc,
                        buildWhen: (previous, current) =>
                            previous.monthlyBalance != current.monthlyBalance,
                        builder: (context, state) {
                          final balanceStream = state.monthlyBalance;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<double?>(
                                  stream: balanceStream,
                                  builder: (context, snapshot) {
                                    final balance = snapshot.data;
                                    return Text(
                                      'R\$: ${balance?.toStringAsFixed(2).replaceAll('.', ',') ?? '0,00'}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
