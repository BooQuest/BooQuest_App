import 'package:booquest/features/missions/domain/entities/subquest_regenerate_request_data.dart';
import 'package:booquest/features/missions/domain/entities/bonus_ad_request_data.dart';
import 'package:booquest/features/missions/domain/entities/bonus_ad_response_data.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/mission_entity.dart';
import '../../domain/failures/mission_failure.dart';
import '../../domain/repositories/mission_repository.dart';
import '../../domain/entities/subquest_entity.dart';
import '../../domain/entities/subquest_request_data.dart';
import '../api/mission_api_service.dart';

class MissionRepositoryImpl implements MissionRepository {
  final MissionApiService apiService;

  MissionRepositoryImpl({MissionApiService? apiService}) : apiService = apiService ?? MissionApiService.instance;

  @override
  Future<Either<MissionFailure, List<MissionStepEntity>>> createMissions(MissionCreateRequest request) {
    return apiService.createMissions(request);
  }

  @override
  Future<Either<MissionFailure, List<MissionStepEntity>>> getMissionsBySideJobId(int sideJobId) {
    return apiService.getMissionsBySideJobId(sideJobId);
  }

  @override
  Future<Either<MissionFailure, List<SubQuestEntity>>> getSubQuests(SubQuestRequestData request) {
    return apiService.getSubQuests(request);
  }

  @override
  Future<Either<MissionFailure, bool>> startMission(int missionId) {
    return apiService.startMission(missionId);
  }

  @override
  Future<Either<MissionFailure, List<SubQuestEntity>>> regenerateSubQuests(
    SubQuestRegenerateRequestData request,
  ) {
    return apiService.regenerateSubQuests(request);
  }

  @override
  Future<Either<MissionFailure, BonusAdResponseData>> submitBonusAd(int stepId, BonusAdRequestData request) {
    return apiService.submitBonusAd(stepId, request);
  }
}


