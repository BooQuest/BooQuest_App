// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionProgressEntityImpl _$$MissionProgressEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionProgressEntityImpl(
  currentMissionId: (json['currentMissionId'] as num).toInt(),
  currentMissionOrder: (json['currentMissionOrder'] as num).toInt(),
  currentMissionTitle: json['currentMissionTitle'] as String,
  missionStepProgressPercentage: (json['missionStepProgressPercentage'] as num)
      .toDouble(),
);

Map<String, dynamic> _$$MissionProgressEntityImplToJson(
  _$MissionProgressEntityImpl instance,
) => <String, dynamic>{
  'currentMissionId': instance.currentMissionId,
  'currentMissionOrder': instance.currentMissionOrder,
  'currentMissionTitle': instance.currentMissionTitle,
  'missionStepProgressPercentage': instance.missionStepProgressPercentage,
};
