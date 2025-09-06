import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/domain/entities/sidejob_progress_entity.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';

class QuestProgressCard extends StatelessWidget {
  final SideJobProgressState state;
  final MissionListState missionListState;
  final String? userNickname;
  final bool isSmallScreen;

  const QuestProgressCard({
    super.key,
    required this.state,
    required this.missionListState,
    this.userNickname,
    required this.isSmallScreen,
  });

  /// 미션 데이터를 기반으로 진행 상황 텍스트를 반환하는 함수
  String _getProgressTextFromMissions(SideJobProgressEntity data, MissionListState missionState) {
    return missionState.maybeWhen(
      success: (missionData) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMissions = missionData.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
        
        if (inProgressMissions.isNotEmpty) {
          // 진행 중인 미션이 있으면 해당 단계 표시
          final currentOrder = inProgressMissions.first.orderNo ?? 1;
          return '$currentOrder단계 진행 중 · 목표까지 ${data.totalStages - currentOrder}단계 남음';
        }
        
        // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 찾기
        final completedMissions = missionData.missions
            .where((mission) => mission.status == 'COMPLETED')
            .toList()
          ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
        
        if (completedMissions.isNotEmpty) {
          // 완료된 미션이 있으면 해당 단계 완료 표시
          final completedOrder = completedMissions.first.orderNo ?? 1;
          return '$completedOrder단계 완료 · 다음 부업 준비 중';
        }
        
        // 미션이 아예 없는 경우
        return '';
      },
      orElse: () => _getProgressText(data), // 미션 데이터가 없으면 기본 로직 사용
    );
  }

  /// 진행 상황 텍스트를 반환하는 함수
  String _getProgressText(SideJobProgressEntity data) {
    // 모든 단계가 완료된 경우
    if (data.progressPercent >= 100) {
      return '${data.totalStages}단계 모두 완료 · 축하합니다!';
    }
    // 진행률이 0%가 아닌 경우 (어떤 단계든 진행 중이거나 완료된 상태)
    else if (data.progressPercent > 0) {
      // 진행률을 기반으로 현재 단계 계산
      final currentStage = ((data.progressPercent / 100.0) * data.totalStages).ceil();
      return '$currentStage단계 진행 중 · 목표까지 ${data.totalStages - currentStage}단계 남음';
    }
    // 아직 시작하지 않은 경우
    else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: state.maybeWhen(
        success: (data) => Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userNickname ?? '사용자'}님이 추천받은 부업',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 6 : 8),
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0D47A1),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 6 : 8),
                  Text(
                    _getProgressTextFromMissions(data, missionListState),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: isSmallScreen ? 16 : 20),
            // 원형 진행률
            SizedBox(
              width: isSmallScreen ? 70 : 80,
              height: isSmallScreen ? 70 : 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: isSmallScreen ? 70 : 80,
                    height: isSmallScreen ? 70 : 80,
                    child: CircularProgressIndicator(
                      value: data.progressPercent / 100.0,
                      strokeWidth: isSmallScreen ? 6 : 8,
                      backgroundColor: const Color(0xFFE6F3FF),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  Text(
                    '${data.progressPercent}%',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        failure: (_) => const Center(
          child: Text(
            '데이터를 불러오는데 실패했습니다.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        orElse: () => const Center(
          child: Text(
            '데이터를 불러오는 중...',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
