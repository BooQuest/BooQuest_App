/// 온보딩 Repository 인터페이스 (단순 Map 기반)
abstract class OnboardingRepository {
  Future<Result<Map<String, dynamic>>> submitOnboarding(Map<String, dynamic> request);
  Future<Result<Map<String, dynamic>>> getOnboardingProgress(int userId);
  Future<Result<void>> saveOnboardingData(Map<String, dynamic> data);
}

/// Result 타입은 auth 도메인과 동일한 형태라고 가정
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final int? statusCode;
  const Failure(this.message, {this.statusCode});
}
