import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/entities/mission_step_completion_entity.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';

/// 퀘스트 스텝 완료 Repository 인터페이스
abstract class MissionStepCompletionRepository {
  /// 퀘스트 스텝 완료 처리
  /// 
  /// [stepId] 완료할 스텝의 ID
  /// [status] 변경할 상태 (보통 "COMPLETED")
  /// 
  /// 성공 시 MissionStepCompletionEntity 반환
  /// 실패 시 MissionFailure 반환
  Future<Either<MissionFailure, MissionStepCompletionEntity>> completeStep(
    int stepId,
    String status,
  );
}
