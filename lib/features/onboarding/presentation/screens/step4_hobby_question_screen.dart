import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step5_preferred_method_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/features/onboarding/presentation/widgets/selected_hobbies_popup.dart';

/// 온보딩 4단계 - 취미 질문 화면 (선택지 방식)
class Step4HobbyQuestionScreen extends StatefulWidget {
  const Step4HobbyQuestionScreen({super.key});

  @override
  State<Step4HobbyQuestionScreen> createState() => _Step4HobbyQuestionScreenState();
}

class _Step4HobbyQuestionScreenState extends State<Step4HobbyQuestionScreen> {
  static const List<Map<String, dynamic>> _hobbyOptions = [
    {'label': '경제·사회·재테크', 'icon': Icons.trending_up, 'iconColor': Colors.green},
    {'label': '문화·예술', 'icon': Icons.palette, 'iconColor': Colors.orange},
    {'label': '뷰티·패션', 'icon': Icons.style, 'iconColor': Colors.pink},
    {'label': 'IT·게임', 'icon': Icons.computer, 'iconColor': Colors.blue},
    {'label': '연예·예능·밈', 'icon': Icons.tv, 'iconColor': Colors.purple},
    {'label': '언어·해외·여행', 'icon': Icons.language, 'iconColor': Colors.indigo},
    {'label': '교육·심리', 'icon': Icons.school, 'iconColor': Colors.teal},
    {'label': '요리·음식', 'icon': Icons.restaurant, 'iconColor': Colors.red},
    {'label': '헬스·건강', 'icon': Icons.fitness_center, 'iconColor': Colors.lime},
    {'label': '가족·인간관계·라이프', 'icon': Icons.family_restroom, 'iconColor': Colors.amber},
  ];

  final Set<String> _selected = <String>{};
  final TextEditingController _hobbyController = TextEditingController();
  final FocusNode _hobbyFocusNode = FocusNode();
  bool _isDirectInputMode = false;
  bool _isValid = false;
  
  // 진행 가능 여부 계산
  bool get _canProceed => _isDirectInputMode ? _isValid : _selected.isNotEmpty;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;



  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _hobbyController.addListener(_onHobbyChanged);
    _saveCurrentStep();
    _loadSavedHobbies(); // 저장된 취미 데이터 불러오기
  }

  void _onHobbyChanged() {
    if (_isDirectInputMode) {
      final valid = _hobbyController.text.trim().length >= 2;
      if (_isValid != valid) {
        setState(() => _isValid = valid);
      }
    }
    
    // 실시간 저장 (Debouncer 적용) - 빈 상태도 저장
    _saveDebouncer.run(() => _saveHobbiesRealtime());
  }

  @override
  void dispose() {
    _hobbyController.removeListener(_onHobbyChanged);
    _hobbyController.dispose();
    _hobbyFocusNode.dispose();
    _saveDebouncer.dispose();
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(2);
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 취미 데이터 불러오기
  Future<void> _loadSavedHobbies() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedHobbies = storage.getHobbies();
      if (savedHobbies.isNotEmpty) {
        
        // 저장된 취미가 1개이고 직접 입력 가능한 형태라면 직접 입력 모드로 설정
        if (savedHobbies.length == 1) {
          final hobby = savedHobbies.first;
          // 선택지에 없는 취미라면 직접 입력 모드로 설정
          final isInOptions = _hobbyOptions.any((option) => option['label'] == hobby);
          
          if (!isInOptions) {
            setState(() {
              _isDirectInputMode = true;
              _hobbyController.text = hobby;
              _isValid = true;
            });
          } else {
            // 선택지에 있는 취미라면 선택 모드로 설정
            setState(() {
              _isDirectInputMode = false;
              _selected.add(hobby);
              _isValid = true;
            });
          }
        } else {
          // 여러 개의 취미가 저장되어 있다면 선택 모드로 설정
          setState(() {
            _isDirectInputMode = false;
            _selected.addAll(savedHobbies);
            _isValid = true;
          });
        }
      }
    } catch (error) {
      print('❌ 저장된 취미 데이터 불러오기 실패: $error');
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
        final double titleToChoiceSpacing = screenHeight * 0.05; // 화면 높이의 5%
        final double choiceToButtonSpacing = screenHeight * 0.075; // 화면 높이의 7.5%
        
        // 하단 버튼 관련 - isSmallScreen 반응형 적용
        final double buttonHeight = isSmallScreen ? 46.0 : 60.0;
        final double inputHeight = isSmallScreen ? 48.0 : 56.0;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => _hobbyFocusNode.unfocus(),
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
                          SizedBox(height: titleToChoiceSpacing),
                          _buildChoiceChips(screenWidth),
                          SizedBox(height: choiceToButtonSpacing),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 16),
                    child: Column(
                      children: [
                        if (_isDirectInputMode) ...[
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
                                controller: _hobbyController,
                                focusNode: _hobbyFocusNode,
                                onChanged: (v) {
                                  final trimmed = v.trim();
                                  _validateInput();
                                },
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14.0 : 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '당신의 취미를 입력해주세요',
                                  hintStyle: TextStyle(
                                    color: AppColors.textHint,
                                    fontSize: isSmallScreen ? 14.0 : 16.0,
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _onNext(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                        // 다음 버튼
                        Container(
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
          child: Center(child: OnboardingProgress(currentStep: 3)),  // 6단계 중 네번째
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 메인 질문 (RichText로 "분야"와 "취미" 강조)
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: (screenWidth * 0.06).clamp(16.0, isSmallScreen ? 20.0 : 24.0), // 최소 16, 최대 20(작은화면) 또는 24(큰화면)
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
              children: [
                const TextSpan(text: '관심 있는 '),
                TextSpan(
                  text: '분야',
                  style: TextStyle(
                    color: const Color(0xFF1976D2),
                  ),
                ),
                const TextSpan(text: '나 즐겨 하는 '),
                TextSpan(
                  text: '취미',
                  style: TextStyle(
                    color: const Color(0xFF1976D2),
                  ),
                ),
                const TextSpan(text: '가 있으신가요?'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 안내 텍스트
          Text(
            '최대 3개까지 선택 가능해요.',
            style: TextStyle(
              fontSize: (screenWidth * 0.04).clamp(12.0, isSmallScreen ? 16.0 : 18.0), // 최소 12, 최대 16(작은화면) 또는 18(큰화면)
              fontWeight: FontWeight.w400,
              color: Colors.grey[600], 
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChips(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _hobbyOptions.map((option) => _buildChoiceChip(option)).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => _toggleDirectInput(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text(
                      '직접입력',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(Map<String, dynamic> option) {
    final String label = option['label'];
    final IconData icon = option['icon'];
    final Color iconColor = option['iconColor'];
    final bool isSelected = _selected.contains(label);
    
    return GestureDetector(
      onTap: () => _toggleHobby(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : AppColors.chipUnselectedBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.chipBorder : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : iconColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.chipSelectedText : AppColors.chipUnselectedText,
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _toggleDirectInput() {
    setState(() {
      _isDirectInputMode = true;
      _selected.clear();
    });
    
    _saveHobbiesRealtime();
  }

  Future<void> _toggleHobby(String label) async {
    if (_isDirectInputMode) {
      setState(() {
        _isDirectInputMode = false;
        _hobbyController.clear();
      });
    }

    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else {
        // 최대 3개까지만 선택 가능
        if (_selected.length < 3) {
          _selected.add(label);
        } else {
          // 3개 초과 선택 시 스낵바로 안내
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('최대 3개까지만 선택할 수 있어요.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
    
    // 선택 상태 변경 시 즉시 저장
    await _saveHobbiesRealtime();
  }



  Future<void> _goBack() async {
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step3JobQuestionScreen(),
      ),
    );
  }

  Future<void> _onNext() async {
    // 취미 데이터를 local storage에 저장
    await _saveHobbies();
    
    if (!mounted) return;
    
    // 조건부 처리:
    // 1. 직접 입력 모드인 경우 → 바로 다음 단계로
    // 2. 카드 옵션을 선택한 경우 → 팝업 표시
    if (_isDirectInputMode) {
      // 직접 입력 모드: 바로 다음 단계로
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Step5PreferredMethodScreen()),
      );
    } else {
      // 카드 옵션 선택 모드: 팝업 표시
      _showSelectedHobbiesPopup();
    }
  }
  
  /// 선택된 취미에 대한 세부 옵션 팝업 표시
  void _showSelectedHobbiesPopup() {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: isSmallScreen ? 300.0 : 400.0,
      ),
      builder: (context) => SelectedHobbiesPopup(
        selectedHobbies: _selected.toList(),
        onConfirm: () {
          // 팝업에서 확인 버튼을 누르면 다음 단계로
          Navigator.pop(context); // 팝업 닫기
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Step5PreferredMethodScreen()),
          );
        },
      ),
    );
  }

  /// 취미 데이터 저장
  Future<void> _saveHobbies() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      List<String> hobbies = [];
      
      if (_isDirectInputMode) {
        // 직접 입력 모드
        final hobby = _hobbyController.text.trim();
        if (hobby.isNotEmpty) {
          hobbies.add(hobby);
        }
      } else {
        // 선택 모드
        hobbies = _selected.toList();
      }
      
      await storage.setHobbies(hobbies);
    } catch (error) {
      print('❌ 취미 저장 실패: $error');
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveHobbiesRealtime() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      List<String> hobbies = [];
      
      if (_isDirectInputMode) {
        final hobby = _hobbyController.text.trim();
        if (hobby.isNotEmpty) {
          hobbies.add(hobby);
        }
      } else {
        hobbies = _selected.toList();
        print('💾 선택 모드 - 취미 실시간 저장: $hobbies');
      }
      
      await storage.setHobbies(hobbies);
    } catch (error) {
      print('❌ 실시간 취미 저장 실패: $error');
    }
  }

  /// 입력 유효성 검사 (직접 입력 모드용)
  void _validateInput() {
    if (_isDirectInputMode) {
      final valid = _hobbyController.text.trim().length >= 2;
      if (_isValid != valid) {
        setState(() => _isValid = valid);
      }
    }
  }
}
