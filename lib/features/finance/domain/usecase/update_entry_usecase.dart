import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class UpdateEntryUsecase {
  final IFinanceRepository _repository;

  UpdateEntryUsecase({
    required IFinanceRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, void>> call(EntriesCompanion entry) async =>
      _repository.updateEntry(entry: entry);
}
