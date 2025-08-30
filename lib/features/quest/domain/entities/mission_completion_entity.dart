import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_completion_entity.freezed.dart';
part 'mission_completion_entity.g.dart';

/// 메인 퀘스트 완료 응답 엔티티
@freezed
class MissionCompletionEntity with _$MissionCompletionEntity {
  const factory MissionCompletionEntity({
    required MissionEntity mission,
    required CharacterEntity character,
    required int totalExpReward,
    required int stepExpReward,
    required int bonusExpReward,
    required int missionCompletionExpReward,
    required int levelUpCount,
    required int previousLevel,
    required bool missionCompleted,
  }) = _MissionCompletionEntity;

  factory MissionCompletionEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionCompletionEntityFromJson(json);
}

/// 미션 엔티티
@freezed
class MissionEntity with _$MissionEntity {
  const factory MissionEntity({
    required int id,
    required int sideJobId,
    required String title,
    required String status,
    required int orderNo,
    required String designNotes,
    required String guide,
    required int missionTotalExp,
    required List<MissionStepEntity> steps,
    required MissionProgressEntity progress,
  }) = _MissionEntity;

  factory MissionEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionEntityFromJson(json);
}

/// 미션 스텝 엔티티
@freezed
class MissionStepEntity with _$MissionStepEntity {
  const factory MissionStepEntity({
    required int id,
    required int seq,
    required String title,
    required String status,
    required String detail,
  }) = _MissionStepEntity;

  factory MissionStepEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionStepEntityFromJson(json);
}

/// 미션 진행률 엔티티
@freezed
class MissionProgressEntity with _$MissionProgressEntity {
  const factory MissionProgressEntity({
    required int percent,
    required int completedStepCount,
    required int totalStepCount,
    required int? currentStepId, // null일 수 있음
    required int? currentStepOrder, // null일 수 있음
  }) = _MissionProgressEntity;

  factory MissionProgressEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionProgressEntityFromJson(json);
}

/// 캐릭터 엔티티
@freezed
class CharacterEntity with _$CharacterEntity {
  const factory CharacterEntity({
    required int userId,
    required String name,
    required int level,
    required int exp,
    required String characterType,
    required String? avatarUrl, // null일 수 있음
  }) = _CharacterEntity;

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);
}
