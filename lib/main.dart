import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/data/auth_repository_impl.dart';
import 'package:booquest/features/auth/presentation/auth_provider.dart';
import 'package:booquest/features/auth/presentation/login_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/character_creation_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/coaching_question_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // 개발 환경일 때만 .env 파일 로드
  // if (const String.fromEnvironment('FLUTTER_ENV') != 'production') {
  //   await dotenv.load(fileName: ".env");
  // }
  
  // NetworkClient 초기화
  NetworkClient().initialize();
  
  // 앱 시작 시 인증 상태 확인을 위한 Provider 생성
  final authProvider = AuthProvider(AuthRepositoryImpl(NetworkClient()));
  
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

    // 스테이지가 저장되어 있다면 스테이지 기준으로 복귀
    final int? stage = storage.getOnboardingStage();
    if (stage != null) {
      switch (stage) {
        case 0:
          return const CharacterCreationScreen();
        case 1:
          return const JobQuestionScreen();
        case 2:
          return const HobbyQuestionScreen();
        case 3:
          return const CoachingQuestionScreen();
      }
    }

    // 스테이지가 없으면 데이터 기준으로 추정
    final String? characterName = storage.getCharacterName();
    final String? job = storage.getJob();
    final List<String> hobbies = storage.getHobbies();

    if (characterName == null || characterName.isEmpty) {
      return const CharacterCreationScreen();
    }
    if (job == null || job.isEmpty) {
      return const JobQuestionScreen();
    }
    if (hobbies.isEmpty) {
      return const HobbyQuestionScreen();
    }

    // 앞 단계가 모두 채워져 있으면 마지막 단계(코칭 여부)로
    return const CoachingQuestionScreen();
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
