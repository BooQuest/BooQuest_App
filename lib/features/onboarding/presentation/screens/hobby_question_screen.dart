import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/coaching_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/job_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 온보딩 2단계 - 취미 질문 화면 (선택지 방식)
class HobbyQuestionScreen extends StatefulWidget {
  const HobbyQuestionScreen({super.key});

  @override
  State<HobbyQuestionScreen> createState() => _HobbyQuestionScreenState();
}

class _HobbyQuestionScreenState extends State<HobbyQuestionScreen> {
  static const List<String> _hobbyOptions = [
    '스포츠', '음악·악기', '미술·디자인',
    '사진·영상', '요리·베이킹', '동물·반려생활',
    '게임·e스포츠', '패션·뷰티', '독서·글쓰기',
    '여행·문화탐방', 'IT·디지털 기술', '재테크·투자',
    '봉사·사회활동', 'DIY·메이킹',
  ];

  final Set<String> _selected = <String>{};
  final TextEditingController _hobbyController = TextEditingController();
  final FocusNode _hobbyFocusNode = FocusNode();
  final Debouncer _saveDebouncer = Debouncer(350);
  LocalStorageService? _storage;
  bool _isDirectInputMode = false;
  bool _isValid = false;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0; 
  static const double _topRowCompensation = 16.0;
  static const double _inputToButtonSpacing = 15.0;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _hobbyController.addListener(_validateInput);
    _loadSavedHobbies();
    _setStage(2);
  }

  void _validateInput() {
    final valid = _hobbyController.text.trim().length >= 2;
    if (_isValid != valid) {
      setState(() => _isValid = valid);
    }
  }

  Future<void> _initStorage() async {
    _storage = await LocalStorageService.getInstance();
  }

  Future<void> _setStage(int stage) async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.setOnboardingStage(stage);
    } catch (_) {}
  }

  Future<void> _loadSavedHobbies() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      final saved = storage.getHobbies();
      if (saved.isNotEmpty) {
        setState(() {
          _selected
            ..clear()
            ..addAll(saved);
        });
      }
    } catch (_) {}
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
          child: Center(child: OnboardingProgress(currentStep: 1)),  // 4단계 중 두 번째
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '취미가 뭐야?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildChoiceChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _hobbyOptions.map((label) => _buildChoiceChip(label)).toList(),
        ),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: () => _toggleDirectInput(),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFBFBFBF),
                    width: 1,
                  ),
                ),
              ),
              child: const Text(
                '직접입력 +',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFBFBFBF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(String label) {
    final bool isSelected = _selected.contains(label);
    
    return GestureDetector(
      onTap: () => _toggleHobby(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : AppColors.chipUnselectedBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.chipBorder, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSelected ? AppColors.chipSelectedText : AppColors.chipUnselectedText,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _saveDebouncer.dispose();
    _hobbyController.dispose();
    _hobbyFocusNode.dispose();
    super.dispose();
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
    
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.saveHobbies(_selected.toList());
    } catch (_) {}
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
            _saveDebouncer.run(() async {
              if (trimmed.isEmpty) return;
              try {
                final storage = _storage ?? await LocalStorageService.getInstance();
                await storage.saveHobbies([trimmed]);
              } catch (_) {}
            });
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
    await _setStage(1);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const JobQuestionScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }

  Future<void> _onNext() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.saveHobbies(_selected.toList());
    } catch (_) {}

    await _setStage(3);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CoachingQuestionScreen()),
    );
  }
}
