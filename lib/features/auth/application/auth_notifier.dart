import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/domain/auth_state.dart';
import 'package:booquest/features/auth/infrastructure/auth_api_service.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// Application 계층: 인증 상태를 관리하는 Notifier
/// 
/// 비즈니스 로직을 처리하고 상태를 관리합니다.
/// Infrastructure 계층의 서비스들을 조합하여 복잡한 인증 플로우를 구현합니다.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApiService _apiService;
  final AuthStorageService _storageService;
  
  // 싱글톤 인스턴스
  static AuthNotifier? _instance;

  AuthNotifier(this._apiService, this._storageService) : super(const AuthState()) {
    _instance = this;
  }
  
  // 싱글톤 인스턴스 접근
  static AuthNotifier? get instance => _instance;

  // ========== 초기화 ==========

  /// 현재 상태 반환
  AuthState getCurrentState() {
    return state;
  }

  /// 현재 상태의 에러 메시지 반환
  String? get currentErrorMessage => state.errorMessage;

  /// 현재 상태의 사용자 정보 반환
  Map<String, dynamic>? get currentUser => state.user;

  /// 현재 상태의 온보딩 진행 정보 반환
  Map<String, dynamic>? get currentOnboardingProgressInfo => state.onboardingProgressInfo;

  /// 앱 시작 시 저장된 인증 상태 확인
  /// 
  /// 로컬 스토리지에서 토큰과 사용자 정보를 확인하고,
  /// 유효한 경우 서버에서 최신 사용자 정보를 가져옵니다.
  Future<void> checkAuthStatus() async {
    state = state.loading();

    try {
      // 1. 로컬 스토리지에서 인증 데이터 확인
      if (!_storageService.hasAuthData()) {
        state = state.unauthenticated();
        return;
      }
      
      // 2. 서버에서 사용자 정보 검증 및 갱신
      final response = await _apiService.getUserInfo();
      
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final userData = response.data!['data'] as Map<String, dynamic>;
        
        // 3. 로컬 스토리지 업데이트
        await _storageService.saveUserInfo(
          userId: userData['id'] as int,
          email: userData['email'] ?? '',
          nickname: userData['nickname'],
          profileImageUrl: userData['profileImageUrl'],
          sideJobId: _extractSideJobId(userData),
          characterType: userData['characterType'],
        );

        // 4. 인증 성공 상태로 전환 (onboardingProgressInfo 포함)
        state = state.authenticated(userData);
      } else {

        // 401 에러인 경우 (refresh token도 만료됨) 로그인 페이지로 이동
        if (response.statusCode == 401) {
          await _storageService.clearAuthData();
          state = state.unauthenticated('인증이 만료되었습니다. 다시 로그인해주세요.');
        } else {
          await _storageService.clearAuthData();
          state = state.unauthenticated('인증이 만료되었습니다.');
        }
      }
    } catch (e) {
      // 401 에러인 경우 (refresh token도 만료됨) 로그인 페이지로 이동
      if (e is DioException && e.response?.statusCode == 401) {
        await _storageService.clearAuthData();
        state = state.unauthenticated('인증이 만료되었습니다. 다시 로그인해주세요.');
        return;
      }
      
      // 500 에러인 경우도 서버 에러이므로 로그인 페이지로 이동
      if (e is DioException && e.response?.statusCode == 500) {
        await _storageService.clearAuthData();
        state = state.unauthenticated('서버 오류가 발생했습니다. 다시 로그인해주세요.');
        return;
      }
      
      // 네트워크 오류 등의 경우, 로컬 데이터로 인증 상태 유지
      final localUserData = _storageService.getUserInfo();
      if (localUserData != null) {
        state = state.authenticated(localUserData);
      } else {
        state = state.unauthenticated('인증 상태 확인 중 오류가 발생했습니다.');
      }
    }
  }

  // ========== 로그인 ==========

  /// 소셜 로그인 수행
  /// 
  /// [accessToken]: 소셜 플랫폼에서 발급받은 액세스 토큰
  /// [provider]: 소셜 플랫폼 종류 (kakao, google 등)
  /// 
  /// Returns: 로그인 성공 여부
  Future<bool> loginWithSocial({
    required String accessToken,
    required String provider,
  }) async {
    state = state.loading();

    try {
      final response = await _apiService.loginWithSocial(
        accessToken: accessToken,
        provider: provider,
      );

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final responseData = response.data!['data'] as Map<String, dynamic>;
        
        // 온보딩 진행 정보 (login 응답에도 추가됨)
        final onboardingProgressInfo = responseData['onboardingProgressInfo'] as Map<String, dynamic>?;

        // 1. 사용자 정보 저장
        Map<String, dynamic> userForState = {};
        if (responseData['userInfo'] != null) {
          final userInfo = responseData['userInfo'] as Map<String, dynamic>;
          
          // onboardingProgressInfo에서 selectedSideJobId 추출
          int? sideJobId;
          if (onboardingProgressInfo != null) {
            sideJobId = onboardingProgressInfo['selectedSideJobId'] as int?;
          }
          
          await _storageService.saveUserInfo(
            userId: userInfo['userId'] as int,
            email: userInfo['email'] ?? '',
            nickname: userInfo['nickname'],
            profileImageUrl: userInfo['profileImageUrl'],
            sideJobId: sideJobId,
            characterType: userInfo['characterType'],
          );
          userForState = Map<String, dynamic>.from(userInfo);
        }
        // userForState에 onboardingProgressInfo 병합 (AuthState가 인지할 수 있도록)
        if (onboardingProgressInfo != null) {
          userForState['onboardingProgressInfo'] = onboardingProgressInfo;
        }

        // 2. 토큰 정보 저장
        if (responseData['tokenInfo'] != null) {
          final tokenInfo = responseData['tokenInfo'] as Map<String, dynamic>;
          await _storageService.saveTokens(
            accessToken: tokenInfo['accessToken'] as String,
            refreshToken: tokenInfo['refreshToken'] as String,
          );
        }

        // 3. 소셜 로그인 정보 저장 (탈퇴 시 필요)
        await _storageService.saveSocialLoginInfo(
          providerAccessToken: accessToken,
          provider: provider,
        );

        // 4. 인증 성공 상태로 전환 (onboardingProgressInfo 포함)
        state = state.authenticated(userForState);
        return true;
      } else {
        final message = response.data?['message'] ?? '로그인에 실패했습니다.';
        state = state.unauthenticated(message);
        return false;
      }
    } catch (e) {
      state = state.unauthenticated('로그인 중 오류가 발생했습니다.');
      return false;
    }
  }

  // ========== 로그아웃 ==========

  /// 로그아웃 수행
  /// 
  /// 서버에 로그아웃 요청을 보내고 로컬 데이터를 모두 삭제합니다.
  Future<void> logout() async {
    state = state.loading();

    try {
      // 1. 서버에 로그아웃 요청 (선택사항)
      try {
        final refreshToken = _storageService.getRefreshToken();
        if (refreshToken != null) {
          await _apiService.logout(refreshToken);
        }
      } catch (e) {
        // 서버 요청 실패해도 로컬 데이터는 삭제
      }

      // 2. 로컬 데이터 삭제
      await _storageService.clearAuthData();

      // 3. 미인증 상태로 전환
      state = state.unauthenticated();
    } catch (e) {
      state = state.unauthenticated('로그아웃 중 오류가 발생했습니다.');
    }
  }

  /// 토큰 만료 시 강제 로그아웃 (NetworkClient에서 호출)
  Future<void> forceLogout() async {
    await _storageService.clearAuthData();
    state = state.unauthenticated('인증이 만료되었습니다. 다시 로그인해주세요.');
  }

  /// 회원탈퇴 수행
  /// 
  /// 서버에 회원탈퇴 요청을 보내고 로컬 데이터를 모두 삭제합니다.
  /// 실패 시 현재 상태를 유지하고 에러 메시지를 반환합니다.
  Future<bool> withdraw() async {
    try {
      // 1. 소셜 플랫폼 액세스 토큰 조회
      final providerAccessToken = _storageService.getProviderAccessToken();
      
      // 2. 서버에 회원탈퇴 요청 (소셜 플랫폼 액세스 토큰 포함)
      final response = await _apiService.withdraw(
        providerAccessToken: providerAccessToken,
      );
      
      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        // 3. 로컬 데이터 삭제
        await _storageService.clearAuthData();
        
        // 4. 미인증 상태로 전환
        state = state.unauthenticated();
        return true;
      } else {
        final message = response.data?['message'] ?? '회원탈퇴에 실패했습니다.';
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // ========== 토큰 갱신 ==========

  /// 토큰 갱신
  /// 
  /// 액세스 토큰이 만료된 경우 리프레시 토큰으로 새 토큰을 발급받습니다.
  Future<bool> refreshTokens() async {
    try {
      final refreshToken = _storageService.getRefreshToken();
      if (refreshToken == null) {
        await logout();
        return false;
      }

      final response = await _apiService.refreshToken(refreshToken);

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final tokenData = response.data!['data'] as Map<String, dynamic>;
        
        await _storageService.saveTokens(
          accessToken: tokenData['accessToken'] as String,
          refreshToken: tokenData['refreshToken'] as String,
        );

        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      await logout();
      return false;
    }
  }

  // ========== 유틸리티 ==========

  /// 에러 메시지 초기화
  void clearError() {
    state = state.clearError();
  }

  /// 현재 사용자 정보 갱신
  Future<void> updateUserInfo() async {
    if (!state.isAuthenticated) return;

    try {
      final response = await _apiService.getUserInfo();

      if (response.statusCode == 200 && 
          response.data != null && 
          response.data!['success'] == true) {
        
        final userData = response.data!['data'] as Map<String, dynamic>;
        
        await _storageService.saveUserInfo(
          userId: userData['id'] as int,
          email: userData['email'] ?? '',
          nickname: userData['nickname'],
          profileImageUrl: userData['profileImageUrl'],
          sideJobId: userData['sideJobId'] as int?,
          characterType: userData['characterType'],
        );

        state = state.authenticated(userData);
      }
    } catch (e) {
      // 사용자 정보 갱신 실패는 에러로 처리하지 않음
    }
  }

  /// 디버그용: 현재 인증 상태 출력
  void printAuthStatus() {
    _storageService.printAuthData();
  }

  /// 사용자 데이터에서 sideJobId를 추출하는 헬퍼 메서드
  int? _extractSideJobId(Map<String, dynamic> userData) {
    try {
      final onboardingInfo = userData['onboardingProgressInfo'] as Map<String, dynamic>?;
      if (onboardingInfo != null) {
        return onboardingInfo['selectedSideJobId'] as int?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

// ========== Riverpod Providers ==========

/// AuthApiService Provider
/// 
/// 주의: 이 Provider는 NetworkClient의 의존성 주입 문제로 사용하지 않습니다.
/// 대신 createAuthNotifier() 함수를 사용하여 직접 초기화하세요.
@Deprecated('createAuthNotifier()를 사용하세요.')
final authApiServiceProvider = Provider<AuthApiService>((ref) {
  throw UnimplementedError('이 Provider는 사용되지 않습니다. createAuthNotifier()를 참조하세요.');
});

/// AuthNotifier Provider (사용하지 않음 - AuthWrapper에서 직접 초기화)
/// 
/// 이 Provider는 비동기 초기화 문제로 사용하지 않습니다.
/// 대신 AuthWrapper에서 createAuthNotifier() 함수를 사용하여 직접 초기화합니다.
@Deprecated('AuthWrapper에서 createAuthNotifier()를 사용하세요.')
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  throw UnimplementedError('이 Provider는 사용되지 않습니다. AuthWrapper를 참조하세요.');
});

/// AuthNotifier 초기화를 위한 헬퍼 함수
Future<AuthNotifier> createAuthNotifier() async {
  final authStorageService = await AuthStorageService.getInstance();
  final networkClient = NetworkClient(authStorageService); // AuthStorageService 주입
  final apiService = AuthApiService(networkClient);
  
  return AuthNotifier(apiService, authStorageService);
}
