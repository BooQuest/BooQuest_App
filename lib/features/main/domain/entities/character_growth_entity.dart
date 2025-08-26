import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_growth_entity.freezed.dart';
part 'character_growth_entity.g.dart';

/// 캐릭터 성장 정보 엔티티
@freezed
class CharacterGrowthEntity with _$CharacterGrowthEntity {
  const factory CharacterGrowthEntity({
    required String name,
    required String type,
    required int level,
    required int remainingExpToLevelUp,
    required int currentExp,
    required int requiredExpForNextLevel,
  }) = _CharacterGrowthEntity;

  factory CharacterGrowthEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterGrowthEntityFromJson(json);
}
