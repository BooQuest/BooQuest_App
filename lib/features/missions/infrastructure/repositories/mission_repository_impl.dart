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
}


