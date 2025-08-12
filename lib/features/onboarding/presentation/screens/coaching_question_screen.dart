import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/main.dart';
import 'package:booquest/features/onboarding/presentation/screens/hobby_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 온보딩 3단계 - 코칭 여부 질문 화면
/// - 상단 진행바는 3단계까지 활성화
/// - 기본: 하단 두 버튼(왼쪽 '있어!', 오른쪽 '없어. 추천해줘!')
/// - '있어!' 클릭 시: 별도 화면 전환 없이 하단이 입력 + 버튼 UI로 변경, 제목 문구도 변경
class CoachingQuestionScreen extends StatefulWidget {
  const CoachingQuestionScreen({super.key});

  @override
  State<CoachingQuestionScreen> createState() => _CoachingQuestionScreenState();
}

class _CoachingQuestionScreenState extends State<CoachingQuestionScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 24.0; // 살짝 더 올림

  // '있어!' 선택 시 사용하는 입력 폼 상태
  bool _showHaveForm = false;
  final TextEditingController _sideJobController = TextEditingController();
  final FocusNode _sideJobFocusNode = FocusNode();
  final Debouncer _saveDebouncer = Debouncer(350);
  LocalStorageService? _storage;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _sideJobController.addListener(() {
      final valid = _sideJobController.text.trim().length >= 2;
      if (_isValid != valid) {
        setState(() => _isValid = valid);
      }
    });
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

  Future<void> _loadSaved() async {
    try {
      final storage = _storage ?? await LocalStorageService.getInstance();
      // 화면 상태 복원
      final screenState = storage.getCoachingScreenState();
      setState(() {
        _showHaveForm = screenState == 1;
      });
      // 입력값 복원
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _sideJobFocusNode.unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      },
                    ),
                    const Expanded(
                      child: Center(child: OnboardingProgress(currentStep: 2)),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                Align(
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
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    // 기본 두 버튼 UI vs 입력 폼 UI 전환
    return _showHaveForm ? _buildHaveFormBar(context) : _buildChoiceBar(context);
  }

  Widget _buildChoiceBar(BuildContext context) {
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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

  Widget _buildHaveFormBar(BuildContext context) {
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
            ),
            const SizedBox(height: _inputToButtonSpacing),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: _isValid ? _onSubmitHave : null,
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
    await _completeOnboarding();
  }

  Future<void> _onSubmitHave() async {
    _sideJobFocusNode.unfocus();
    await _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.setOnboardingCompleted(true);
      await storage.clearOnboardingDetailsOnly();
      await storage.removeOnboardingStage();
    } catch (_) {}

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }
}
