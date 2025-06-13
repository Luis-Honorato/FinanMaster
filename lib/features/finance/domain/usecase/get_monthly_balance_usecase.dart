import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class GetMonthlyBalanceUsecase {
  final IFinanceRepository _repository;

  GetMonthlyBalanceUsecase({
    required IFinanceRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Stream<double>>> call({
    int? month,
    int? year,
  }) async {
    final now = DateTime.now();
    return _repository.getMonthlyBalance(
      month: month ?? now.month,
      year: year ?? now.year,
    );
  }
}
