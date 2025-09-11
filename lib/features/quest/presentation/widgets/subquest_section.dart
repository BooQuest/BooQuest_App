import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';

class SubquestSection extends StatelessWidget {
  final MissionListState state;
  final int? selectedStepId;
  final bool isExpanded;
  final ValueChanged<int> onStepSelected;
  final VoidCallback onToggle;
  final VoidCallback onSidejobGuide;

  const SubquestSection({
    super.key,
    required this.state,
    this.selectedStepId,
    required this.isExpanded,
    required this.onStepSelected,
    required this.onToggle,
    required this.onSidejobGuide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '부 퀘스트',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const Spacer(),
              state.maybeWhen(
                success: (data) {
                  // IN_PROGRESS 상태인 미션 찾기
                  final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
                  if (inProgressMission != null) {
                    final completedCount = inProgressMission.steps.where((step) => step.status == 'COMPLETED').length;
                    return Text(
                      '($completedCount/5) 완료',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    );
                  } else {
                    // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 완료 개수 표시
                    final completedMissions = data.missions
                        .where((mission) => mission.status == 'COMPLETED')
                        .toList()
                      ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                    
                    if (completedMissions.isNotEmpty) {
                      final latestCompletedMission = completedMissions.first;
                      final completedCount = latestCompletedMission.steps.where((step) => step.status == 'COMPLETED').length;
                      return Text(
                        '($completedCount/5) 완료',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      );
                    } else {
                      return const Text(
                        '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      );
                    }
                  }
                },
                orElse: () => const Text(
                  '',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 위/아래 아이콘만 클릭 가능하도록 GestureDetector 추가
              GestureDetector(
                onTap: onToggle,
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: isExpanded ? 0.0 : 0.5,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    children: [
                      const SizedBox(height: 16),
                      state.maybeWhen(
                        success: (data) {
                          // IN_PROGRESS 상태인 미션 찾기
                          final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
                          
                          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 찾기
                          if (inProgressMission == null) {
                            final completedMissions = data.missions
                                .where((mission) => mission.status == 'COMPLETED')
                                .toList()
                              ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                            
                            if (completedMissions.isNotEmpty) {
                              final latestCompletedMission = completedMissions.first;
                              // seq 순서대로 정렬
                              final sortedSteps = List<MissionStep>.from(latestCompletedMission.steps)
                                ..sort((a, b) => a.seq.compareTo(b.seq));
                              
                              return Column(
                                children: [
                                  ...sortedSteps.map((step) => _buildSubQuestItem(
                                    step.id,
                                    step.title,
                                    step.status == 'COMPLETED',
                                    step.status == 'PLANNED',
                                  )),
                                  const SizedBox(height: 16),
                                  // 부업가이드 버튼
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        print('🔍 부업가이드 버튼 1 클릭됨');
                                        onSidejobGuide();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: AppColors.cardBorder, width: 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '부업 가이드 >',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [],
                              );
                            }
                          }
                          
                          // 진행 중인 미션이 있으면 기존 로직
                          // seq 순서대로 정렬
                          final sortedSteps = List<MissionStep>.from(inProgressMission.steps)
                            ..sort((a, b) => a.seq.compareTo(b.seq));
                          
                          return Column(
                            children: [
                              ...sortedSteps.map((step) => _buildSubQuestItem(
                                step.id,
                                step.title,
                                step.status == 'COMPLETED',
                                step.status == 'PLANNED',
                              )),
                              const SizedBox(height: 16),
                              // 부업가이드 버튼
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print('🔍 부업가이드 버튼 2 클릭됨');
                                    onSidejobGuide();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.cardBorder, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '부업 가이드 >',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        orElse: () => Column(
                          children: [],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubQuestItem(int stepId, String title, bool isCompleted, bool isPlanned) {
    final isSelected = selectedStepId == stepId;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isCompleted 
                    ? AppColors.textSecondary 
                    : isPlanned 
                        ? AppColors.textSecondary.withValues(alpha: 0.6)
                        : AppColors.textPrimary,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: isCompleted ? null : () => onStepSelected(stepId),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? const Color(0xFF666666) 
                    : isSelected 
                        ? AppColors.primary 
                        : AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted 
                      ? const Color(0xFF666666) 
                      : isSelected 
                          ? AppColors.primary 
                          : AppColors.cardBorder,
                  width: 2,
                ),
              ),
              child: isCompleted || isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}