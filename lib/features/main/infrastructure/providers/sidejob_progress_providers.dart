import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/notifiers/sidejob_progress_notifier.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/infrastructure/repositories/sidejob_progress_repository_impl.dart';

/// 사이드잡 진행률 Repository Provider
final sideJobProgressRepositoryProvider = Provider<SideJobProgressRepositoryImpl>((ref) {
  return SideJobProgressRepositoryImpl();
});

/// 사이드잡 진행률 Notifier Provider
final sideJobProgressNotifierProvider = StateNotifierProvider<SideJobProgressNotifier, SideJobProgressState>((ref) {
  final repository = ref.watch(sideJobProgressRepositoryProvider);
  return SideJobProgressNotifier(repository);
});
