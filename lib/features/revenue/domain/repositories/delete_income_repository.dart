import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';

/// 수익 삭제 Repository 인터페이스
abstract class DeleteIncomeRepository {
  /// 수익 삭제
  Future<Either<RevenueFailure, void>> deleteIncome(int incomeId);
}
