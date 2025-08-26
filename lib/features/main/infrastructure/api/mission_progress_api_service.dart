import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import '../../domain/entities/mission_progress_entity.dart';

/// 미션 진행 상황 API 서비스
class MissionProgressApiService {
  final NetworkClient _networkClient;

  MissionProgressApiService(this._networkClient);

  /// 미션 진행 상황 조회
  /// 
  /// [sideJobId]: 사용자의 사이드잡 ID
  /// 
  /// Returns: 미션 진행 상황 정보
  Future<Response<Map<String, dynamic>>> getMissionProgress(int sideJobId) async {
    return await _networkClient.get<Map<String, dynamic>>(
      '/api/missions/progress',
      queryParameters: {
        'sideJobId': sideJobId,
      },
    );
  }
}

