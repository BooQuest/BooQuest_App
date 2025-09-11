import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/quest/domain/entities/mission_step_completion_entity.dart';

part 'mission_step_completion_state.freezed.dart';

/// 퀘스트 스텝 완료 상태
@freezed
class MissionStepCompletionState with _$MissionStepCompletionState {
  /// 초기 상태
  const factory MissionStepCompletionState.initial() = _Initial;

  /// 로딩 중
  const factory MissionStepCompletionState.loading() = _Loading;

  /// 성공
  const factory MissionStepCompletionState.success(
    MissionStepCompletionEntity data,
  ) = _Success;

  /// 레벨업
  const factory MissionStepCompletionState.levelUp(
    MissionStepCompletionEntity data,
  ) = _LevelUp;

  /// 실패
  const factory MissionStepCompletionState.failure(
    String message,
  ) = _Failure;
}
