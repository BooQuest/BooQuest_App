// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_step_completion_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionStepCompletionEntityImpl _$$MissionStepCompletionEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionStepCompletionEntityImpl(
  step: MissionStepEntity.fromJson(json['step'] as Map<String, dynamic>),
  character: CharacterEntity.fromJson(
    json['character'] as Map<String, dynamic>,
  ),
  expDelta: (json['expDelta'] as num).toInt(),
);

Map<String, dynamic> _$$MissionStepCompletionEntityImplToJson(
  _$MissionStepCompletionEntityImpl instance,
) => <String, dynamic>{
  'step': instance.step,
  'character': instance.character,
  'expDelta': instance.expDelta,
};

_$MissionStepEntityImpl _$$MissionStepEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionStepEntityImpl(
  id: (json['id'] as num).toInt(),
  seq: (json['seq'] as num).toInt(),
  title: json['title'] as String,
  status: json['status'] as String,
  detail: json['detail'] as String,
);

Map<String, dynamic> _$$MissionStepEntityImplToJson(
  _$MissionStepEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'seq': instance.seq,
  'title': instance.title,
  'status': instance.status,
  'detail': instance.detail,
};

_$CharacterEntityImpl _$$CharacterEntityImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterEntityImpl(
  userId: (json['userId'] as num).toInt(),
  name: json['name'] as String,
  level: (json['level'] as num).toInt(),
  exp: (json['exp'] as num).toInt(),
  characterType: json['characterType'] as String,
  avatarUrl: json['avatarUrl'] as String,
);

Map<String, dynamic> _$$CharacterEntityImplToJson(
  _$CharacterEntityImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'level': instance.level,
  'exp': instance.exp,
  'characterType': instance.characterType,
  'avatarUrl': instance.avatarUrl,
};
