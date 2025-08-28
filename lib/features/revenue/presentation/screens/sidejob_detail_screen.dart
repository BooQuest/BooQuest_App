import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/main/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/revenue/application/providers/sidejob_summary_providers.dart';
import 'package:booquest/features/revenue/presentation/screens/total_revenue_screen.dart';
import 'package:booquest/features/revenue/application/states/sidejob_summary_state.dart';
import 'package:booquest/features/revenue/domain/entities/sidejob_summary_entity.dart';

/// 부업 프로젝트 상세 화면 - Clean Architecture + Riverpod 구조
class SidejobDetailScreen extends ConsumerStatefulWidget {
  final int userSideJobId;
  
  const SidejobDetailScreen({
    super.key,
    required this.userSideJobId,
  });

  @override
  ConsumerState<SidejobDetailScreen> createState() => _SidejobDetailScreenState();
}

class _SidejobDetailScreenState extends ConsumerState<SidejobDetailScreen> {
  int _currentIndex = 2; // MyRecord 탭이 선택된 상태

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuestScreen(),
    const MyRecordScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // userSideJobId 값 출력
    print('SidejobDetailScreen - userSideJobId: ${widget.userSideJobId}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      await ref.read(sideJobSummaryNotifierProvider.notifier).getSideJobSummary(widget.userSideJobId);
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  /// MyRecord 상세 화면 내용만 구성 (IndexedStack 내부용)
  Widget _buildMyRecordDetailContent(SideJobSummaryState summaryState) {
    return Column(
      children: [
        _buildTopBar(context, summaryState),
        _buildHeaderSection(summaryState),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildStatsSection(summaryState),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // 같은 탭 클릭 시 무시
    
    setState(() {
      _currentIndex = index;
    });
    // IndexedStack으로 화면 전환하므로 하단 탭이 유지됨
  }

  @override
  Widget build(BuildContext context) {
    final summaryState = ref.watch(sideJobSummaryNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            // Home 화면
            const HomeScreen(),
            // Quest 화면  
            const QuestScreen(),
            // MyRecord 상세 화면 (현재 화면)
            _buildMyRecordDetailContent(summaryState),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  /// 상단 바 구성
  Widget _buildTopBar(BuildContext context, SideJobSummaryState summaryState) {
    String title = '로딩 중...';
    
    summaryState.when(
      initial: () => title = '로딩 중...',
      loading: () => title = '로딩 중...',
      success: (data) => title = data.userSideJob.title,
      failure: (_) => title = '부업 프로젝트',
    );

    return Container(
      color: const Color(0xFF8A8A8A),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  /// 헤더 섹션 구성
  Widget _buildHeaderSection(SideJobSummaryState summaryState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF8A8A8A),
      ),
      child: summaryState.when(
        initial: () => _buildLoadingHeader(),
        loading: () => _buildLoadingHeader(),
        success: (data) => _buildSuccessHeader(data),
        failure: (failure) => _buildErrorHeader(failure.toString()),
      ),
    );
  }

  /// 로딩 중 헤더
  Widget _buildLoadingHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '지금까지',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(
          '로딩 중...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '0원 벌었어요!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildTag('로딩 중...'),
            const SizedBox(width: 12),
            _buildTag('로딩 중...'),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 140,
            height: 160,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  /// 성공 헤더
  Widget _buildSuccessHeader(SideJobSummaryEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '지금까지',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '${data.userSideJob.title}로',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${_formatCurrency(data.totalIncome)}원 벌었어요!',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildTag(data.period),
            const SizedBox(width: 12),
            //_buildTag('경제·사회·재테크'),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: SvgPicture.asset(
            'assets/images/characters/sidejob_test2.svg',
            width: 140,
            height: 160,
          ),
        ),
      ],
    );
  }

  /// 에러 헤더
  Widget _buildErrorHeader(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '지금까지',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(
          '부업 프로젝트로',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '0원 벌었어요!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildTag('에러 발생'),
            const SizedBox(width: 12),
            _buildTag('데이터 없음'),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 태그 위젯
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// 통계 섹션 구성
  Widget _buildStatsSection(SideJobSummaryState summaryState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40), // 하단 패딩 증가
      child: Column(
        children: [
          // 총 수익 카드
          _buildStatCard(
            label: '나의 총 수익',
            value: summaryState.when(
              initial: () => '0원',
              loading: () => '로딩 중...',
              success: (data) => '${_formatCurrency(data.totalIncome)}원',
              failure: (_) => '0원',
            ),
            icon: Icons.monetization_on,
            showAddButton: true,
          ),
          const SizedBox(height: 16),
          // 하단 두 카드 (가로 배치)
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: '완료한 퀘스트 수',
                  value: summaryState.when(
                    initial: () => '0개',
                    loading: () => '로딩 중...',
                    success: (data) => '${data.completedQuestCount}개',
                    failure: (_) => '0개',
                  ),
                  icon: Icons.emoji_events,
                  showAddButton: false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  label: '첫 수익화까지',
                  value: summaryState.when(
                    initial: () => '0일',
                    loading: () => '로딩 중...',
                    success: (data) => '${data.daysToFirstIncome}일',
                    failure: (_) => '0일',
                  ),
                  icon: Icons.trending_up,
                  showAddButton: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 통계 카드 위젯
  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required bool showAddButton,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // 밝은 회색 배경
        borderRadius: BorderRadius.circular(20), // 더 둥근 모서리
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              if (showAddButton)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TotalRevenueScreen(
                          userSideJobId: widget.userSideJobId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0), // 밝은 회색 원형 버튼
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (!showAddButton) ...[
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF8A8A8A), // 어두운 회색 원형 아이콘
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// 통화 포맷팅 (123,456 형태)
  String _formatCurrency(int amount) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amount.toString().replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }
}
