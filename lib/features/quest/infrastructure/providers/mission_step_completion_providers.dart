import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/domain/repositories/mission_step_completion_repository.dart';
import 'package:booquest/features/quest/infrastructure/api/mission_step_completion_api_service.dart';
import 'package:booquest/features/quest/infrastructure/repositories/mission_step_completion_repository_impl.dart';
import 'package:booquest/features/quest/application/notifiers/mission_step_completion_notifier.dart';
import 'package:booquest/features/quest/application/states/mission_step_completion_state.dart';

/// AuthStorageService Provider
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  // 동기적으로 초기화 (singleton 패턴 활용)
  return AuthStorageService.getInstanceSync();
});

/// NetworkClient Provider
final networkClientProvider = Provider<NetworkClient>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  return NetworkClient(authStorage);
});

/// MissionStepCompletionApiService Provider
final missionStepCompletionApiServiceProvider = Provider<MissionStepCompletionApiService>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return MissionStepCompletionApiService(networkClient);
});

/// MissionStepCompletionRepository Provider
final missionStepCompletionRepositoryProvider = Provider<MissionStepCompletionRepository>((ref) {
  final apiService = ref.watch(missionStepCompletionApiServiceProvider);
  return MissionStepCompletionRepositoryImpl(apiService);
});

/// MissionStepCompletionNotifier Provider
final missionStepCompletionNotifierProvider = StateNotifierProvider<MissionStepCompletionNotifier, MissionStepCompletionState>((ref) {
  final repository = ref.watch(missionStepCompletionRepositoryProvider);
  return MissionStepCompletionNotifier(repository);
});
