import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/application/states/bonus_proof_state.dart';
import 'package:booquest/features/quest/domain/repositories/bonus_proof_repository.dart';
import 'package:booquest/features/quest/domain/entities/bonus_proof_entity.dart';

/// 보너스 인증 Notifier
class BonusProofNotifier extends StateNotifier<BonusProofState> {
  final BonusProofRepository _repository;

  BonusProofNotifier(this._repository) : super(const BonusProofState.initial());

  /// 보너스 인증 처리
  Future<void> submitProof(int stepId, ProofType proofType, String content) async {
    try {
      print('🚀 BonusProofNotifier: submitProof 시작 - stepId: $stepId, proofType: $proofType');
      
      state = const BonusProofState.loading();

      final result = await _repository.submitProof(stepId, proofType, content);

      result.fold(
        (failure) {
          print('❌ BonusProofNotifier: submitProof 실패 - ${failure.message}');
          state = BonusProofState.failure(failure.message);
        },
        (data) {
          print('✅ BonusProofNotifier: submitProof 성공 - status: ${data.status}, additionalExp: ${data.additionalExp}');
          
          // 레벨업 체크
          if (data.leveledUp) {
            state = BonusProofState.levelUp(data);
          } else {
            state = BonusProofState.success(data);
          }
        },
      );
    } catch (e) {
      print('❌ BonusProofNotifier: submitProof 예외 발생 - $e');
      state = BonusProofState.failure('알 수 없는 오류가 발생했습니다.');
    }
  }

  /// 상태 초기화
  void reset() {
    state = const BonusProofState.initial();
  }
}
