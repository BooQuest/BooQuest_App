import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/quest/presentation/screens/link_verification_screen.dart';
import 'package:booquest/features/quest/presentation/screens/text_verification_screen.dart';
import 'package:booquest/features/quest/presentation/screens/photo_verification_screen.dart';

/// 퀘스트 인증 화면 - 퀘스트 수행 결과를 간단하게 인증
class QuestVerificationScreen extends ConsumerStatefulWidget {
  final int stepId;
  
  const QuestVerificationScreen({
    super.key,
    required this.stepId,
  });

  @override
  ConsumerState<QuestVerificationScreen> createState() => _QuestVerificationScreenState();
}

class _QuestVerificationScreenState extends ConsumerState<QuestVerificationScreen> {
  String? _selectedVerificationMethod; // 선택된 인증 방식
  int _currentIndex = 1; // Quest 탭이 선택된 상태

  // 반응형을 위한 화면 크기 계산 (home_screen.dart와 동일한 구조)
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

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
            _buildQuestVerificationContent(),
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

  /// Quest 인증 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildQuestVerificationContent() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20, vertical: _isSmallScreen ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(),
                SizedBox(height: _isSmallScreen ? 32 : 40),
                _buildVerificationOptions(),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
          child: _buildNextButton(),
        ),
      ],
    );
  }

  /// 상단 바 구성 (quest_screen.dart와 동일한 구조)
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: _isSmallScreen ? 44 : 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 뒤로가기 버튼 (왼쪽)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: _isSmallScreen ? 36 : 40,
                height: _isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textPrimary,
                    size: _isSmallScreen ? 18 : 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            // 중앙 제목
            Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // 설정 버튼 (오른쪽)
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: _isSmallScreen ? 36 : 40,
                height: _isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () {
                    // TODO: 설정 화면으로 이동
                  },
                  icon: Icon(
                    Icons.settings,
                    color: AppColors.textPrimary,
                    size: _isSmallScreen ? 18 : 20,
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
        Text(
          '퀘스트 수행 결과를',
          style: TextStyle(
            fontSize: _isSmallScreen ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        Text(
          '간단하게 인증해주세요',
          style: TextStyle(
            fontSize: _isSmallScreen ? 22 : 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        SizedBox(height: _isSmallScreen ? 20 : 24),
        // 부제목/설명
        Text(
          '수정한 부업에 관한 인증 방식을 1가지 선택해주세요.',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// 인증 방식 선택 옵션들
  Widget _buildVerificationOptions() {
    return Column(
      children: [
        _buildVerificationOption(
          title: '링크',
          subtitle: 'ex.블로그, SNS, 포스타입, 노션 등',
          icon: Icons.link,
          value: 'link',
        ),
        SizedBox(height: _isSmallScreen ? 12 : 16),
        _buildVerificationOption(
          title: '텍스트',
          subtitle: 'ex.작성한 글',
          icon: Icons.text_fields,
          value: 'text',
        ),
        SizedBox(height: _isSmallScreen ? 12 : 16),
        _buildVerificationOption(
          title: '사진',
          subtitle: 'ex.모니터 캡처본',
          icon: Icons.photo_camera,
          value: 'photo',
        ),
      ],
    );
  }

  /// 인증 방식 선택 옵션 아이템
  Widget _buildVerificationOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = _selectedVerificationMethod == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVerificationMethod = value;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(_isSmallScreen ? 12 : 16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.cardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // 아이콘
            Container(
              width: _isSmallScreen ? 42 : 48,
              height: _isSmallScreen ? 42 : 48,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
              ),
              child: Icon(
                icon,
                size: _isSmallScreen ? 20 : 24,
                color: isSelected ? AppColors.white : AppColors.textSecondary,
              ),
            ),
            SizedBox(width: _isSmallScreen ? 12 : 16),
            // 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: _isSmallScreen ? 3 : 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.8) : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // 선택 표시
            if (isSelected)
              Container(
                width: _isSmallScreen ? 20 : 24,
                height: _isSmallScreen ? 20 : 24,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: _isSmallScreen ? 14 : 16,
                  color: AppColors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 다음 버튼
  Widget _buildNextButton() {
    final isEnabled = _selectedVerificationMethod != null;
    
    return Container(
      width: double.infinity,
      height: _isSmallScreen ? 50 : 56,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(_isSmallScreen ? 10 : 12),
      ),
      child: TextButton(
        onPressed: isEnabled ? _onNextPressed : null,
        child: Text(
          '다음',
          style: TextStyle(
            fontSize: _isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: isEnabled ? AppColors.white : AppColors.textSecondary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  /// 다음 버튼 클릭 처리
  void _onNextPressed() {
    if (_selectedVerificationMethod == null) return;
    
    // 선택된 인증 방식에 따른 화면 전환
    if (_selectedVerificationMethod == 'link') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LinkVerificationScreen(stepId: widget.stepId),
        ),
      );
    } else if (_selectedVerificationMethod == 'text') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TextVerificationScreen(stepId: widget.stepId),
        ),
      );
    } else if (_selectedVerificationMethod == 'photo') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoVerificationScreen(stepId: widget.stepId),
        ),
      );
    }
  }

  
}
