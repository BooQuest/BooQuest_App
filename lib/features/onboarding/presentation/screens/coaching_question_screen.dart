import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/hobby_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';
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
  static const double _topSpacing = 120.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 24.0;

  bool _showHaveForm = false;
  bool _isLoading = false;
  final TextEditingController _sideJobController = TextEditingController();
  final FocusNode _sideJobFocusNode = FocusNode();
  final Debouncer _saveDebouncer = Debouncer(350);
  LocalStorageService? _storage;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _sideJobController.addListener(_validateInput);
    _loadSaved();
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

  void _validateInput() {
    final valid = _sideJobController.text.trim().length >= 2;
    if (_isValid != valid) {
      setState(() => _isValid = valid);
    }
  }

  Future<void> _loadSaved() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      final screenState = storage.getCoachingScreenState();
      setState(() {
        _showHaveForm = screenState == 1;
      });
      
      final saved = storage.getCoachingSideJob();
      if (saved != null && saved.isNotEmpty) {
        setState(() {
          _sideJobController.text = saved;
          _isValid = true;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _saveDebouncer.dispose();
    final text = _sideJobController.text.trim();
    if (text.isNotEmpty) {
      _storage?.saveCoachingSideJob(text);
    }
    _sideJobController.dispose();
    _sideJobFocusNode.dispose();
    super.dispose();
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
                    onTap: () => _sideJobFocusNode.unfocus(),
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
            title: 'AI가 추천을 탐색 중...',
            subtitle: '취향, 패턴, 목표를 분석하고 있어요',
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
          child: Center(child: OnboardingProgress(currentStep: 2)),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _showHaveForm ? '코칭 받고 싶은 부업을 알려줘!' : '코칭 받고 싶은 부업이 있어?',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return _showHaveForm ? _buildHaveFormBar() : _buildChoiceBar();
  }

  Widget _buildChoiceBar() {
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

  Widget _buildHaveFormBar() {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
            _buildInputField(),
            const SizedBox(height: _inputToButtonSpacing),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
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
          controller: _sideJobController,
          focusNode: _sideJobFocusNode,
          onChanged: (v) {
            final trimmed = v.trim();
            _saveDebouncer.run(() async {
              if (trimmed.isEmpty) return;
              try {
                final storage = _storage ?? await LocalStorageService.getInstance();
                await storage.saveCoachingSideJob(trimmed);
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
            hintText: '마케팅 프리랜서',
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: 18,
            ),
          ),
          textInputAction: TextInputAction.done,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onSubmitted: (_) => _onSubmitHave(),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _isValid ? _onSubmitHave : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isValid ? AppColors.buttonActive : AppColors.buttonInactive,
          foregroundColor: AppColors.buttonText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          '확인',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }



  Future<void> _persistScreenState(int state) async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.setCoachingScreenState(state);
    } catch (_) {}
  }

  void _onHave() {
    setState(() => _showHaveForm = true);
    _persistScreenState(1);
  }

  Future<void> _onRecommend() async {
    _showLoadingAndNavigate();
  }

  Future<void> _onSubmitHave() async {
    _sideJobFocusNode.unfocus();
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
