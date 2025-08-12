import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';

/// 온보딩 진행 바 (3단계)
/// - currentStep: 0, 1, 2 중 하나
class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  const OnboardingProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final bool isActive = index <= currentStep; // 현재 단계까지 활성화
        return Container(
          width: 28,
          height: 4,
          margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
          decoration: BoxDecoration(
            color: isActive ? AppColors.progressActive : AppColors.progressInactive,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
