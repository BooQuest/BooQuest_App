import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_step_completion_entity.freezed.dart';
part 'mission_step_completion_entity.g.dart';

/// 퀘스트 스텝 완료 응답 Entity
@freezed
class MissionStepCompletionEntity with _$MissionStepCompletionEntity {
  const factory MissionStepCompletionEntity({
    required MissionStepEntity step,
    required CharacterEntity character,
    required int expDelta,
  }) = _MissionStepCompletionEntity;

  factory MissionStepCompletionEntity.fromJson(Map<String, dynamic> json) =>
      _$MissionStepCompletionEntityFromJson(json);
}

/// 퀘스트 스텝 Entity
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

/// 캐릭터 Entity
@freezed
class CharacterEntity with _$CharacterEntity {
  const factory CharacterEntity({
    required int userId,
    required String name,
    required int level,
    required int exp,
    required String characterType,
    required String avatarUrl,
  }) = _CharacterEntity;

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);
}
