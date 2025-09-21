import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_character_selection_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_hobby_question_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/core/navigation/transitions.dart';

/// 온보딩 3단계 - 직업 질문 화면
class Step3JobQuestionScreen extends StatefulWidget {
  const Step3JobQuestionScreen({super.key});

  @override
  State<Step3JobQuestionScreen> createState() => _Step3JobQuestionScreenState();
}

class _Step3JobQuestionScreenState extends State<Step3JobQuestionScreen> {

  final TextEditingController _jobController = TextEditingController();
  final FocusNode _jobFocusNode = FocusNode();
  bool _isValid = false;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;

  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _jobController.addListener(_onJobChanged);
    _saveCurrentStep();
    _loadSavedJob(); 
  }

  @override
  void dispose() {
    _jobController.removeListener(_onJobChanged);
    _jobController.dispose();
    _jobFocusNode.dispose();
    _saveDebouncer.dispose();
    super.dispose();
  }

  void _onJobChanged() {
    final isValid = _jobController.text.trim().length >= 2;
    if (_isValid != isValid) {
      setState(() => _isValid = isValid);
    }
    
    // 실시간 저장 (Debouncer 적용) - 빈 상태도 저장
    _saveDebouncer.run(() => _saveJobRealtime());
  }

  @override
  Widget build(BuildContext context) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
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
        final double titleToInputSpacing = screenHeight * 0.075; // 화면 높이의 7.5%
        final double inputToButtonSpacing = screenHeight * 0.02; // 화면 높이의 2%
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        final double inputHeight = isSmallScreen ? 48.0 : 56.0;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => _jobFocusNode.unfocus(),
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
                          SizedBox(height: titleToInputSpacing),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 16),
                    child: Column(
                      children: [
                        // 입력 필드
                        Container(
                          width: double.infinity,
                          height: inputHeight,
                          decoration: BoxDecoration(
                            color: AppColors.inputBackground,
                            border: Border.all(
                              color: AppColors.inputBorder,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(inputHeight * 0.125),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                            child: TextField(
                              controller: _jobController,
                              focusNode: _jobFocusNode,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14.0 : 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '마케팅 어시스턴트',
                                hintStyle: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: isSmallScreen ? 14.0 : 16.0,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _onConfirm(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // 확인 버튼
                        Container(
                          width: double.infinity,
                          height: buttonHeight,
                          decoration: BoxDecoration(
                            color: _isValid 
                                ? const Color(0xFF1976D2)
                                : const Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isValid ? _onConfirm : null,
                              borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                              child: Center(
                                child: Text(
                                  '확인',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          child: Center(child: OnboardingProgress(currentStep: 2)),  // 6단계 중 세번째
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
        child: Text(
          '지금 어떤 일을 하고 계시나요?',
          style: TextStyle(
            fontSize: (screenWidth * 0.06).clamp(16.0, isSmallScreen ? 20.0 : 24.0), // 최소 16, 최대 20(작은화면) 또는 24(큰화면)
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.4,
          ),
        ),
      ),
    );
  }



  void _goBack() async {
    await _saveCurrentStep();
    
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step2CharacterSelectionScreen(),
      ),
    );
  }

  void _onConfirm() async {
    _jobFocusNode.unfocus();
    
    // 직업 데이터를 local storage에 저장
    await _saveJob();
    
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Step4HobbyQuestionScreen()),
    );
  }

  /// 직업 데이터 저장
  Future<void> _saveJob() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final job = _jobController.text.trim();
      await storage.setJob(job);
    } catch (error) {
      print('❌ 직업 저장 실패: $error');
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveJobRealtime() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final job = _jobController.text.trim();
      await storage.setJob(job);
    } catch (error) {
    }
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(1);
    } catch (error) {
    }
  }

  /// 저장된 직업 데이터 불러오기
  Future<void> _loadSavedJob() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedJob = storage.getJob();
      if (savedJob != null && savedJob.isNotEmpty) {
        _jobController.text = savedJob;
        setState(() {
          _isValid = true;
        });
      }
    } catch (error) {
    }
  }
}
