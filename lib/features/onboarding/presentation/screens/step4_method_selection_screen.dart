import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/presentation/widgets/common_widgets.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/utils/user_data_utils.dart';
import 'package:booquest/features/sidejob/infrastructure/sidejob_providers.dart';
import 'package:booquest/features/sidejob/application/sidejob_state.dart';
import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';

/// 온보딩 4단계 - 자신 있는 방식 선택 화면
class Step4MethodSelectionScreen extends ConsumerStatefulWidget {
  const Step4MethodSelectionScreen({super.key});

  @override
  ConsumerState<Step4MethodSelectionScreen> createState() => _Step4MethodSelectionScreenState();
}

class _Step4MethodSelectionScreenState extends ConsumerState<Step4MethodSelectionScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _titleToOptionsSpacing = 40.0;
  static const double _optionsToButtonSpacing = 120.0;
  static const double _topRowCompensation = 16.0;

  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _saveCurrentStep();
    _loadAllSavedData(); // 모든 저장된 데이터 불러오기
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(4);
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 모든 저장된 온보딩 데이터 불러오기
  Future<void> _loadAllSavedData() async {
    try {
      // 1. strengthType 불러오기
      final savedStrengthType = await UserDataUtils.instance.getStrengthType();
      if (savedStrengthType != null) {
        setState(() {
          _selectedOption = savedStrengthType;
        });
        print('📖 저장된 자신 있는 방식 타입 불러옴: $savedStrengthType');
      }
      
    } catch (error) {
      print('❌ 저장된 온보딩 데이터 불러오기 실패: $error');
    }
  }

  /// 저장된 자신 있는 방식 타입 불러오기 (기존 메서드 - 호환성 유지)
  Future<void> _loadSavedStrengthType() async {
    try {
      final savedStrengthType = await UserDataUtils.instance.getStrengthType();
      if (savedStrengthType != null) {
        setState(() {
          _selectedOption = savedStrengthType;
        });
        print('📖 저장된 자신 있는 방식 타입 불러옴: $savedStrengthType');
      }
    } catch (error) {
      print('❌ 저장된 자신 있는 방식 타입 불러오기 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Riverpod 상태 관찰
    final sideJobState = ref.watch(sideJobNotifierProvider);
    
    // 상태 변화를 감지하여 자동 처리
    ref.listen<SideJobState>(sideJobNotifierProvider, (previous, next) {
      next.when(
        initial: () {
          // 초기 상태 - 아무것도 하지 않음
        },
        loading: () {
          // 로딩 상태 - 아무것도 하지 않음
        },
        success: (recommendations) async {
          // 성공 시 온보딩 완료 처리 후 다음 화면으로 이동
          await _completeOnboarding();
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SideJobRecommendationsScreen(
                  recommendations: _convertToMap(recommendations),
                ),
              ),
            );
          }
        },
        userSideJobSelected: (userSideJob) {
          // 사용자 부업 선택 완료 - 이 화면에서는 처리하지 않음
        },
        failure: (failure) {
          // 실패 시 에러는 이미 UI에서 표시됨
          print('❌ 부업 추천 실패: ${failure.debugMessage}');
        },
      );
    });
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    _buildTopRow(),
                    const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                    _buildTitle(),
                    const SizedBox(height: _titleToOptionsSpacing),
                    _buildOptions(),
                    const SizedBox(height: _optionsToButtonSpacing),
                    
                    // 에러 메시지 표시
                    if (sideJobState.isFailure) ...[
                      const SizedBox(height: 20),
                      CommonErrorMessage(
                        message: sideJobState.failure!.userMessage,
                        onRetry: _onNext,
                        retryText: '다시 시도',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(),
          ),
          if (sideJobState.isLoading) const AILoadingOverlay(
            title: 'AI가 당신에게 맞는\n부업을 분석하고 있어요...',
            subtitle: '',
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => _goBack(),
        ),
        const Expanded(
          child: Center(child: OnboardingProgress(currentStep: 3)),  // 5단계 중 네번째
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '어떤 방식이\n더 자신 있으신가요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '가장 능숙하고 편하게 하실 수 있는 방식을 선택해 주세요',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary.withOpacity(0.6),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SvgPicture.asset(
          'assets/images/characters/basic_icon_1.svg',
          width: 39,
          height: 39,
        ),
      ],
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        _buildOptionButton('창작하기', Icons.auto_awesome, 'CREATE'),
        const SizedBox(height: 12),
        _buildOptionButton('정리·전달하기', Icons.article, 'ORGANIZE'),
        const SizedBox(height: 12),
        _buildOptionButton('일상 공유하기', Icons.share, 'SHARE'),
        const SizedBox(height: 12),
        _buildOptionButton('트렌드 파악하기', Icons.trending_up, 'TREND'),
      ],
    );
  }

  Widget _buildOptionButton(String label, IconData icon, String value) {
    final bool isSelected = _selectedOption == value;
    
    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedOption = value;
        });
        // 에러 상태 클리어
        ref.read(sideJobNotifierProvider.notifier).clearError();
        // 선택 시 즉시 저장
        await _saveStrengthTypeRealtime(value);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : AppColors.chipUnselectedBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.chipBorder : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : _getIconColor(label), // label(한글)로 아이콘 색상 결정
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.chipSelectedText : AppColors.chipUnselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor(String value) {
    switch (value) {
      case '창작하기':
        return Colors.amber;
      case '정리·전달하기':
        return Colors.blue;
      case '일상 공유하기':
        return Colors.green;
      case '트렌드 파악하기':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildBottomBar() {
    final sideJobState = ref.watch(sideJobNotifierProvider);
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bool canProceed = _selectedOption != null && !sideJobState.isLoading;
    
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + bottomInset,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: canProceed ? _onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canProceed ? AppColors.buttonActive : AppColors.buttonInactive,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text(
              '다음',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onNext() async {
    if (_selectedOption == null) return;

    // 단순히 부업 추천 액션만 트리거
    // 나머지는 ref.listen에서 자동 처리됨
    ref.read(sideJobNotifierProvider.notifier)
        .getSideJobRecommendations(_selectedOption!);
  }

  /// 자신 있는 방식 타입 실시간 저장
  Future<void> _saveStrengthTypeRealtime(String strengthType) async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setStrengthType(strengthType);
      print('💾 자신 있는 방식 타입 실시간 저장 성공: $strengthType');
    } catch (error) {
      print('❌ 자신 있는 방식 타입 실시간 저장 실패: $error');
    }
  }

  /// 온보딩 완료 처리 (LocalStorageService 사용)
  Future<void> _completeOnboarding() async {
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.setOnboardingCompleted(true);
      print('✅ 온보딩 완료 상태 설정됨');
      
      // 온보딩 데이터 정리 (OnboardingStorageService)
      final onboardingStorage = await OnboardingStorageService.getInstance();
      onboardingStorage.printOnboardingData(); // 디버깅용 출력
      
    } catch (error) {
      print('❌ 온보딩 완료 처리 실패: $error');
    }
  }

  Future<void> _goBack() async {
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step3PreferredMethodScreen(),
      ),
    );
  }

  /// SideJobEntity를 Map으로 변환하는 헬퍼 메서드
  List<Map<String, dynamic>> _convertToMap(List<SideJobEntity> entities) {
    return entities.map((entity) => {
      'id': entity.id,
      'title': entity.title,
      'description': entity.description,
    }).toList();
  }
}
