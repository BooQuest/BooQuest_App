import 'package:booquest/features/missions/domain/entities/subquest_regenerate_request_data.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../domain/repositories/mission_repository.dart';
import '../../domain/entities/mission_entity.dart';
import '../../domain/failures/mission_failure.dart';
import '../../domain/entities/subquest_entity.dart';
import '../../domain/entities/subquest_request_data.dart';
import '../states/mission_state.dart';

class MissionNotifier extends StateNotifier<MissionState> {
  final MissionRepository repository;

  MissionNotifier(this.repository) : super(const MissionState.initial());

  Future<void> createMissions({
    required int userId,
    required int sideJobId,
    required String sideJobTitle,
    required String sideJobDesignNotes,
  }) async {
    state = const MissionState.loading();
    final result = await repository.createMissions(MissionCreateRequest(
      userId: userId,
      sideJobId: sideJobId,
      sideJobTitle: sideJobTitle,
      sideJobDesignNotes: sideJobDesignNotes,
    ));
    result.fold(
      (MissionFailure f) => state = MissionState.failure(f),
      (List<MissionStepEntity> steps) => state = MissionState.success(steps),
    );
  }

  /// 선택된 부업의 미션 데이터 조회
  Future<void> getMissionsBySideJobId(int sideJobId) async {
    state = const MissionState.loading();
    final result = await repository.getMissionsBySideJobId(sideJobId);
    result.fold(
      (MissionFailure f) => state = MissionState.failure(f),
      (List<MissionStepEntity> steps) => state = MissionState.success(steps),
    );
  }

  /// 부퀘스트 조회
  Future<List<SubQuestEntity>?> getSubQuests(SubQuestRequestData request) async {
    final result = await repository.getSubQuests(request);
    return result.fold(
      (MissionFailure f) {
        print('❌ 부퀘스트 조회 실패: ${f.userMessage}');
        return null;
      },
      (List<SubQuestEntity> subQuests) {
        return subQuests;
      },
    );
  }

  /// 상태 직접 설정 (외부에서 사용)
  void setState(MissionState newState) {
    state = newState;
  }

  /// 부퀘스트 재생성
  Future<void> regenerateSubQuests(SubQuestRegenerateRequestData request) async {
    state = const MissionState.loading();
    
    final result = await repository.regenerateSubQuests(request);
    result.fold(
      (MissionFailure f) {
        print('❌ 부퀘스트 재생성 실패: ${f.userMessage}');
        state = MissionState.failure(f);
      },
      (List<SubQuestEntity> subQuests) {
        // SubQuestEntity를 MissionStepEntity로 변환
        final missionSteps = subQuests.map((subQuest) => MissionStepEntity(
          id: subQuest.id,
          title: subQuest.title,
          order: subQuest.seq,
          designNotes: subQuest.detail,
        )).toList();
        state = MissionState.success(missionSteps);
      },
    );
  }

  /// 미션 시작
  Future<bool> startMission(int missionId) async {
    
    final result = await repository.startMission(missionId);
    return result.fold(
      (MissionFailure f) {
        print('❌ 미션 시작 실패: ${f.userMessage}');
        return false;
      },
      (bool success) {
        return success;
      },
    );
  }
}


