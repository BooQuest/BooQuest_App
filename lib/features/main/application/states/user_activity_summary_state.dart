import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/main/domain/entities/user_activity_summary_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';

part 'user_activity_summary_state.freezed.dart';

/// 사용자 활동 요약 상태
@freezed
class UserActivitySummaryState with _$UserActivitySummaryState {
  const factory UserActivitySummaryState.initial() = _Initial;
  const factory UserActivitySummaryState.loading() = _Loading;
  const factory UserActivitySummaryState.success(UserActivitySummaryEntity data) = _Success;
  const factory UserActivitySummaryState.failure(MainFailure failure) = _Failure;
}
