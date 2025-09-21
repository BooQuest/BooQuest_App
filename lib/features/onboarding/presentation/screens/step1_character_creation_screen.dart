import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_character_selection_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/auth/presentation/auth_wrapper.dart';

/// 온보딩 2단계 - 캐릭터 생성 화면
class Step1CharacterCreationScreen extends StatefulWidget {
  const Step1CharacterCreationScreen({super.key});

  @override
  State<Step1CharacterCreationScreen> createState() => _Step1CharacterCreationScreenState();
}

class _Step1CharacterCreationScreenState extends State<Step1CharacterCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isNameValid = false;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;


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
    // JWT 토큰 삭제
    try {
      final authStorage = await AuthStorageService.getInstance();
      await authStorage.clearTokens();
    } catch (error) {
    }
    
    // 온보딩 데이터 삭제
    try {
      final onboardingStorage = await OnboardingStorageService.getInstance();
      await onboardingStorage.clearAllData();
    } catch (error) {
    }
    
    // AuthWrapper로 이동 (로그인 페이지 포함)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const AuthWrapper(),
      ),
      (route) => false, // 모든 이전 화면 제거
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
          MaterialPageRoute(builder: (_) => const Step2CharacterSelectionScreen()),
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
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final isLandscape = screenSize.width > screenSize.height;
    
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
        final double titleBottomSpacing = screenHeight * 0.05; // 화면 높이의 5%
        
        // 캐릭터 이미지 관련 
        final double characterImageHeight = isLandscape 
            ? screenHeight * 0.5  // 가로 모드에서는 화면 높이의 50%
            : screenHeight * 0.4; 
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        final double inputHeight = isSmallScreen ? 48.0 : 56.0;
        
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
                                '이름을 입력해주세요',
                                style: TextStyle(
                                  fontSize: (screenWidth * 0.06).clamp(16.0, isSmallScreen ? 20.0 : 24.0), // 최소 16, 최대 20(작은화면) 또는 24(큰화면)
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: titleBottomSpacing),
                          SizedBox(
                            height: characterImageHeight,
                            child: Center(
                              child: _buildCharacterSection(characterImageHeight),
                            ),
                          ),
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
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14.0 : 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '이름을 입력하세요',
                                hintStyle: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: isSmallScreen ? 14.0 : 16.0,
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
                          height: buttonHeight,
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
        const Expanded(
          child: Center(child: OnboardingProgress(currentStep: 0)),  // 6단계 중 첫번째
        ),
        SizedBox(width: rightPadding),
      ],
    );
  }


  Widget _buildCharacterSection(double characterImageHeight) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Center(
      child: SizedBox(
        height: characterImageHeight > 0 ? characterImageHeight + 50.0 : (isSmallScreen ? 400.0 : 450.0), 
        child: Stack(
          alignment: Alignment.center,
          children: [
              Positioned(
                top: 0,
                child: Container(
                  width: isSmallScreen ? 180.0 : 220.0, 
                  height: isSmallScreen ? 180.0 : 220.0, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/onboarding/onboarding_create_1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
             // 하단 고양이 캐릭터 (작게, 약간 겹치게)
             Positioned(
               top: isSmallScreen ? 140.0 : 160.0, // 겹치도록 위치 조정 (위로 올림)
               left: 0,
               right: 0,
               child: Center(
                 child: Transform.translate(
                   offset: Offset(isSmallScreen ? -25.0 : -30.0, 0),
                   child: Image.asset(
                     'assets/images/onboarding/onboarding_create_2.png',
                     height: isSmallScreen ? 150.0 : 170.0, // 높이 증가
                     fit: BoxFit.contain,
                   ),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

}