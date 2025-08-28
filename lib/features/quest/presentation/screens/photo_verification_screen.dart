import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';

/// 사진 인증 화면 - 부업 활동에 관한 모습을 간단히 남기기
class PhotoVerificationScreen extends ConsumerStatefulWidget {
  const PhotoVerificationScreen({super.key});

  @override
  ConsumerState<PhotoVerificationScreen> createState() => _PhotoVerificationScreenState();
}

class _PhotoVerificationScreenState extends ConsumerState<PhotoVerificationScreen> {
  int _currentIndex = 1; // Quest 탭이 선택된 상태
  List<String> _selectedImages = []; // 선택된 이미지들

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
            _buildPhotoVerificationContent(),
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

  /// 사진 인증 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildPhotoVerificationContent() {
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
                _buildPhotoUploadSection(),
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
          '부업 활동에 관한 모습을',
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
        const SizedBox(height: 24),
        // 부제목/설명 (2줄로 분리)
        const Text(
          '결과물에 대한 사진을 자유롭게 인증해 주세요',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
        const Text(
          '(ex.블로그 작성 중인 모니터 사진)',
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

  /// 사진 업로드 섹션
  Widget _buildPhotoUploadSection() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.cardBorder.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: _selectedImages.isNotEmpty
          ? Stack(
              children: [
                // 선택된 이미지 표시 (예시로 플레이스홀더)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                // 편집 버튼 (우상단)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 60,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '메인 사진을 선택해주세요',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// 인증하기 버튼
  Widget _buildVerifyButton() {
    final isEnabled = _selectedImages.isNotEmpty;
    
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
    if (_selectedImages.isEmpty) return;
    
    // 사진 인증 처리
    print('사진 인증 처리: ${_selectedImages.length}장의 사진');
    
    // 인증 완료 후 완료 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCompleteScreen(
          method: 'photo',
          content: _selectedImages.join(', '),
        ),
      ),
    );
  }
}
