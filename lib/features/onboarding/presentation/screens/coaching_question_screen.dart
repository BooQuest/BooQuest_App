import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/coaching_input_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';

/// 온보딩 3단계 - 코칭 여부 질문 화면
class CoachingQuestionScreen extends StatefulWidget {
  const CoachingQuestionScreen({super.key});

  @override
  State<CoachingQuestionScreen> createState() => _CoachingQuestionScreenState();
}

class _CoachingQuestionScreenState extends State<CoachingQuestionScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 24.0;

  bool _isLoading = false;
  LocalStorageService? _storage;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _setStage(3);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
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
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
          ),
          if (_isLoading) const AILoadingOverlay(
            title: 'AI가 당신에게 맞는\n부업을 분석하고 있어요...',
            subtitle: '',
          ),
        ],
      ),
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
          child: Center(child: OnboardingProgress(currentStep: 2)),  // 4단계 중 세번째
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '코칭 받고 싶은 부업이 있어?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _onHave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonSecondary,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    '있어!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _onRecommend,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonActive,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    '없어. 추천해줘!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onHave() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CoachingInputScreen()),
    );
  }

  Future<void> _onRecommend() async {
    _showLoadingAndNavigate();
  }

  void _showLoadingAndNavigate() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _goToRecommendations();
      }
    });
  }

  Future<void> _goToRecommendations() async {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SideJobRecommendationsScreen()),
    );
  }

  Future<void> _goBack() async {
    await _setStage(2);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const HobbyQuestionScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }
}
