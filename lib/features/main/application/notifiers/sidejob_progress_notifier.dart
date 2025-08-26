import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/domain/entities/sidejob_progress_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/repositories/sidejob_progress_repository_impl.dart';

/// 사이드잡 진행률 Notifier
class SideJobProgressNotifier extends StateNotifier<SideJobProgressState> {
  final SideJobProgressRepositoryImpl _repository;

  SideJobProgressNotifier(this._repository) : super(const SideJobProgressState.initial());

  /// 사이드잡 진행률 조회
  Future<void> getSideJobProgress(int sideJobId) async {
    try {
      print('🔍 SideJobProgressNotifier: getSideJobProgress 호출 - sideJobId: $sideJobId');
      
      state = const SideJobProgressState.loading();
      
      final result = await _repository.getSideJobProgress(sideJobId);
      
      result.fold(
        (failure) {
          print('Notifier: Failed to get side job progress data');
          state = SideJobProgressState.failure(failure);
        },
        (data) {
          print('Notifier: Successfully got side job progress data: ${data.title}');
          state = SideJobProgressState.success(data);
        },
      );
    } catch (e) {
      print('❌ SideJobProgressNotifier: 예외 발생 - $e');
      state = SideJobProgressState.failure(MainFailure.serverError());
    }
  }
}
