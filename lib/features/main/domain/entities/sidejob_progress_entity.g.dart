// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidejob_progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SideJobProgressEntityImpl _$$SideJobProgressEntityImplFromJson(
  Map<String, dynamic> json,
) => _$SideJobProgressEntityImpl(
  title: json['title'] as String,
  progressPercent: (json['progressPercent'] as num).toInt(),
  currentOrder: (json['currentOrder'] as num).toInt(),
  totalStages: (json['totalStages'] as num).toInt(),
);

Map<String, dynamic> _$$SideJobProgressEntityImplToJson(
  _$SideJobProgressEntityImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'progressPercent': instance.progressPercent,
  'currentOrder': instance.currentOrder,
  'totalStages': instance.totalStages,
};
