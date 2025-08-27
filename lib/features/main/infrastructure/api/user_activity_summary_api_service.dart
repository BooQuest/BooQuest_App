import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 사용자 활동 요약 API 서비스
class UserActivitySummaryApiService {
  final NetworkClient _client;

  UserActivitySummaryApiService(this._client);

  /// 사용자 활동 요약 조회
  Future<Response> getUserActivitySummary() async {
    return await _client.get('/api/user/me/activities/summary');
  }
}
