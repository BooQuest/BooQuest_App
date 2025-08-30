import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/application/states/mission_completion_state.dart';
import 'package:booquest/features/quest/domain/repositories/mission_completion_repository.dart';
import 'package:booquest/features/quest/domain/entities/mission_completion_entity.dart';

/// 메인 퀘스트 완료 Notifier
class MissionCompletionNotifier extends StateNotifier<MissionCompletionState> {
  final MissionCompletionRepository _repository;

  MissionCompletionNotifier(this._repository) : super(const MissionCompletionState.initial());

  /// 메인 퀘스트 완료 처리
  Future<void> completeMission(int missionId) async {
    try {
      print('🎯 [Notifier] 메인 퀘스트 완료 시작: missionId=$missionId');
      
      // 로딩 상태로 변경
      state = const MissionCompletionState.loading();

      // 리포지토리 호출
      final result = await _repository.completeMission(missionId);

      // 결과에 따른 상태 업데이트
      result.fold(
        (failure) {
          final errorMessage = failure.when(
            serverError: (message) => message,
            networkError: (message) => message,
            authError: (message) => message,
            unknownError: (message) => message,
          );
          print('❌ [Notifier] 메인 퀘스트 완료 실패: $errorMessage');
          state = MissionCompletionState.failure(errorMessage);
        },
        (data) {
          state = MissionCompletionState.success(data);
        },
      );
    } catch (e) {
      print('❌ [Notifier] 메인 퀘스트 완료 처리 중 오류: $e');
      state = const MissionCompletionState.failure('메인 퀘스트 완료 처리 중 오류가 발생했습니다.');
    }
  }
}
