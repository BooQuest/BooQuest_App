import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step3_preferred_method_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_job_question_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 온보딩 2단계 - 취미 질문 화면 (선택지 방식)
class Step2HobbyQuestionScreen extends StatefulWidget {
  const Step2HobbyQuestionScreen({super.key});

  @override
  State<Step2HobbyQuestionScreen> createState() => _Step2HobbyQuestionScreenState();
}

class _Step2HobbyQuestionScreenState extends State<Step2HobbyQuestionScreen> {
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
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0; 
  static const double _topRowCompensation = 16.0;
  static const double _inputToButtonSpacing = 15.0;

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
      final storage = await LocalStorageService.getInstance();
      await storage.setCurrentOnboardingStep(2);
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 취미 데이터 불러오기
  Future<void> _loadSavedHobbies() async {
    try {
      final storage = await LocalStorageService.getInstance();
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _hobbyFocusNode.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                _buildTopRow(),
                const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildChoiceChips(),
                const SizedBox(height: 120),
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
          child: Center(child: OnboardingProgress(currentStep: 2)),  // 5단계 중 세 번째
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
                '관심 있는 분야나\n즐겨 하는 취미가\n있으신가요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '취향에 맞춘 부업을 추천해 드릴게요',
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

  Widget _buildChoiceChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _hobbyOptions.map((option) => _buildChoiceChip(option)).toList(),
        ),
        const SizedBox(height: 20),
        GestureDetector(
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
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  Widget _buildBottomBar() {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bool canProceed = _isDirectInputMode ? _isValid : _selected.isNotEmpty;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + bottomInset,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isDirectInputMode) ...[
              _buildInputField(),
              const SizedBox(height: _inputToButtonSpacing),
            ],
            SizedBox(
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
        _selected.add(label);
      }
    });
    
    // 선택 상태 변경 시 즉시 저장
    await _saveHobbiesRealtime();
  }

  Widget _buildInputField() {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(color: AppColors.inputBorder, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _hobbyController,
          focusNode: _hobbyFocusNode,
          onChanged: (v) {
            final trimmed = v.trim();
            _validateInput(); // Keep validation for direct input
          },
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '당신의 취미를 입력해주세요',
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: 18,
            ),
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _onNext(),
        ),
      ),
    );
  }

  Future<void> _goBack() async {
    await _saveCurrentStep();
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const Step1JobQuestionScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }

  Future<void> _onNext() async {
    // 취미 데이터를 local storage에 저장
    await _saveHobbies();
    
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Step3PreferredMethodScreen()),
    );
  }

  /// 취미 데이터 저장
  Future<void> _saveHobbies() async {
    try {
      final storage = await LocalStorageService.getInstance();
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
      
      await storage.saveHobbies(hobbies);
    } catch (error) {
      print('❌ 취미 저장 실패: $error');
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveHobbiesRealtime() async {
    try {
      final storage = await LocalStorageService.getInstance();
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
      
      await storage.saveHobbies(hobbies);
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
