import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_proof_entity.freezed.dart';
part 'image_proof_entity.g.dart';

/// 이미지 인증 응답 Entity
@freezed
class ImageProofEntity with _$ImageProofEntity {
  const factory ImageProofEntity({
    required String status,
    required int additionalExp,
  }) = _ImageProofEntity;

  factory ImageProofEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageProofEntityFromJson(json);
}

/// 이미지 인증 요청 데이터
@freezed
class ImageProofRequest with _$ImageProofRequest {
  const factory ImageProofRequest({
    required int stepId,
    // imagePath 제거 - API에서 file 자체를 받음
  }) = _ImageProofRequest;

  factory ImageProofRequest.fromJson(Map<String, dynamic> json) =>
      _$ImageProofRequestFromJson(json);
}
