import 'package:flutter/foundation.dart';
import 'package:booquest/features/auth/domain/auth_repository.dart';

/// 인증 상태를 관리하는 Provider
///
/// 로그인/로그아웃 상태, 사용자 정보, 로딩 상태 등을 관리합니다.
/// UI에서 이 Provider를 통해 인증 상태를 구독하고 변경할 수 있습니다.
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  
  AuthProvider(this._authRepository);

  // 상태 변수들
  bool _isLoading = false;
  bool _isAuthenticated = false;
  UserInfo? _currentUser;
  String? _errorMessage;

  // Getter들
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  UserInfo? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  /// 앱 시작 시 현재 사용자 상태 확인
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    _clearError();
    
    try {
      final result = await _authRepository.getCurrentUser();
      
      result.when(
        success: (userInfo) {
          _currentUser = userInfo;
          _isAuthenticated = userInfo != null;
        },
        failure: (message, error) {
          _setError(message);
          _isAuthenticated = false;
        },
      );
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
      final result = await _authRepository.loginWithSocial(
        accessToken: accessToken,
        provider: provider,
      );
      
      return result.when(
        success: (userInfo) {
          _currentUser = userInfo;
          _isAuthenticated = true;
          _setLoading(false);
          return true;
        },
        failure: (message, error) {
          _setError(message);
          _setLoading(false);
          return false;
        },
      );
    } catch (e) {
      _setError('로그인 중 오류가 발생했습니다.');
      _setLoading(false);
      return false;
    }
  }

  /// 로그아웃 수행
  Future<void> logout() async {
    _setLoading(true);
    _clearError();
    
    try {
      final result = await _authRepository.logout();
      
      result.when(
        success: (_) {
          _currentUser = null;
          _isAuthenticated = false;
        },
        failure: (message, error) {
          _setError(message);
        },
      );
    } catch (e) {
      _setError('로그아웃 중 오류가 발생했습니다.');
    } finally {
      _setLoading(false);
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
