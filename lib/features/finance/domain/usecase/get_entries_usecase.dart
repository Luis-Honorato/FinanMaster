import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/data/database/app_database.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class GetEntriesUsecase {
  final IFinanceRepository _repository;

  GetEntriesUsecase({
    required IFinanceRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Stream<List<Entry>>>> call({
    int? month,
    int? year,
  }) async {
    final now = DateTime.now();
    return _repository.getEntries(
      month: month ?? now.month,
      year: year ?? now.year,
    );
  }
}
