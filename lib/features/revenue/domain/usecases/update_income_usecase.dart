import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/repositories/update_income_repository.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

/// 수익 수정 UseCase
class UpdateIncomeUseCase {
  final UpdateIncomeRepository _repository;

  UpdateIncomeUseCase(this._repository);

  /// 수익 수정 실행
  Future<Either<RevenueFailure, IncomeEntity>> call({
    required int incomeId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    return await _repository.updateIncome(
      incomeId: incomeId,
      title: title,
      amount: amount,
      incomeDate: incomeDate,
      memo: memo,
    );
  }
}
