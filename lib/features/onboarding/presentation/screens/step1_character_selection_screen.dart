import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_character_creation_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/auth/presentation/auth_wrapper.dart';

/// 온보딩 1단계 - 캐릭터 선택 화면
class Step1CharacterSelectionScreen extends StatefulWidget {
  const Step1CharacterSelectionScreen({super.key});

  @override
  State<Step1CharacterSelectionScreen> createState() => _Step1CharacterSelectionScreenState();
}

class _Step1CharacterSelectionScreenState extends State<Step1CharacterSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 반응형 값을 위한 late final 변수들 (성능 최적화)
  late final double _screenHeight = MediaQuery.of(context).size.height;
  late final double _screenWidth = MediaQuery.of(context).size.width;
  
  // 동적으로 계산되는 값들 (한 번만 계산)
  late final double _horizontalPadding = _screenWidth * 0.05; // 화면 너비의 5%
  late final double _topSpacing = _screenHeight * 0.1; // 화면 높이의 10%
  late final double _bottomSpacing = _screenHeight * 0.04; // 화면 높이의 4%
  
  // 상단 여백 관련
  late final double _topMargin = _screenHeight * 0.05; // 화면 높이의 5%
  late final double _titleTopSpacing = _screenHeight * 0.05; // 화면 높이의 5%
  late final double _titleBottomSpacing = _screenHeight * 0.05; // 화면 높이의 5%
  
  // 캐릭터 이미지 관련
  late final double _characterImageHeight = _screenHeight * 0.35; // 화면 높이의 35%
  late final double _pageIndicatorSpacing = _screenWidth * 0.02; // 화면 너비의 2%
  
  // 하단 버튼 관련
  late final double _buttonHeight = _screenHeight * 0.06; // 화면 높이의 6% (최소 46, 최대 60)
  late final double _buttonBottomPadding = _screenHeight * 0.02; // 화면 높이의 2%
  
  // 프로그레스 바 관련
  late final double _progressBarHeight = _screenHeight * 0.008; // 화면 높이의 0.8%

  @override
  void initState() {
    super.initState();
    _saveCurrentStep();
    _loadSavedCharacterType(); // 저장된 캐릭터 타입 불러오기
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(0);
      await storage.setCharacterScreenType('selection');
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 캐릭터 타입 불러오기
  Future<void> _loadSavedCharacterType() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedCharacterType = storage.getCharacterType();
      if (savedCharacterType != null) {
        // 저장된 캐릭터 타입에 따라 페이지 설정
        final int targetPage = savedCharacterType == 'BLACK' ? 0 : 1;
        setState(() {
          _currentPage = targetPage;
        });
        // PageController도 해당 페이지로 이동
        _pageController.animateToPage(
          targetPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } catch (error) {
      print('❌ 저장된 캐릭터 타입 불러오기 실패: $error');
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _goBack() async {
    // JWT 토큰 삭제
    try {
      final authStorage = await AuthStorageService.getInstance();
      await authStorage.clearTokens();
      print('🔒 JWT 토큰이 삭제되었습니다.');
    } catch (error) {
      print('❌ JWT 토큰 삭제 실패: $error');
    }
    
    // AuthWrapper로 이동 (로그인 페이지 포함)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const AuthWrapper(),
      ),
      (route) => false, // 모든 이전 화면 제거
    );
  }

  void _onCharacterSelected() async {
    // 선택된 캐릭터 타입 저장
    await _saveCharacterType();
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Step2CharacterCreationScreen()),
    );
  }

  /// 캐릭터 타입 저장
  Future<void> _saveCharacterType() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final type = _currentPage == 0 ? 'BLACK' : 'WHITE';
      await storage.setCharacterType(type);
    } catch (error) {
      print('❌ 캐릭터 타입 저장 실패: $error');
    }
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
        final double titleBottomSpacing = screenHeight * 0.05; // 화면 높이의 5%
        
        // 캐릭터 이미지 관련
        final double characterImageHeight = screenHeight * 0.35; // 화면 높이의 35%
        final double pageIndicatorSpacing = screenWidth * 0.02; // 화면 너비의 2%
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        final double buttonBottomPadding = screenHeight * 0.02; // 화면 높이의 2%
        
        // 프로그레스 바 관련
        final double progressBarHeight = screenHeight * 0.008; // 화면 높이의 0.8%
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
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
                              '새로운 성장을 함께할 \n파트너를 선택해 주세요',
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
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return SvgPicture.asset(
                                'assets/images/characters/sel_char_${index + 1}.svg',
                                height: characterImageHeight,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025), // 화면 높이의 2.5%
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPageIndicator(0, screenWidth),
                            SizedBox(width: pageIndicatorSpacing),
                            _buildPageIndicator(1, screenWidth),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, buttonBottomPadding),
                  child: Container(
                    width: double.infinity,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2), // 파란색 배경
                      borderRadius: BorderRadius.circular(buttonHeight * 0.26), // 버튼 높이의 26% (반응형 둥근 모서리)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _onCharacterSelected,
                        borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                        child: Center(
                          child: Text(
                            '선택',
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

  Widget _buildPageIndicator(int page, double screenWidth) {
    final double indicatorSize = screenWidth * 0.02; // 화면 너비의 2% (반응형 크기)
    
    return Container(
      width: indicatorSize.clamp(6.0, 12.0), // 최소 6, 최대 12로 제한
      height: indicatorSize.clamp(6.0, 12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == page 
            ? AppColors.textPrimary
            : AppColors.textPrimary.withValues(alpha: 0.3), // withOpacity 대신 withValues 사용
      ),
    );
  }
}