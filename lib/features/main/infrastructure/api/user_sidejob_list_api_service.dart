import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 사용자 사이드잡 목록 API 서비스
class UserSideJobListApiService {
  final NetworkClient _client;

  UserSideJobListApiService(this._client);

  /// 사용자 사이드잡 목록 조회
  Future<Response> getUserSideJobList() async {
    return await _client.get('/api/user/sideJob');
  }
}
