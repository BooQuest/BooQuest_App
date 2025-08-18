import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/widgets/onboarding_progress.dart';
import 'package:booquest/features/onboarding/presentation/screens/step2_hobby_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_creation_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 온보딩 1단계 - 직업 질문 화면
class Step1JobQuestionScreen extends StatefulWidget {
  const Step1JobQuestionScreen({super.key});

  @override
  State<Step1JobQuestionScreen> createState() => _Step1JobQuestionScreenState();
}

class _Step1JobQuestionScreenState extends State<Step1JobQuestionScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _topRowCompensation = 16.0;
  static const double _titleToInputSpacing = 120.0; // 제목과 입력 필드 사이 간격
  static const double _inputToButtonSpacing = 15.0; // 입력 필드와 버튼 사이 간격

  final TextEditingController _jobController = TextEditingController();
  final FocusNode _jobFocusNode = FocusNode();
  bool _isValid = false;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;

  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _jobController.addListener(_onJobChanged);
    _saveCurrentStep();
    _loadSavedJob(); 
  }

  @override
  void dispose() {
    _jobController.removeListener(_onJobChanged);
    _jobController.dispose();
    _jobFocusNode.dispose();
    _saveDebouncer.dispose();
    super.dispose();
  }

  void _onJobChanged() {
    final isValid = _jobController.text.trim().length >= 2;
    if (_isValid != isValid) {
      setState(() => _isValid = isValid);
    }
    
    // 실시간 저장 (Debouncer 적용) - 빈 상태도 저장
    _saveDebouncer.run(() => _saveJobRealtime());
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
          child: Center(child: OnboardingProgress(currentStep: 0)),  // 5단계 중 첫 번째
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
                '혹시 지금 어떤 일을\n하고 계신가요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '더 잘 맞는 부업과 가이드를 준비해 드릴 수 있어요',
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

  void _goBack() async {
    await _saveCurrentStep();
    
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, a, sa) => const Step0CharacterCreationScreen(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 280),
    ));
  }

  void _onConfirm() async {
    _jobFocusNode.unfocus();
    
    // 직업 데이터를 local storage에 저장
    await _saveJob();
    
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Step2HobbyQuestionScreen()),
    );
  }

  /// 직업 데이터 저장
  Future<void> _saveJob() async {
    try {
      final storage = await LocalStorageService.getInstance();
      final job = _jobController.text.trim();
      await storage.saveJob(job);
    } catch (error) {
      print('❌ 직업 저장 실패: $error');
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveJobRealtime() async {
    try {
      final storage = await LocalStorageService.getInstance();
      final job = _jobController.text.trim();
      await storage.saveJob(job);
      print('💾 직업 저장됨: "${job.isEmpty ? "(빈 값)" : job}"');
    } catch (error) {
      print('❌ 직업 실시간 저장 실패: $error');
    }
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.setCurrentOnboardingStep(1);
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 직업 데이터 불러오기
  Future<void> _loadSavedJob() async {
    try {
      final storage = await LocalStorageService.getInstance();
      final savedJob = storage.getJob();
      if (savedJob != null && savedJob.isNotEmpty) {
        _jobController.text = savedJob;
        setState(() {
          _isValid = true;
        });
      }
    } catch (error) {
      print('❌ 저장된 직업 데이터 불러오기 실패: $error');
    }
  }
}
