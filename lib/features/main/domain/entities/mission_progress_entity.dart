import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_progress_entity.freezed.dart';
part 'mission_progress_entity.g.dart';

/// 미션 진행 상황 엔티티
@freezed
class MissionProgressEntity with _$MissionProgressEntity {
  const factory MissionProgressEntity({
    int? currentMissionId,
    int? currentMissionOrder,
    String? currentMissionTitle,
    required double missionStepProgressPercentage,
  }) = _MissionProgressEntity;

  factory MissionProgressEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionProgressEntityFromJson(json);
}

