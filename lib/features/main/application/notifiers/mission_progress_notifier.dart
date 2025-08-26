import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/mission_progress_state.dart';
import '../../infrastructure/repositories/mission_progress_repository_impl.dart';

/// 미션 진행 상황 상태 노티파이어
class MissionProgressNotifier extends StateNotifier<MissionProgressState> {
  MissionProgressNotifier() : super(const MissionProgressState.initial());

  /// 미션 진행 상황 정보를 가져옵니다
  Future<void> getMissionProgress(int sideJobId) async {
    print('Notifier: Starting to get mission progress data - sideJobId: $sideJobId');
    state = const MissionProgressState.loading();
    
    final repository = MissionProgressRepositoryImpl();
    final result = await repository.getMissionProgress(sideJobId);
    
    result.fold(
      (failure) {
        print('Notifier: Failed to get mission progress data');
        state = MissionProgressState.failure(failure);
      },
      (data) {
        print('Notifier: Successfully got mission progress data: ${data.currentMissionTitle}');
        state = MissionProgressState.success(data);
      },
    );
  }

  /// 상태를 초기화합니다
  void reset() {
    state = const MissionProgressState.initial();
  }
}

