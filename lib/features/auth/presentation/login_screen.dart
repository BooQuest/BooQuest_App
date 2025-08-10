import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';
import 'package:booquest/core/constants.dart';

/// 로그인 화면
///
/// 카카오 로그인 버튼과 로그인 상태를 표시합니다.
/// 로그인 성공 시 자동으로 메인 화면으로 이동합니다.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final KakaoLoginService _kakaoLoginService = KakaoLoginService();

  @override
  void initState() {
    super.initState();
    // 화면 진입 시 에러 메시지 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().clearError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 앱 로고/제목
              const Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '퀘스트를 시작하세요!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 60),
              
              // 카카오 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ElevatedButton(
                      onPressed: authProvider.isLoading 
                          ? null 
                          : _handleKakaoLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEE500), // 카카오 브랜드 색상
                        foregroundColor: const Color(0xFF191919), // 카카오 텍스트 색상
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: authProvider.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF191919),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 카카오 아이콘 (임시로 텍스트 사용)
                                const Text(
                                  '카카오',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '로그인',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 에러 메시지 표시 (별도 Consumer로 분리)
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  if (authProvider.errorMessage == null) return const SizedBox.shrink();
                  
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      authProvider.errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              
              const Spacer(),
              
              // 하단 안내 텍스트
              const Text(
                '로그인하면 BooQuest의 모든 기능을 이용할 수 있습니다.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 카카오 로그인 처리
  Future<void> _handleKakaoLogin() async {
    try {
      final authProvider = context.read<AuthProvider>();
      
      // 카카오 로그인 시도
      final accessToken = await _kakaoLoginService.login();
      if (accessToken != null) {
        // AuthProvider를 통해 로그인 처리
        final success = await authProvider.loginWithSocial(
          accessToken: accessToken,
          provider: 'kakao',
        );
        
        if (success && mounted) {
          // 로그인 성공 시 스낵바 표시
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.kakaoLoginSuccessMessage),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
