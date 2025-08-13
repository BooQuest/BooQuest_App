import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/job_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 캐릭터 생성 화면
class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() => _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final Debouncer _saveDebouncer = Debouncer(350);
  LocalStorageService? _storage;
  bool _isNameValid = false;

  static const double _horizontalPadding = 20.0;
  static const double _topSpacing = 120.0;
  static const double _avatarToTextSpacing = 20.0;
  static const double _textToInputSpacing = 120.0;
  static const double _inputToButtonSpacing = 15.0;
  static const double _bottomSpacing = 60.0;

  @override
  void initState() {
    super.initState();
    _initStorage();
    _nameController.addListener(_validateName);
    _loadSavedCharacterName();
    _setStage(0);
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
  
  Future<void> _loadSavedCharacterName() async {
    try {
      final localStorage = _storage ?? await LocalStorageService.getInstance();
      final savedName = localStorage.getCharacterName();
      setState(() {
        if (savedName != null && savedName.isNotEmpty) {
          _nameController.text = savedName;
          _isNameValid = true;
        } else {
          _nameController.text = ''; // 명시적으로 지우기
          _isNameValid = false;
        }
      });
    } catch (e) {
      debugPrint('저장된 이름 불러오기 실패: $e');
    }
  }

  @override
  void dispose() {
    _saveDebouncer.dispose();
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      _storage?.saveCharacterName(name);
    }
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _validateName() {
    final isValid = _nameController.text.trim().length >= 2;
    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
  }

  Future<void> _onConfirmPressed() async {
    if (_isNameValid) {
      final name = _nameController.text.trim();
      debugPrint('캐릭터 이름: $name');
      
      try {
        final localStorage = _storage ?? await LocalStorageService.getInstance();
        await localStorage.saveCharacterName(name);
      } catch (e) {
        debugPrint('캐릭터 이름 저장 중 오류: $e');
      }
      
      _nameFocusNode.unfocus();
      await _setStage(1);
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const JobQuestionScreen()),
        );
      }
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
                const SizedBox(height: _topSpacing),
                _buildCharacterAvatar(),
                const SizedBox(height: _avatarToTextSpacing),
                _buildWelcomeText(),
                const SizedBox(height: _textToInputSpacing),
                _buildNameInputField(),
                const SizedBox(height: _inputToButtonSpacing),
                _buildConfirmButton(),
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      '안녕! 너의 부업을 도울 Boo야\n내가 너를 뭐라고 부르면 좋을까?',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCharacterAvatar() {
    return Container(
      width: 116,
      height: 116,
      decoration: BoxDecoration(
        color: AppColors.overlayLight.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.pets,
        size: 48,
        color: Colors.grey,
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
          onChanged: (v) {
            final trimmed = v.trim();
            _saveDebouncer.run(() async {
              try {
                final storage = _storage ?? await LocalStorageService.getInstance();
                if (trimmed.isEmpty) {
                  await storage.removeCharacterName();
                  _nameController.clear();
                } else {
                  await storage.saveCharacterName(trimmed);
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
      child: ElevatedButton(
        onPressed: _isNameValid ? _onConfirmPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isNameValid 
              ? AppColors.buttonActive
              : AppColors.buttonInactive,
          foregroundColor: AppColors.buttonText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          '확인',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
