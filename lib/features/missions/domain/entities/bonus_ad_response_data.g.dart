// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_ad_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BonusAdResponseDataImpl _$$BonusAdResponseDataImplFromJson(
  Map<String, dynamic> json,
) => _$BonusAdResponseDataImpl(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: BonusAdData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BonusAdResponseDataImplToJson(
  _$BonusAdResponseDataImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$BonusAdDataImpl _$$BonusAdDataImplFromJson(Map<String, dynamic> json) =>
    _$BonusAdDataImpl(
      status: json['status'] as String,
      additionalExp: (json['additionalExp'] as num).toInt(),
      totalStepExp: (json['totalStepExp'] as num).toInt(),
      leveledUp: json['leveledUp'] as bool,
      currentLevel: (json['currentLevel'] as num).toInt(),
    );

Map<String, dynamic> _$$BonusAdDataImplToJson(_$BonusAdDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'additionalExp': instance.additionalExp,
      'totalStepExp': instance.totalStepExp,
      'leveledUp': instance.leveledUp,
      'currentLevel': instance.currentLevel,
    };
