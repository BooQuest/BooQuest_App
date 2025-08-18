import 'package:flutter/foundation.dart';
import 'package:booquest/features/auth/data/auth_api_service.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:dio/dio.dart';

/// 인증 상태를 관리하는 Provider
///
/// 로그인/로그아웃 상태, 사용자 정보, 로딩 상태 등을 관리합니다.
/// UI에서 이 Provider를 통해 인증 상태를 구독하고 변경할 수 있습니다.
class AuthProvider extends ChangeNotifier {
  final AuthApiService _authApiService;
  
  AuthProvider(this._authApiService);

  // 상태 변수들
  bool _isLoading = false;
  bool _isAuthenticated = false;
  Map<String, dynamic>? _currentUser;
  String? _errorMessage;

  // Getter들
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic>? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  /// 앱 시작 시 현재 사용자 상태 확인
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _authApiService.getUserInfo();
      
      if (response.statusCode == 200 && response.data != null && response.data!['success'] == true) {
        final userData = response.data!['data'] as Map<String, dynamic>;
        
        // 사용자 정보를 LocalStorage에 저장
        final storage = await LocalStorageService.getInstance();
        await storage.setUserId(userData['id'] as int);
        await storage.setEmail(userData['email'] ?? '');
        if (userData['profileImageUrl'] != null) {
          await storage.setProfileImageUrl(userData['profileImageUrl'] as String);
        }
        
        _currentUser = userData;
        _isAuthenticated = true;
      } else {
        _setError('인증 상태 확인에 실패했습니다.');
        _isAuthenticated = false;
      }
    } catch (e) {
      _setError('인증 상태 확인 중 오류가 발생했습니다.');
      _isAuthenticated = false;
    } finally {
      _setLoading(false);
    }
  }

  /// 소셜 로그인 수행
  Future<bool> loginWithSocial({
    required String accessToken,
    required String provider,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _authApiService.loginWithSocial(
        accessToken: accessToken,
        provider: provider,
      );
      
      if (response.statusCode == 200 && response.data != null && response.data!['success'] == true) {
        final responseData = response.data!['data'] as Map<String, dynamic>;
        
        // 사용자 정보와 토큰 정보를 LocalStorage에 저장
        final storage = await LocalStorageService.getInstance();
        
        // userInfo 저장
        if (responseData['userInfo'] != null) {
          final userInfo = responseData['userInfo'] as Map<String, dynamic>;
          await storage.setUserId(userInfo['userId'] as int);
          await storage.setEmail(userInfo['email'] ?? '');
          if (userInfo['nickname'] != null) {
            await storage.setNickname(userInfo['nickname'] as String);
          }
          if (userInfo['profileImageUrl'] != null) {
            await storage.setProfileImageUrl(userInfo['profileImageUrl'] as String);
          }
        }
        
        // tokenInfo 저장
        if (responseData['tokenInfo'] != null) {
          final tokenInfo = responseData['tokenInfo'] as Map<String, dynamic>;
          await storage.setAccessToken(tokenInfo['accessToken'] as String);
          await storage.setRefreshToken(tokenInfo['refreshToken'] as String);
        }
        
        _currentUser = responseData;
        _isAuthenticated = true;
        _setLoading(false);
        return true;
      } else {
        final message = response.data?['message'] ?? '로그인에 실패했습니다.';
        _setError(message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('로그인 중 오류가 발생했습니다.');
      _setLoading(false);
      return false;
    }
  }

  /// 에러 메시지 설정
  void _setError(String message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      notifyListeners();
    }
  }

  /// 에러 메시지 초기화
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  /// 로딩 상태 설정
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// 에러 메시지 수동 초기화 (UI에서 호출)
  void clearError() {
    _clearError();
  }
}
