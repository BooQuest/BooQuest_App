import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/notifiers/sidejob_summary_notifier.dart';
import 'package:booquest/features/revenue/application/states/sidejob_summary_state.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/sidejob_summary_repository_impl.dart';

/// 부업 프로젝트 요약 Repository Provider
final sideJobSummaryRepositoryProvider = Provider<SideJobSummaryRepositoryImpl>((ref) {
  return SideJobSummaryRepositoryImpl();
});

/// 부업 프로젝트 요약 Notifier Provider
final sideJobSummaryNotifierProvider = StateNotifierProvider<SideJobSummaryNotifier, SideJobSummaryState>((ref) {
  final repository = ref.watch(sideJobSummaryRepositoryProvider);
  return SideJobSummaryNotifier(repository);
});


