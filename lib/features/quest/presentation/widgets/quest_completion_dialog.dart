import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

/// 퀘스트 완료 확인 다이얼로그
class QuestCompletionDialog extends StatelessWidget {
  final VoidCallback onComplete;
  final VoidCallback onCancel;
  final String questTitle;

  const QuestCompletionDialog({
    super.key,
    required this.onComplete,
    required this.onCancel,
    required this.questTitle,
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
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목
            Text(
              '퀘스트를 완료하시겠어요?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // 설명
            Text(
              '아직 진행 중 이라면 취소 할 수 있어요',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 버튼들
            Row(
              children: [
                // 취소 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 완료 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: onComplete,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          '완료',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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

  /// 다이얼로그 표시
  static Future<bool?> show(
    BuildContext context, {
    required String questTitle,
    required VoidCallback onComplete,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => QuestCompletionDialog(
        questTitle: questTitle,
        onComplete: () {
          Navigator.of(context).pop(true);
          onComplete();
        },
        onCancel: () {
          Navigator.of(context).pop(false);
        },
      ),
    );
  }
}
