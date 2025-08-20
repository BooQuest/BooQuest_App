import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/core/navigation/transitions.dart';

import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_method_selection_screen.dart';

/// 부업 추천 화면
class SideJobRecommendationsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> recommendations;
  
  const SideJobRecommendationsScreen({
    super.key,
    required this.recommendations,
  });

  @override
  State<SideJobRecommendationsScreen> createState() => _SideJobRecommendationsScreenState();
}

class _SideJobRecommendationsScreenState extends State<SideJobRecommendationsScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _cardSpacing = 12.0;

  String _characterName = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCharacterName();
  }

  Future<void> _loadCharacterName() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final name = storage.getCharacterName();
      if (name != null && name.isNotEmpty) {
        setState(() => _characterName = name);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildTopBar(),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 20),
                        _buildCardList(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(),

              ],
            ),
          ),
          if (_isLoading) const AILoadingOverlay(
            title: 'AI가 추천을 탐색 중...',
            subtitle: '취향, 패턴, 목표를 분석하고 있어요',
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: _handleBack,
        ),
        const Expanded(
          child: Center(child: Text('부업 추천 3가지', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
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
              Text(
                '${_characterName.isNotEmpty ? _characterName : '사용자'} 에게 딱 맞는\n부업을 3가지 추천할게',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '재생성을 원하거나 맘에드는 부업을 선택해 주세요.',
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
        const SizedBox(width: 12),
        SizedBox(
          width: 39,
          height: 39,
          child: SvgPicture.asset(
            'assets/images/characters/basic_icon_1.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildCardList() {
    // 전달받은 recommendations 데이터 사용
    if (widget.recommendations.isEmpty) {
      return const Center(
        child: Text(
          '부업 추천 데이터가 없습니다.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final rec = widget.recommendations[index];
        return _SideJobCard(
          item: _SideJobItem(
            title: rec['title'] ?? '제목 없음',
            subtitle: rec['description'] ?? '설명 없음',
          ),
          onSelect: () => _handleCardSelect(index),
          onRecommendAgain: () => _handleRecommendAgain(index),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: _cardSpacing),
      itemCount: widget.recommendations.length,
    );
  }



  @override
  void dispose() {
    super.dispose();
  }

  void _handleCardSelect(int index) {
    // 선택하기 버튼 클릭 시 다음 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuestStepsScreen()),
    );
  }

  void _handleRecommendAgain(int index) {
    print('다시 추천받기: $index');
  }

  Future<void> _handleBack() async {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step4MethodSelectionScreen(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              // TODO: 전체 재생성 로직 구현
              print('전체 재생성하기');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonActive,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('전체 재생성하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }


}

class _SideJobItem {
  final String title;
  final String subtitle;
  
  const _SideJobItem({required this.title, required this.subtitle});
}

class _SideJobCard extends StatelessWidget {
  final _SideJobItem item;
  final VoidCallback onSelect;
  final VoidCallback onRecommendAgain;
  
  const _SideJobCard({
    required this.item, 
    required this.onSelect, 
    required this.onRecommendAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.cardBorder, 
          width: 1
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: onRecommendAgain,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F5F5),
                        foregroundColor: const Color(0xFF666666),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '다시 추천받기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onSelect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonActive,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        '선택하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


