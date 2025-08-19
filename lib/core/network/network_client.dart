import 'package:dio/dio.dart';
import '../constants.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// Infrastructure 계층: HTTP 네트워크 클라이언트
/// 
/// Clean Architecture의 Infrastructure 계층에서 외부 API와의 통신을 담당합니다.
/// Dio를 사용하여 Spring API와의 통신을 처리하고, 인터셉터를 통해
/// JWT 토큰 자동 추가, 에러 처리 등을 수행합니다.
class NetworkClient {
  final AuthStorageService _authStorageService;
  late final Dio _dio;

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
          // AuthStorageService에서 JWT 토큰을 가져와서 헤더에 추가
          try {
            final token = _authStorageService.getAccessToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            print('❌ 토큰 가져오기 실패: $e');
          }
          
          // 디버깅용 로그 (개발 환경에서만)
          print('🌐 API 요청: ${options.method} ${options.path}');
          if (options.headers['Authorization'] != null) {
            final token = options.headers['Authorization'] as String;
            
            print('🔐 Authorization: $token');
          }
          
          handler.next(options);
        },
        onResponse: (response, handler) {
          // 응답 로그
          print('✅ API 응답: ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          // 에러 로그
          print('❌ API 에러: ${error.response?.statusCode} ${error.requestOptions.path}');
          print('❌ 에러 메시지: ${error.message}');
          
          // 401 에러 시 토큰 만료 처리
          if (error.response?.statusCode == 401) {
            print('🔒 토큰 만료 감지, 인증 데이터 초기화 필요');
            // TODO: AuthNotifier를 통해 로그아웃 처리
          }
          
          handler.next(error);
        },
      ),
    );
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