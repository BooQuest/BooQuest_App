import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';
import 'package:booquest/features/auth/presentation/naver_login_service.dart';

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
  
  // 화면 크기에 따른 동적 간격 계산
  double get _titleToImageSpacing {
    final screenHeight = MediaQuery.of(context).size.height;
    // 작은 화면: 30px, 큰 화면: 50px
    return (screenHeight * 0.04).clamp(30.0, 50.0);
  }
  
  double get _bottomSpacing {
    final screenHeight = MediaQuery.of(context).size.height;
    // 작은 화면: 40px, 큰 화면: 80px
    return (screenHeight * 0.06).clamp(40.0, 80.0);
  }
  
  // 화면 크기에 따른 버튼 높이 계산
  double _getButtonHeight() {
    final screenHeight = MediaQuery.of(context).size.height;
    // 작은 화면: 48px, 큰 화면: 64px
    return (screenHeight * 0.07).clamp(48.0, 64.0);
  }

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
        final errorMessage = widget.authNotifier.currentErrorMessage ??
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

  /// 네이버 로그인 버튼 클릭 핸들러
  /// 
  /// 1. 네이버 SDK를 통해 소셜 로그인 수행
  /// 2. 발급받은 액세스 토큰으로 앱 인증 진행
  /// 3. 결과에 따라 사용자에게 피드백 제공
  Future<void> _handleNaverLogin() async {
    try {
      // 1. 네이버 소셜 로그인
      final naverService = NaverLoginService();
      final String? naverAccessToken = await naverService.login();

      if (!mounted) return;

      if (naverAccessToken == null) {
        _showErrorMessage('네이버 로그인에 실패했습니다. 다시 시도해주세요.');
        return;
      }

      // 2. 앱 인증 진행
      final bool loginSuccess = await widget.authNotifier.loginWithSocial(
        accessToken: naverAccessToken,
        provider: 'NAVER',
      );

      if (!mounted) return;

      // 3. 로그인 결과 처리
      if (!loginSuccess) {
        final errorMessage = widget.authNotifier.currentErrorMessage ??
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F2F7), // 은은한 파란색 (상단)
              Colors.white,       // 흰색 (하단)
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
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
                        SizedBox(height: _titleToImageSpacing),
                        _buildImageSection(),
                        ],
                      ),
                    ),
                  ),
                  _buildKakaoLoginButton(),
                  const SizedBox(height: 16), // 버튼 간 간격
                  _buildNaverLoginButton(),
                  SizedBox(height: _bottomSpacing),
                ],
              ),
            ),
          ),
        ),
      ),
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

  /// 앱 타이틀 섹션 빌드
  Widget _buildAppTitle() {
    return Column(
      children: [
        Text(
          'BOOQUEST',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A73E8), // 더 진한 파란색
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
            color: const Color(0xFF616161), // 이미지와 동일한 회색
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// 카카오 로그인 버튼 빌드
  Widget _buildKakaoLoginButton() {
    return Container(
      width: double.infinity,
      height: _getButtonHeight(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4285F4).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: _handleKakaoLogin,
          child: SvgPicture.asset(
            'assets/images/login/kakao.svg',
            width: double.infinity,
            height: _getButtonHeight(),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  /// 네이버 로그인 버튼 빌드
  Widget _buildNaverLoginButton() {
    return Container(
      width: double.infinity,
      height: _getButtonHeight(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF03C75A).withValues(alpha: 0.3), // 네이버 브랜드 색상
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: _handleNaverLogin,
          child: SvgPicture.asset(
            'assets/images/login/naver.svg',
            width: double.infinity,
            height: _getButtonHeight(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}