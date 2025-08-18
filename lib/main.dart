import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/auth/data/auth_api_service.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/login_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_selection_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_creation_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_method_selection_screen.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '635d855eae5acd47eaaaf28fc6b49ca8',
    javaScriptAppKey: '635d855eae5acd47eaaaf28fc6b49ca8',
  );
  
  // NetworkClient 초기화
  NetworkClient().initialize();
  
  // 앱 시작 시 인증 상태 확인을 위한 Provider 생성
  final authProvider = AuthProvider(AuthApiService(NetworkClient()));
  
  // 앱 시작 시 인증 상태 확인
  await authProvider.checkAuthStatus();
  
  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  
  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authProvider,
      child: MaterialApp(
        title: 'BooQuest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// 인증 상태에 따라 적절한 화면을 보여주는 래퍼 위젯
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // 로딩 중일 때
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // 미인증 → 로그인 화면
        if (!authProvider.isAuthenticated) {
          return const LoginScreen();
        }

        // 인증됨 → 온보딩 상태를 확인한 뒤 적절한 시작 화면 반환
        return const _OnboardingRouter();
      },
    );
  }
}

/// 온보딩 로컬 상태를 확인하여 다음에 보여줄 화면을 선택하는 라우터
class _OnboardingRouter extends StatelessWidget {
  const _OnboardingRouter();

  Future<Widget> _decideStartScreen() async {
    final storage = await LocalStorageService.getInstance();

    // 온보딩 완료면 메인으로
    if (storage.isOnboardingCompleted()) {
      return const MainScreen();
    }

    // 현재 온보딩 단계를 확인하여 해당 화면으로 복귀
    final int currentStep = storage.getCurrentOnboardingStep();
    switch (currentStep) {
      case 0:
        final String? screenType = storage.getCharacterScreenType();
        if (screenType == 'creation') {
          return const Step0CharacterCreationScreen();
        } else {
          return const Step0CharacterSelectionScreen();
        }
      case 1:
        return const Step1JobQuestionScreen();
      case 2:
        return const Step2HobbyQuestionScreen();
      case 3:
        return const Step3PreferredMethodScreen();
      case 4:
        return const Step4MethodSelectionScreen();
      default:
        return const Step0CharacterSelectionScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStartScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          // 오류 시 로그인으로 되돌리거나 기본 화면 노출
          return const LoginScreen();
        }
        return snapshot.data ?? const LoginScreen();
      },
    );
  }
}
