import 'package:flutter/material.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/entrys_schedule.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/widgets/infos_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          InfosView(),
          Expanded(child: EntrysSchedule()),
        ],
      ),
    );
  }
}
