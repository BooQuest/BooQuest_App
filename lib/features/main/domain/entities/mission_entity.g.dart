// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionEntityImpl _$$MissionEntityImplFromJson(Map<String, dynamic> json) =>
    _$MissionEntityImpl(
      id: (json['id'] as num).toInt(),
      sideJobId: (json['sideJobId'] as num).toInt(),
      title: json['title'] as String,
      status: json['status'] as String,
      orderNo: (json['orderNo'] as num?)?.toInt(),
      designNotes: json['designNotes'] as String,
      missionTotalExp: (json['missionTotalExp'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => MissionStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      progress: MissionProgress.fromJson(
        json['progress'] as Map<String, dynamic>,
      ),
      guide: json['guide'] as String?,
    );

Map<String, dynamic> _$$MissionEntityImplToJson(_$MissionEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sideJobId': instance.sideJobId,
      'title': instance.title,
      'status': instance.status,
      'orderNo': instance.orderNo,
      'designNotes': instance.designNotes,
      'missionTotalExp': instance.missionTotalExp,
      'steps': instance.steps,
      'progress': instance.progress,
      'guide': instance.guide,
    };

_$MissionStepImpl _$$MissionStepImplFromJson(Map<String, dynamic> json) =>
    _$MissionStepImpl(
      id: (json['id'] as num).toInt(),
      seq: (json['seq'] as num).toInt(),
      title: json['title'] as String,
      status: json['status'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$$MissionStepImplToJson(_$MissionStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seq': instance.seq,
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
    };

_$MissionProgressImpl _$$MissionProgressImplFromJson(
  Map<String, dynamic> json,
) => _$MissionProgressImpl(
  percent: (json['percent'] as num).toInt(),
  completedStepCount: (json['completedStepCount'] as num).toInt(),
  totalStepCount: (json['totalStepCount'] as num).toInt(),
  currentStepId: (json['currentStepId'] as num?)?.toInt(),
  currentStepOrder: (json['currentStepOrder'] as num?)?.toInt(),
);

Map<String, dynamic> _$$MissionProgressImplToJson(
  _$MissionProgressImpl instance,
) => <String, dynamic>{
  'percent': instance.percent,
  'completedStepCount': instance.completedStepCount,
  'totalStepCount': instance.totalStepCount,
  'currentStepId': instance.currentStepId,
  'currentStepOrder': instance.currentStepOrder,
};

_$MissionListEntityImpl _$$MissionListEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionListEntityImpl(
  missions: (json['missions'] as List<dynamic>)
      .map((e) => MissionEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$MissionListEntityImplToJson(
  _$MissionListEntityImpl instance,
) => <String, dynamic>{'missions': instance.missions};
