import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/revenue/application/states/sidejob_summary_state.dart';
import 'package:booquest/features/revenue/infrastructure/repositories/sidejob_summary_repository_impl.dart';

/// 부업 프로젝트 요약 Notifier
class SideJobSummaryNotifier extends StateNotifier<SideJobSummaryState> {
  final SideJobSummaryRepositoryImpl _repository;

  SideJobSummaryNotifier(this._repository)
      : super(const SideJobSummaryState.initial());

  /// 부업 프로젝트 요약 데이터 조회
  Future<void> getSideJobSummary(int userSideJobId) async {
    state = const SideJobSummaryState.loading();

    final result = await _repository.getSideJobSummary(userSideJobId);

    result.fold(
      (failure) => state = SideJobSummaryState.failure(failure),
      (data) => state = SideJobSummaryState.success(data),
    );
  }
}


