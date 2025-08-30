import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_entity.freezed.dart';
part 'mission_entity.g.dart';

/// 미션 엔티티
@freezed
class MissionEntity with _$MissionEntity {
  const factory MissionEntity({
    required int id,
    required int sideJobId,
    required String title,
    required String status,
    int? orderNo,
    required String designNotes,
    required int missionTotalExp,
    required List<MissionStep> steps,
    required MissionProgress progress,
    String? guide,
  }) = _MissionEntity;

  factory MissionEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionEntityFromJson(json);
}

/// 미션 단계 엔티티
@freezed
class MissionStep with _$MissionStep {
  const factory MissionStep({
    required int id,
    required int seq,
    required String title,
    required String status,
    required String detail,
  }) = _MissionStep;

  factory MissionStep.fromJson(Map<String, dynamic> json) =>
      _$MissionStepFromJson(json);
}

/// 미션 진행률 엔티티
@freezed
class MissionProgress with _$MissionProgress {
  const factory MissionProgress({
    required int percent,
    required int completedStepCount,
    required int totalStepCount,
    int? currentStepId,
    int? currentStepOrder,
  }) = _MissionProgress;

  factory MissionProgress.fromJson(Map<String, dynamic> json) =>
      _$MissionProgressFromJson(json);
}

/// 미션 목록 응답 엔티티
@freezed
class MissionListEntity with _$MissionListEntity {
  const factory MissionListEntity({
    required List<MissionEntity> missions,
  }) = _MissionListEntity;

  factory MissionListEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionListEntityFromJson(json);
}
