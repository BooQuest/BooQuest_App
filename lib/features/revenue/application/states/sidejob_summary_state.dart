import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:booquest/features/revenue/domain/entities/sidejob_summary_entity.dart';
import 'package:booquest/features/main/domain/failures/main_failure.dart';

part 'sidejob_summary_state.freezed.dart';

/// 부업 프로젝트 요약 상태
@freezed
class SideJobSummaryState with _$SideJobSummaryState {
  const factory SideJobSummaryState.initial() = _Initial;
  const factory SideJobSummaryState.loading() = _Loading;
  const factory SideJobSummaryState.success(SideJobSummaryEntity data) = _Success;
  const factory SideJobSummaryState.failure(MainFailure failure) = _Failure;
}


