import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_failure.freezed.dart';

/// 메인 기능 실패 케이스
@freezed
class MainFailure with _$MainFailure {
  const factory MainFailure.serverError() = ServerError;
  const factory MainFailure.networkError() = NetworkError;
  const factory MainFailure.unauthorized() = Unauthorized;
  const factory MainFailure.notFound() = NotFound;
  const factory MainFailure.unknown() = Unknown;
}
