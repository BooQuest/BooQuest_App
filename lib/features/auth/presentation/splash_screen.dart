import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Splash Screen
/// 
/// 로그인 화면과 동일한 디자인을 사용하되 로그인 버튼은 제거한 화면입니다.
/// 앱 시작 시 표시되며, 자동으로 로그인 화면으로 전환됩니다.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double _horizontalPadding = 24.0;
  static const double _titleToImageSpacing = 40.0;
  static const double _bottomSpacing = 40.0;

  @override
  void initState() {
    super.initState();
    // 2초 후 로그인 화면으로 자동 전환
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F2F7),
              Colors.white,       
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAppTitle(),
                        const SizedBox(height: _titleToImageSpacing),
                        _buildImageSection(),
                      ],
                    ),
                  ),
                ),
                // 로딩 인디케이터 추가
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                ),
                const SizedBox(height: 20),
                const Text(
                  '부퀘스트를 시작합니다...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 앱 타이틀 빌드
  Widget _buildAppTitle() {
    return Column(
      children: [
        Text(
          'BOOQUEST',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A73E8),
            height: 1.2,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '부퀘스트와 함께하는 SNS 부업 여정',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF616161), 
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// 이미지 섹션 빌드
  Widget _buildImageSection() {
    // 화면 크기에 따라 이미지 크기 동적 조정
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 화면 너비의 85%를 사용하되, 최소 400, 최대 600으로 제한
    final imageSize = (screenWidth * 0.85).clamp(400.0, 600.0);
    
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Center(
        child: Image.asset(
          'assets/images/login/login.png',
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
