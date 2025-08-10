import 'package:dio/dio.dart';
import '../constants.dart';

/// HTTP 네트워크 클라이언트
/// 
/// Dio를 사용하여 Spring API와의 통신을 담당합니다.
/// 인터셉터, 타임아웃, 에러 처리 등을 설정합니다.
class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();
  factory NetworkClient() => _instance;
  NetworkClient._internal();

  late final Dio _dio;

  /// Dio 인스턴스 초기화
  void initialize() {
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

    // 인터셉터 추가
    _setupInterceptors();
  }

  /// Dio 인스턴스 가져오기
  Dio get dio => _dio;

  /// 인터셉터 설정
  void _setupInterceptors() {
    // 요청 인터셉터
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // JWT 토큰이 있으면 헤더에 추가
          // TODO: SharedPreferences에서 토큰 가져오기
          // final token = await _getStoredToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          
        //   print('🌐 API 요청: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
        //   print('✅ API 응답: ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
        //   print('❌ API 에러: ${error.response?.statusCode} ${error.requestOptions.path}');
        //   print('에러 메시지: ${error.message}');
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