import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';

/// 네이버 로그인 서비스
/// 
/// 네이버 소셜 로그인 기능을 담당하는 서비스 클래스입니다.
/// iOS에서 네이버 로그인 SDK를 통해 인증을 처리합니다.
/// 
/// 카카오 로그인과 동일한 구조로:
/// 1. 앱에서 액세스 토큰만 받기
/// 2. 백엔드에서 액세스 토큰으로 사용자 정보 조회 및 처리
class NaverLoginService {
  // 네이버 개발자 센터에서 발급받은 값들
  static const String _clientId = 'TM5eDkpd_rKv82eBNyJd';
  static const String _clientSecret = 'unToCI8V3H';
  /// 네이버 로그인 실행
  /// 
  /// 1. 네이버 로그인 SDK를 통해 인증 수행
  /// 2. 성공 시 액세스 토큰만 반환 (사용자 정보는 백엔드에서 처리)
  /// 3. 실패 시 null 반환
  Future<String?> login() async {
    try {
      
      // 네이버 로그인 실행
      final result = await FlutterNaverLogin.logIn();
      
      if (result.status == NaverLoginStatus.loggedIn) {
        print('✅ 네이버 로그인 성공');
        print('  - Access Token: ${result.accessToken?.accessToken}');
        
        // 로그인 성공 시 액세스 토큰만 반환
        return result.accessToken?.accessToken;
      } else {
        print('❌ 네이버 로그인 실패: ${result.status}');
        print('  - Error Message: ${result.errorMessage}');
        return null;
      }
    } catch (e) {
      print('❌ 네이버 로그인 중 예외 발생: $e');
      return null;
    }
  }
  

}
