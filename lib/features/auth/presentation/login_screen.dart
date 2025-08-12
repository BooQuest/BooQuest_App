import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';

/// 로그인 화면
/// 캐릭터 생성 화면과 동일한 UI 구조로 구현
/// 상단에 로고, 중간에 텍스트, 하단에 버튼 배치
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final KakaoLoginService _kakaoLoginService = KakaoLoginService();

  // 캐릭터 생성 화면과 동일한 간격 상수
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;       // 상태바 아래 여백 더 증가 (80 → 120)
  static const double _logoToTextSpacing = 20.0;
  static const double _textToButtonSpacing = 120.0; // 텍스트와 버튼 사이 간격 더 줄임 (150 → 120)
  static const double _bottomSpacing = 60.0;      // 하단 여백 더 줄임 (80 → 60)

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
        child: GestureDetector(
          onTap: () {
            // 포커스 해제
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: _topSpacing),
                
                // 앱 로고 섹션
                _buildLogoSection(),
                
                const SizedBox(height: _logoToTextSpacing),
                
                // 앱 제목
                _buildAppTitle(),
                
                const SizedBox(height: _textToButtonSpacing),
                
                // 카카오 로그인 버튼
                _buildKakaoLoginButton(),
                
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 앱 로고 섹션 생성
  Widget _buildLogoSection() {
    return Container(
      width: 116,
      height: 116,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// 앱 제목 생성
  Widget _buildAppTitle() {
    return const Text(
      '당신의 부캐와 함께하는\n부(富)를 향한 퀘스트',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF202020),
        height: 1.4,
      ),
    );
  }

  /// 카카오 로그인 버튼 생성
  Widget _buildKakaoLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _handleKakaoLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF525252),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    '카카오로 3초만에 가입하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  );
          },
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
          // 로그인 성공 시 바로 캐릭터 생성 화면으로 이동
          // AuthProvider의 상태 변경으로 자동으로 화면 전환됨
          debugPrint('카카오 로그인 성공: 캐릭터 생성 화면으로 이동');
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
