import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/recommendation/presentation/screens/tutorial_completion_screen.dart';

class QuestStepsScreen extends StatelessWidget {
  const QuestStepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                  const SizedBox(height: 12),
                  _buildTopRow(context),
                  const SizedBox(height: 16),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildQuestSteps(),
                  const SizedBox(height: 50), // 하단 여백 추가
                ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Expanded(
          child: Center(child: Text('메인/부 퀘스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '메인/부 퀘스트 생성 완료\n이렇게 진행하면 될까요?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildQuestSteps() {
    return Column(
      children: [
        _buildQuestStep(1, isActive: true),
        _buildQuestStep(2, isActive: false),
        _buildQuestStep(3, isActive: false),
        _buildQuestStep(4, isActive: false),
        _buildQuestStep(5, isActive: false),
      ],
    );
  }

  Widget _buildQuestStep(int stepNumber, {required bool isActive}) {
    final stepData = _getStepData(stepNumber);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.black : const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFE7E7E7) : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '$stepNumber단계',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.black : const Color(0xFF999999),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                stepData.difficulty,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isActive ? Colors.black : const Color(0xFF999999),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: isActive ? Colors.black : const Color(0xFF999999),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? const Color(0xFF87CEEB) : const Color(0xFFCCCCCC),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              stepData.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.textPrimary : const Color(0xFF999999),
              ),
            ),
          ),
          // 1단계에만 부퀘스트 표시
          if (stepNumber == 1 && isActive) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E7E7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '부퀘스트',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSubQuest('1단계', '인스타그램 계정 설정 & 프로필 완성', '매우 쉬움'),
                  const SizedBox(height: 8),
                  _buildSubQuest('2단계', '첫 게시물 3개 작성 & 해시태그 연습', '쉬움'),
                  const SizedBox(height: 8),
                  _buildSubQuest('3단계', '팔로워 10명 확보 & 댓글 소통 시작', '보통'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubQuest(String step, String title, String difficulty) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            difficulty,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  _StepData _getStepData(int stepNumber) {
    switch (stepNumber) {
      case 1:
        return _StepData('매우 쉬움', '인스타그램 기반 구축 & 운영준비');
      case 2:
        return _StepData('쉬움', '콘텐츠 전략 & 해시태그 설계');
      case 3:
        return _StepData('보통', '콘텐츠 1차 생산 & 초기 팔로워 확보');
      case 4:
        return _StepData('어려움', '콘텐츠 지속 생산 & 팔로워 확대');
      case 5:
        return _StepData('매우 어려움', '수익화 & 브랜드 확장');
      default:
        return _StepData('보통', '퀘스트 설명');
    }
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TutorialCompletionScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonActive,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('다음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}

class _StepData {
  final String difficulty;
  final String title;

  _StepData(this.difficulty, this.title);
}
