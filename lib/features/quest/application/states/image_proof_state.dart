import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/quest/domain/entities/image_proof_entity.dart';

part 'image_proof_state.freezed.dart';

/// 이미지 인증 상태
@freezed
class ImageProofState with _$ImageProofState {
  /// 초기 상태
  const factory ImageProofState.initial() = _Initial;
  
  /// 로딩 상태
  const factory ImageProofState.loading() = _Loading;
  
  /// 성공 상태
  const factory ImageProofState.success(ImageProofEntity data) = _Success;
  
  /// 실패 상태
  const factory ImageProofState.failure(String message) = _Failure;
}
