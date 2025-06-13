import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

abstract class IFinanceRepository {
  Future<Either<Failure, void>> insertEntry(EntriesCompanion entry);
  Future<Either<Failure, Stream<List<Entry>>>> getEntries({
    required int month,
    required int year,
  });

  Future<Either<Failure, void>> updateEntry({
    required EntriesCompanion entry,
  });
  Future<Either<Failure, void>> deleteEntry({
    required int id,
  });
  Future<Either<Failure, Stream<double>>> getMonthlyBalance({
    required int month,
    required int year,
  });
}
