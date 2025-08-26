import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/main/application/notifiers/mission_list_notifier.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/infrastructure/repositories/mission_list_repository_impl.dart';

/// 미션 목록 Repository Provider
final missionListRepositoryProvider = Provider<MissionListRepositoryImpl>((ref) {
  return MissionListRepositoryImpl();
});

/// 미션 목록 Notifier Provider
final missionListNotifierProvider = StateNotifierProvider<MissionListNotifier, MissionListState>((ref) {
  final repository = ref.watch(missionListRepositoryProvider);
  return MissionListNotifier(repository);
});
