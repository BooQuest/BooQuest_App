import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_method_selection_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/navigation/transitions.dart';

/// 온보딩 3단계 - 표현 방식 선택 화면
class Step3PreferredMethodScreen extends StatefulWidget {
  const Step3PreferredMethodScreen({super.key});

  @override
  State<Step3PreferredMethodScreen> createState() => _Step3PreferredMethodScreenState();
}

class _Step3PreferredMethodScreenState extends State<Step3PreferredMethodScreen> {
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
    _loadSavedExpressionStyle(); // 저장된 표현 방식 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
          child: Center(child: OnboardingProgress(currentStep: 2)),  // 5단계 중 세번째
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
                '어떤 평소 표현 방식을\n더 선호하시나요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '더 편안한 방식으로 안내드릴 수 있게 알려주세요',
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
        _buildOptionButton('글쓰기', Icons.edit, '글쓰기'),
        const SizedBox(height: 12),
        _buildOptionButton('그림 그리기', Icons.brush, '그림 그리기'),
        const SizedBox(height: 12),
        _buildOptionButton('영상', Icons.videocam, '영상'),
      ],
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
              color: isSelected ? Colors.white : _getIconColor(value),
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

  Widget _buildBottomBar() {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
            onPressed: _selectedOption != null ? _onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedOption != null ? AppColors.buttonActive : AppColors.buttonInactive,
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

  void _onNext() {
    if (_selectedOption != null) {
      // 선택한 값을 local storage에 저장
      _saveExpressionStyle();
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Step4MethodSelectionScreen()),
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
        builder: (_) => const Step2HobbyQuestionScreen(),
      ),
    );
  }
}
