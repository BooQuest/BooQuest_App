import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';
import 'package:booquest/core/constants.dart';

/// 로그인 화면
/// Figma 디자인에 맞춰 구현된 반응형 로그인 화면
/// iOS/Android 플랫폼별 최적화 및 bottom overflow 방지
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 화면 크기 및 플랫폼별 정보 가져오기
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final mediaQuery = MediaQuery.of(context);
            final statusBarHeight = mediaQuery.padding.top;
            final bottomPadding = mediaQuery.padding.bottom;
            
            // Figma 디자인 기준 비율 계산 (360 x 740)
            // 실제 사용 가능한 화면 높이에서 계산
            final availableHeight = screenHeight - statusBarHeight - bottomPadding;
            
            // 반응형 비율 계산 (안전한 여백 포함)
            final logoTopMargin = availableHeight * 0.15; // 15% (안전한 상단 여백)
            final logoSize = screenWidth * 0.32; // 116/360 ≈ 32% (화면 너비 기준)
            final logoTitleGap = availableHeight * 0.03; // 3% (적절한 간격)
            final titleButtonGap = availableHeight * 0.25; // 25% (적절한 중간 여백)
            final buttonHeight = screenHeight * 0.06; // 6% (버튼 높이)
            final buttonBottomMargin = availableHeight * 0.15; // 15% (안전한 하단 여백)
            
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: availableHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: logoTopMargin),
                        
                        // 앱 로고 섹션 (완전 반응형)
                        _buildLogoSection(logoSize),
                        
                        SizedBox(height: logoTitleGap),
                        
                        // 앱 제목 (완전 반응형)
                        _buildAppTitle(screenWidth),
                        
                        SizedBox(height: titleButtonGap),
                        
                        // 카카오 로그인 버튼 (완전 반응형)
                        _buildKakaoLoginButton(buttonHeight),
                        
                        SizedBox(height: buttonBottomMargin),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 앱 로고 섹션 생성 (완전 반응형)
  Widget _buildLogoSection(double logoSize) {
    return Center(
      child: Container(
        width: logoSize,
        height: logoSize,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(logoSize / 2),
        ),
        child: Center(
          child: Icon(
            Icons.person,
            size: logoSize * 0.41, // 48/116 ≈ 41%
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  /// 앱 제목 생성 (완전 반응형)
  Widget _buildAppTitle(double screenWidth) {
    final fontSize = screenWidth * 0.05; // 18/360 ≈ 5%
    
    return Text(
      '당신의 부캐와 함께하는\n부(富)를 향한 퀘스트',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF202020),
        height: 1.4,
      ),
    );
  }

  /// 카카오 로그인 버튼 생성 (완전 반응형)
  Widget _buildKakaoLoginButton(double buttonHeight) {
    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF525252),
        borderRadius: BorderRadius.circular(buttonHeight * 0.17), // 8/46 ≈ 17%
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleKakaoLogin,
          borderRadius: BorderRadius.circular(buttonHeight * 0.17),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Center(
                child: authProvider.isLoading
                    ? SizedBox(
                        width: buttonHeight * 0.52, // 24/46 ≈ 52%
                        height: buttonHeight * 0.52,
                        child: CircularProgressIndicator(
                          strokeWidth: buttonHeight * 0.04, // 2/46 ≈ 4%
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        '카카오로 3초만에 가입하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: buttonHeight * 0.35, // 16/46 ≈ 35%
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              );
            },
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
