import 'package:dartz/dartz.dart';
import 'package:booquest/features/quest/domain/entities/mission_completion_entity.dart';
import 'package:booquest/features/quest/domain/failures/mission_failure.dart';

/// 메인 퀘스트 완료 리포지토리 인터페이스
abstract class MissionCompletionRepository {
  /// 메인 퀘스트 완료 처리
  Future<Either<MissionFailure, MissionCompletionEntity>> completeMission(int missionId);
}
