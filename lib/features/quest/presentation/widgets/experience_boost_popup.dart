import 'package:flutter/material.dart';
import 'package:booquest/features/quest/presentation/screens/quest_verification_screen.dart';

/// 경험치 부스트 팝업 위젯
class ExperienceBoostPopup extends StatelessWidget {
  final int stepId;
  
  const ExperienceBoostPopup({
    super.key,
    required this.stepId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 체크마크 아이콘
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // 제목
            const Text(
              '경험치 부스트!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // 부제목
            const Text(
              '보너스 찬스가 도착했어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // 본문 텍스트
            Column(
              children: [
                const Text(
                  '더 빠른 성장을 위한 두 가지 방법 중',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '하나를 선택해 보상을 획득하세요',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 버튼들
            Row(
              children: [
                // 인증하기 버튼
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF64B5F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // 인증 화면으로 이동
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuestVerificationScreen(stepId: stepId),
                          ),
                        );
                      },
                      child: const Text(
                        '인증하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 광고보기 버튼
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: 광고보기 기능 구현
                      },
                      child: const Text(
                        '광고보기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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

