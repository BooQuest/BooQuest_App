import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';

part 'mission_list_state.freezed.dart';

/// 미션 목록 상태
@freezed
class MissionListState with _$MissionListState {
  const factory MissionListState.initial() = _Initial;
  const factory MissionListState.loading() = _Loading;
  const factory MissionListState.success(MissionListEntity data) = _Success;
  const factory MissionListState.failure(MainFailure failure) = _Failure;
}
