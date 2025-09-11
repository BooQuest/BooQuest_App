import 'package:flutter/material.dart';

/// 커스텀 로딩 화면
/// 
/// 상단 텍스트와 하단 "잠시만 기다려주세요" 메시지가 있는 로딩 화면입니다.
/// 중앙에는 loading.gif 애니메이션이 표시됩니다.
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
      backgroundColor: backgroundColor ?? Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // 상단 텍스트
              Text(
                topText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // 로딩 GIF 이미지
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/loading.gif',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // GIF 로드 실패 시 기본 로딩 인디케이터
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700), // 금색
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
                ),
              ),
              
              const SizedBox(height: 40),
              
              // 하단 텍스트
              Text(
                bottomText ?? '잠시만 기다려주세요',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              
              const Spacer(),
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
      color: (backgroundColor ?? Colors.black).withOpacity(0.8),
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
              // 상단 텍스트
              Text(
                topText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 로딩 GIF 이미지
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/loading.gif',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // GIF 로드 실패 시 기본 로딩 인디케이터
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700), // 금색
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 하단 텍스트
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
