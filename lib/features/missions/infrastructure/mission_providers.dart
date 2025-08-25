import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/mission_repository.dart';
import 'mission_repository_impl.dart';
import '../application/mission_notifier.dart';
import '../application/mission_state.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepositoryImpl();
});

final missionNotifierProvider = StateNotifierProvider<MissionNotifier, MissionState>((ref) {
  final repo = ref.watch(missionRepositoryProvider);
  return MissionNotifier(repo);
});


