import 'package:flutter/material.dart';

/// 커스텀 로딩 화면
/// 
/// 상단 텍스트와 하단 "잠시만 기다려주세요" 메시지가 있는 로딩 화면입니다.
/// 중앙에는 loading_fixed.gif 애니메이션이 표시됩니다.
class CustomLoadingScreen extends StatelessWidget {
  final String topText;
  final String? bottomText;
  final Color? backgroundColor;

  const CustomLoadingScreen({
    super.key,
    required this.topText,
    this.bottomText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // 위쪽은 완전 흰색
              Color(0xFFE6F3FF), // 아래쪽은 하늘색
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // GIF 파일 (훨씬 더 크게, 텍스트와 바로 붙이기)
            Image.asset(
              'assets/images/loading_fixed.gif',
              width: 500,
              height: 500,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 500,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD700),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 250,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            Transform.translate(
              offset: const Offset(0, -150),
              child: Column(
                children: [
                  // 텍스트 (간격 없이 바로 붙이기)
                  Text(
                    topText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    bottomText ?? '잠시만 기다려주세요',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 로딩 오버레이 (다른 화면 위에 표시)
class CustomLoadingOverlay extends StatelessWidget {
  final String topText;
  final String? bottomText;
  final Color? backgroundColor;

  const CustomLoadingOverlay({
    super.key,
    required this.topText,
    this.bottomText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // GIF 파일
              Image.asset(
                'assets/images/loading_fixed.gif',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD700),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // 텍스트
              Text(
                topText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                bottomText ?? '잠시만 기다려주세요',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}