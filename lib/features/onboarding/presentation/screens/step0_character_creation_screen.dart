import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/onboarding/presentation/screens/step1_job_question_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step0_character_selection_screen.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/utils/debouncer.dart';
import 'package:booquest/core/navigation/transitions.dart';

/// 온보딩 0단계 - 캐릭터 생성 화면
class Step0CharacterCreationScreen extends StatefulWidget {
  const Step0CharacterCreationScreen({super.key});

  @override
  State<Step0CharacterCreationScreen> createState() => _Step0CharacterCreationScreenState();
}

class _Step0CharacterCreationScreenState extends State<Step0CharacterCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isNameValid = false;
  
  // Debouncer 추가
  late final Debouncer _saveDebouncer;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 80.0;
  static const double _avatarToTextSpacing = 20.0;
  static const double _textToCharacterSpacing = 40.0;
  static const double _characterToInputSpacing = 60.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _topRowCompensation = 16.0;

  @override
  void initState() {
    super.initState();
    _saveDebouncer = Debouncer(OnboardingDebouncer.inputDelay);
    _nameController.addListener(_onNameChanged);
    _saveCurrentStep();
    _loadSavedCharacterName(); // 저장된 캐릭터 이름 불러오기
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _nameFocusNode.dispose();
    _saveDebouncer.dispose();
    super.dispose();
  }

  /// 현재 온보딩 단계 저장
  Future<void> _saveCurrentStep() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCurrentStep(0);
      await storage.setCharacterScreenType('creation');
    } catch (error) {
      print('❌ 현재 온보딩 단계 저장 실패: $error');
    }
  }

  /// 저장된 캐릭터 이름 불러오기
  Future<void> _loadSavedCharacterName() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final savedName = storage.getCharacterName();
      if (savedName != null && savedName.isNotEmpty) {
        _nameController.text = savedName;
        setState(() {
          _isNameValid = true;
        });
      }
    } catch (error) {
      print('❌ 저장된 캐릭터 이름 불러오기 실패: $error');
    }
  }

  void _onNameChanged() {
    final isValid = _nameController.text.trim().length >= 2;
    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
    
    // 실시간 저장 (Debouncer 적용) - 빈 상태도 저장
    _saveDebouncer.run(() => _saveCharacterNameRealtime());
  }

  void _goBack() async {
    await _saveCurrentStep();
    
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step0CharacterSelectionScreen(),
      ),
    );
  }

  void _onConfirmPressed() async {
    if (_isNameValid) {
      final name = _nameController.text.trim();
      
      // 캐릭터 이름을 local storage에 저장
      await _saveCharacterName(name);
      
      _nameFocusNode.unfocus();
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Step1JobQuestionScreen()),
        );
      }
    }
  }

  /// 실시간 저장 (Debouncer 적용)
  Future<void> _saveCharacterNameRealtime() async {
    final name = _nameController.text.trim();
    await _saveCharacterName(name);
  }

  /// 캐릭터 이름 저장
  Future<void> _saveCharacterName(String name) async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      await storage.setCharacterName(name);
    } catch (error) {
      print('❌ 캐릭터 이름 저장 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _nameFocusNode.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildTopRow(),
                const SizedBox(height: _topSpacing - 40 - _topRowCompensation),
                _buildTitle(),
                const SizedBox(height: 40),
                _buildCharacterSection(),
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
          onPressed: _goBack,
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '어떻게 불러드리면 될까요?',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildCharacterSection() {
    return Center(
      child: Image.asset(
        'assets/images/characters/create_char.png',
        height: 400,
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
            _buildNameInputField(),
            const SizedBox(height: _inputToButtonSpacing),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInputField() {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(
          color: AppColors.inputBorder,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '이름을 입력하세요',
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: 18,
            ),
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _onConfirmPressed(),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: Container(
        decoration: BoxDecoration(
          color: _isNameValid 
              ? const Color(0xFF1976D2) // 파란색 배경
              : const Color(0xFFCCCCCC), // 비활성화 시 회색
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isNameValid ? _onConfirmPressed : null,
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                '확인',
                style: TextStyle(
                  color: _isNameValid ? Colors.white : Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}