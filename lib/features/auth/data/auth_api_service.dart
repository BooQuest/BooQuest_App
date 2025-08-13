import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/core/constants.dart';

/// 인증 API 서비스
///
/// - 기능 요약: 소셜 로그인 요청 전송, JWT 수신(예정)
class AuthApiService {
  final NetworkClient _client;

  AuthApiService(this._client);

  /// 소셜 로그인
  /// provider: 'kakao', 'naver', 'apple' 등
  /// accessToken: SNS에서 받은 액세스 토큰
  Future<Response<Map<String, dynamic>>> socialLogin({
    required String provider,
    required String accessToken,
  }) async {
    return await _client.post<Map<String, dynamic>>(
      AppConstants.loginEndpoint,
      data: {
        'provider': provider,
        'accessToken': accessToken,
      },
    );
  }
}


