import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/add_entry_modal.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entrys_schedule.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/infos_view.dart';

class HomePage extends StatefulWidget {
  final FinanceBloc bloc;
  const HomePage({
    super.key,
    required this.bloc,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: MediaQuery.sizeOf(context).height / 1.1,
            ),
            builder: (ctx) => AddEntryModal(
              financeBloc: widget.bloc,
            ),
          );
        },
        icon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(18.0),
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Color(0xFF2B2F59),
              Color(0xFF1C1E3A),
              Color(0xFF0F1123),
            ],
          ),
        ),
        child: const Column(
          children: [
            InfosView(),
            Expanded(child: EntrysSchedule()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
