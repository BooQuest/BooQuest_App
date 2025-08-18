import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// 인증 API 서비스
class AuthApiService {
  final NetworkClient _networkClient;

  AuthApiService(this._networkClient);

  /// 소셜 로그인
  Future<Response<Map<String, dynamic>>> loginWithSocial({
    required String accessToken,
    required String provider,
  }) async {
    return await _networkClient.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {
        'accessToken': accessToken,
        'provider': provider,
      },
    );
  }

  /// 사용자 정보 조회 (user/me)
  Future<Response<Map<String, dynamic>>> getUserInfo() async {
    return await _networkClient.get<Map<String, dynamic>>('/api/user/me');
  }

}


