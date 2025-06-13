import 'package:dartz/dartz.dart';
import 'package:gerenciamento_financeiro/features/finance/domain/repository/i_finance_repository.dart';
import 'package:gerenciamento_financeiro/features/finance/utils/erros/failure.dart';

class DeleteEntryUsecase {
  final IFinanceRepository _repository;

  DeleteEntryUsecase({
    required IFinanceRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, void>> call(int id) async =>
      _repository.deleteEntry(id: id);
}
