import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sidejob_state.dart';
import 'get_sidejob_recommendations.dart';
import '../domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/application/select_user_sidejob.dart';
import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';
import 'package:booquest/features/sidejob/domain/user_sidejob_entity.dart';

/// 부업 추천 StateNotifier
class SideJobNotifier extends StateNotifier<SideJobState> {
  final GetSideJobRecommendations _getSideJobRecommendations;
  final SelectUserSideJob _selectUserSideJob;

  SideJobNotifier(this._getSideJobRecommendations, this._selectUserSideJob) : super(const SideJobState.initial());

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

  /// 사용자 부업 선택
  Future<void> selectUserSideJob(int sideJobId) async {
    state = const SideJobState.loading();
    
    final result = await _selectUserSideJob(sideJobId);
    
    result.fold(
      (failure) => state = SideJobState.failure(failure),
      (userSideJob) => state = SideJobState.userSideJobSelected(userSideJob),
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
