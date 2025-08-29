// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_proof_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BonusProofEntityImpl _$$BonusProofEntityImplFromJson(
  Map<String, dynamic> json,
) => _$BonusProofEntityImpl(
  status: json['status'] as String,
  additionalExp: (json['additionalExp'] as num).toInt(),
);

Map<String, dynamic> _$$BonusProofEntityImplToJson(
  _$BonusProofEntityImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'additionalExp': instance.additionalExp,
};

_$BonusProofRequestImpl _$$BonusProofRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BonusProofRequestImpl(
  proofType: $enumDecode(_$ProofTypeEnumMap, json['proofType']),
  content: json['content'] as String,
);

Map<String, dynamic> _$$BonusProofRequestImplToJson(
  _$BonusProofRequestImpl instance,
) => <String, dynamic>{
  'proofType': _$ProofTypeEnumMap[instance.proofType]!,
  'content': instance.content,
};

const _$ProofTypeEnumMap = {
  ProofType.link: 'LINK',
  ProofType.text: 'TEXT',
  ProofType.image: 'IMAGE',
};
