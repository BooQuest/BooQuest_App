import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';

/// Infrastructure 계층: 인증 API 서비스
/// 
/// 외부 API와의 통신을 담당하는 서비스입니다.
/// 순수한 API 호출 로직만 포함하며, 비즈니스 로직은 포함하지 않습니다.
class AuthApiService {
  final NetworkClient _networkClient;

  AuthApiService(this._networkClient);

  /// 소셜 로그인 API 호출
  /// 
  /// [accessToken]: 소셜 플랫폼에서 발급받은 액세스 토큰
  /// [provider]: 소셜 플랫폼 종류 (kakao, google 등)
  /// 
  /// Returns: 서버 응답 (success, data, message 포함)
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

  /// 사용자 정보 조회 API 호출
  /// 
  /// JWT 토큰을 헤더에 포함하여 현재 사용자 정보를 조회합니다.
  /// 
  /// Returns: 사용자 정보 (id, email, nickname, profileImageUrl 등)
  Future<Response<Map<String, dynamic>>> getUserInfo() async {
    return await _networkClient.get<Map<String, dynamic>>('/api/user/me');
  }

  /// 토큰 갱신 API 호출
  /// 
  /// [refreshToken]: 리프레시 토큰
  /// 
  /// Returns: 새로운 액세스 토큰과 리프레시 토큰
  Future<Response<Map<String, dynamic>>> refreshToken(String refreshToken) async {
    return await _networkClient.post<Map<String, dynamic>>(
      '/api/auth/refresh',
      data: {
        'refreshToken': refreshToken,
      },
    );
  }

  /// 로그아웃 API 호출
  /// 
  /// 서버에서 토큰을 무효화합니다.
  Future<Response<Map<String, dynamic>>> logout() async {
    return await _networkClient.post<Map<String, dynamic>>('/api/auth/logout');
  }
}
