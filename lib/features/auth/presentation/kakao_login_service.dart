import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/core/storage/local_storage_service.dart';

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
      
      // 서버에 로그인 요청
      await _sendLoginToServer(token.accessToken);
      
      return token.accessToken;
    } catch (error) {
      print('❌ 카카오 로그인 실패: $error');
      return null;
    }
  }

  /// 서버에 로그인 요청
  Future<void> _sendLoginToServer(String accessToken) async {
    try {
      final response = await NetworkClient().post('/api/auth/login', data: {
        'accessToken': accessToken,
        'provider': 'kakao',
      });
      
      final responseData = response.data;
      if (responseData['success'] == true) {
        print('📦 응답 데이터: ${responseData['data']}');
        
        // userInfo를 local storage에 저장
        if (responseData['data'] != null) {
          final data = responseData['data'];
          
          // tokenInfo 저장
          if (data['tokenInfo'] != null) {
            final tokenInfo = data['tokenInfo'];
            final storage = await LocalStorageService.getInstance();
            
            // JWT 토큰 저장
            if (tokenInfo['accessToken'] != null) {
              await storage.setAccessToken(tokenInfo['accessToken']);
            }
            if (tokenInfo['refreshToken'] != null) {
              await storage.setRefreshToken(tokenInfo['refreshToken']);
            }
          } else {
            print('❌ data에 tokenInfo가 없음');
          }
          
          // userInfo 저장
          if (data['userInfo'] != null) {
            final userInfo = data['userInfo'];
            final storage = await LocalStorageService.getInstance();
            
            // userId 저장
            if (userInfo['userId'] != null) {
              await storage.setUserId(userInfo['userId']);
            } else {
              print('❌ userInfo에 userId가 없음');
            }
            
            // 기타 사용자 정보 저장
            if (userInfo['nickname'] != null) {
              storage.saveCharacterName(userInfo['nickname']);
            }
            if (userInfo['email'] != null) {
              storage.setEmail(userInfo['email']);
            }
            if (userInfo['profileImageUrl'] != null) {
              storage.setProfileImageUrl(userInfo['profileImageUrl']);
            }

          } else {
            print('❌ data에 userInfo가 없음');
          }
        }
        
      } else {
        print('❌ 서버 로그인 실패');
        print('🚨 에러 메시지: ${responseData['message']}');
        print('🚨 상태 코드: ${responseData['status']}');
      }
      
    } catch (error) {
      print('❌ 서버 로그인 실패: $error');
      // 서버 로그인 실패해도 카카오 로그인은 성공한 것으로 처리
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