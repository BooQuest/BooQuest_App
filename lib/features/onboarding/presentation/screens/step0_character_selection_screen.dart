import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_creation_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';

/// 온보딩 0단계 - 캐릭터 선택 화면
class Step0CharacterSelectionScreen extends StatefulWidget {
  const Step0CharacterSelectionScreen({super.key});

  @override
  State<Step0CharacterSelectionScreen> createState() => _Step0CharacterSelectionScreenState();
}

class _Step0CharacterSelectionScreenState extends State<Step0CharacterSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _bottomSpacing = 32.0;

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
      final storage = await LocalStorageService.getInstance();
      await storage.setCurrentOnboardingStep(0);
      await storage.saveCharacterScreenType('selection');
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 캐릭터 타입 불러오기
  Future<void> _loadSavedCharacterType() async {
    try {
      final storage = await LocalStorageService.getInstance();
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

  void _onCharacterSelected() async {
    // 선택된 캐릭터 타입 저장
    await _saveCharacterType();
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Step0CharacterCreationScreen()),
    );
  }

  /// 캐릭터 타입 저장
  Future<void> _saveCharacterType() async {
    try {
      final storage = await LocalStorageService.getInstance();
      final type = _currentPage == 0 ? 'BLACK' : 'WHITE';
      await storage.saveCharacterType(type);
    } catch (error) {
      print('❌ 캐릭터 타입 저장 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: _topSpacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '당신의 새로운 성장을\n함께할 친구를\n골라주세요',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return SvgPicture.asset(
                            'assets/images/characters/sel_char_${index + 1}.svg',
                            height: 300,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPageIndicator(0),
                        const SizedBox(width: 8),
                        _buildPageIndicator(1),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(_horizontalPadding, 0, _horizontalPadding, _bottomSpacing),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: _onCharacterSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonActive,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    '선택',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int page) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == page 
            ? AppColors.textPrimary
            : AppColors.textPrimary.withOpacity(0.3),
      ),
    );
  }
}