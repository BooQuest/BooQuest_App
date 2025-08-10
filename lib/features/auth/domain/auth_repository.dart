/// 인증 관련 도메인 인터페이스
/// 
/// 이 인터페이스는 인증 기능의 비즈니스 로직을 정의합니다.
/// 구현체는 Data Layer에서 제공됩니다.
abstract class AuthRepository {
  /// 카카오 로그인을 수행합니다.
  /// 
  /// [accessToken] 카카오에서 받은 액세스 토큰
  /// [provider] 로그인 제공자 (예: 'kakao', 'naver', 'apple')
  /// 
  /// Returns: 로그인 결과 (성공 시 사용자 정보, 실패 시 에러)
  Future<Result<UserInfo>> loginWithSocial({
    required String accessToken,
    required String provider,
  });
  
  /// 로그아웃을 수행합니다.
  /// 
  /// Returns: 로그아웃 결과
  Future<Result<void>> logout();
  
  /// 현재 로그인 상태를 확인합니다.
  /// 
  /// Returns: 로그인 상태 (로그인된 사용자 정보 또는 null)
  Future<Result<UserInfo?>> getCurrentUser();
}


sealed class Result<T> {
  const Result();
  
  /// 패턴 매칭을 위한 when 메서드
  /// 
  /// [success] 성공 시 실행할 콜백
  /// [failure] 실패 시 실행할 콜백
  /// Returns: 콜백의 반환값
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Object? error) failure,
  }) {
    return switch (this) {
      Success(data: final data) => success(data),
      Failure(message: final message, error: final error) => failure(message, error),
    };
  }
}

/// 성공 결과
class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
}

/// 실패 결과
class Failure<T> extends Result<T> {
  final String message;
  final Object? error;
  
  const Failure(this.message, [this.error]);
}

/// 사용자 정보 모델
/// 
/// 로그인 성공 시 받는 사용자 정보를 담습니다.
class UserInfo {
  final String id;
  final String email;
  final String? name;
  final String? profileImage;
  final String provider; // 'kakao', 'naver', 'apple' 등
  
  const UserInfo({
    required this.id,
    required this.email,
    this.name,
    this.profileImage,
    required this.provider,
  });
  
  /// JSON에서 UserInfo 객체 생성
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      provider: json['provider'] as String,
    );
  }
  
  /// UserInfo 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'provider': provider,
    };
  }
  
  @override
  String toString() {
    return 'UserInfo(id: $id, email: $email, name: $name, provider: $provider)';
  }
}
