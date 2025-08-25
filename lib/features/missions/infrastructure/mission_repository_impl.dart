import 'package:dartz/dartz.dart';
import '../domain/mission_entity.dart';
import '../domain/mission_failure.dart';
import '../domain/mission_repository.dart';
import '../domain/subquest_entity.dart';
import '../domain/subquest_request_data.dart';
import 'mission_api_service.dart';

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
}


