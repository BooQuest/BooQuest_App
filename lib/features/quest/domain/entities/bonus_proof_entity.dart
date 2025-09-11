import 'package:freezed_annotation/freezed_annotation.dart';

part 'bonus_proof_entity.freezed.dart';
part 'bonus_proof_entity.g.dart';

/// 보너스 인증 응답 Entity
@freezed
class BonusProofEntity with _$BonusProofEntity {
  const factory BonusProofEntity({
    required String status,
    required int additionalExp,
    @Default(false) bool leveledUp,
    @Default(0) int currentLevel,
  }) = _BonusProofEntity;

  factory BonusProofEntity.fromJson(Map<String, dynamic> json) =>
      _$BonusProofEntityFromJson(json);
}

/// 인증 타입 Enum
enum ProofType {
  @JsonValue('LINK')
  link,
  @JsonValue('TEXT')
  text,
  @JsonValue('IMAGE')
  image,
}

/// 인증 요청 데이터
@freezed
class BonusProofRequest with _$BonusProofRequest {
  const factory BonusProofRequest({
    required ProofType proofType,
    required String content,
  }) = _BonusProofRequest;

  factory BonusProofRequest.fromJson(Map<String, dynamic> json) =>
      _$BonusProofRequestFromJson(json);
}
