import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';

class PlannedQuestCard extends StatelessWidget {
  final MissionListState state;
  final bool isSmallScreen;

  const PlannedQuestCard({
    super.key,
    required this.state,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      success: (data) {
        // PLANNED 상태인 미션만 필터링
        final plannedMissions = data.missions.where((mission) => mission.status == 'PLANNED').toList();
        
        if (plannedMissions.isEmpty) {
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
                    Icons.schedule,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '아직 예정된 퀘스트가 없어요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  '모든 메인 퀘스트를 완료하셨습니다!\n새로운 부업을 시작하면 퀘스트가 생길 예정이에요.',
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

        // orderNo 순서로 정렬 (null 체크 포함)
        final sortedMissions = List<dynamic>.from(plannedMissions)
          ..sort((a, b) {
            final aOrder = a.orderNo ?? 0;
            final bOrder = b.orderNo ?? 0;
            return aOrder.compareTo(bOrder);
          });

        return Column(
          children: sortedMissions.map((mission) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
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
                  // 상단 태그들 - 대기 중은 왼쪽, 메인퀘스트/단계는 오른쪽
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 11 : 12, vertical: isSmallScreen ? 5 : 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF666666),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '대기 중',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 11.5 : 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
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
                          '${mission.orderNo ?? 1}단계',
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
                            Text(
                              mission.title,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 17 : 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 7 : 8),
                            Text(
                              mission.designNotes,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13.5 : 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 14 : 16),
                      // 오른쪽 잠금 아이콘
                      Container(
                        width: isSmallScreen ? 55 : 60,
                        height: isSmallScreen ? 55 : 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: isSmallScreen ? 27 : 30,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )).toList(),
        );
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
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
              '데이터를 불러오는데 실패했어요',
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // 데이터 새로고침은 MainScreen에서 관리
                // 필요시 여기서 특정 API만 호출
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '다시 시도',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
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
              child: const Icon(
                Icons.help_outline,
                size: 40,
                color: AppColors.textSecondary,
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
            const SizedBox(height: 12),
            const Text(
              '잠시만 기다려주세요',
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
    );
  }
}
