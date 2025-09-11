import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/mission_repository.dart';
import '../repositories/mission_repository_impl.dart';
import '../../application/notifiers/mission_notifier.dart';
import '../../application/states/mission_state.dart';
import '../../domain/entities/bonus_ad_request_data.dart';
import '../../domain/entities/bonus_ad_response_data.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepositoryImpl();
});

final missionNotifierProvider = StateNotifierProvider<MissionNotifier, MissionState>((ref) {
  final repo = ref.watch(missionRepositoryProvider);
  return MissionNotifier(repo);
});

/// 보너스 광고 API 호출 Provider
final submitBonusAdProvider = FutureProvider.family<BonusAdResponseData, ({int stepId, BonusAdRequestData request})>((ref, params) async {
  final repo = ref.watch(missionRepositoryProvider);
  final result = await repo.submitBonusAd(params.stepId, params.request);
  return result.fold(
    (failure) => throw Exception(failure.userMessage),
    (data) => data,
  );
});



