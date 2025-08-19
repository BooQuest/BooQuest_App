import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sidejob_state.dart';
import 'get_sidejob_recommendations.dart';
import '../domain/sidejob_failure.dart';

/// 부업 추천 StateNotifier
class SideJobNotifier extends StateNotifier<SideJobState> {
  final GetSideJobRecommendations _getSideJobRecommendations;

  SideJobNotifier(this._getSideJobRecommendations) : super(const SideJobState.initial());

  /// 부업 추천 가져오기
  /// 
  /// [strengthType] 사용자가 선택한 자신 있는 방식
  Future<void> getSideJobRecommendations(String strengthType) async {
    // 로딩 상태로 변경
    state = const SideJobState.loading();

    // UseCase 실행
    final result = await _getSideJobRecommendations(strengthType);

    // 결과에 따라 상태 변경
    result.fold(
      (failure) {
        print('❌ 부업 추천 실패: ${failure.debugMessage}');
        state = SideJobState.failure(failure);
      },
      (recommendations) {
        print('✅ 부업 추천 성공: ${recommendations.length}개');
        state = SideJobState.success(recommendations);
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const SideJobState.initial();
  }

  /// 에러 상태 클리어
  void clearError() {
    if (state.isFailure) {
      state = const SideJobState.initial();
    }
  }
}

// Provider들은 infrastructure/sidejob_providers.dart에서 정의됩니다.
