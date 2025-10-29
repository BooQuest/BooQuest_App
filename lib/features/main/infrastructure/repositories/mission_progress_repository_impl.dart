import 'package:dartz/dartz.dart';
import 'package:booquest/features/main/domain/entities/mission_progress_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/api/mission_progress_api_service.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 미션 진행 상황 Repository 구현체
class MissionProgressRepositoryImpl {

  /// 미션 진행 상황 조회
  /// 
  /// [sideJobId]: 사용자의 사이드잡 ID
  /// 
  /// Returns: 성공 시 MissionProgressEntity, 실패 시 MainFailure
  Future<Either<MainFailure, MissionProgressEntity>> getMissionProgress(int sideJobId) async {
    try {
      // AuthStorageService는 비동기 싱글톤이므로 여기서 인스턴스를 획득합니다
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);
      final api = MissionProgressApiService(client);

      final response = await api.getMissionProgress(sideJobId);

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final data = response.data!['data'] as Map<String, dynamic>;
        
        final missionProgress = MissionProgressEntity(
          currentMissionId: data['currentMissionId'] as int?,
          currentMissionOrder: data['currentMissionOrder'] as int?,
          currentMissionTitle: data['currentMissionTitle'] as String?,
          missionStepProgressPercentage: data['missionStepProgressPercentage'] as double,
        );

        return Right(missionProgress);
      } else {
        return const Left(MainFailure.serverError());
      }
    } catch (e) {
      return const Left(MainFailure.serverError());
    }
  }
}

