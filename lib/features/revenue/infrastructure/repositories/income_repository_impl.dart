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
      print('🔍 IncomeRepository: getIncomeList 호출 - userSideJobId=$userSideJobId');

      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = IncomeApiService(client);

      final response = await apiService.getIncomeList(userSideJobId);

      print('✅ IncomeRepository: API 응답 성공');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data!['success'] == true) {
        final data = response.data!['data'] as Map<String, dynamic>;
        final incomeList = IncomeListEntity.fromJson(data);

        print('📊 IncomeRepository: 데이터 파싱 성공');
        print('  - totalCount: ${incomeList.totalCount}');
        print('  - totalAmount: ${incomeList.totalAmount}');
        print('  - incomes count: ${incomeList.incomes.length}');

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
