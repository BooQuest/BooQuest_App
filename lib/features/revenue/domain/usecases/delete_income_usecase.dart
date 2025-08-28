import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/repositories/delete_income_repository.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';

/// 수익 삭제 UseCase
class DeleteIncomeUseCase {
  final DeleteIncomeRepository _repository;

  DeleteIncomeUseCase(this._repository);

  /// 수익 삭제 실행
  Future<Either<RevenueFailure, void>> call(int incomeId) async {
    return await _repository.deleteIncome(incomeId);
  }
}
