import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step5_preferred_method_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/presentation/widgets/common_widgets.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';

import 'package:booquest/core/utils/user_data_utils.dart';
import 'package:booquest/features/sidejob/infrastructure/sidejob_providers.dart';
import 'package:booquest/features/sidejob/application/sidejob_state.dart';
import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';

/// 온보딩 6단계 - 자신 있는 방식 선택 화면
class Step6MethodSelectionScreen extends ConsumerStatefulWidget {
  const Step6MethodSelectionScreen({super.key});

  @override
  ConsumerState<Step6MethodSelectionScreen> createState() => _Step6MethodSelectionScreenState();
}

class _Step6MethodSelectionScreenState extends ConsumerState<Step6MethodSelectionScreen> {

  String? _selectedOption;
  
  // 진행 가능 여부 계산
  bool get _canProceed => _selectedOption != null && !ref.watch(sideJobNotifierProvider).isLoading;

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
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
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
          // 성공 시 다음 화면으로 이동
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
    
    return LayoutBuilder(
      builder: (context, constraints) {
        // 실시간 반응형 값 계산 (오버플로우 방지)
        final double screenHeight = constraints.maxHeight;
        final double screenWidth = constraints.maxWidth;
        
        // 동적으로 계산되는 값들 (실시간 업데이트)
        final double horizontalPadding = screenWidth * 0.05; // 화면 너비의 5%
        final double topSpacing = screenHeight * 0.1; // 화면 높이의 10%
        final double bottomSpacing = screenHeight * 0.04; // 화면 높이의 4%
        
        // 상단 여백 관련
        final double topMargin = screenHeight * 0.05; // 화면 높이의 5%
        final double titleTopSpacing = screenHeight * 0.05; // 화면 높이의 5%
        final double titleToOptionsSpacing = screenHeight * 0.05; // 화면 높이의 5%
        final double optionsToButtonSpacing = screenHeight * 0.075; // 화면 높이의 7.5%
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: topMargin),
                              _buildTopRow(screenWidth),
                              SizedBox(height: titleTopSpacing),
                              _buildTitle(screenWidth),
                              SizedBox(height: titleToOptionsSpacing),
                              _buildOptions(screenWidth),
                              SizedBox(height: optionsToButtonSpacing),
                              
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 16),
                        child: Container(
                          width: double.infinity,
                          height: buttonHeight,
                          decoration: BoxDecoration(
                            color: _canProceed 
                                ? const Color(0xFF1976D2)
                                : const Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _canProceed ? _onNext : null,
                              borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                              child: Center(
                                child: Text(
                                  '다음',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 16.0 : 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (sideJobState.isLoading) const AILoadingOverlay(
                title: 'AI가 당신에게 맞는\n부업을 분석하고 있어요...',
                subtitle: '',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopRow(double screenWidth) {
    final double iconSize = screenWidth * 0.05; // 화면 너비의 5% (반응형 아이콘 크기)
    final double rightPadding = screenWidth * 0.1; // 화면 너비의 10% (반응형 오른쪽 패딩)
    
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, 
            size: iconSize.clamp(18.0, 24.0), // 최소 18, 최대 24로 제한
            color: AppColors.textPrimary
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: _goBack,
        ),
        Expanded(
          child: Center(child: OnboardingProgress(currentStep: 5)),  // 6단계 중 마지막
        ),
        SizedBox(width: rightPadding),
      ],
    );
  }

  Widget _buildTitle(double screenWidth) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: (screenWidth * 0.06).clamp(16.0, isSmallScreen ? 20.0 : 24.0), // 최소 16, 최대 20(작은화면) 또는 24(큰화면)
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: '어떤 '),
              TextSpan(
                text: '방식',
                style: TextStyle(
                  color: const Color(0xFF1976D2), // 파란색 강조
                ),
              ),
              const TextSpan(text: '이 더 자신 있으신가요?\n'),
              TextSpan(
                text: '가장 즐겁고 자신 있는 활동을 골라주세요.',
                style: TextStyle(
                  fontSize: (screenWidth * 0.04).clamp(12.0, isSmallScreen ? 16.0 : 18.0), // 최소 12, 최대 16(작은화면) 또는 18(큰화면)
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          _buildOptionButton('창작하기', Icons.auto_awesome, 'CREATE'),
          const SizedBox(height: 12),
          _buildOptionButton('정리·전달하기', Icons.article, 'ORGANIZE'),
          const SizedBox(height: 12),
          _buildOptionButton('일상 공유하기', Icons.share, 'SHARE'),
          const SizedBox(height: 12),
          _buildOptionButton('트렌드 파악하기', Icons.trending_up, 'TREND'),
        ],
      ),
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



  Future<void> _goBack() async {
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step5PreferredMethodScreen(),
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
