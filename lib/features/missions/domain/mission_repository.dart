import 'package:dartz/dartz.dart';
import 'mission_entity.dart';
import 'mission_failure.dart';
import 'subquest_entity.dart';
import 'subquest_request_data.dart';

abstract class MissionRepository {
  Future<Either<MissionFailure, List<MissionStepEntity>>> createMissions(MissionCreateRequest request);
  Future<Either<MissionFailure, List<MissionStepEntity>>> getMissionsBySideJobId(int sideJobId);
  Future<Either<MissionFailure, List<SubQuestEntity>>> getSubQuests(SubQuestRequestData request);
}


