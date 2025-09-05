import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/quest/domain/entities/mission_completion_entity.dart';

/// 메인 퀘스트 완료 API Service
class MissionCompletionApiService {
  final NetworkClient _networkClient;

  MissionCompletionApiService(this._networkClient);

  /// 메인 퀘스트 완료 API 호출
  Future<MissionCompletionEntity> completeMission(int missionId) async {
    try {
      final response = await _networkClient.post(
        '/api/missions/$missionId/complete',
      );
      
      // data 필드가 null이거나 status가 already-completed인 경우 처리
      if (response.data['data'] == null || response.data['data']['status'] == 'already-completed') {
        // 이미 완료된 메인 퀘스트의 경우 예외를 던져서 quest_screen에서 처리하도록 함
        throw Exception('already-completed');
      }
      
      return MissionCompletionEntity.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
