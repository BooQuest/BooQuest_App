/// Domain 계층: 순수 상태 모델
/// 
/// 인증 관련 상태를 정의하는 불변 모델입니다.
/// 비즈니스 로직이나 외부 의존성 없이 순수한 데이터 구조만 포함합니다.
class AuthState {
  /// 로딩 상태
  final bool isLoading;
  
  /// 인증 상태 (로그인 여부)
  final bool isAuthenticated;
  
  /// 현재 사용자 정보
  final Map<String, dynamic>? user;
  
  /// 에러 메시지
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
  });

  /// 상태 업데이트를 위한 copyWith 메서드
  /// 불변성을 유지하면서 특정 필드만 업데이트할 수 있습니다.
  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    Map<String, dynamic>? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// 에러 상태 초기화
  AuthState clearError() {
    return copyWith(errorMessage: null);
  }

  /// 로딩 상태로 전환
  AuthState loading() {
    return copyWith(isLoading: true, errorMessage: null);
  }

  /// 인증 성공 상태
  AuthState authenticated(Map<String, dynamic> userData) {
    return copyWith(
      isLoading: false,
      isAuthenticated: true,
      user: userData,
      errorMessage: null,
    );
  }

  /// 인증 실패 상태
  AuthState unauthenticated([String? error]) {
    return copyWith(
      isLoading: false,
      isAuthenticated: false,
      user: null,
      errorMessage: error,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isAuthenticated: $isAuthenticated, '
           'user: $user, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isAuthenticated == isAuthenticated &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isAuthenticated.hashCode ^
        user.hashCode ^
        errorMessage.hashCode;
  }
}
