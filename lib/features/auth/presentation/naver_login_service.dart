import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'dart:io';

/// 네이버 로그인 서비스
/// 
/// 네이버 소셜 로그인 기능을 담당하는 서비스 클래스입니다.
/// iOS에서 네이버 로그인 SDK를 통해 인증을 처리합니다.
/// 
/// 카카오 로그인과 동일한 구조로:
/// 1. 앱에서 액세스 토큰만 받기
/// 2. 백엔드에서 액세스 토큰으로 사용자 정보 조회 및 처리
class NaverLoginService {
  // 네이버 개발자 센터에서 발급받은 값들은 Info.plist에 설정됨
  // iOS에서는 Info.plist의 NidClientID, NidClientSecret을 사용
  
  /// 네이버 로그인 실행
  /// 
  /// 1. 네이버 로그인 SDK를 통해 인증 수행
  /// 2. 성공 시 액세스 토큰만 반환 (사용자 정보는 백엔드에서 처리)
  /// 3. 실패 시 null 반환
  Future<String?> login() async {
    try {
      
      // 기존 토큰 정리 (토큰 만료 문제 방지)
      try {
        await FlutterNaverLogin.logOut();
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {

      }
      
      // 네이버 로그인 실행
      final result = await FlutterNaverLogin.logIn();
      
      if (result.status == NaverLoginStatus.loggedIn) {
        
        // 네이버 플러그인 설계상 logIn() 결과에 accessToken이 포함되지 않음
        // 별도로 getCurrentAccessToken()을 호출해야 함
        try {
          final token = await FlutterNaverLogin.getCurrentAccessToken();
          
          if (token.accessToken.isNotEmpty) {
            print('✅ Access Token 획득 성공: ${token.accessToken}');
            return token.accessToken;
          } else {
            print('⚠️ Access Token이 비어있음. 리프레시 시도...');
            
            // 리프레시 토큰으로 갱신 시도
            final refreshedToken = await FlutterNaverLogin.refreshAccessTokenWithRefreshToken();

            if (refreshedToken.accessToken.isNotEmpty) {
              return refreshedToken.accessToken;
            } else {
              return null;
            }
          }
        } catch (e) {
          return null;
        }
      } else {
        
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
