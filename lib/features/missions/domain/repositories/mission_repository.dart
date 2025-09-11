import 'package:booquest/features/missions/domain/entities/subquest_regenerate_request_data.dart';
import 'package:booquest/features/missions/domain/entities/bonus_ad_request_data.dart';
import 'package:booquest/features/missions/domain/entities/bonus_ad_response_data.dart';
import 'package:dartz/dartz.dart';
import '../entities/mission_entity.dart';
import '../failures/mission_failure.dart';
import '../entities/subquest_entity.dart';
import '../entities/subquest_request_data.dart';

abstract class MissionRepository {
  Future<Either<MissionFailure, List<MissionStepEntity>>> createMissions(MissionCreateRequest request);
  Future<Either<MissionFailure, List<MissionStepEntity>>> getMissionsBySideJobId(int sideJobId);
  Future<Either<MissionFailure, List<SubQuestEntity>>> getSubQuests(SubQuestRequestData request);
  Future<Either<MissionFailure, bool>> startMission(int missionId);

  /// 부퀘스트 재생성
  Future<Either<MissionFailure, List<SubQuestEntity>>> regenerateSubQuests(SubQuestRegenerateRequestData request);
  
  /// 보너스 광고 API 호출
  Future<Either<MissionFailure, BonusAdResponseData>> submitBonusAd(int stepId, BonusAdRequestData request);
}


