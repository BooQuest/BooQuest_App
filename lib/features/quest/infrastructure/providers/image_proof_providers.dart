import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/infrastructure/api/image_proof_api_service.dart';
import 'package:booquest/features/quest/infrastructure/repositories/image_proof_repository_impl.dart';
import 'package:booquest/features/quest/domain/repositories/image_proof_repository.dart';
import 'package:booquest/features/quest/application/notifiers/image_proof_notifier.dart';
import 'package:booquest/features/quest/application/states/image_proof_state.dart';

/// AuthStorageService Provider
final authStorageServiceProvider = Provider<AuthStorageService>((ref) {
  return AuthStorageService.getInstanceSync();
});

/// NetworkClient Provider
final networkClientProvider = Provider<NetworkClient>((ref) {
  final authStorage = ref.watch(authStorageServiceProvider);
  return NetworkClient(authStorage);
});

/// 이미지 인증 API Service Provider
final imageProofApiServiceProvider = Provider<ImageProofApiService>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return ImageProofApiService(networkClient);
});

/// 이미지 인증 Repository Provider
final imageProofRepositoryProvider = Provider<ImageProofRepository>((ref) {
  final apiService = ref.watch(imageProofApiServiceProvider);
  return ImageProofRepositoryImpl(apiService);
});

/// 이미지 인증 Notifier Provider
final imageProofNotifierProvider = StateNotifierProvider<ImageProofNotifier, ImageProofState>((ref) {
  final repository = ref.watch(imageProofRepositoryProvider);
  return ImageProofNotifier(repository);
});
