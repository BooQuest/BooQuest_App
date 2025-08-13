import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 보안 토큰 저장 서비스
///
/// - 기능 요약: JWT/리프레시 토큰을 안전하게 저장/조회/삭제
class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  static Future<void> removeAccessToken() async {
    await _secureStorage.delete(key: _accessTokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> removeRefreshToken() async {
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  static Future<void> clearAll() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}


