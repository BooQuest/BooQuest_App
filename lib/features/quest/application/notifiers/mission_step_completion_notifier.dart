import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/application/states/mission_step_completion_state.dart';
import 'package:booquest/features/quest/domain/repositories/mission_step_completion_repository.dart';

/// 퀘스트 스텝 완료 Notifier
class MissionStepCompletionNotifier extends StateNotifier<MissionStepCompletionState> {
  final MissionStepCompletionRepository _repository;

  MissionStepCompletionNotifier(this._repository) : super(const MissionStepCompletionState.initial());

  /// 퀘스트 스텝 완료 처리
  Future<void> completeStep(int stepId, String status) async {
    try {
      
      state = const MissionStepCompletionState.loading();

      final result = await _repository.completeStep(stepId, status);

      result.fold(
        (failure) {
          print('❌ MissionStepCompletionNotifier: completeStep 실패 - ${failure.message}');
          state = MissionStepCompletionState.failure(failure.message);
        },
        (data) {
          
          // 레벨업 체크
          if (data.leveledUp) {
            state = MissionStepCompletionState.levelUp(data);
          } else {
            state = MissionStepCompletionState.success(data);
          }
        },
      );
    } catch (e) {
      print('❌ MissionStepCompletionNotifier: completeStep 예외 발생 - $e');
      state = MissionStepCompletionState.failure('알 수 없는 오류가 발생했습니다.');
    }
  }

  /// 상태 초기화
  void reset() {
    state = const MissionStepCompletionState.initial();
  }
}
