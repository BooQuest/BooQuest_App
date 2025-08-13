import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/character_creation_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 온보딩 1단계 - 직업 질문 화면
class JobQuestionScreen extends StatefulWidget {
  const JobQuestionScreen({super.key});

  @override
  State<JobQuestionScreen> createState() => _JobQuestionScreenState();
}

class _JobQuestionScreenState extends State<JobQuestionScreen> {
  final TextEditingController _jobController = TextEditingController();
  final FocusNode _jobFocusNode = FocusNode();
  final Debouncer _saveDebouncer = Debouncer(350);
  LocalStorageService? _storage;
  bool _isValid = false;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;
  static const double _titleToInputSpacing = 120.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 16.0;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _jobController.addListener(_validateJob);
    _loadSavedJob();
    _setStage(1);
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

  void _validateJob() {
    final valid = _jobController.text.trim().length >= 2;
    if (_isValid != valid) {
      setState(() => _isValid = valid);
    }
  }

  Future<void> _loadSavedJob() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      final saved = storage.getJob();
      setState(() {
        if (saved != null && saved.isNotEmpty) {
          _jobController.text = saved;
          _isValid = true;
        } else {
          _jobController.text = ''; // 명시적으로 지우기
          _isValid = false;
        }
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _saveDebouncer.dispose();
    final job = _jobController.text.trim();
    if (job.isNotEmpty) {
      _storage?.saveJob(job);
    }
    _jobController.dispose();
    _jobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _jobFocusNode.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                _buildTopRow(),
                const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                _buildTitle(),
                const SizedBox(height: _titleToInputSpacing),
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
          child: Center(child: OnboardingProgress(currentStep: 0)),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '직업이 뭐야?',
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
          controller: _jobController,
          focusNode: _jobFocusNode,
          onChanged: (v) {
            final trimmed = v.trim();
            _saveDebouncer.run(() async {
              try {
                final storage = _storage ?? await LocalStorageService.getInstance();
                if (trimmed.isEmpty) {
                  await storage.removeJob();
                  _jobController.clear();
                } else {
                  await storage.saveJob(trimmed);
                }
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
            hintText: '마케팅 어시스턴트',
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: 18,
            ),
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _onConfirm(),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _isValid ? _onConfirm : null,
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

  Future<void> _goBack() async {
    await _setStage(0);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const CharacterCreationScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }

  Future<void> _onConfirm() async {
    _jobFocusNode.unfocus();
    final job = _jobController.text.trim();
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.saveJob(job);
    } catch (_) {}

    await _setStage(2);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HobbyQuestionScreen()),
    );
  }
}
