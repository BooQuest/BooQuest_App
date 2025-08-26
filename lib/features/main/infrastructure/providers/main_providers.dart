import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/notifiers/character_growth_notifier.dart';
import '../../application/notifiers/mission_progress_notifier.dart';
import '../../application/states/character_growth_state.dart';
import '../../application/states/mission_progress_state.dart';
import '../repositories/character_growth_repository_impl.dart';

/// 캐릭터 성장 노티파이어 프로바이더
final characterGrowthNotifierProvider = StateNotifierProvider<CharacterGrowthNotifier, CharacterGrowthState>((ref) {
  return CharacterGrowthNotifier();
});

/// 미션 진행 상황 노티파이어 프로바이더
final missionProgressNotifierProvider = StateNotifierProvider<MissionProgressNotifier, MissionProgressState>((ref) {
  return MissionProgressNotifier();
});

/// 캐릭터 성장 데이터 프로바이더 (FutureProvider)
final characterGrowthDataProvider = FutureProvider<dynamic>((ref) async {
  final repository = CharacterGrowthRepositoryImpl();
  final result = await repository.getCharacterGrowth();
  return result.fold(
    (failure) => throw failure,
    (data) => data,
  );
});
