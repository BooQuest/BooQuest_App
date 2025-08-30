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
      print('🔧 [Repository] 메인 퀘스트 완료 처리 시작: missionId=$missionId');
      
      final result = await _apiService.completeMission(missionId);
      
      return Right(result);
    } catch (e) {
      print('❌ [Repository] 메인 퀘스트 완료 처리 실패: $e');
      return Left(MissionFailure.serverError(e.toString()));
    }
  }
}
