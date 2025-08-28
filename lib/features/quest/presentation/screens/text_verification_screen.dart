import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';

/// 텍스트 인증 화면 - 부업 활동에 관한 소감을 간단히 남기기
class TextVerificationScreen extends ConsumerStatefulWidget {
  const TextVerificationScreen({super.key});

  @override
  ConsumerState<TextVerificationScreen> createState() => _TextVerificationScreenState();
}

class _TextVerificationScreenState extends ConsumerState<TextVerificationScreen> {
  int _currentIndex = 1; // Quest 탭이 선택된 상태
  final TextEditingController _textController = TextEditingController();
  static const int maxLength = 500;

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuestScreen(),
    const MyRecordScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Home 화면
            const HomeScreen(),
            // Quest 화면 (현재 화면)
            _buildTextVerificationContent(),
            // MyRecord 화면
            const MyRecordScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  /// 텍스트 인증 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildTextVerificationContent() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(),
                const SizedBox(height: 40),
                _buildTextInputField(),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: _buildVerifyButton(),
        ),
      ],
    );
  }

  /// 상단 바 구성 (quest_screen.dart와 동일한 구조)
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 뒤로가기 버튼 (왼쪽)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            // 중앙 제목
            const Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // 설정 버튼 (오른쪽)
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () {
                    // TODO: 설정 화면으로 이동
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 제목 섹션
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 메인 제목 (2줄로 분리)
        const Text(
          '부업 활동에 관한 소감을',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        const Text(
          '간단히 남겨주세요',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        // 부제목/설명
        const Text(
          '짧게 적어도 충분해요.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// 텍스트 입력 필드
  Widget _buildTextInputField() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (value) {
                setState(() {
                  // 텍스트 변경 시 UI 업데이트
                });
              },
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: '인증 소감을 작성해주세요. ex: 블로그 글 1편 작성 완료!',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // 글자 수 카운터
          Text(
            '${_textController.text.length}/$maxLength',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// 인증하기 버튼
  Widget _buildVerifyButton() {
    final isEnabled = _textController.text.trim().isNotEmpty;
    
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: isEnabled ? _onVerifyPressed : null,
        child: Text(
          '인증하기',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isEnabled ? AppColors.white : AppColors.textSecondary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  /// 인증하기 버튼 클릭 처리
  void _onVerifyPressed() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    
    // 텍스트 인증 처리
    print('텍스트 인증 처리: $text');
    
    // 인증 완료 후 완료 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCompleteScreen(
          method: 'text',
          content: text,
        ),
      ),
    );
  }
}
