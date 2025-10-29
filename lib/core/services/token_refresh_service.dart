import 'package:dio/dio.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/core/constants.dart';

/// 토큰 갱신 서비스
/// 
/// JWT 토큰이 만료되었을 때 refresh token을 사용하여 새로운 토큰을 발급받고
/// 로컬 스토리지를 업데이트하는 서비스를 제공합니다.
class TokenRefreshService {
  static TokenRefreshService? _instance;
  final AuthStorageService _authStorageService;
  late final Dio _dio;

  TokenRefreshService._(this._authStorageService) {
    _initializeDio();
  }

  /// 싱글톤 인스턴스 생성
  static Future<TokenRefreshService> getInstance() async {
    if (_instance == null) {
      final authStorageService = await AuthStorageService.getInstance();
      _instance = TokenRefreshService._(authStorageService);
    }
    return _instance!;
  }

  /// Dio 인스턴스 초기화 (토큰 갱신 전용)
  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.requestTimeout,
        receiveTimeout: AppConstants.requestTimeout,
        sendTimeout: AppConstants.requestTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  /// 토큰 갱신 시도
  /// 
  /// refresh token을 사용하여 새로운 access token과 refresh token을 발급받습니다.
  /// 성공 시 로컬 스토리지를 업데이트하고, 실패 시 false를 반환합니다.
  /// 
  /// Returns: 토큰 갱신 성공 여부
  Future<bool> refreshTokens() async {
    try {
      
      // 1. refresh token 확인
      final refreshToken = _authStorageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        print('❌ refresh token이 없습니다');
        return false;
      }

      // 2. 토큰 갱신 API 호출 (직접 Dio 사용)
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/auth/token/refresh',
        options: Options(
          headers: {
            'X-Refresh-Token': refreshToken,
          },
        ),
      );

      // 3. 응답 검증
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final responseData = response.data!['data'] as Map<String, dynamic>;
        
        // 4. 새로운 토큰 추출
        final newAccessToken = responseData['accessToken'] as String?;
        final newRefreshToken = responseData['refreshToken'] as String?;
        
        if (newAccessToken == null || newRefreshToken == null) {
          print('❌ 새로운 토큰이 응답에 없습니다');
          return false;
        }

        // 5. 로컬 스토리지 업데이트
        await _authStorageService.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        
        return true;
      } else {
        print('❌ 토큰 갱신 API 실패:');
        print('  - Status Code: ${response.statusCode}');
        print('  - Response Data: ${response.data}');
        return false;
      }
    } catch (e) {
      print('❌ 토큰 갱신 중 오류 발생: $e');
      return false;
    }
  }

  /// 토큰 갱신 실패 시 인증 데이터 초기화
  /// 
  /// refresh token도 만료되었거나 유효하지 않은 경우
  /// 모든 인증 데이터를 삭제합니다.
  Future<void> clearAuthDataOnRefreshFailure() async {
    print('🧹 토큰 갱신 실패로 인한 인증 데이터 초기화');
    await _authStorageService.clearAuthData();
  }
}
