import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/quest/infrastructure/api/mission_completion_api_service.dart';
import 'package:booquest/features/quest/infrastructure/repositories/mission_completion_repository_impl.dart';
import 'package:booquest/features/quest/application/notifiers/mission_completion_notifier.dart';
import 'package:booquest/features/quest/application/states/mission_completion_state.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// AuthStorageService 프로바이더
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  return AuthStorageService.getInstanceSync();
});

/// NetworkClient 프로바이더
final networkClientProvider = Provider<NetworkClient>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  return NetworkClient(authStorage);
});

/// MissionCompletionApiService 프로바이더
final missionCompletionApiServiceProvider = Provider<MissionCompletionApiService>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return MissionCompletionApiService(networkClient);
});

/// MissionCompletionRepository 프로바이더
final missionCompletionRepositoryProvider = Provider<MissionCompletionRepositoryImpl>((ref) {
  final apiService = ref.watch(missionCompletionApiServiceProvider);
  return MissionCompletionRepositoryImpl(apiService);
});

/// MissionCompletionNotifier 프로바이더
final missionCompletionNotifierProvider = StateNotifierProvider<MissionCompletionNotifier, MissionCompletionState>((ref) {
  final repository = ref.watch(missionCompletionRepositoryProvider);
  return MissionCompletionNotifier(repository);
});
