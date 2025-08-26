import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/mission_progress_entity.dart';
import '../../domain/failures/main_failure.dart';

part 'mission_progress_state.freezed.dart';

/// 미션 진행 상황 상태
@freezed
class MissionProgressState with _$MissionProgressState {
  const factory MissionProgressState.initial() = _Initial;
  const factory MissionProgressState.loading() = _Loading;
  const factory MissionProgressState.success(MissionProgressEntity data) = _Success;
  const factory MissionProgressState.failure(MainFailure failure) = _Failure;
}

