// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidejob_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SideJobEntityImpl _$$SideJobEntityImplFromJson(Map<String, dynamic> json) =>
    _$SideJobEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$SideJobEntityImplToJson(_$SideJobEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };

_$SideJobRequestDataImpl _$$SideJobRequestDataImplFromJson(
  Map<String, dynamic> json,
) => _$SideJobRequestDataImpl(
  userId: (json['userId'] as num).toInt(),
  nickname: json['nickname'] as String,
  job: json['job'] as String,
  hobbies: (json['hobbies'] as List<dynamic>).map((e) => e as String).toList(),
  expressionStyle: json['expressionStyle'] as String,
  strengthType: json['strengthType'] as String,
  characterType: json['characterType'] as String,
  characterName: json['characterName'] as String,
);

Map<String, dynamic> _$$SideJobRequestDataImplToJson(
  _$SideJobRequestDataImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'nickname': instance.nickname,
  'job': instance.job,
  'hobbies': instance.hobbies,
  'expressionStyle': instance.expressionStyle,
  'strengthType': instance.strengthType,
  'characterType': instance.characterType,
  'characterName': instance.characterName,
};
