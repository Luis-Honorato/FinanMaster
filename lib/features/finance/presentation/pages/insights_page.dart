import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/daos/entry_dao.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/enums/request_state_enum.dart';

class InsightsPage extends StatefulWidget {
  final EntryDao entryDao;
  const InsightsPage({super.key, required this.entryDao});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<FinanceBloc, FinanceState>(
            builder: (context, state) {
              if (state.entriesRequestState != RequestState.success) {
                return const Center(child: CircularProgressIndicator());
              }

              return StreamBuilder<List<Entry>>(
                  stream: widget.entryDao.watchEntries(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
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
                    final grouped = _groupEntriesByMonth(snapshot.data!);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Insights Mensais',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Expanded(
                          child: BarChart(
                            BarChartData(
                              borderData: FlBorderData(show: false),
                              backgroundColor: Colors.transparent,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) => Text(
                                      value.toInt().toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    reservedSize: 40,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) {
                                      final label =
                                          grouped[value.toInt()].label;
                                      return Text(label,
                                          style: const TextStyle(
                                              color: Colors.white));
                                    },
                                    reservedSize: 36,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              barGroups: List.generate(
                                grouped.length,
                                (i) => BarChartGroupData(
                                  x: i,
                                  barsSpace: 4,
                                  barRods: [
                                    BarChartRodData(
                                      toY: grouped[i].income,
                                      color: AppColors.bluePrimary,
                                      width: 12,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    BarChartRodData(
                                      toY: grouped[i].expense,
                                      color: AppColors.red,
                                      width: 12,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ],
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              barTouchData: BarTouchData(enabled: true),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Despesas por Categoria (mês atual)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        StreamBuilder<List<Entry>>(
                            stream: state.entriesStream,
                            builder: (context, snapshot) {
                              if (snapshot.data == null ||
                                  snapshot.data!.isEmpty) {
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
                              return SizedBox(
                                height: 200,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 2,
                                    centerSpaceRadius: 40,
                                    borderData: FlBorderData(show: false),
                                    sections: _buildPieSections(
                                        _groupExpenseByCategory(
                                            snapshot.data!)),
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  List<_MonthlySummary> _groupEntriesByMonth(List<Entry> entries) {
    final now = DateTime.now();
    final summary = <_MonthlySummary>[];

    for (int i = 5; i >= 0; i--) {
      final target = DateTime(now.year, now.month - i);
      final filtered = entries.where((e) =>
          e.entryDate.month == target.month && e.entryDate.year == target.year);

      final income = filtered
          .where((e) => e.entryType == 'income')
          .fold(0.0, (sum, e) => sum + e.value);

      final expense = filtered
          .where((e) => e.entryType == 'expense')
          .fold(0.0, (sum, e) => sum + e.value);

      summary.add(_MonthlySummary(
        label: _monthLabel(target.month),
        income: income,
        expense: expense,
      ));
    }

    return summary;
  }

  String _monthLabel(int month) {
    const months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return months[month - 1];
  }

  Map<String, double> _groupExpenseByCategory(List<Entry> entries) {
    final now = DateTime.now();

    final currentMonthEntries = entries.where((e) =>
        e.entryType == 'expense' &&
        e.entryDate.month == now.month &&
        e.entryDate.year == now.year);

    final Map<String, double> grouped = {};

    for (final e in currentMonthEntries) {
      grouped[e.entryCategory] = (grouped[e.entryCategory] ?? 0) + e.value;
    }

    return grouped;
  }

  List<PieChartSectionData> _buildPieSections(Map<String, double> data) {
    final total = data.values.fold(0.0, (sum, v) => sum + v);
    final colors = [
      AppColors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.green,
      Colors.amber,
      Colors.indigo,
    ];

    int i = 0;
    return data.entries.map((e) {
      final percentage = (e.value / total * 100).toStringAsFixed(1);
      final color = colors[i++ % colors.length];
      return PieChartSectionData(
        color: color,
        value: e.value,
        radius: 50,
        title: '${e.key.split(' ').first}\n$percentage%',
        titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
        titlePositionPercentageOffset: 0.6,
      );
    }).toList();
  }

  @override
  bool get wantKeepAlive => true;
}

class _MonthlySummary {
  final String label;
  final double income;
  final double expense;

  _MonthlySummary({
    required this.label,
    required this.income,
    required this.expense,
  });
}

class Legend extends StatelessWidget {
  final Color color;
  final String label;

  const Legend({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
