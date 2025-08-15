import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/coaching_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';

/// 온보딩 3단계 - 코칭 받고 싶은 부업 입력 화면
class CoachingInputScreen extends StatefulWidget {
  const CoachingInputScreen({super.key});

  @override
  State<CoachingInputScreen> createState() => _CoachingInputScreenState();
}

class _CoachingInputScreenState extends State<CoachingInputScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 24.0;

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
          child: Center(child: OnboardingProgress(currentStep: 3)),  // 4단계 중 네번째
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '코칭 받고 싶은 부업을 알려줘!',
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
          onSubmitted: (_) => _onSubmit(),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _isValid ? _onSubmit : null,
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

  Future<void> _onSubmit() async {
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
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
