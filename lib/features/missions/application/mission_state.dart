import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/mission_entity.dart';
import '../domain/mission_failure.dart';

part 'mission_state.freezed.dart';

@freezed
class MissionState with _$MissionState {
  const factory MissionState.initial() = _Initial;
  const factory MissionState.loading() = _Loading;
  const factory MissionState.success(List<MissionStepEntity> steps) = _Success;
  const factory MissionState.failure(MissionFailure failure) = _Failure;
}


