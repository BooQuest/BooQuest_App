import 'package:flutter/material.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';

class TutorialCompletionScreen extends StatelessWidget {
  final String userName;
  
  const TutorialCompletionScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05, // 화면 너비의 5%
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: isSmallScreen ? 80 : 120),
                    _buildCatImage(),
                    SizedBox(height: isSmallScreen ? 30 : 40),
                    _buildCongratulatoryText(),
                    SizedBox(height: isSmallScreen ? 80 : 100),
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

  Widget _buildCatImage() {
    return Container(
      width: double.infinity,
      height: 200,
      child: Image.asset(
        'assets/images/login/complete.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildCongratulatoryText() {
    return Column(
      children: [
        Text(
          '$userName님의',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          '새로운 여정을 응원해요!',
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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width * 0.05, // 화면 너비의 5%
          right: screenSize.width * 0.05, // 화면 너비의 5%
          bottom: (isSmallScreen ? 12 : 16) + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: isSmallScreen ? 42 : 46,
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
              backgroundColor: const Color(0xFF1976D2), // 이미지와 동일한 파란색
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text(
              '부퀘스트 시작하기', 
              style: TextStyle(
                fontSize: isSmallScreen ? 15 : 16, 
                fontWeight: FontWeight.w500
              )
            ),
          ),
        ),
      ),
    );
  }
}
