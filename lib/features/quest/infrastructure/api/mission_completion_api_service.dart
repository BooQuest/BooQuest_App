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
      print('🚀 [API] 메인 퀘스트 완료 요청 시작: missionId=$missionId');
      
      final response = await _networkClient.post(
        '/api/missions/$missionId/complete',
      );
      
      return MissionCompletionEntity.fromJson(response.data['data']);
    } catch (e) {
      print('❌ [API] 메인 퀘스트 완료 요청 실패: $e');
      rethrow;
    }
  }
}
