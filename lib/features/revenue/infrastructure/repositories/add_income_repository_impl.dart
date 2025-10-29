import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/entities/income_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/revenue/infrastructure/api/add_income_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 수익 추가 Repository 구현체
class AddIncomeRepositoryImpl {
  /// 수익 추가
  Future<Either<MainFailure, IncomeEntity>> addIncome({
    required int userSideJobId,
    required String title,
    required int amount,
    required String incomeDate,
    required String memo,
  }) async {
    try {

      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = AddIncomeApiService(client);

      final response = await apiService.addIncome(
        userSideJobId: userSideJobId,
        title: title,
        amount: amount,
        incomeDate: incomeDate,
        memo: memo,
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data!['success'] == true) {
        final data = response.data!['data'] as Map<String, dynamic>;
        final income = IncomeEntity.fromJson(data);

        return Right(income);
      } else {
        print('❌ AddIncomeRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ AddIncomeRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
