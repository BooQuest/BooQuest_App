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
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';
import 'package:booquest/features/main/infrastructure/providers/main_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  /// 레벨과 타입에 따라 캐릭터 GIF 파일 경로를 반환하는 함수
  String _getCharacterGifPath(int level) {
    // 레벨 7 이상은 최대 레벨로 제한
    final gifLevel = level > 7 ? 7 : level;
    
    // 로컬 스토리지에서 캐릭터 타입 가져오기
    try {
      final authStorage = AuthStorageService.getInstanceSync();
      final characterType = authStorage.getCharacterType();
      
      // 타입에 따라 다른 GIF 파일 사용 (네이버 클라우드 스토리지 URL 사용)
      if (characterType == 'WHITE') {
        return 'https://kr.object.ncloudstorage.com/booquest-character/pleasure/pleasure_W$gifLevel.gif';
      } else {
        // BLACK이거나 null인 경우 기본값으로 B 사용
        return 'https://kr.object.ncloudstorage.com/booquest-character/pleasure/pleasure_B$gifLevel.gif';
      }
    } catch (e) {
      // 스토리지 접근 실패 시 기본값으로 B 사용
      return 'https://kr.object.ncloudstorage.com/booquest-character/pleasure/pleasure_B$gifLevel.gif';
    }
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

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // 뒤로가기 시 콜백 호출
          widget.onBack?.call();
        }
      },
      child: Scaffold(
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
      color: Colors.white, 
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 뒤로가기 시 콜백 호출
                    widget.onBack?.call();
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            // 제목 (중앙)
            Center(
              child: Text(
                title,
                style: const TextStyle(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, color: AppColors.textPrimary),
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
    
    // 캐릭터 레벨 가져오기
    final characterGrowthState = ref.watch(characterGrowthNotifierProvider);
    final characterLevel = characterGrowthState.maybeWhen(
      success: (characterData) => characterData.level,
      orElse: () => 1, // 기본값
    );
    
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
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: isSmallScreen ? 180 : 200,
            height: isSmallScreen ? 200 : 220,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.bottomCenter,
                child: Transform.scale(
                  scale: 1.2, // 이미지를 1.2배 확대
                  child: Image.network(
                    _getCharacterGifPath(characterLevel), 
                    width: isSmallScreen ? 180 : 200,
                    height: isSmallScreen ? 200 : 220,
                    fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: isSmallScreen ? 180 : 200,
                      height: isSmallScreen ? 200 : 220,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.pets, size: isSmallScreen ? 80 : 100, color: AppColors.textHint);
                  },
                  ),
                ),
              ),
            ),
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
                    color: Colors.white, 
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      label == '완료한 퀘스트 수' 
                        ? 'assets/images/quest.png'
                        : 'assets/images/income.png',
                      width: isSmallScreen ? 16 : 20,
                      height: isSmallScreen ? 16 : 20,
                      fit: BoxFit.contain,
                    ),
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
