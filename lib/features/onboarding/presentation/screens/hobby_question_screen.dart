import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/coaching_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/job_question_screen.dart';

/// 온보딩 2단계 - 취미 질문 화면 (선택지 방식)
class HobbyQuestionScreen extends StatefulWidget {
  const HobbyQuestionScreen({super.key});

  @override
  State<HobbyQuestionScreen> createState() => _HobbyQuestionScreenState();
}

class _HobbyQuestionScreenState extends State<HobbyQuestionScreen> {
  static const List<String> _hobbyOptions = [
    '글쓰기', '요리', '악기연주',
    '사진촬영', '운동', '독서',
    '여행', '제테크', '드로잉',
    '자격증', '스펙', '경험',
    '크리에이터', '전문 프리랜서', '판매',
    '강의/컨설팅', '서비스직',
  ];

  final Set<String> _selected = <String>{};
  LocalStorageService? _storage;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;
  static const double _topRowCompensation = 16.0;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _loadSavedHobbies();
    _setStage(2);
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
          child: Center(child: OnboardingProgress(currentStep: 1)),
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
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _hobbyOptions.map((label) => _buildChoiceChip(label)).toList(),
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

  Widget _buildBottomBar() {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bool canProceed = _selected.isNotEmpty;

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
      ),
    );
  }

  Future<void> _toggleHobby(String label) async {
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
