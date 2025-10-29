import 'dart:async';
import 'package:dio/dio.dart';
import '../constants.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';

/// Infrastructure 계층: HTTP 네트워크 클라이언트
/// 
/// Clean Architecture의 Infrastructure 계층에서 외부 API와의 통신을 담당합니다.
/// Dio를 사용하여 Spring API와의 통신을 처리하고, 인터셉터를 통해
/// JWT 토큰 자동 추가, 에러 처리 등을 수행합니다.
class NetworkClient {
  final AuthStorageService _authStorageService;
  late final Dio _dio;
  
  // 토큰 갱신 관련
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;
  static const String _refreshTokenPath = '/api/auth/token/refresh';

  /// 생성자에서 AuthStorageService를 주입받아 의존성을 명확히 합니다.
  NetworkClient(this._authStorageService) {
    _initializeDio();
  }

  /// Dio 인스턴스 초기화
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

    // 인터셉터 설정
    _setupInterceptors();
  }

  /// Dio 인스턴스 가져오기
  Dio get dio => _dio;

  /// 인터셉터 설정
  void _setupInterceptors() {
    // 요청 인터셉터
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // refresh token API 호출 자체는 인터셉터 스킵
          if (options.path == _refreshTokenPath) {
            handler.next(options);
            return;
          }
          
          // 토큰 만료 체크 및 필요시 갱신
          await _checkAndRefreshTokenIfNeeded();
          
          // AuthStorageService에서 JWT 토큰을 가져와서 헤더에 추가
          try {
            final token = _authStorageService.getAccessToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            // 에러 무시
          }
          
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          
          // 401, 502 에러 시 로컬 스토리지 데이터 삭제 및 로그인 페이지로 이동
          if (error.response?.statusCode == 401 || error.response?.statusCode == 502) {
            
              try {
                // 로컬 스토리지 데이터 삭제
                await _authStorageService.clearAuthData();
                
                // AuthNotifier 강제 로그아웃 호출
                final authNotifier = AuthNotifier.instance;
                if (authNotifier != null) {
                  await authNotifier.forceLogout();
                }
              } catch (e) {
              }
          }
          
          handler.next(error);
        },
      ),
    );
  }

  /// 토큰 만료 체크 및 필요시 갱신
  /// 
  /// 만료되었거나 5분 이내라면 refresh token API 호출
  /// 여러 요청이 동시에 들어와도 한 번만 갱신하도록 처리
  Future<void> _checkAndRefreshTokenIfNeeded() async {
    try {
      // 토큰 만료시간 확인
      final expiresAt = _authStorageService.getTokenExpiresAt();
      if (expiresAt == null) {
        return;
      }

      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final timeUntilExpiry = expiresAt - currentTime;

      // 만료되었거나 5분 이내라면 갱신
      if (timeUntilExpiry > 300) { // 5분 = 300초
        return;
      }

      // 이미 갱신 중이면 완료될 때까지 대기
      if (_isRefreshing && _refreshCompleter != null) {
        await _refreshCompleter!.future;
        return;
      }

      // 토큰 갱신 시작
      _isRefreshing = true;
      _refreshCompleter = Completer<void>();

      try {
        final refreshToken = _authStorageService.getRefreshToken();
        if (refreshToken == null) {
          await _handleTokenRefreshFailure();
          return;
        }

        // Refresh token API 직접 호출 (인터셉터 우회)
        final response = await _dio.post<Map<String, dynamic>>(
          _refreshTokenPath,
          options: Options(
            headers: {
              'X-Refresh-Token': refreshToken,
            },
          ),
        );

        if (response.statusCode == 200 && 
            response.data != null && 
            response.data!['success'] == true) {
          
          final tokenData = response.data!['data'] as Map<String, dynamic>;
          final expiresIn = tokenData['expiresIn'] as int?;
          
          await _authStorageService.saveTokens(
            accessToken: tokenData['accessToken'] as String,
            refreshToken: tokenData['refreshToken'] as String,
            expiresIn: expiresIn,
          );
        } else {
          await _handleTokenRefreshFailure();
        }
      } catch (e) {
        await _handleTokenRefreshFailure();
      } finally {
        _isRefreshing = false;
        _refreshCompleter?.complete();
        _refreshCompleter = null;
      }
    } catch (e) {
      // 에러 발생 시 무시하고 원래 요청 진행
      _isRefreshing = false;
      _refreshCompleter?.complete();
      _refreshCompleter = null;
    }
  }

  /// 토큰 갱신 실패 시 처리
  Future<void> _handleTokenRefreshFailure() async {
    try {
      await _authStorageService.clearAuthData();
      
      final authNotifier = AuthNotifier.instance;
      if (authNotifier != null) {
        await authNotifier.forceLogout();
      }
    } catch (e) {
      // 에러 무시
    }
  }

  /// GET 요청
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST 요청
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT 요청
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE 요청
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// 에러 처리 헬퍼 메서드
  String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppConstants.networkErrorMessage;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          return '인증이 필요합니다. 다시 로그인해주세요.';
        } else if (error.response?.statusCode == 403) {
          return '접근 권한이 없습니다.';
        } else if (error.response?.statusCode == 404) {
          return '요청한 리소스를 찾을 수 없습니다.';
        } else if (error.response?.statusCode == 500) {
          return '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
        }
        return '요청 처리 중 오류가 발생했습니다.';
      case DioExceptionType.cancel:
        return '요청이 취소되었습니다.';
      case DioExceptionType.connectionError:
        return AppConstants.networkErrorMessage;
      default:
        return AppConstants.unknownErrorMessage;
    }
  }

}