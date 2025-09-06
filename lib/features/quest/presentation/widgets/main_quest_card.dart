import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/quest/presentation/widgets/subquest_section.dart';

class MainQuestCard extends StatelessWidget {
  final MissionListState state;
  final bool isSmallScreen;
  final int? selectedStepId;
  final bool isSubQuestExpanded;
  final ValueChanged<int> onStepSelected;
  final VoidCallback onSubQuestToggle;
  final VoidCallback onSidejobGuide;
  final bool Function(MissionListState) isCompleteButtonEnabled;
  final String Function(MissionListState) getButtonText;
  final Future<void> Function(BuildContext, MissionListState) onButtonTap;

  const MainQuestCard({
    super.key,
    required this.state,
    required this.isSmallScreen,
    this.selectedStepId,
    required this.isSubQuestExpanded,
    required this.onStepSelected,
    required this.onSubQuestToggle,
    required this.onSidejobGuide,
    required this.isCompleteButtonEnabled,
    required this.getButtonText,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      success: (data) {
        // 5단계 완료 상태를 먼저 체크
        final completedMissions = data.missions
            .where((mission) => mission.status == 'COMPLETED')
            .toList()
          ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
        
        final hasCompleted5thStage = completedMissions.any((mission) => mission.orderNo == 5);
        
        // 5단계가 모두 완료된 경우 - '예정' 탭과 동일한 카드만 표시
        if (completedMissions.length >= 5 || hasCompleted5thStage) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '진행 중인 메인 퀘스트가 없어요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  '모든 메인 퀘스트를 완료하셨습니다!\n새로운 부업 기능이 준비되면 알려드릴게요.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        
        // 5단계가 완료되지 않은 경우 - 기존 카드 디자인 표시
        return _buildNormalQuestCard(context, data);
      },
      loading: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      failure: (_) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 40,
                color: Color(0xFFE53E3E),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 불러올 수 없어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '잠시 후 다시 시도해주세요',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      orElse: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 준비하고 있어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 기존 카드 디자인을 위한 헬퍼 메서드
  Widget _buildNormalQuestCard(BuildContext context, dynamic data) {
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 태그들 - 진행 중은 왼쪽, 메인퀘스트/단계는 오른쪽
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 11 : 12, vertical: isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '진행 중',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11.5 : 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 9 : 10, vertical: isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '메인 퀘스트',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11.5 : 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 7 : 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 9 : 10, vertical: isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${data.missions.where((mission) => mission.status == 'IN_PROGRESS').isNotEmpty ? data.missions.where((mission) => mission.status == 'IN_PROGRESS').first.orderNo : 1}단계',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11.5 : 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            // 메인 콘텐츠 - 제목과 설명을 왼쪽에, 아이콘을 오른쪽에
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 진행 중인 미션이 있으면 표시, 없으면 완료된 미션 중 가장 최근 것 표시
                      Builder(
                        builder: (context) {
                          final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                          
                          if (inProgressMissions.isNotEmpty) {
                            // 진행 중인 미션이 있으면 표시
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  inProgressMissions.first.title,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 17 : 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 7 : 8),
                                Text(
                                  inProgressMissions.first.designNotes,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13.5 : 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 표시
                            final completedMissions = data.missions
                                .where((mission) => mission.status == 'COMPLETED')
                                .toList()
                              ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                            
                            if (completedMissions.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    completedMissions.first.title,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 17 : 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 7 : 8),
                                  Text(
                                    completedMissions.first.designNotes,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 13.5 : 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      // 경험치 - 작고 회색으로
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Builder(
                            builder: (context) {
                              final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                              
                              if (inProgressMissions.isNotEmpty) {
                                return Text(
                                  '+${inProgressMissions.first.missionTotalExp}EXP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                );
                              } else {
                                // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 경험치 표시
                                final completedMissions = data.missions
                                    .where((mission) => mission.status == 'COMPLETED')
                                    .toList()
                                  ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                                
                                if (completedMissions.isNotEmpty) {
                                  return Text(
                                    '+${completedMissions.first.missionTotalExp}EXP',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  );
                                }
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isSmallScreen ? 14 : 16),
                // 오른쪽 아이콘
                Container(
                  width: isSmallScreen ? 55 : 60,
                  height: isSmallScreen ? 55 : 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0E6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.settings,
                    size: isSmallScreen ? 27 : 30,
                    color: const Color(0xFFE91E63),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 진행률 바
            Builder(
              builder: (context) {
                final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                
                if (inProgressMissions.isNotEmpty) {
                  // 진행 중인 미션이 있으면 진행률 바 표시
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: inProgressMissions.first.progress.percent / 100.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${inProgressMissions.first.progress.percent}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  );
                } else {
                  // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 진행률 표시
                  final completedMissions = data.missions
                      .where((mission) => mission.status == 'COMPLETED')
                      .toList()
                    ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                  
                  if (completedMissions.isNotEmpty) {
                    // 완료된 미션이면 100% 진행률 표시
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDEDED),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 1.0, // 100%
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '100%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // 완료된 미션도 없으면 진행률 바 숨김
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
            const SizedBox(height: 24),
            // 부퀘스트 섹션
            SubquestSection(
              state: state,
              selectedStepId: selectedStepId,
              isExpanded: isSubQuestExpanded,
              onStepSelected: onStepSelected,
              onToggle: onSubQuestToggle,
              onSidejobGuide: onSidejobGuide,
            ),
            const SizedBox(height: 24),
            // 하단 버튼들
            Column(
              children: [
                // 완료하기 버튼
                GestureDetector(
                  onTap: isCompleteButtonEnabled(state) ? () => onButtonTap(context, state) : null,
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isCompleteButtonEnabled(state) ? const Color(0xFF2C2C2C) : AppColors.textSecondary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        getButtonText(state),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w700,
                          color: isCompleteButtonEnabled(state) ? Colors.white : AppColors.textSecondary.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
