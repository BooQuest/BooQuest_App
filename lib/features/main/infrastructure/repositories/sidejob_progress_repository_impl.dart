import 'package:dartz/dartz.dart';
import 'package:booquest/features/main/domain/entities/sidejob_progress_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/api/sidejob_progress_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 사이드잡 진행률 Repository 구현체
class SideJobProgressRepositoryImpl {

  /// 사이드잡 진행률 조회
  /// 
  /// [sideJobId]: 사용자의 사이드잡 ID
  /// 
  /// Returns: 성공 시 SideJobProgressEntity, 실패 시 MainFailure
  Future<Either<MainFailure, SideJobProgressEntity>> getSideJobProgress(int sideJobId) async {
    try {
      
      // Create AuthStorageService and NetworkClient asynchronously within the method
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final apiService = SideJobProgressApiService(client); // Local instance

      final response = await apiService.getSideJobProgress(sideJobId); // Use local instance

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        final progress = data['progress'] as Map<String, dynamic>;
        final stage = progress['stage'] as Map<String, dynamic>;
        
        final sideJobProgress = SideJobProgressEntity(
          title: data['title'] as String,
          progressPercent: progress['percent'] as int,
          currentOrder: stage['currentOrder'] as int? ?? 0, // null일 경우 0으로 기본값 설정
          totalStages: stage['total'] as int,
        );

        return Right(sideJobProgress);
      } else {
        print('❌ SideJobProgressRepository: API 응답 실패');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        
        return Left(MainFailure.serverError());
      }
    } catch (e) {
      print('❌ SideJobProgressRepository: 예외 발생 - $e');
      return Left(MainFailure.serverError());
    }
  }
}
