import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/main/domain/entities/user_sidejob_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';

part 'user_sidejob_list_state.freezed.dart';

/// 사용자 사이드잡 목록 상태
@freezed
class UserSideJobListState with _$UserSideJobListState {
  const factory UserSideJobListState.initial() = _Initial;
  const factory UserSideJobListState.loading() = _Loading;
  const factory UserSideJobListState.success(UserSideJobListEntity data) = _Success;
  const factory UserSideJobListState.failure(MainFailure failure) = _Failure;
}
