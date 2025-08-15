import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';

class TutorialCompletionScreen extends StatelessWidget {
  const TutorialCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120),
                    _buildCheckIcon(),
                    const SizedBox(height: 40),
                    _buildCongratulatoryText(),
                    const SizedBox(height: 100),
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

  Widget _buildCheckIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCongratulatoryText() {
    return Column(
      children: [
        const Text(
          '새로운 "소현"를 위한',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          '튜토리얼의 첫걸음을 응원합니다',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          '지금 바로 시작해보세요!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
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
              // 시작하기 버튼 클릭 시 메인 화면으로 이동
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('시작하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
