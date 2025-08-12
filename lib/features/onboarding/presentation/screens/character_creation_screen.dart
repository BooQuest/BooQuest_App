import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/features/onboarding/presentation/screens/job_question_screen.dart';
import 'package:booquest/core/utils/debouncer.dart';

/// 캐릭터 생성 화면
/// Figma 디자인에 맞춰 반응형으로 구현
/// 성능 최적화 적용: const 생성자, 불필요한 rebuild 방지
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

  static const double _horizontalPadding = 20.0;   // Figma 기준
  static const double _topSpacing = 120.0;       // 상태바 아래 여백 더 증가 (80 → 120)
  static const double _avatarToTextSpacing = 20.0; // 아바타와 텍스트 사이 20px
  static const double _textToInputSpacing = 120.0; // 텍스트와 입력 필드 사이 간격 더 줄임 (150 → 120)
  static const double _inputToButtonSpacing = 15.0; // 입력 필드와 버튼 사이 15px
  static const double _bottomSpacing = 60.0;      // 하단 여백 더 줄임 (80 → 60)

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
  
  /// 저장된 캐릭터 이름 불러오기
  Future<void> _loadSavedCharacterName() async {
    try {
      final localStorage = _storage ?? await LocalStorageService.getInstance();
      final savedName = localStorage.getCharacterName();
      if (savedName != null && savedName.isNotEmpty) {
        setState(() {
          _nameController.text = savedName;
          _isNameValid = true;
        });
      }
    } catch (e) {
      debugPrint('저장된 이름 불러오기 실패: $e');
    }
  }

  @override
  void dispose() {
    _saveDebouncer.dispose();
    // 마지막 값 한 번 더 저장
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      _storage?.saveCharacterName(name);
    }
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  /// 이름 유효성 검사 (2글자 이상) - 불필요한 setState 방지
  void _validateName() {
    final isValid = _nameController.text.trim().length >= 2;
    if (_isNameValid != isValid) {
      setState(() {
        _isNameValid = isValid;
      });
    }
  }

  /// 확인 버튼 클릭 처리
  Future<void> _onConfirmPressed() async {
    if (_isNameValid) {
      final name = _nameController.text.trim();
      debugPrint('캐릭터 이름: $name');
      
      // 로컬 스토리지에 이름 저장 (최종)
      try {
        final localStorage = _storage ?? await LocalStorageService.getInstance();
        await localStorage.saveCharacterName(name);
      } catch (e) {
        debugPrint('캐릭터 이름 저장 중 오류: $e');
      }
      
      // 키보드 숨기기
      _nameFocusNode.unfocus();

      // 다음 단계 스테이지 기록
      await _setStage(1);
      
      // 다음 온보딩 단계(직업 질문)로 이동 - 기본 전환 유지
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
          onTap: () {
            // 입력 필드 외부 터치 시 포커스 해제 및 키보드 숨기기
            _nameFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: _topSpacing),
                
                // 캐릭터 아바타
                _buildCharacterAvatar(),
                
                const SizedBox(height: _avatarToTextSpacing),
                
                // 환영 메시지
                _buildWelcomeText(),
                
                const SizedBox(height: _textToInputSpacing),
                
                // 이름 입력 필드
                _buildNameInputField(),
                
                const SizedBox(height: _inputToButtonSpacing),
                
                // 확인 버튼
                _buildConfirmButton(),
                
                const SizedBox(height: _bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 환영 메시지 텍스트
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

  /// 캐릭터 아바타
  Widget _buildCharacterAvatar() {
    return Container(
      width: 116,
      height: 116,
      decoration: BoxDecoration(
        color: AppColors.overlayLight.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.avatarIcon,
            border: Border.all(
              color: AppColors.avatarBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  /// 이름 입력 필드
  Widget _buildNameInputField() {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.centerLeft, // 세로 중앙 정렬
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
              if (trimmed.isEmpty) return;
              try {
                final storage = _storage ?? await LocalStorageService.getInstance();
                await storage.saveCharacterName(trimmed);
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

  /// 확인 버튼
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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
