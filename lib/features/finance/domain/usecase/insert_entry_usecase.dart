import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class InsertEntryUsecase {
  final IFinanceRepository _repository;

  InsertEntryUsecase({
    required IFinanceRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, void>> call(EntriesCompanion entry) async =>
      _repository.insertEntry(entry);
}
