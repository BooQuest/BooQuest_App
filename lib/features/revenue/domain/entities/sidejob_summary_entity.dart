import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidejob_summary_entity.freezed.dart';
part 'sidejob_summary_entity.g.dart';

/// 부업 프로젝트 요약 정보 엔티티
@freezed
class SideJobSummaryEntity with _$SideJobSummaryEntity {
  const factory SideJobSummaryEntity({
    required UserSideJobEntity userSideJob,
    required String period,
    required int totalIncome,
    required int completedQuestCount,
    required int daysToFirstIncome,
  }) = _SideJobSummaryEntity;

  factory SideJobSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$SideJobSummaryEntityFromJson(json);
}

/// 사용자 부업 프로젝트 엔티티
@freezed
class UserSideJobEntity with _$UserSideJobEntity {
  const factory UserSideJobEntity({
    required String createdAt,
    required String updatedAt,
    required int id,
    required int userId,
    required int sideJobId,
    required String title,
    required String description,
    required String status,
    required String startedAt,
    String? endedAt,
    required List<MissionEntity> missions,
  }) = _UserSideJobEntity;

  factory UserSideJobEntity.fromJson(Map<String, dynamic> json) =>
      _$UserSideJobEntityFromJson(json);
}

/// 미션 엔티티
@freezed
class MissionEntity with _$MissionEntity {
  const factory MissionEntity({
    required String createdAt,
    required String updatedAt,
    required int id,
    required int sideJobId,
    required int userId,
    required String title,
    required String status,
    required int orderNo,
    required String designNotes,
    required List<StepEntity> steps,
  }) = _MissionEntity;

  factory MissionEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionEntityFromJson(json);
}

/// 스텝 엔티티
@freezed
class StepEntity with _$StepEntity {
  const factory StepEntity({
    required String createdAt,
    required String updatedAt,
    required int id,
    required int missionId,
    required int seq,
    required String title,
    required String status,
    required String detail,
    required bool completed,
  }) = _StepEntity;

  factory StepEntity.fromJson(Map<String, dynamic> json) =>
      _$StepEntityFromJson(json);
}


