import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

/// 수익 수정 Repository 인터페이스
abstract class UpdateIncomeRepository {
  /// 수익 수정
  Future<Either<RevenueFailure, IncomeEntity>> updateIncome({
    required int incomeId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  });
}
