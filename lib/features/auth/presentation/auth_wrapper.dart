import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/auth/application/auth_notifier.dart';
import 'package:booquest/features/auth/domain/auth_state.dart';
import 'package:booquest/features/auth/presentation/login_page.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_character_selection_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_character_creation_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step5_preferred_method_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step6_method_selection_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';
import 'package:booquest/core/services/force_update_service.dart';

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
  bool _hasCheckedUpdate = false;

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
        
        // 백그라운드에서 업데이트 체크
        _checkForUpdatesInBackground();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  /// 백그라운드에서 업데이트 체크
  Future<void> _checkForUpdatesInBackground() async {
    if (_hasCheckedUpdate) return;

    _hasCheckedUpdate = true;

    if (mounted) {
      await ForceUpdateService().checkAndForceUpdate(context);
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
      initialData: _authNotifier!.getCurrentState(),
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
      
      // sideJobCreated가 true면 메인 페이지
      if (sideJobCreated) {
        return const MainScreen();
      }
      
      // missionRecommended가 true면 퀘스트 스텝 화면
      if (missionRecommended) {
        // selectedSideJobId가 있으면 전달
        final selectedSideJobId = onboardingProgressInfo['selectedSideJobId'] as int?;
        return QuestStepsScreen(selectedSideJobId: selectedSideJobId);
      }
      
      // sideJobRecommended가 true면 부업 추천 화면
      if (sideJobRecommended) {
        // 부업 추천 데이터는 빈 배열로 전달 (실제로는 API에서 가져와야 함)
        return const SideJobRecommendationsScreen(recommendations: []);
      }
    }
    
        // onboardingProgressInfo가 없거나 모든 값이 false인 경우
    // 온보딩이 완료되지 않은 상태로 간주하여 온보딩 화면으로 이동

    // 온보딩 진행 상황 확인 (OnboardingStorageService)
    final onboardingStorage = await OnboardingStorageService.getInstance();
    final int currentStep = onboardingStorage.getCurrentStep();
    
    switch (currentStep) {
      case 0:
        // Step 0: 캐릭터 선택/생성
        final String? screenType = onboardingStorage.getCharacterScreenType();
        if (screenType == 'creation') {
          return const Step2CharacterCreationScreen();
        } else {
          return const Step1CharacterSelectionScreen();
        }
      case 1:
        // Step 1: 직업 질문
        return const Step3JobQuestionScreen();
      case 2:
        // Step 2: 취미 질문
        return const Step4HobbyQuestionScreen();
      case 3:
        // Step 3: 표현 방식 선호도
        return const Step5PreferredMethodScreen();
      case 4:
        // Step 4: 방법 선택
        return const Step6MethodSelectionScreen();
      default:
        // 기본값: 캐릭터 선택부터 시작
        return const Step1CharacterSelectionScreen();
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
          return const Step1CharacterSelectionScreen();
        }

        // 결정된 화면 반환
        return snapshot.data ?? const Step1CharacterSelectionScreen();
      },
    );
  }
}
