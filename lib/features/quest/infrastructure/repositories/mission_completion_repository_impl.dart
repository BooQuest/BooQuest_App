import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';
import 'package:booquest/features/quest/domain/repositories/mission_completion_repository.dart';
import 'package:booquest/features/quest/domain/entities/mission_completion_entity.dart';
import 'package:booquest/features/quest/infrastructure/api/mission_completion_api_service.dart';

/// 메인 퀘스트 완료 리포지토리 구현체
class MissionCompletionRepositoryImpl implements MissionCompletionRepository {
  final MissionCompletionApiService _apiService;

  MissionCompletionRepositoryImpl(this._apiService);

  @override
  Future<Either<MissionFailure, MissionCompletionEntity>> completeMission(int missionId) async {
    try {
      final result = await _apiService.completeMission(missionId);
      
      return Right(result);
    } catch (e) {
      
      // 이미 완료된 메인 퀘스트인 경우 특별 처리
      if (e.toString().contains('already-completed')) {
        // 특별한 실패 타입을 만들어서 notifier에서 구분할 수 있도록 함
        return Left(MissionFailure.serverError('already-completed'));
      }
      
      return Left(MissionFailure.serverError(e.toString()));
    }
  }
}
