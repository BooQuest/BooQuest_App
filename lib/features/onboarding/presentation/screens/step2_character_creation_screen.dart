import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_character_selection_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_job_question_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';

/// 온보딩 2단계 - 캐릭터 생성 화면
class Step2CharacterCreationScreen extends StatefulWidget {
  const Step2CharacterCreationScreen({super.key});

  @override
  State<Step2CharacterCreationScreen> createState() => _Step2CharacterCreationScreenState();
}

class _Step2CharacterCreationScreenState extends State<Step2CharacterCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isNameValid = false;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;

  // 초기 로딩 시에만 반응형으로 계산 (키보드 올라온 후 고정값 유지)
  late final double _screenHeight = MediaQuery.of(context).size.height;
  late final double _screenWidth = MediaQuery.of(context).size.width;
  
  // 초기 반응형 값들 (한 번만 계산하고 고정)
  late final double _horizontalPadding = _screenWidth * 0.05; // 화면 너비의 5%
  late final double _topSpacing = _screenHeight * 0.1; // 화면 높이의 10%
  late final double _avatarToTextSpacing = _screenHeight * 0.025; // 화면 높이의 2.5%
  late final double _textToCharacterSpacing = _screenHeight * 0.05; // 화면 높이의 5%
  late final double _characterToInputSpacing = _screenHeight * 0.075; // 화면 높이의 7.5%
  late final double _inputToButtonSpacing = _screenHeight * 0.02; // 화면 높이의 2%
  late final double _topRowCompensation = _screenHeight * 0.02; // 화면 높이의 2%
  
  // 캐릭터 이미지 관련
  late final double _characterImageHeight = _screenHeight * 0.35; // 화면 높이의 35%
  
  // 상단 여백 관련
  late final double _topMargin = _screenHeight * 0.05; // 화면 높이의 5%
  late final double _titleTopSpacing = _screenHeight * 0.05; // 화면 높이의 5%
  
  // 하단 버튼 관련
  late final double _buttonHeight = _screenHeight * 0.06; // 화면 높이의 6% (최소 46, 최대 60)
  late final double _inputHeight = _screenHeight * 0.06; // 화면 높이의 6% (최소 48, 최대 56)
  
  // 프로그레스 바 관련
  late final double _progressBarHeight = _screenHeight * 0.008; // 화면 높이의 0.8%

  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _nameController.addListener(_onNameChanged);
    _saveCurrentStep();
    _loadSavedCharacterName(); // 저장된 캐릭터 이름 불러오기
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _nameFocusNode.dispose();
    _saveDebouncer.dispose();
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(0);
      await storage.setCharacterScreenType('creation');
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 캐릭터 이름 불러오기
  Future<void> _loadSavedCharacterName() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedName = storage.getCharacterName();
      if (savedName != null && savedName.isNotEmpty) {
        _nameController.text = savedName;
        setState(() {
          _isNameValid = true;
        });
      }
    } catch (error) {
      print('❌ 저장된 캐릭터 이름 불러오기 실패: $error');
    }
  }

  void _onNameChanged() {
    final isValid = _nameController.text.trim().length >= 2;
    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
    
    // 실시간 저장 (Debouncer 적용) - 빈 상태도 저장
    _saveDebouncer.run(() => _saveCharacterNameRealtime());
  }

  void _goBack() async {
    await _saveCurrentStep();
    
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step1CharacterSelectionScreen(),
      ),
    );
  }

  void _onConfirmPressed() async {
    if (_isNameValid) {
      final name = _nameController.text.trim();
      
      // 캐릭터 이름을 local storage에 저장
      await _saveCharacterName(name);
      
      _nameFocusNode.unfocus();
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Step3JobQuestionScreen()),
        );
      }
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveCharacterNameRealtime() async {
    final name = _nameController.text.trim();
    await _saveCharacterName(name);
  }

  /// 캐릭터 이름 저장
  Future<void> _saveCharacterName(String name) async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCharacterName(name);
    } catch (error) {
      print('❌ 캐릭터 이름 저장 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        final double textToCharacterSpacing = screenHeight * 0.05; // 화면 높이의 5%
        final double characterToInputSpacing = screenHeight * 0.075; // 화면 높이의 7.5%
        final double inputToButtonSpacing = screenHeight * 0.02; // 화면 높이의 2%
        final double topRowCompensation = screenHeight * 0.02; // 화면 높이의 2%
        
        // 캐릭터 이미지 관련
        final double characterImageHeight = screenHeight * 0.35; // 화면 높이의 35%
        
        // 하단 버튼 관련
        final double buttonHeight = screenHeight * 0.06; // 화면 높이의 6% (최소 46, 최대 60)
        final double inputHeight = screenHeight * 0.06; // 화면 높이의 6% (최소 48, 최대 56)
        
        // 프로그레스 바 관련
        final double progressBarHeight = screenHeight * 0.008; // 화면 높이의 0.8%
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => _nameFocusNode.unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: topMargin),
                          _buildTopRow(screenWidth),
                                                  SizedBox(height: titleTopSpacing),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '어떻게 불러드리면 될까요?',
                              style: TextStyle(
                                fontSize: screenWidth * 0.06, // 화면 너비의 6% (반응형 폰트 크기)
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                          SizedBox(height: textToCharacterSpacing),
                          _buildCharacterSection(characterImageHeight),
                          SizedBox(height: characterToInputSpacing),
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
                          height: inputHeight.clamp(48.0, 56.0),
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
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              style: TextStyle(
                                fontSize: inputHeight * 0.375,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '이름을 입력하세요',
                                hintStyle: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: inputHeight * 0.375,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _onConfirmPressed(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // 확인 버튼
                        Container(
                          width: double.infinity,
                          height: buttonHeight.clamp(46.0, 60.0),
                          decoration: BoxDecoration(
                            color: _isNameValid 
                                ? const Color(0xFF1976D2)
                                : const Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isNameValid ? _onConfirmPressed : null,
                              borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                              child: Center(
                                child: Text(
                                  '확인',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: buttonHeight * 0.39,
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
          child: Center(child: OnboardingProgress(currentStep: 1)),  // 6단계 중 두번째
        ),
        SizedBox(width: rightPadding),
      ],
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '어떻게 불러드리면 될까요?',
        style: TextStyle(
          fontSize: screenWidth * 0.06, // 화면 너비의 6% (반응형 폰트 크기)
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildCharacterSection(double characterImageHeight) {
    return Center(
      child: Image.asset(
        'assets/images/characters/create_char.png',
        height: characterImageHeight.clamp(300.0, 500.0), // 최소 300, 최대 500으로 제한
      ),
    );
  }

  Widget _buildBottomBar(double screenWidth, double buttonHeight, double inputHeight, double inputToButtonSpacing) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
        bottom: 16 + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNameInputField(screenWidth, inputHeight),
          SizedBox(height: inputToButtonSpacing),
          _buildConfirmButton(buttonHeight),
        ],
      ),
    );
  }

  Widget _buildNameInputField(double screenWidth, double inputHeight) {
    final double horizontalPadding = screenWidth * 0.04; // 화면 너비의 4% (반응형 패딩)
    
    return Container(
      width: double.infinity,
      height: inputHeight.clamp(48.0, 56.0), // 최소 48, 최대 56으로 제한
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(
          color: AppColors.inputBorder,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(inputHeight * 0.125), // 입력창 높이의 12.5% (반응형 둥근 모서리)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: TextField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          style: TextStyle(
            fontSize: inputHeight * 0.375, // 입력창 높이의 37.5% (반응형 폰트 크기)
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '이름을 입력하세요',
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: inputHeight * 0.375, // 입력창 높이의 37.5% (반응형 폰트 크기)
            ),
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _onConfirmPressed(),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(double buttonHeight) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight.clamp(46.0, 60.0), // 최소 46, 최대 60으로 제한
      child: Container(
        decoration: BoxDecoration(
          color: _isNameValid 
              ? const Color(0xFF1976D2) // 파란색 배경
              : const Color(0xFFCCCCCC), // 비활성화 시 회색
          borderRadius: BorderRadius.circular(buttonHeight * 0.26), // 버튼 높이의 26% (반응형 둥근 모서리)
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isNameValid ? _onConfirmPressed : null,
            borderRadius: BorderRadius.circular(buttonHeight * 0.26),
            child: Center(
              child: Text(
                '확인',
                style: TextStyle(
                  color: _isNameValid ? Colors.white : Colors.grey[600],
                  fontSize: buttonHeight * 0.39, // 버튼 높이의 39% (반응형 폰트 크기)
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}