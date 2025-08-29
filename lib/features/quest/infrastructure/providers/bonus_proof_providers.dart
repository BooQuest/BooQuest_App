import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/domain/repositories/bonus_proof_repository.dart';
import 'package:booquest/features/quest/infrastructure/api/bonus_proof_api_service.dart';
import 'package:booquest/features/quest/infrastructure/repositories/bonus_proof_repository_impl.dart';
import 'package:booquest/features/quest/application/notifiers/bonus_proof_notifier.dart';
import 'package:booquest/features/quest/application/states/bonus_proof_state.dart';

/// AuthStorageService Provider
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  return AuthStorageService.getInstanceSync();
});

/// NetworkClient Provider
final networkClientProvider = Provider<NetworkClient>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  return NetworkClient(authStorage);
});

/// BonusProofApiService Provider
final bonusProofApiServiceProvider = Provider<BonusProofApiService>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return BonusProofApiService(networkClient);
});

/// BonusProofRepository Provider
final bonusProofRepositoryProvider = Provider<BonusProofRepository>((ref) {
  final apiService = ref.watch(bonusProofApiServiceProvider);
  return BonusProofRepositoryImpl(apiService);
});

/// BonusProofNotifier Provider
final bonusProofNotifierProvider = StateNotifierProvider<BonusProofNotifier, BonusProofState>((ref) {
  final repository = ref.watch(bonusProofRepositoryProvider);
  return BonusProofNotifier(repository);
});
