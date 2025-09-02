import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/presentation/widgets/common_bottom_navigation.dart';
import 'package:booquest/features/main/presentation/screens/home_screen.dart';
import 'package:booquest/features/quest/presentation/screens/quest_screen.dart';
import 'package:booquest/features/main/presentation/screens/my_record_screen.dart';
import 'package:booquest/features/revenue/application/providers/sidejob_summary_providers.dart';
import 'package:booquest/features/revenue/presentation/screens/total_revenue_screen.dart';
import 'package:booquest/features/revenue/application/states/sidejob_summary_state.dart';
import 'package:booquest/features/revenue/domain/entities/sidejob_summary_entity.dart';

/// 부업 프로젝트 상세 화면 - Clean Architecture + Riverpod 구조
class SidejobDetailScreen extends ConsumerStatefulWidget {
  final int userSideJobId;
  final VoidCallback? onBack;
  
  const SidejobDetailScreen({
    super.key,
    required this.userSideJobId,
    this.onBack,
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
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Column(
      children: [
        _buildTopBar(context, summaryState),
        _buildHeaderSection(summaryState),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSmallScreen ? 24 : 30),
                topRight: Radius.circular(isSmallScreen ? 24 : 30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: isSmallScreen ? 16 : 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // 드래그 핸들 (팝업 스타일)
                Container(
                  margin: EdgeInsets.only(top: isSmallScreen ? 10 : 12, bottom: isSmallScreen ? 6 : 8),
                  width: isSmallScreen ? 36 : 40,
                  height: isSmallScreen ? 3 : 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0), // 회색으로 변경
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildStatsSection(summaryState),
                      ],
                    ),
                  ),
                ),
              ],
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, 
              Color(0xFFE6F3FF),
            ],
          ),
        ),
        child: SafeArea(
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
      ),
      bottomNavigationBar: CommonBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  /// 상단 바 구성
  Widget _buildTopBar(BuildContext context, SideJobSummaryState summaryState) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    String title = '로딩 중...';
    
    summaryState.when(
      initial: () => title = '로딩 중...',
      loading: () => title = '로딩 중...',
      success: (data) => title = data.userSideJob.title,
      failure: (_) => title = '부업 프로젝트',
    );

    return Container(
      color: Colors.white, // 최상단 바는 흰색 배경
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20, vertical: isSmallScreen ? 14 : 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 뒤로가기 시 콜백 호출
              widget.onBack?.call();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black, // 검은색으로 변경
              size: isSmallScreen ? 18 : 20,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black, // 검은색으로 변경
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.black, // 검은색으로 변경
              size: isSmallScreen ? 18 : 20,
            ),
          ),
        ],
      ),
    );
  }

  /// 헤더 섹션 구성
  Widget _buildHeaderSection(SideJobSummaryState summaryState) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFEFEFF), // 거의 흰색
            Color(0xFFE6F3FF), // 연한 하늘색
          ],
        ),
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
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지금까지',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '로딩 중...',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 10 : 12),
        Text(
          '0원 벌었어요!',
          style: TextStyle(
            fontSize: isSmallScreen ? 26 : 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Row(
          children: [
            _buildTag('로딩 중...'),
            SizedBox(width: isSmallScreen ? 10 : 12),
            _buildTag('로딩 중...'),
          ],
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: isSmallScreen ? 140 : 160,
            height: isSmallScreen ? 160 : 180,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  /// 성공 헤더
  Widget _buildSuccessHeader(SideJobSummaryEntity data) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지금까지',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '${data.userSideJob.title}로',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 10 : 12),
        Text(
          '${_formatCurrency(data.totalIncome)}원 벌었어요!',
          style: TextStyle(
            fontSize: isSmallScreen ? 26 : 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Row(
          children: [
            _buildTag(data.period),
            SizedBox(width: isSmallScreen ? 10 : 12),
            //_buildTag('경제·사회·재테크'),
          ],
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Align(
          alignment: Alignment.centerRight,
          child: SvgPicture.asset(
            'assets/images/characters/sidejob_test2.svg',
            width: isSmallScreen ? 140 : 160,
            height: isSmallScreen ? 160 : 180,
          ),
        ),
      ],
    );
  }

  /// 에러 헤더
  Widget _buildErrorHeader(String message) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지금까지',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '부업 프로젝트로',
          style: TextStyle(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 10 : 12),
        Text(
          '0원 벌었어요!',
          style: TextStyle(
            fontSize: isSmallScreen ? 26 : 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Row(
          children: [
            _buildTag('에러 발생'),
            SizedBox(width: isSmallScreen ? 10 : 12),
            _buildTag('데이터 없음'),
          ],
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: isSmallScreen ? 140 : 160,
            height: isSmallScreen ? 160 : 180,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: isSmallScreen ? 40 : 48,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 태그 위젯
  Widget _buildTag(String text) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 12, vertical: isSmallScreen ? 5 : 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 14 : 16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmallScreen ? 11 : 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// 통계 섹션 구성
  Widget _buildStatsSection(SideJobSummaryState summaryState) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(isSmallScreen ? 20 : 24, isSmallScreen ? 12 : 16, isSmallScreen ? 20 : 24, 0), 
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
            summaryState: summaryState,
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
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
              SizedBox(width: isSmallScreen ? 16 : 20), 
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
    SideJobSummaryState? summaryState,
  }) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), 
        borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: isSmallScreen ? 8 : 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16, 
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (showAddButton)
                GestureDetector(
                  onTap: () {
                    // 부업 이름 가져오기
                    String sideJobTitle = '부업 프로젝트';
                    if (summaryState != null) {
                      summaryState.when(
                        initial: () => sideJobTitle = '부업 프로젝트',
                        loading: () => sideJobTitle = '부업 프로젝트',
                        success: (data) => sideJobTitle = data.userSideJob.title,
                        failure: (_) => sideJobTitle = '부업 프로젝트',
                      );
                    }
                    
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TotalRevenueScreen(
                          userSideJobId: widget.userSideJobId,
                          sideJobTitle: sideJobTitle,
                          onBack: () {
                            // 뒤로가기 시 데이터 새로고침
                            _loadData();
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: isSmallScreen ? 32 : 36,
                    height: isSmallScreen ? 32 : 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2), // 파란색으로 변경
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: isSmallScreen ? 20 : 22, 
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 14 : 16),
          if (!showAddButton) 
            Row(
              children: [
                Container(
                  width: isSmallScreen ? 24 : 28,
                  height: isSmallScreen ? 24 : 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F3FF), 
                    borderRadius: BorderRadius.all(Radius.circular(isSmallScreen ? 6 : 8)),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 10),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24,
                    fontWeight: FontWeight.w800, 
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 20 : 24,
                fontWeight: FontWeight.w800, 
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
