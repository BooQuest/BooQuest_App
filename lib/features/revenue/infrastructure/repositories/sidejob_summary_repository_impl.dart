import 'package:dartz/dartz.dart';
import 'package:booquest/features/revenue/domain/entities/sidejob_summary_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/revenue/infrastructure/api/sidejob_summary_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 부업 프로젝트 요약 Repository 구현체
class SideJobSummaryRepositoryImpl {
  /// 부업 프로젝트 요약 조회
  Future<Either<MainFailure, SideJobSummaryEntity>> getSideJobSummary(int userSideJobId) async {
    try {
      // AuthStorageService와 NetworkClient를 메서드 내부에서 비동기로 준비 (main 패턴과 동일)
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = SideJobSummaryApiService(client);

      final response = await apiService.getSideJobSummary(userSideJobId);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data!['success'] == true) {
        final data = response.data!['data'] as Map<String, dynamic>;
        final summary = SideJobSummaryEntity.fromJson(data);

        return Right(summary);
      } else {
        print('❌ SideJobSummaryRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ SideJobSummaryRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}


