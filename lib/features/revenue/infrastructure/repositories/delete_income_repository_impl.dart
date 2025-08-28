import 'package:dartz/dartz.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/revenue/infrastructure/api/delete_income_api_service.dart';
import 'package:booquest/features/revenue/domain/repositories/delete_income_repository.dart';
import 'package:booquest/features/revenue/domain/failures/revenue_failure.dart';

/// 수익 삭제 Repository 구현체
class DeleteIncomeRepositoryImpl implements DeleteIncomeRepository {
  @override
  Future<Either<RevenueFailure, void>> deleteIncome(int incomeId) async {
    try {
      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = DeleteIncomeApiService(client);

      final response = await apiService.deleteIncome(incomeId);

      if (response['success'] == true) {
        return const Right(null);
      } else {
        return Left(RevenueFailure.serverError('삭제에 실패했습니다.'));
      }
    } catch (e) {
      return Left(RevenueFailure.serverError('삭제 중 오류가 발생했습니다: $e'));
    }
  }
}
