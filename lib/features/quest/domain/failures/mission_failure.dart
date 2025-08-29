import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_failure.freezed.dart';

/// 퀘스트 관련 실패
@freezed
class MissionFailure with _$MissionFailure {
  /// 서버 오류
  const factory MissionFailure.serverError(String message) = _ServerError;

  /// 네트워크 오류
  const factory MissionFailure.networkError(String message) = _NetworkError;

  /// 인증 오류
  const factory MissionFailure.authError(String message) = _AuthError;

  /// 알 수 없는 오류
  const factory MissionFailure.unknownError(String message) = _UnknownError;
}
