import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/main/domain/entities/sidejob_progress_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';

part 'sidejob_progress_state.freezed.dart';

/// 사이드잡 진행률 상태
@freezed
class SideJobProgressState with _$SideJobProgressState {
  const factory SideJobProgressState.initial() = _Initial;
  const factory SideJobProgressState.loading() = _Loading;
  const factory SideJobProgressState.success(SideJobProgressEntity data) = _Success;
  const factory SideJobProgressState.failure(MainFailure failure) = _Failure;
}
