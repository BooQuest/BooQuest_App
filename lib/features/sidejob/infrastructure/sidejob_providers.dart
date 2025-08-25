import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/sidejob_repository.dart';
import '../domain/sidejob_entity.dart';
import '../domain/sidejob_failure.dart';
import '../application/sidejob_notifier.dart';
import '../application/sidejob_state.dart';
import '../application/get_sidejob_recommendations.dart';
import 'sidejob_repository_impl.dart';
import 'sidejob_api_service.dart';
import 'user_data_service.dart';
import 'package:booquest/features/sidejob/application/select_user_sidejob.dart';

// ========== Infrastructure Providers ==========

/// SideJobApiService Provider
final sideJobApiServiceProvider = Provider<SideJobApiService>((ref) {
  return SideJobApiService.instance;
});

/// UserDataService Provider
final userDataServiceProvider = Provider<UserDataService>((ref) {
  return UserDataService.instance;
});

/// SideJobRepository Provider
final sideJobRepositoryProvider = Provider<SideJobRepository>((ref) {
  return SideJobRepositoryImpl(
    apiService: ref.read(sideJobApiServiceProvider),
    userDataService: ref.read(userDataServiceProvider),
  );
});

// ========== Application Providers ==========

/// GetSideJobRecommendations UseCase Provider
final getSideJobRecommendationsProvider = Provider<GetSideJobRecommendations>((ref) {
  return GetSideJobRecommendations(ref.read(sideJobRepositoryProvider));
});

/// RegenerateSideJobs UseCase Provider
final regenerateSideJobsProvider = Provider<RegenerateSideJobs>((ref) {
  return RegenerateSideJobs(ref.read(sideJobRepositoryProvider));
});

/// RegenerateSingleSideJob UseCase Provider
final regenerateSingleSideJobProvider = Provider<RegenerateSingleSideJob>((ref) {
  return RegenerateSingleSideJob(ref.read(sideJobRepositoryProvider));
});

/// GetExistingSideJobs UseCase Provider
final getExistingSideJobsProvider = Provider<GetExistingSideJobs>((ref) {
  return GetExistingSideJobs(ref.read(sideJobRepositoryProvider));
});

/// 사용자 부업 선택 Use Case Provider
final selectUserSideJobProvider = Provider<SelectUserSideJob>((ref) {
  final repository = ref.watch(sideJobRepositoryProvider);
  return SelectUserSideJob(repository);
});

/// SideJob Notifier Provider (업데이트)
final sideJobNotifierProvider = StateNotifierProvider<SideJobNotifier, SideJobState>((ref) {
  final getRecommendations = ref.watch(getSideJobRecommendationsProvider);
  final selectUserSideJob = ref.watch(selectUserSideJobProvider);
  return SideJobNotifier(getRecommendations, selectUserSideJob);
});

// ========== Convenience Providers ==========

/// 현재 부업 추천 상태
final sideJobStateProvider = Provider<SideJobState>((ref) {
  return ref.watch(sideJobNotifierProvider);
});

/// 로딩 상태 확인
final sideJobLoadingProvider = Provider<bool>((ref) {
  return ref.watch(sideJobNotifierProvider).isLoading;
});

/// 성공 시 추천 데이터
final sideJobRecommendationsProvider = Provider<List<SideJobEntity>?>((ref) {
  return ref.watch(sideJobNotifierProvider).recommendations;
});

/// 실패 시 에러 정보
final sideJobFailureProvider = Provider<SideJobFailure?>((ref) {
  return ref.watch(sideJobNotifierProvider).failure;
});
