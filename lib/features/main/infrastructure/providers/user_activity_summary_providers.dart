import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/notifiers/user_activity_summary_notifier.dart';
import 'package:booquest/features/main/application/states/user_activity_summary_state.dart';
import 'package:booquest/features/main/infrastructure/repositories/user_activity_summary_repository_impl.dart';

/// 사용자 활동 요약 Repository Provider
final userActivitySummaryRepositoryProvider = Provider<UserActivitySummaryRepositoryImpl>((ref) {
  return UserActivitySummaryRepositoryImpl();
});

/// 사용자 활동 요약 Notifier Provider
final userActivitySummaryNotifierProvider = StateNotifierProvider<UserActivitySummaryNotifier, UserActivitySummaryState>((ref) {
  final repository = ref.watch(userActivitySummaryRepositoryProvider);
  return UserActivitySummaryNotifier(repository);
});
