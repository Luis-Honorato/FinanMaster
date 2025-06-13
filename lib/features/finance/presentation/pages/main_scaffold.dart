import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/daos/entry_dao.dart';
import 'package:gerenciamento_financeiro/features/finance/data/repository/finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/delete_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/get_entries_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/get_monthly_balance_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/insert_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/usecase/update_entry_usecase.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/bloc/finance_bloc.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/pages/home_page.dart';
import 'package:gerenciamento_financeiro/features/finance/presentation/pages/insights_page.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/colors/app_colors.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  late final AppDatabase _db;
  late final EntryDao _entryDao;
  late final IFinanceRepository _financeRepository;
  late final GetEntriesUsecase _getEntriesUsecase;
  late final GetMonthlyBalanceUsecase _getMonthlyBalanceUsecase;
  late final DeleteEntryUsecase _deleteEntryUsecase;
  late final InsertEntryUsecase _insertEntryUsecase;
  late final UpdateEntryUsecase _updateEntryUsecase;
  late final FinanceBloc _bloc;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _entryDao = _db.entryDao;
    _financeRepository = FinanceRepository(entryDao: _entryDao);
    _getEntriesUsecase = GetEntriesUsecase(repository: _financeRepository);
    _getMonthlyBalanceUsecase =
        GetMonthlyBalanceUsecase(repository: _financeRepository);
    _deleteEntryUsecase = DeleteEntryUsecase(repository: _financeRepository);
    _insertEntryUsecase = InsertEntryUsecase(repository: _financeRepository);
    _updateEntryUsecase = UpdateEntryUsecase(repository: _financeRepository);
    _bloc = FinanceBloc(
      getEntriesUsecase: _getEntriesUsecase,
      getMonthlyBalanceUsecase: _getMonthlyBalanceUsecase,
      deleteEntryUsecase: _deleteEntryUsecase,
      insertEntryUsecase: _insertEntryUsecase,
      updateEntryUsecase: _updateEntryUsecase,
    );
    _pages = [
      HomePage(
        bloc: _bloc,
      ),
      InsightsPage(entryDao: _entryDao),
    ];
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.grayDark,
          selectedItemColor: AppColors.bluePrimary,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Movimentações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Insights',
            ),
          ],
        ),
      ),
    );
  }
}
