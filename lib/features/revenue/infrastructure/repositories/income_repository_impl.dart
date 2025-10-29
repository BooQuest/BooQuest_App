import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/revenue/infrastructure/api/income_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 수익 Repository 구현체
class IncomeRepositoryImpl {
  /// 수익 목록 조회
  Future<Either<MainFailure, IncomeListEntity>> getIncomeList(int userSideJobId) async {
    try {

      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = IncomeApiService(client);

      final response = await apiService.getIncomeList(userSideJobId);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data!['success'] == true) {
        final data = response.data!['data'] as Map<String, dynamic>;
        final incomeList = IncomeListEntity.fromJson(data);

        return Right(incomeList);
      } else {
        print('❌ IncomeRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ IncomeRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
