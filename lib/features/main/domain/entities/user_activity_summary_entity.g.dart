// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserActivitySummaryEntityImpl _$$UserActivitySummaryEntityImplFromJson(
  Map<String, dynamic> json,
) => _$UserActivitySummaryEntityImpl(
  totalIncome: (json['totalIncome'] as num).toInt(),
  completedSideJobCount: (json['completedSideJobCount'] as num).toInt(),
  completedQuestCount: (json['completedQuestCount'] as num).toInt(),
);

Map<String, dynamic> _$$UserActivitySummaryEntityImplToJson(
  _$UserActivitySummaryEntityImpl instance,
) => <String, dynamic>{
  'totalIncome': instance.totalIncome,
  'completedSideJobCount': instance.completedSideJobCount,
  'completedQuestCount': instance.completedQuestCount,
};
