import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/quest/presentation/screens/quest_verification_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

/// 경험치 부스트 팝업 위젯
class ExperienceBoostPopup extends ConsumerWidget {
  final int stepId;
  
  const ExperienceBoostPopup({
    super.key,
    required this.stepId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // 상단 닫기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    
                    // API 재호출하여 데이터 업데이트
                    try {
                      final authStorage = await AuthStorageService.getInstance();
                      final sideJobId = authStorage.getSideJobId();
                      
                      if (sideJobId != null) {
                        await Future.wait([
                          ref.read(sideJobProgressNotifierProvider.notifier).getSideJobProgress(sideJobId),
                          ref.read(missionListNotifierProvider.notifier).getMissionList('', sideJobId),
                        ]);
                      }
                    } catch (e) {
                      print('❌ API 재호출 실패: $e');
                    }
                    
                    // VerificationCompleteScreen으로 이동
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VerificationCompleteScreen(
                          method: 'sub_quest',
                          content: '부퀘스트 완료',
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            // 메인 메시지
            const Text(
              '보너스 찬스를 놓치지 마세요',
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
                  '경험치를 두배 받고',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  '부냥이를 빠르게 성장시키세요',
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
                      color: const Color(0xFFE3F2FD),
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
                          color: Color(0xFF1976D2),
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

