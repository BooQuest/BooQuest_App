import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

/// 온보딩 진행 바 (5단계)
/// - currentStep: 0, 1, 2, 3, 4 중 하나
class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  const OnboardingProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final bool isActive = index <= currentStep; // 현재 단계까지 활성화
        return Container(
          width: 44,  // 너비 늘림
          height: 4,
          margin: EdgeInsets.only(right: index < 4 ? 8 : 0),  // 간격 늘림
          decoration: BoxDecoration(
            color: isActive ? AppColors.progressActive : AppColors.progressInactive,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}