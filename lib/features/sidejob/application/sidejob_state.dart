import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';
import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/domain/user_sidejob_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidejob_state.freezed.dart';

@freezed
class SideJobState with _$SideJobState {
  const factory SideJobState.initial() = _Initial;
  const factory SideJobState.loading() = _Loading;
  const factory SideJobState.success(List<SideJobEntity> recommendations) = _Success;
  const factory SideJobState.userSideJobSelected(UserSideJobEntity userSideJob) = _UserSideJobSelected;
  const factory SideJobState.failure(SideJobFailure failure) = _Failure;
}

/// SideJobState 확장 메서드
extension SideJobStateX on SideJobState {
  /// 로딩 중인지 확인
  bool get isLoading => this is _Loading;
  
  /// 성공 상태인지 확인
  bool get isSuccess => this is _Success;
  
  /// 실패 상태인지 확인
  bool get isFailure => this is _Failure;
  
  /// 초기 상태인지 확인
  bool get isInitial => this is _Initial;
  
  /// 성공 시 데이터 가져오기
  List<SideJobEntity>? get recommendations => maybeWhen(
    success: (recommendations) => recommendations,
    orElse: () => null,
  );
  
  /// 실패 시 에러 가져오기
  SideJobFailure? get failure => maybeWhen(
    failure: (failure) => failure,
    orElse: () => null,
  );
}
