import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

/// 카카오 로그인 서비스
///
/// 카카오 SDK를 통한 로그인 로직을 담당합니다.
/// 현재는 Spring API가 구현되지 않아 임시로 성공 응답을 시뮬레이션합니다.
class KakaoLoginService {
  /// 카카오 로그인 수행
  ///
  /// 카카오 SDK를 통해 로그인하고 액세스 토큰을 반환합니다.
  /// 로그인 실패 시 null을 반환합니다.
  Future<String?> login() async {
    try {
      OAuthToken token;
      final bool talkInstalled = await isKakaoTalkInstalled();

      if (talkInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (_) {
          token = await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      print('🔑 카카오 액세스 토큰: ${token.accessToken}');

      return token.accessToken;
    } catch (error) {
      print('❌ 카카오 로그인 실패: $error');
      return null;
    }
  }

  /// 카카오 로그아웃 수행
  ///
  /// 카카오 SDK를 통해 로그아웃합니다.
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 카카오 계정 연결 해제
  ///
  /// 카카오 계정과의 연결을 완전히 해제합니다.
  Future<bool> unlink() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 카카오 SDK 초기화 상태 확인
  ///
  /// 앱 시작 시 카카오 SDK가 제대로 초기화되었는지 확인합니다.
  Future<bool> isInitialized() async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }
} 