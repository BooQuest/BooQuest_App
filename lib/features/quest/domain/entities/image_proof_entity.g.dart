// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_proof_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageProofEntityImpl _$$ImageProofEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ImageProofEntityImpl(
  status: json['status'] as String,
  additionalExp: (json['additionalExp'] as num).toInt(),
);

Map<String, dynamic> _$$ImageProofEntityImplToJson(
  _$ImageProofEntityImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'additionalExp': instance.additionalExp,
};

_$ImageProofRequestImpl _$$ImageProofRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ImageProofRequestImpl(stepId: (json['stepId'] as num).toInt());

Map<String, dynamic> _$$ImageProofRequestImplToJson(
  _$ImageProofRequestImpl instance,
) => <String, dynamic>{'stepId': instance.stepId};
