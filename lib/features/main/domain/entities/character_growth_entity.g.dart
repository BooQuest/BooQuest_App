// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_growth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterGrowthEntityImpl _$$CharacterGrowthEntityImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterGrowthEntityImpl(
  name: json['name'] as String,
  type: json['type'] as String,
  level: (json['level'] as num).toInt(),
  remainingExpToLevelUp: (json['remainingExpToLevelUp'] as num).toInt(),
  currentExp: (json['currentExp'] as num).toInt(),
  requiredExpForNextLevel: (json['requiredExpForNextLevel'] as num).toInt(),
);

Map<String, dynamic> _$$CharacterGrowthEntityImplToJson(
  _$CharacterGrowthEntityImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'type': instance.type,
  'level': instance.level,
  'remainingExpToLevelUp': instance.remainingExpToLevelUp,
  'currentExp': instance.currentExp,
  'requiredExpForNextLevel': instance.requiredExpForNextLevel,
};
