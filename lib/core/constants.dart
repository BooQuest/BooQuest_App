import 'dart:io';

/// 앱 전반에 사용되는 상수들
class AppConstants {
  // 앱 정보
  static const String appName = 'BooQuest';
  static const String appVersion = '1.0.0';
  
  // 카카오 로그인 관련 - 기본값 사용 (환경변수 비활성화)
  static String get kakaoAppKey {
    if (Platform.isAndroid) {
      return 'YOUR_ANDROID_APP_KEY'; // TODO: 실제 Android 앱 키로 교체
    } else if (Platform.isIOS) {
      return 'YOUR_IOS_APP_KEY'; // TODO: 실제 iOS 앱 키로 교체
    }
    throw UnsupportedError('지원하지 않는 플랫폼입니다.');
  }
  
  static String get kakaoRedirectUri => 'kakao$kakaoAppKey://oauth';
  
  // 에러 메시지
  static const String networkErrorMessage = '네트워크 연결을 확인해주세요.';
  static const String unknownErrorMessage = '알 수 없는 오류가 발생했습니다.';
  static const String kakaoLoginErrorMessage = '카카오 로그인에 실패했습니다.';
  static const String kakaoInitErrorMessage = '카카오 SDK 초기화에 실패했습니다.';
  
  // 성공 메시지
  static const String kakaoLoginSuccessMessage = '카카오 로그인에 성공했습니다!';
  
  // 로딩 메시지
  static const String loginLoadingMessage = '로그인 중입니다...';
  
  // 로컬 저장소 키
  static const String authTokenKey = 'auth_token';
  static const String userInfoKey = 'user_info';
  
  // API 관련 (나중에 Spring API 구현시 사용)
  static const String baseUrl = 'http://49.50.129.68:8080'; // 실제 API URL
  static const String loginEndpoint = '/api/auth/login';
  static const Duration requestTimeout = Duration(seconds: 30);
}
