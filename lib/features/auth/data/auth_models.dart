import 'package:booquest/features/auth/domain/auth_repository.dart';

/// Spring API와의 통신을 위한 데이터 모델들
/// 
/// 이 파일에는 인증 관련 API 요청/응답 모델이 정의됩니다.

/// 로그인 요청 모델
/// 
/// Spring API에 소셜 로그인 요청을 보낼 때 사용됩니다.
class LoginRequest {
  final String provider;      // 'kakao', 'naver', 'apple' 등
  final String accessToken;   // 소셜 로그인에서 받은 액세스 토큰
  
  const LoginRequest({
    required this.provider,
    required this.accessToken,
  });
  
  /// JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'accessToken': accessToken,
    };
  }
  
  @override
  String toString() {
    return 'LoginRequest(provider: $provider, accessToken: $accessToken)';
  }
}

/// 로그인 응답 모델
/// 
/// Spring API에서 로그인 성공 시 받는 응답입니다.
class LoginResponse {
  final String jwtToken;      // JWT 토큰
  final UserInfo userInfo;    // 사용자 정보
  
  const LoginResponse({
    required this.jwtToken,
    required this.userInfo,
  });
  
  /// JSON에서 LoginResponse 객체 생성
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwtToken: json['jwtToken'] as String,
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    );
  }
  
  @override
  String toString() {
    return 'LoginResponse(jwtToken: ${jwtToken.substring(0, 10)}..., userInfo: $userInfo)';
  }
}

/// API 에러 응답 모델
/// 
/// Spring API에서 에러 발생 시 받는 응답입니다.
class ApiErrorResponse {
  final String message;       // 에러 메시지
  final String? code;         // 에러 코드 (선택사항)
  final int statusCode;       // HTTP 상태 코드
  
  const ApiErrorResponse({
    required this.message,
    this.code,
    required this.statusCode,
  });
  
  /// JSON에서 ApiErrorResponse 객체 생성
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      message: json['message'] as String,
      code: json['code'] as String?,
      statusCode: json['statusCode'] as int? ?? 500,
    );
  }
  
  @override
  String toString() {
    return 'ApiErrorResponse(message: $message, code: $code, statusCode: $statusCode)';
  }
}

/// 사용자 정보 모델 (API 응답용)
/// 
/// Spring API에서 받는 사용자 정보입니다.
/// Domain의 UserInfo와 동일하지만 API 응답 구조에 맞춰 별도 정의
class ApiUserInfo {
  final String id;
  final String email;
  final String? name;
  final String? profileImage;
  final String provider;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  const ApiUserInfo({
    required this.id,
    required this.email,
    this.name,
    this.profileImage,
    required this.provider,
    this.createdAt,
    this.updatedAt,
  });
  
  /// JSON에서 ApiUserInfo 객체 생성
  factory ApiUserInfo.fromJson(Map<String, dynamic> json) {
    return ApiUserInfo(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      provider: json['provider'] as String,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }
  
  /// Domain의 UserInfo로 변환
  UserInfo toUserInfo() {
    return UserInfo(
      id: id,
      email: email,
      name: name,
      profileImage: profileImage,
      provider: provider,
    );
  }
  
  @override
  String toString() {
    return 'ApiUserInfo(id: $id, email: $email, name: $name, provider: $provider)';
  }
}
