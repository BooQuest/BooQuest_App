import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/states/user_activity_summary_state.dart';
import 'package:booquest/features/main/domain/entities/user_activity_summary_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';
import 'package:booquest/features/main/infrastructure/repositories/user_activity_summary_repository_impl.dart';

/// 사용자 활동 요약 Notifier
class UserActivitySummaryNotifier extends StateNotifier<UserActivitySummaryState> {
  final UserActivitySummaryRepositoryImpl _repository;

  UserActivitySummaryNotifier(this._repository) : super(const UserActivitySummaryState.initial());

  /// 사용자 활동 요약 데이터 조회
  Future<void> getUserActivitySummary() async {
    state = const UserActivitySummaryState.loading();
    
    final result = await _repository.getUserActivitySummary();
    
    result.fold(
      (failure) {
        print('Notifier: Failed to get user activity summary data');
        state = UserActivitySummaryState.failure(failure);
      },
      (data) {
        print('Notifier: Successfully got user activity summary data');
        state = UserActivitySummaryState.success(data);
      },
    );
  }
}
