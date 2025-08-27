import 'package:dartz/dartz.dart';
import 'package:booquest/features/main/domain/entities/user_activity_summary_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/api/user_activity_summary_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 사용자 활동 요약 Repository 구현체
class UserActivitySummaryRepositoryImpl {
  /// 사용자 활동 요약 조회
  Future<Either<MainFailure, UserActivitySummaryEntity>> getUserActivitySummary() async {
    try {
      print('🔍 UserActivitySummaryRepository: getUserActivitySummary 호출');
      
      // Create AuthStorageService and NetworkClient asynchronously within the method
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = UserActivitySummaryApiService(client);

      final response = await apiService.getUserActivitySummary();
      
      print('✅ UserActivitySummaryRepository: API 응답 성공');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        final summary = UserActivitySummaryEntity.fromJson(data);

        print('📊 UserActivitySummaryRepository: 데이터 파싱 성공');
        print('  - totalIncome: ${summary.totalIncome}');
        print('  - completedSideJobCount: ${summary.completedSideJobCount}');
        print('  - completedQuestCount: ${summary.completedQuestCount}');

        return Right(summary);
      } else {
        print('❌ UserActivitySummaryRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ UserActivitySummaryRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
