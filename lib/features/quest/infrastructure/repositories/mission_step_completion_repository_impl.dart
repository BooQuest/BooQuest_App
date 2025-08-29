import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/entities/mission_step_completion_entity.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';
import 'package:booquest/features/quest/domain/repositories/mission_step_completion_repository.dart';
import 'package:booquest/features/quest/infrastructure/api/mission_step_completion_api_service.dart';

/// 퀘스트 스텝 완료 Repository 구현체
class MissionStepCompletionRepositoryImpl implements MissionStepCompletionRepository {
  final MissionStepCompletionApiService _apiService;

  MissionStepCompletionRepositoryImpl(this._apiService);

  @override
  Future<Either<MissionFailure, MissionStepCompletionEntity>> completeStep(
    int stepId,
    String status,
  ) async {
    try {
      print('🔍 MissionStepCompletionRepository: completeStep 호출 - stepId: $stepId, status: $status');
      
      final result = await _apiService.completeStep(stepId, status);
      
      print('✅ MissionStepCompletionRepository: completeStep 성공');
      return Right(result);
    } catch (e) {
      print('❌ MissionStepCompletionRepository: completeStep 실패 - $e');
      
      if (e is Exception) {
        return Left(MissionFailure.serverError(e.toString()));
      } else {
        return Left(MissionFailure.serverError('알 수 없는 오류가 발생했습니다.'));
      }
    }
  }
}
