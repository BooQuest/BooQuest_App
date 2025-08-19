import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';
import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';

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

class _SideJobRecommendationsScreenState extends State<SideJobRecommendationsScreen> with TickerProviderStateMixin {
  static const double _horizontalPadding = 20.0;
  static const double _cardSpacing = 12.0;

  String _characterName = '';
  bool _isLoading = false;
  int? _selectedCardIndex;
  late final AnimationController _selectionController;
  late final Animation<double> _selectionScale;
  late final Animation<double> _selectionOpacity;

  @override
  void initState() {
    super.initState();
    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _selectionScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeInOut),
    );
    _selectionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeInOut),
    );
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
          onPressed: () => Navigator.of(context).pop(),
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
        return GestureDetector(
          onTap: () => _handleCardTap(index),
          child: AnimatedBuilder(
            animation: _selectionController,
            builder: (context, child) {
              final isSelected = _selectedCardIndex == index;
              final scale = isSelected ? _selectionScale.value : 1.0;
              final opacity = isSelected ? _selectionOpacity.value : 0.0;
              
              return Transform.scale(
                scale: scale,
                child: Stack(
                  children: [
                    _SideJobCard(
                      item: _SideJobItem(
                        title: rec['title'] ?? '제목 없음',
                        subtitle: rec['description'] ?? '설명 없음',
                      ),
                      isSelected: isSelected,
                    ),
                    if (isSelected) ...[
                      // Glowing border
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Opacity(
                            opacity: opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF7BA8FF),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7BA8FF).withValues(alpha: 0.45 * opacity),
                                    blurRadius: 22,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Soft highlight overlay
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Opacity(
                            opacity: 0.06 * opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF7BA8FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Sparkle star (top-right)
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Opacity(
                          opacity: opacity,
                          child: Transform.translate(
                            offset: Offset(6 * _selectionController.value, -6 * _selectionController.value),
                            child: Transform.scale(
                              scale: 0.8 + 0.4 * _selectionController.value,
                              child: const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: Color(0xFF7BA8FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Small sparkle (bottom-left)
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Opacity(
                          opacity: opacity * 0.8,
                          child: Transform.translate(
                            offset: Offset(-5 * _selectionController.value, 5 * _selectionController.value),
                            child: Transform.rotate(
                              angle: 0.6 * _selectionController.value,
                              child: const Icon(
                                Icons.star_rate_rounded,
                                size: 10,
                                color: Color(0xFFB2C7FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: _cardSpacing),
      itemCount: widget.recommendations.length,
    );
  }

  Widget _buildBottomBar() {
    final bool hasSelection = _selectedCardIndex != null;
    
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: hasSelection ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuestStepsScreen()),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasSelection ? AppColors.buttonActive : AppColors.buttonInactive,
                  foregroundColor: AppColors.buttonText,
                  disabledBackgroundColor: AppColors.buttonInactive,
                  disabledForegroundColor: AppColors.buttonText,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('다음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }







  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  void _handleCardTap(int index) {
    setState(() {
      _selectedCardIndex = index;
    });
  }


}

class _SideJobItem {
  final String title;
  final String subtitle;
  
  const _SideJobItem({required this.title, required this.subtitle});
}

class _SideJobCard extends StatelessWidget {
  final _SideJobItem item;
  final bool isSelected;
  
  const _SideJobCard({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF0F0F0) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFFD0D0D0) : AppColors.cardBorder, 
          width: isSelected ? 2 : 1
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: const Color(0xFFD0D0D0).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.overlayLight.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: isSelected 
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : const SizedBox.shrink(),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down, size: 24, color: Colors.black),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isSelected ? const Color(0xFF4A4A4A) : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? const Color(0xFF666666) : AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildButton('빠른 수익'),
                const SizedBox(width: 12),
                _buildButton('실제 수익화 사례'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected 
                    ? AppColors.buttonActive
                    : const Color(0xFFE0E0E0),
                  foregroundColor: isSelected 
                    ? Colors.white 
                    : const Color(0xFF333333),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  side: isSelected 
                    ? BorderSide(color: AppColors.buttonActive, width: 1) 
                    : BorderSide(color: const Color(0xFFCCCCCC), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh, 
                      size: 20, 
                      color: isSelected ? Colors.white : const Color(0xFF333333)
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '다시 추천해줘', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}


