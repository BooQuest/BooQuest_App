import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/notifiers/user_sidejob_list_notifier.dart';
import 'package:booquest/features/main/application/states/user_sidejob_list_state.dart';
import 'package:booquest/features/main/infrastructure/repositories/user_sidejob_list_repository_impl.dart';

/// 사용자 사이드잡 목록 Repository Provider
final userSideJobListRepositoryProvider = Provider<UserSideJobListRepositoryImpl>((ref) {
  return UserSideJobListRepositoryImpl();
});

/// 사용자 사이드잡 목록 Notifier Provider
final userSideJobListNotifierProvider = StateNotifierProvider<UserSideJobListNotifier, UserSideJobListState>((ref) {
  final repository = ref.watch(userSideJobListRepositoryProvider);
  return UserSideJobListNotifier(repository);
});
