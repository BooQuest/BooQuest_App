import 'package:dartz/dartz.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/revenue/infrastructure/api/update_income_api_service.dart';
import 'package:booquest/features/revenue/domain/repositories/update_income_repository.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';

/// 수익 수정 Repository 구현체
class UpdateIncomeRepositoryImpl implements UpdateIncomeRepository {
  @override
  Future<Either<RevenueFailure, IncomeEntity>> updateIncome({
    required int incomeId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    try {
      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = UpdateIncomeApiService(client);

      final response = await apiService.updateIncome(
        incomeId: incomeId,
        title: title,
        amount: amount,
        incomeDate: incomeDate,
        memo: memo,
      );

      if (response['success'] == true) {
        final data = response['data'] as Map<String, dynamic>;
        final income = IncomeEntity.fromJson(data);
        return Right(income);
      } else {
        return Left(RevenueFailure.serverError('수정에 실패했습니다.'));
      }
    } catch (e) {
      return Left(RevenueFailure.serverError('수정 중 오류가 발생했습니다: $e'));
    }
  }
}
