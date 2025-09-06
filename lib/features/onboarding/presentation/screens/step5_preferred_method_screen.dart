import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step6_method_selection_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/navigation/transitions.dart';

/// 온보딩 5단계 - 표현 방식 선택 화면
class Step5PreferredMethodScreen extends StatefulWidget {
  const Step5PreferredMethodScreen({super.key});

  @override
  State<Step5PreferredMethodScreen> createState() => _Step5PreferredMethodScreenState();
}

class _Step5PreferredMethodScreenState extends State<Step5PreferredMethodScreen> {

  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _saveCurrentStep();
    _loadSavedExpressionStyle(); // 저장된 표현 방식 불러오기
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
        final double titleToOptionsSpacing = screenHeight * 0.05; // 화면 높이의 5%
        final double optionsToButtonSpacing = screenHeight * 0.075; // 화면 높이의 7.5%
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
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
                        color: _selectedOption != null 
                            ? const Color(0xFF1976D2)
                            : const Color(0xFFCCCCCC),
                        borderRadius: BorderRadius.circular(buttonHeight * 0.26),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _selectedOption != null ? _onNext : null,
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
          child: Center(child: OnboardingProgress(currentStep: 4)),  // 6단계 중 다섯번째
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
              const TextSpan(text: '선호하는 '),
              TextSpan(
                text: '표현 방식',
                style: TextStyle(
                  color: const Color(0xFF1976D2), // 파란색 강조
                ),
              ),
              const TextSpan(text: '을 알려주세요\n'),
              TextSpan(
                text: '가장 \'나답게\' 표현할 수 있는 방식을 알려주세요.',
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
          _buildOptionButton('글쓰기', Icons.edit, 'TEXT'),
          const SizedBox(height: 12),
          _buildOptionButton('그림 그리기', Icons.brush, 'IMAGE'),
          const SizedBox(height: 12),
          _buildOptionButton('영상', Icons.videocam, 'VIDEO'),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String label, IconData icon, String value) {
    final bool isSelected = _selectedOption == value;
    
    return GestureDetector(
      onTap: () async {
        setState(() => _selectedOption = value);
        // 선택 시 즉시 저장
        await _saveExpressionStyleRealtime(value);
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
              label, // 한글로 표시
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
      case '글쓰기':
        return Colors.blue;
      case '그림 그리기':
        return Colors.purple;
      case '영상':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }



  void _onNext() {
    if (_selectedOption != null) {
      // 선택한 값을 local storage에 저장 (영어 값으로 저장)
      _saveExpressionStyle();
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Step6MethodSelectionScreen()),
      );
    }
  }

  /// 표현 방식 저장
  Future<void> _saveExpressionStyle() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setExpressionStyle(_selectedOption!);
    } catch (error) {
      print('❌ 표현 방식 저장 실패: $error');
    }
  }

  /// 표현 방식 실시간 저장
  Future<void> _saveExpressionStyleRealtime(String value) async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setExpressionStyle(value);
    } catch (error) {
      print('❌ 표현 방식 실시간 저장 실패: $error');
    }
  }

  /// 현재 온보딩 단계를 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(3); // 3단계
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 표현 방식을 불러와서 선택 상태로 설정
  Future<void> _loadSavedExpressionStyle() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedExpressionStyle = storage.getExpressionStyle();
      if (savedExpressionStyle != null) {
        setState(() {
          _selectedOption = savedExpressionStyle;
        });
      }
    } catch (error) {
      print('❌ 저장된 표현 방식 불러오기 실패: $error');
    }
  }

  Future<void> _goBack() async {
    // 뒤로가기 시에도 현재 온보딩 단계 저장
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step4HobbyQuestionScreen(),
      ),
    );
  }
}
