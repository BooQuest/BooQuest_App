import 'dart:io';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Apple Login 서비스
/// 
/// Apple Sign In 기능을 제공하는 서비스 클래스입니다.
/// iOS에서만 동작하며, Android에서는 null을 반환합니다.
class AppleLoginService {
  /// Apple 로그인 실행
  /// 
  /// Apple Sign In을 통해 사용자 인증을 수행합니다.
  /// 
  /// Returns:
  /// - 성공 시: Apple에서 발급받은 identityToken (JWT)
  /// - 실패 시: null
  /// - Android에서 호출 시: null
  Future<String?> login() async {
    // Android에서는 Apple Login을 지원하지 않음
    if (!Platform.isIOS) {
      return null;
    }

    try {
      
      // Apple Sign In 요청
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // authorizationCode 있는지 확인
      if (credential.authorizationCode != null && credential.authorizationCode!.isNotEmpty) {
        print('Apple Login Success: ${credential.authorizationCode}');
        return credential.authorizationCode;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
