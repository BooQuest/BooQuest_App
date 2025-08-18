import 'package:flutter/material.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_creation_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';
import 'package:booquest/main.dart';
import 'package:provider/provider.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/kakao_login_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_selection_screen.dart';

/// 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;
  static const double _logoToTextSpacing = 20.0;
  static const double _textToButtonSpacing = 120.0;
  static const double _bottomSpacing = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: _topSpacing),
                _buildLogoSection(),
                const SizedBox(height: _logoToTextSpacing),
                _buildAppTitle(),
                const SizedBox(height: _textToButtonSpacing),
                _buildKakaoLoginButton(),
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      width: 116,
      height: 116,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.pets, size: 48, color: Colors.grey),
    );
  }

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

  Widget _buildKakaoLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _handleKakaoLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF525252),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          '카카오로 3초만에 가입하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _handleKakaoLogin() async {
    // 카카오 로그인 기능
    // 1) KakaoLoginService를 통해 카카오 액세스 토큰 발급 시도
    // 2) 발급 성공 시 AuthProvider.socialLogin 호출로 앱 인증 진행
    // 3) 인증 성공 후 온보딩 완료 여부에 따라 적절한 화면으로 전환
    try {
      // 1) 카카오 로그인 시도
      final kakaoService = KakaoLoginService();
      final String? kakaoAccessToken = await kakaoService.login();

      if (!mounted) return;

      if (kakaoAccessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('카카오 로그인에 실패했습니다. 다시 시도해주세요.')),
        );
        return;
      }

      // 2) 앱 인증 진행
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bool loginOk = await authProvider.loginWithSocial(
        accessToken: kakaoAccessToken,
        provider: 'kakao',
      );

      if (!loginOk) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(authProvider.errorMessage ?? '로그인 중 오류가 발생했습니다.')),
          );
        }
        return;
      }

      // 3) 온보딩 완료 여부에 따라 화면 전환
      final storage = await LocalStorageService.getInstance();
      final isOnboardingCompleted = storage.isOnboardingCompleted();

      if (!mounted) return;

      if (isOnboardingCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        final Widget onboardingScreen = await _decideOnboardingScreen(storage);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => onboardingScreen),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('화면 전환 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<Widget> _decideOnboardingScreen(LocalStorageService storage) async {
    // final int? stage = storage.getOnboardingStage();
    // if (stage != null) {
    //   switch (stage) {
    //     case 0:
    //       return const Step0CharacterSelectionScreen();
    //     case 1:
    //       return const Step0CharacterCreationScreen();
    //     case 2:
    //       return const Step1JobQuestionScreen();
    //     case 3:
    //       return const Step2HobbyQuestionScreen();
    //     case 4:
    //       return const Step3PreferredMethodScreen();
    //   }
    // }

    return const Step0CharacterSelectionScreen();
  }
}
