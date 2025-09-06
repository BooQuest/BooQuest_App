import 'package:dio/dio.dart';
import 'package:booquest/core/services/token_refresh_service.dart';

/// API 재시도 서비스
/// 
/// 401 에러(토큰 만료) 발생 시 자동으로 토큰을 갱신하고
/// 실패한 API 요청을 재시도하는 공통 로직을 제공합니다.
class ApiRetryService {
  static ApiRetryService? _instance;
  final TokenRefreshService _tokenRefreshService;

  ApiRetryService._(this._tokenRefreshService);

  /// 싱글톤 인스턴스 생성
  static Future<ApiRetryService> getInstance() async {
    if (_instance == null) {
      final tokenRefreshService = await TokenRefreshService.getInstance();
      _instance = ApiRetryService._(tokenRefreshService);
    }
    return _instance!;
  }

  /// API 요청을 재시도 로직과 함께 실행
  /// 
  /// 401 에러 발생 시 토큰 갱신 후 재시도합니다.
  /// 토큰 갱신 실패 시 인증 데이터를 초기화합니다.
  /// 
  /// [apiCall]: 실행할 API 함수
  /// 
  /// Returns: API 응답 결과
  Future<T> executeWithRetry<T>(Future<T> Function() apiCall) async {
    try {
      // 1차 시도
      return await apiCall();
    } on DioException catch (e) {
      // 401 에러인 경우 토큰 갱신 후 재시도
      if (e.response?.statusCode == 401) {
        print('🔒 401 에러 감지 - 토큰 갱신 시도');
        
        // 토큰 갱신 시도
        final refreshSuccess = await _tokenRefreshService.refreshTokens();
        
        if (refreshSuccess) {
          print('✅ 토큰 갱신 성공 - API 재시도');
          // 토큰 갱신 성공 시 재시도
          return await apiCall();
        } else {
          print('❌ 토큰 갱신 실패 - 인증 데이터 초기화');
          // 토큰 갱신 실패 시 인증 데이터 초기화
          await _tokenRefreshService.clearAuthDataOnRefreshFailure();
          // 원래 에러를 다시 던져서 호출자가 처리하도록 함
          rethrow;
        }
      } else {
        // 401이 아닌 다른 에러는 그대로 전달
        rethrow;
      }
    } catch (e) {
      // DioException이 아닌 다른 에러도 그대로 전달
      rethrow;
    }
  }

  /// 특정 API 함수에 대한 재시도 래퍼 생성
  /// 
  /// 사용 예시:
  /// ```dart
  /// final retryWrapper = ApiRetryService.createRetryWrapper();
  /// final result = await retryWrapper(() => _apiService.someApiCall());
  /// ```
  static Future<ApiRetryService> createRetryWrapper() async {
    return await getInstance();
  }
}
