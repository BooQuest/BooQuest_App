import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';

part 'bonus_proof_state.freezed.dart';

/// 보너스 인증 상태
@freezed
class BonusProofState with _$BonusProofState {
  /// 초기 상태
  const factory BonusProofState.initial() = _Initial;

  /// 로딩 중
  const factory BonusProofState.loading() = _Loading;

  /// 성공
  const factory BonusProofState.success(
    BonusProofEntity data,
  ) = _Success;

  /// 레벨업
  const factory BonusProofState.levelUp(
    BonusProofEntity data,
  ) = _LevelUp;

  /// 실패
  const factory BonusProofState.failure(
    String message,
  ) = _Failure;
}
