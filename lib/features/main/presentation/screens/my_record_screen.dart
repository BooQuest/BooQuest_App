import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/user_activity_summary_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/user_sidejob_list_providers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';
import 'package:booquest/features/revenue/presentation/screens/sidejob_detail_screen.dart';




class MyRecordScreen extends ConsumerStatefulWidget {
  const MyRecordScreen({super.key});

  @override
  ConsumerState<MyRecordScreen> createState() => _MyRecordScreenState();
}

class _MyRecordScreenState extends ConsumerState<MyRecordScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      await Future.wait([
        ref.read(userActivitySummaryNotifierProvider.notifier).getUserActivitySummary(),
        ref.read(userSideJobListNotifierProvider.notifier).getUserSideJobList(),
      ]);
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            SizedBox(height: isSmallScreen ? 16 : 20), 
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 활동',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15 : 16, 
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 12), 
                    _MyActivityCard(),
                    SizedBox(height: isSmallScreen ? 20 : 24), 
                    Text(
                      '부업 프로젝트 관리',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15 : 16, 
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 12), 
                    _ProjectCard(),
                    SizedBox(height: isSmallScreen ? 16 : 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                '나의 기록',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18, 
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
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
}

class _MyActivityCard extends ConsumerWidget {
  /// 통화 포맷팅 (123,456 형태)
  String _formatCurrency(int amount) {
    if (amount == 0) return '0';
    
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return amount.toString().replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final activitySummaryState = ref.watch(userActivitySummaryNotifierProvider);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333), width: 2), // 진한 검은색 외곽선
      ),
      child: activitySummaryState.maybeWhen(
        success: (data) => Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '${_formatCurrency(data.totalIncome)}원',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '${data.completedSideJobCount}개',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '${data.completedQuestCount}개',
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
        loading: () => Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '로딩 중...',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '로딩 중...',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '로딩 중...',
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
        failure: (_) => Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '',
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
        orElse: () => Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '0원',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '0개',
              isSmallScreen: isSmallScreen,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '0개',
              isSmallScreen: isSmallScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isSmallScreen;

  const _ActivityRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16, vertical: isSmallScreen ? 12 : 16), // 반응형 패딩
      child: Row(
        children: [
          Container(
            width: isSmallScreen ? 20 : 24, 
            height: isSmallScreen ? 20 : 24,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: isSmallScreen ? 16 : 18, color: AppColors.textHint), // 반응형 아이콘 크기
          ),
          SizedBox(width: isSmallScreen ? 10 : 12), 
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16, 
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16, 
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 반응형을 위한 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final sideJobListState = ref.watch(userSideJobListNotifierProvider);
    
    return sideJobListState.maybeWhen(
      success: (data) {
        if (data.sideJobs.isEmpty) {
          return Center(
            child: Text(
              '등록된 부업 프로젝트가 없습니다.',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16, 
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        return Column(
          children: data.sideJobs.map((sideJob) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SidejobDetailScreen(
                    userSideJobId: sideJob.id,
                    onBack: () {
                      // 뒤로가기 시 데이터 새로고침
                      ref.read(userActivitySummaryNotifierProvider.notifier).getUserActivitySummary();
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (sideJob.status == 'PLANNED') ...[
                                _Chip(label: '예정', isSmallScreen: isSmallScreen),
                              ] else ...[
                                _Chip(label: sideJob.period, isSmallScreen: isSmallScreen),
                              ],
                            ],
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 10),
                          Text(
                            sideJob.title,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 10 : 12),
                    // SVG 이미지
                    SvgPicture.asset(
                      'assets/images/characters/sidejob_test.svg',
                      width: isSmallScreen ? 80 : 100, 
                      height: isSmallScreen ? 80 : 100,
                    ),
                    SizedBox(width: isSmallScreen ? 3 : 4),
                    // 화살표 아이콘 (더 구석으로)
                    Icon(
                      Icons.chevron_right, 
                      color: AppColors.textPrimary,
                      size: isSmallScreen ? 18 : 20,
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      failure: (_) => Center(
        child: Text(
          '데이터를 불러오는데 실패했습니다.',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            color: AppColors.textSecondary,
          ),
        ),
      ),
      orElse: () => Center(
        child: Text(
          '데이터를 불러오는 중...',
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }


}

class _Chip extends StatelessWidget {
  final String label;
  final bool isSmallScreen;
  const _Chip({required this.label, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 12, vertical: isSmallScreen ? 5 : 6), // 반응형 패딩
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isSmallScreen ? 11 : 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
