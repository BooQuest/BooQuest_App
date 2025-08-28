// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidejob_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SideJobSummaryEntityImpl _$$SideJobSummaryEntityImplFromJson(
  Map<String, dynamic> json,
) => _$SideJobSummaryEntityImpl(
  userSideJob: UserSideJobEntity.fromJson(
    json['userSideJob'] as Map<String, dynamic>,
  ),
  period: json['period'] as String,
  totalIncome: (json['totalIncome'] as num).toInt(),
  completedQuestCount: (json['completedQuestCount'] as num).toInt(),
  daysToFirstIncome: (json['daysToFirstIncome'] as num).toInt(),
);

Map<String, dynamic> _$$SideJobSummaryEntityImplToJson(
  _$SideJobSummaryEntityImpl instance,
) => <String, dynamic>{
  'userSideJob': instance.userSideJob,
  'period': instance.period,
  'totalIncome': instance.totalIncome,
  'completedQuestCount': instance.completedQuestCount,
  'daysToFirstIncome': instance.daysToFirstIncome,
};

_$UserSideJobEntityImpl _$$UserSideJobEntityImplFromJson(
  Map<String, dynamic> json,
) => _$UserSideJobEntityImpl(
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  sideJobId: (json['sideJobId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  status: json['status'] as String,
  startedAt: json['startedAt'] as String,
  endedAt: json['endedAt'] as String?,
  missions: (json['missions'] as List<dynamic>)
      .map((e) => MissionEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$UserSideJobEntityImplToJson(
  _$UserSideJobEntityImpl instance,
) => <String, dynamic>{
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'id': instance.id,
  'userId': instance.userId,
  'sideJobId': instance.sideJobId,
  'title': instance.title,
  'description': instance.description,
  'status': instance.status,
  'startedAt': instance.startedAt,
  'endedAt': instance.endedAt,
  'missions': instance.missions,
};

_$MissionEntityImpl _$$MissionEntityImplFromJson(Map<String, dynamic> json) =>
    _$MissionEntityImpl(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      id: (json['id'] as num).toInt(),
      sideJobId: (json['sideJobId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      status: json['status'] as String,
      orderNo: (json['orderNo'] as num).toInt(),
      designNotes: json['designNotes'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MissionEntityImplToJson(_$MissionEntityImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'sideJobId': instance.sideJobId,
      'userId': instance.userId,
      'title': instance.title,
      'status': instance.status,
      'orderNo': instance.orderNo,
      'designNotes': instance.designNotes,
      'steps': instance.steps,
    };

_$StepEntityImpl _$$StepEntityImplFromJson(Map<String, dynamic> json) =>
    _$StepEntityImpl(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      id: (json['id'] as num).toInt(),
      missionId: (json['missionId'] as num).toInt(),
      seq: (json['seq'] as num).toInt(),
      title: json['title'] as String,
      status: json['status'] as String,
      detail: json['detail'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$StepEntityImplToJson(_$StepEntityImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'missionId': instance.missionId,
      'seq': instance.seq,
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
      'completed': instance.completed,
    };
