import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/features/main/presentation/screens/main_screen.dart';

/// 부업 추천 화면
class SideJobRecommendationsScreen extends StatefulWidget {
  const SideJobRecommendationsScreen({super.key});

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
      final storage = await LocalStorageService.getInstance();
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
                        const SizedBox(height: 48),
                        _buildTopBar(),
                        const SizedBox(height: 40),
                        _buildTitle(),
                        const SizedBox(height: 48),
                        _buildCardList(),
                        const SizedBox(height: 100),
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.overlayLight.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.pets, size: 20, color: Colors.orange),
        ),
        const SizedBox(width: 10),
        const Text(
          'Boo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
            height: 1.35,
          ),
          children: [
            TextSpan(
              text: _characterName.isNotEmpty ? _characterName : '사용자',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const TextSpan(text: ' 에게 딱 맞는 '),
            const TextSpan(
              text: '부업을 3가지 추천',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const TextSpan(text: '할게'),
          ],
        ),
      ),
    );
  }

  Widget _buildCardList() {
    const items = [
      _SideJobItem(
        title: '제테크 릴스 인스타',
        subtitle: '적은 시간과 자본으로 시작해 수익을 창출할 수 있는 유연한 부업',
      ),
      _SideJobItem(
        title: '노션 템플릿 판매',
        subtitle: '생산성/가계부 템플릿 제작 및 판매로 지속적인 수익 창출',
      ),
      _SideJobItem(
        title: '블로그 SEO 글쓰기',
        subtitle: '키워드 분석 후 주 2회 포스팅으로 장기적 수익 모델 구축',
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => GestureDetector(
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
                  _SideJobCard(item: items[index]),
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
      ),
      separatorBuilder: (_, __) => const SizedBox(height: _cardSpacing),
      itemCount: items.length,
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
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: true, // 클릭 이벤트 제거 요청에 따라 항상 비활성화
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonActive,
                    foregroundColor: AppColors.buttonText,
                    disabledBackgroundColor: AppColors.buttonInactive,
                    disabledForegroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.refresh, size: 20, color: Colors.white),
                      SizedBox(width: 8),
                      Text('다시 추천해줘', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
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
      ),
    );
  }

  void _showConfirmationPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildConfirmationPopup(),
    );
  }

  Widget _buildConfirmationPopup() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // drag handle
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 75,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // progress (e.g., 8/10)
              const Text(
                '8/10',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              const Text(
                '메인 퀘스트 생성완료',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              const Text(
                '맘에 안 드시면 재생성 해드릴게요',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              // steps
              const _StepRow(stepLabel: '1단계', title: '블로그 기반 구축 & 운영준비', difficulty: '매우 쉬움'),
              const SizedBox(height: 12),
              const _StepRow(stepLabel: '2단계', title: '키워드 & 콘텐츠 전략 설계', difficulty: '쉬움'),
              const SizedBox(height: 12),
              const _StepRow(stepLabel: '3단계', title: '콘텐츠 1차 생산 & 초기 유입 확보', difficulty: '보통'),
              const SizedBox(height: 12),
              const _StepRow(stepLabel: '4단계', title: '콘텐츠 지속 생산 & 유입 확대', difficulty: '어려움'),
              const SizedBox(height: 12),
              Stack(
                children: [
                  const _StepRow(stepLabel: '5단계', title: '수익화 & 비즈니스 확장', difficulty: '매우 어려움'),
                  // again button overlaid on bottom center of 5th step card
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 46,
                        width: 156,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBFBFBF).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: const Text('다시 추천해줘', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // primary CTA
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _onConfirmRecommendations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonActive,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('이대로 진행하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onConfirmRecommendations() async {
    // 온보딩 데이터 초기화 및 메인(Home) 이동
    try {
      final storage = await LocalStorageService.getInstance();
      await storage.clearOnboardingDetailsOnly();
      await storage.setOnboardingCompleted(true);
    } catch (_) {}

    if (!mounted) return;
    Navigator.pop(context); // 팝업 닫기
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (_) => false,
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

    // AI 선택 애니메이션 시작
    _selectionController.forward().then((_) {
      // 애니메이션 완료 후 로딩 시작
      setState(() {
        _isLoading = true;
      });

      // Simulate AI processing delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _selectedCardIndex = null;
        });
        _selectionController.reset();
        _showConfirmationPopup();
      });
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
  
  const _SideJobCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.overlayLight.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pets, size: 24, color: Colors.orange),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down, size: 24, color: Colors.black),
              ],
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 16),
            Row(
              children: [
                _buildButton('빠른 수익'),
                const SizedBox(width: 12),
                _buildButton('실제 수익화 사례'),
              ],
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

class _StepRow extends StatelessWidget {
  final String stepLabel;
  final String title;
  final String difficulty;
  const _StepRow({required this.stepLabel, required this.title, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: step label and difficulty
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    stepLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  difficulty,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Bottom row: title with underline
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF87CEEB), // Light blue underline
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
