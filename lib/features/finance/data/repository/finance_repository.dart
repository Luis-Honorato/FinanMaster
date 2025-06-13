import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/daos/entry_dao.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class FinanceRepository extends IFinanceRepository {
  final EntryDao _entryDao;

  FinanceRepository({
    required EntryDao entryDao,
  }) : _entryDao = entryDao;
  @override
  Future<Either<Failure, void>> insertEntry(EntriesCompanion entry) async {
    try {
      await _entryDao.insertEntry(entry);

      return const Right(null);
    } catch (e) {
      return Left(DaoFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Entry>>>> getEntries({
    required int month,
    required int year,
  }) async {
    try {
      final entries = await _entryDao.watchEntriesByMonthYear(
        month: month,
        year: year,
      );

      return Right(entries);
    } catch (e) {
      return Left(DaoFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEntry({
    required EntriesCompanion entry,
  }) async {
    try {
      await _entryDao.updateEntry(
        newEntry: entry,
        id: entry.id.value,
      );
      return const Right(null);
    } catch (e) {
      return Left(DaoFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEntry({
    required int id,
  }) async {
    try {
      await _entryDao.deleteEntry(
        id: id,
      );
      return const Right(null);
    } catch (e) {
      return Left(DaoFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<double>>> getMonthlyBalance({
    required int month,
    required int year,
  }) async {
    try {
      final balance = await _entryDao.watchMonthlyBalance(
        month: month,
        year: year,
      );

      return Right(balance);
    } catch (e) {
      return Left(DaoFailure(message: e.toString()));
    }
  }
}
