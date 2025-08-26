import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 미션 목록 API 서비스
class MissionListApiService {
  final NetworkClient _client;

  MissionListApiService(this._client);

  /// 미션 목록 조회
  /// 
  /// [status]: 미션 상태 ('IN_PROGRESS', 'PLANNED' 등)
  /// 
  /// Returns: API 응답
  Future<Response> getMissionList(String status) async {
    try {
      print('🔍 MissionListApiService: getMissionList 호출 - status: $status');
      
      final response = await _client.get('/api/missions', 
        queryParameters: {'status': status});
      
      print('✅ MissionListApiService: API 응답 성공');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');
      
      return response;
    } catch (e) {
      print('❌ MissionListApiService: API 호출 실패 - $e');
      rethrow;
    }
  }
}
