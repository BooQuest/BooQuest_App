import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/quest/domain/entities/mission_completion_entity.dart';

part 'mission_completion_state.freezed.dart';

/// 메인 퀘스트 완료 상태
@freezed
class MissionCompletionState with _$MissionCompletionState {
  const factory MissionCompletionState.initial() = _Initial;
  const factory MissionCompletionState.loading() = _Loading;
  const factory MissionCompletionState.success(MissionCompletionEntity data) = _Success;
  const factory MissionCompletionState.levelUp(MissionCompletionEntity data) = _LevelUp;
  const factory MissionCompletionState.failure(String message) = _Failure;
  const factory MissionCompletionState.alreadyCompleted() = _AlreadyCompleted;
}
