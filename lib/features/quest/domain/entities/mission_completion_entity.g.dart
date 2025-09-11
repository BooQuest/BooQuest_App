// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_completion_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MissionCompletionEntityImpl _$$MissionCompletionEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionCompletionEntityImpl(
  mission: MissionEntity.fromJson(json['mission'] as Map<String, dynamic>),
  character: CharacterEntity.fromJson(
    json['character'] as Map<String, dynamic>,
  ),
  totalExpReward: (json['totalExpReward'] as num).toInt(),
  stepExpReward: (json['stepExpReward'] as num).toInt(),
  bonusExpReward: (json['bonusExpReward'] as num).toInt(),
  missionCompletionExpReward: (json['missionCompletionExpReward'] as num)
      .toInt(),
  levelUpCount: (json['levelUpCount'] as num).toInt(),
  previousLevel: (json['previousLevel'] as num).toInt(),
  missionCompleted: json['missionCompleted'] as bool,
  leveledUp: json['leveledUp'] as bool? ?? false,
  currentLevel: (json['currentLevel'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MissionCompletionEntityImplToJson(
  _$MissionCompletionEntityImpl instance,
) => <String, dynamic>{
  'mission': instance.mission,
  'character': instance.character,
  'totalExpReward': instance.totalExpReward,
  'stepExpReward': instance.stepExpReward,
  'bonusExpReward': instance.bonusExpReward,
  'missionCompletionExpReward': instance.missionCompletionExpReward,
  'levelUpCount': instance.levelUpCount,
  'previousLevel': instance.previousLevel,
  'missionCompleted': instance.missionCompleted,
  'leveledUp': instance.leveledUp,
  'currentLevel': instance.currentLevel,
};

_$MissionEntityImpl _$$MissionEntityImplFromJson(Map<String, dynamic> json) =>
    _$MissionEntityImpl(
      id: (json['id'] as num).toInt(),
      sideJobId: (json['sideJobId'] as num).toInt(),
      title: json['title'] as String,
      status: json['status'] as String,
      orderNo: (json['orderNo'] as num).toInt(),
      designNotes: json['designNotes'] as String,
      guide: json['guide'] as String,
      missionTotalExp: (json['missionTotalExp'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => MissionStepEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      progress: MissionProgressEntity.fromJson(
        json['progress'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$MissionEntityImplToJson(_$MissionEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sideJobId': instance.sideJobId,
      'title': instance.title,
      'status': instance.status,
      'orderNo': instance.orderNo,
      'designNotes': instance.designNotes,
      'guide': instance.guide,
      'missionTotalExp': instance.missionTotalExp,
      'steps': instance.steps,
      'progress': instance.progress,
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

_$MissionProgressEntityImpl _$$MissionProgressEntityImplFromJson(
  Map<String, dynamic> json,
) => _$MissionProgressEntityImpl(
  percent: (json['percent'] as num).toInt(),
  completedStepCount: (json['completedStepCount'] as num).toInt(),
  totalStepCount: (json['totalStepCount'] as num).toInt(),
  currentStepId: (json['currentStepId'] as num?)?.toInt(),
  currentStepOrder: (json['currentStepOrder'] as num?)?.toInt(),
);

Map<String, dynamic> _$$MissionProgressEntityImplToJson(
  _$MissionProgressEntityImpl instance,
) => <String, dynamic>{
  'percent': instance.percent,
  'completedStepCount': instance.completedStepCount,
  'totalStepCount': instance.totalStepCount,
  'currentStepId': instance.currentStepId,
  'currentStepOrder': instance.currentStepOrder,
};

_$CharacterEntityImpl _$$CharacterEntityImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterEntityImpl(
  userId: (json['userId'] as num).toInt(),
  name: json['name'] as String,
  level: (json['level'] as num).toInt(),
  exp: (json['exp'] as num).toInt(),
  characterType: json['characterType'] as String,
  avatarUrl: json['avatarUrl'] as String?,
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
