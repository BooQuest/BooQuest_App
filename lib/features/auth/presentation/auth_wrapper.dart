import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/auth/domain/auth_state.dart';
import 'package:booquest/features/auth/presentation/login_page.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_selection_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_creation_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_method_selection_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';

/// Presentation 계층: 인증 상태에 따른 화면 분기 래퍼
/// 
/// 사용자의 인증 상태를 확인하고 적절한 화면으로 라우팅합니다.
/// Clean Architecture의 Presentation 계층으로서 UI 로직만 담당합니다.
class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool _isInitialized = false;
  AuthNotifier? _authNotifier;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  /// 인증 시스템 초기화
  /// 
  /// AuthStorageService가 비동기 초기화가 필요하므로
  /// 앱 시작 시 한 번만 초기화를 수행합니다.
  Future<void> _initializeAuth() async {
    try {
      // AuthNotifier 초기화 (비동기 서비스 포함)
      _authNotifier = await createAuthNotifier();
      
      // 인증 상태 확인
      await _authNotifier!.checkAuthStatus();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('AuthWrapper 초기화 실패: $e');
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 초기화 중일 때 로딩 화면
    if (!_isInitialized || _authNotifier == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // AuthNotifier의 상태를 직접 구독
    return StreamBuilder<AuthState>(
      stream: _authNotifier!.stream,
      initialData: _authNotifier!.debugState,
      builder: (context, snapshot) {
        final authState = snapshot.data ?? const AuthState();

        // 로딩 중일 때
        if (authState.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 미인증 상태 → 로그인 페이지 (AuthNotifier 전달)
        if (!authState.isAuthenticated) {
          return LoginPage(authNotifier: _authNotifier!);
        }

        // 인증됨 → 온보딩 상태 확인 후 적절한 화면으로 분기
        return _OnboardingRouter(authNotifier: _authNotifier!);
      },
    );
  }
}

/// 온보딩 상태를 확인하여 적절한 화면으로 라우팅하는 내부 위젯
/// 
/// 인증된 사용자의 온보딩 진행 상황을 확인하고
/// 완료되지 않은 단계부터 시작하도록 합니다.
class _OnboardingRouter extends StatelessWidget {
  final AuthNotifier authNotifier;
  
  const _OnboardingRouter({required this.authNotifier});

  /// 사용자의 온보딩 진행 상황에 따라 시작 화면을 결정합니다.
  Future<Widget> _decideStartScreen(BuildContext context) async {
    // AuthNotifier에서 onboardingProgressInfo 확인
    final authState = authNotifier.getCurrentState();
    
    if (authState.onboardingProgressInfo != null) {
      final onboardingProgressInfo = authState.onboardingProgressInfo!;
      final sideJobCreated = onboardingProgressInfo['sideJobCreated'] as bool? ?? false;
      final missionRecommended = onboardingProgressInfo['missionRecommended'] as bool? ?? false;
      final sideJobRecommended = onboardingProgressInfo['sideJobRecommended'] as bool? ?? false;
      
      print('📊 온보딩 진행 정보 기반 라우팅:');
      print('  - sideJobCreated: $sideJobCreated');
      print('  - missionRecommended: $missionRecommended');
      print('  - sideJobRecommended: $sideJobRecommended');
      
      // sideJobCreated가 true면 메인 페이지
      if (sideJobCreated) {
        print('🏠 sideJobCreated = true → MainScreen');
        return const MainScreen();
      }
      
      // missionRecommended가 true면 퀘스트 스텝 화면
      if (missionRecommended) {
        print('📋 missionRecommended = true → QuestStepsScreen');
        return const QuestStepsScreen();
      }
      
      // sideJobRecommended가 true면 부업 추천 화면
      if (sideJobRecommended) {
        print('💼 sideJobRecommended = true → SideJobRecommendationsScreen');
        // 부업 추천 데이터는 빈 배열로 전달 (실제로는 API에서 가져와야 함)
        return const SideJobRecommendationsScreen(recommendations: []);
      }
    }
    
    // onboardingProgressInfo가 없거나 모든 값이 false인 경우
    // 기존 로직대로 storage data 기준으로 화면 결정
    print('🔄 onboardingProgressInfo 없음 → storage data 기준으로 화면 결정');
    
    // 온보딩 완료 여부 확인 (LocalStorageService)
    final localStorage = await LocalStorageService.getInstance();
    if (localStorage.isOnboardingCompleted()) {
      return const MainScreen();
    }

    // 온보딩 진행 상황 확인 (OnboardingStorageService)
    final onboardingStorage = await OnboardingStorageService.getInstance();
    final int currentStep = onboardingStorage.getCurrentStep();
    
    print('🔄 온보딩 라우터: 현재 단계 = $currentStep');
    
    switch (currentStep) {
      case 0:
        // Step 0: 캐릭터 선택/생성
        final String? screenType = onboardingStorage.getCharacterScreenType();
        print('🔄 온보딩 라우터: 캐릭터 화면 타입 = $screenType');
        if (screenType == 'creation') {
          return const Step0CharacterCreationScreen();
        } else {
          return const Step0CharacterSelectionScreen();
        }
      case 1:
        // Step 1: 직업 질문
        return const Step1JobQuestionScreen();
      case 2:
        // Step 2: 취미 질문
        return const Step2HobbyQuestionScreen();
      case 3:
        // Step 3: 표현 방식 선호도
        return const Step3PreferredMethodScreen();
      case 4:
        // Step 4: 방법 선택
        return const Step4MethodSelectionScreen();
      default:
        // 기본값: 캐릭터 선택부터 시작
        print('🔄 온보딩 라우터: 기본값으로 캐릭터 선택 화면');
        return const Step0CharacterSelectionScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStartScreen(context),
      builder: (context, snapshot) {
        // 로딩 중
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 에러 발생 시 기본 화면 (캐릭터 선택)
        if (snapshot.hasError) {
          print('OnboardingRouter 에러: ${snapshot.error}');
          return const Step0CharacterSelectionScreen();
        }

        // 결정된 화면 반환
        return snapshot.data ?? const Step0CharacterSelectionScreen();
      },
    );
  }
}

/// 에러 상태를 표시하는 위젯
class _ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorScreen({
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                '오류가 발생했습니다',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('다시 시도'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}