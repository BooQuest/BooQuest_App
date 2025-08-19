import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/auth/domain/auth_state.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';

/// Presentation 계층: 로그인 페이지
/// 
/// Clean Architecture의 Presentation 계층으로서 UI 로직만 담당합니다.
/// AuthNotifier를 통해 비즈니스 로직과 상호작용합니다.
class LoginPage extends ConsumerStatefulWidget {
  final AuthNotifier authNotifier;
  
  const LoginPage({
    super.key,
    required this.authNotifier,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 0.0;
  static const double _titleToImageSpacing = 40.0;
  static const double _bottomSpacing = 60.0;

  /// 카카오 로그인 버튼 클릭 핸들러
  /// 
  /// 1. 카카오 SDK를 통해 소셜 로그인 수행
  /// 2. 발급받은 액세스 토큰으로 앱 인증 진행
  /// 3. 결과에 따라 사용자에게 피드백 제공
  Future<void> _handleKakaoLogin() async {
    try {
      // 1. 카카오 소셜 로그인
      final kakaoService = KakaoLoginService();
      final String? kakaoAccessToken = await kakaoService.login();

      if (!mounted) return;

      if (kakaoAccessToken == null) {
        _showErrorMessage('카카오 로그인에 실패했습니다. 다시 시도해주세요.');
        return;
      }

      // 2. 앱 인증 진행 (AuthWrapper에서 전달받은 인스턴스 사용)
      final bool loginSuccess = await widget.authNotifier.loginWithSocial(
        accessToken: kakaoAccessToken,
        provider: 'kakao',
      );

      if (!mounted) return;

      // 3. 로그인 결과 처리
      if (!loginSuccess) {
        final errorMessage = widget.authNotifier.debugState.errorMessage ??
            '로그인 중 오류가 발생했습니다.';
        _showErrorMessage(errorMessage);
      }
      
      // 성공 시에는 AuthWrapper에서 자동으로 화면 전환됨
    } catch (e) {
      if (mounted) {
        _showErrorMessage('로그인 중 예상치 못한 오류가 발생했습니다.');
      }
    }
  }

  /// 에러 메시지 표시
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                _buildKakaoLoginButton(),
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 이미지 섹션 빌드
  Widget _buildImageSection() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.landscape,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 앱 타이틀 섹션 빌드
  Widget _buildAppTitle() {
    return Column(
      children: [
        Text(
          '당신의 부캐와 함께하는',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              height: 1.3,
            ),
            children: [
              const TextSpan(text: '부'),
              TextSpan(
                text: '(富)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const TextSpan(text: '를 향한 퀘스트'),
            ],
          ),
        ),
      ],
    );
  }

  /// 카카오 로그인 버튼 빌드
  Widget _buildKakaoLoginButton() {
    return Consumer(
      builder: (context, ref, child) {
        // 로딩 상태는 별도로 관리 (실제로는 _handleKakaoLogin에서 처리)
        bool isLoading = false;
        
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : _handleKakaoLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.grey[400],
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                    ),
                  )
                : const Text(
                    '카카오로 3초만에 가입하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}