import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 사이드잡 진행률 API 서비스
class SideJobProgressApiService {
  final NetworkClient _client;

  SideJobProgressApiService(this._client);

  /// 사이드잡 진행률 조회
  /// 
  /// [sideJobId]: 사용자의 사이드잡 ID
  /// 
  /// Returns: API 응답
  Future<Response> getSideJobProgress(int sideJobId) async {
    try {
      print('🔍 SideJobProgressApiService: getSideJobProgress 호출 - sideJobId: $sideJobId');
      
      final response = await _client.get('/api/user/sideJob/progress/', 
        queryParameters: {'sideJobId': sideJobId});
      
      print('✅ SideJobProgressApiService: API 응답 성공');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');
      
      return response;
    } catch (e) {
      print('❌ SideJobProgressApiService: API 호출 실패 - $e');
      rethrow;
    }
  }
}
