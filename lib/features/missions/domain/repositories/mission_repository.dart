import 'package:dartz/dartz.dart';
import '../entities/mission_entity.dart';
import '../failures/mission_failure.dart';
import '../entities/subquest_entity.dart';
import '../entities/subquest_request_data.dart';

abstract class MissionRepository {
  Future<Either<MissionFailure, List<MissionStepEntity>>> createMissions(MissionCreateRequest request);
  Future<Either<MissionFailure, List<MissionStepEntity>>> getMissionsBySideJobId(int sideJobId);
  Future<Either<MissionFailure, List<SubQuestEntity>>> getSubQuests(SubQuestRequestData request);
}


