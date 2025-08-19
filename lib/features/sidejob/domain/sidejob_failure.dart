import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidejob_failure.freezed.dart';

/// 부업 추천 관련 실패/에러 모델
@freezed
class SideJobFailure with _$SideJobFailure {
  const factory SideJobFailure.networkError([String? message]) = _NetworkError;
  const factory SideJobFailure.serverError([String? message]) = _ServerError;
  const factory SideJobFailure.dataError([String? message]) = _DataError;
  const factory SideJobFailure.unknownError([String? message]) = _UnknownError;
  const factory SideJobFailure.userDataError([String? message]) = _UserDataError;
}

/// SideJobFailure 확장 메서드
extension SideJobFailureX on SideJobFailure {
  /// 사용자에게 표시할 에러 메시지
  String get userMessage {
    return when(
      networkError: (message) => '네트워크 연결에 문제가 있습니다. 인터넷 연결을 확인해 주세요.',
      serverError: (message) => '서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해 주세요.',
      dataError: (message) => '데이터를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.',
      unknownError: (message) => '예상치 못한 오류가 발생했습니다. 다시 시도해 주세요.',
      userDataError: (message) => '사용자 정보를 불러오는 중 문제가 발생했습니다. 다시 로그인해 주세요.',
    );
  }

  /// 개발자용 에러 메시지
  String get debugMessage {
    return when(
      networkError: (message) => 'Network Error: ${message ?? 'Unknown network error'}',
      serverError: (message) => 'Server Error: ${message ?? 'Unknown server error'}',
      dataError: (message) => 'Data Error: ${message ?? 'Unknown data error'}',
      unknownError: (message) => 'Unknown Error: ${message ?? 'Unknown error'}',
      userDataError: (message) => 'User Data Error: ${message ?? 'Unknown user data error'}',
    );
  }
}
