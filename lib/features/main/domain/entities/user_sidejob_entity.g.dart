// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sidejob_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSideJobEntityImpl _$$UserSideJobEntityImplFromJson(
  Map<String, dynamic> json,
) => _$UserSideJobEntityImpl(
  id: (json['id'] as num).toInt(),
  sideJobId: (json['sideJobId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  status: json['status'] as String,
  startedAt: json['startedAt'] as String,
  endedAt: json['endedAt'] as String?,
  period: json['period'] as String,
);

Map<String, dynamic> _$$UserSideJobEntityImplToJson(
  _$UserSideJobEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sideJobId': instance.sideJobId,
  'title': instance.title,
  'description': instance.description,
  'status': instance.status,
  'startedAt': instance.startedAt,
  'endedAt': instance.endedAt,
  'period': instance.period,
};

_$UserSideJobListEntityImpl _$$UserSideJobListEntityImplFromJson(
  Map<String, dynamic> json,
) => _$UserSideJobListEntityImpl(
  sideJobs: (json['sideJobs'] as List<dynamic>)
      .map((e) => UserSideJobEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$UserSideJobListEntityImplToJson(
  _$UserSideJobListEntityImpl instance,
) => <String, dynamic>{'sideJobs': instance.sideJobs};
