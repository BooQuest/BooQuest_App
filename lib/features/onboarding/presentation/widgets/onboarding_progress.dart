import 'package:flutter/material.dart';

/// 온보딩 진행 바 (6단계) - 반응형
/// - currentStep: 0, 1, 2, 3, 4, 5 중 하나
class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  const OnboardingProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 화면 너비에 따른 반응형 크기 계산
        final double screenWidth = constraints.maxWidth;
        
        // 프로그레스 바가 차지할 수 있는 너비 (화면의 100%로 확장)
        final double maxProgressWidth = screenWidth * 0.95; // 95%로 설정하여 좌우 여백 약간 유지
        
        // 각 점의 크기와 간격을 화면 너비에 맞춰 계산
        final double dotWidth = (maxProgressWidth / 8).clamp(25.0, 60.0); // 점의 너비 (최소 25, 최대 60)
        final double dotSpacing = (maxProgressWidth / 12).clamp(6.0, 15.0); // 점 사이 간격 (최소 6, 최대 15)
        final double dotHeight = dotWidth * 0.09; // 점의 높이 (너비의 9%)
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            final bool isActive = index <= currentStep; // 현재 단계까지 활성화
            
            return Container(
              width: dotWidth,
              height: dotHeight,
              margin: EdgeInsets.only(right: index < 5 ? dotSpacing : 0), // 마지막 점 제외하고 간격
              decoration: BoxDecoration(
                color: isActive 
                    ? const Color(0xFF1976D2) // 이미지와 동일한 파란색
                    : const Color(0xFFE0E0E0), // 연한 회색
                borderRadius: BorderRadius.circular(100),
              ),
            );
          }),
        );
      },
    );
  }
}