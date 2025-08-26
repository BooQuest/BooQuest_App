import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/mission_repository.dart';
import '../repositories/mission_repository_impl.dart';
import '../../application/notifiers/mission_notifier.dart';
import '../../application/states/mission_state.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepositoryImpl();
});

final missionNotifierProvider = StateNotifierProvider<MissionNotifier, MissionState>((ref) {
  final repo = ref.watch(missionRepositoryProvider);
  return MissionNotifier(repo);
});


