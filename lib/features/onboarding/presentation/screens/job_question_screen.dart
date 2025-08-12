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

  // 캐릭터 생성 화면과 동일한 간격 사용
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0; // 상단 여백
  static const double _titleToInputSpacing = 120.0; // 질문과 입력 필드(하단)에 대한 시각적 여백
  static const double _inputToButtonSpacing = 15.0; // 입력과 버튼 간 여백
  static const double _topRowCompensation = 16.0; // 상단 Row 높이 보정치

  @override
  void initState() {
    super.initState();
    _initStorage();
    _jobController.addListener(() {
      final valid = _jobController.text.trim().length >= 2;
      if (_isValid != valid) {
        setState(() => _isValid = valid);
      }
    });
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

  // 저장된 직업 불러와서 입력 필드에 반영
  Future<void> _loadSavedJob() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      final saved = storage.getJob();
      if (saved != null && saved.isNotEmpty) {
        setState(() {
          _jobController.text = saved;
          _isValid = true;
        });
      }
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _jobFocusNode.unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                // 상단: 뒤로가기 + 중앙 진행바
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () async {
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
                      },
                    ),
                    const Expanded(
                      child: Center(child: OnboardingProgress(currentStep: 0)),
                    ),
                    const SizedBox(width: 40), // 균형을 위한 우측 여백
                  ],
                ),
                const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                const Align(
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
                ),
                const SizedBox(height: _titleToInputSpacing),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom; // 키보드 높이
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + bottomInset, // 키보드가 올라오면 그만큼 올림
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 입력 필드 (버튼 바로 위)
            Container(
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
                      if (trimmed.isEmpty) return;
                      try {
                        final storage = _storage ?? await LocalStorageService.getInstance();
                        await storage.saveJob(trimmed);
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
            ),

            const SizedBox(height: _inputToButtonSpacing),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: _isValid ? _onConfirm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isValid ? AppColors.buttonActive : AppColors.buttonInactive,
                  foregroundColor: AppColors.buttonText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirm() async {
    _jobFocusNode.unfocus();
    final job = _jobController.text.trim();
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      await storage.saveJob(job);
    } catch (_) {}

    // 다음 스테이지 기록 (2: hobby)
    await _setStage(2);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HobbyQuestionScreen()),
    );
  }
}
