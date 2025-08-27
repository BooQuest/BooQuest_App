import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/user_activity_summary_providers.dart';
import 'package:booquest/features/main/infrastructure/providers/user_sidejob_list_providers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/features/main/presentation/screens/settings_screen.dart';




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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '나의 활동',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _MyActivityCard(),
                    const SizedBox(height: 24),
                    const Text(
                      '부업 프로젝트 관리',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ProjectCard(),
                    const SizedBox(height: 20),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '나의 기록',
                style: TextStyle(
                  fontSize: 18,
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              value: '${data.totalIncome}원',
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '${data.completedSideJobCount}개',
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '${data.completedQuestCount}개',
            ),
          ],
        ),
        loading: () => const Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '로딩 중...',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '로딩 중...',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '로딩 중...',
            ),
          ],
        ),
        failure: (_) => const Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '',
            ),
          ],
        ),
        orElse: () => const Column(
          children: [
            _ActivityRow(
              icon: Icons.monetization_on,
              label: '나의 총 수익',
              value: '0원',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.work,
              label: '완료한 부업 프로젝트',
              value: '0개',
            ),
            Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            _ActivityRow(
              icon: Icons.emoji_events,
              label: '완료한 퀘스트 수',
              value: '0개',
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

  const _ActivityRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: AppColors.textHint),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
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
    final sideJobListState = ref.watch(userSideJobListNotifierProvider);
    
    return sideJobListState.maybeWhen(
      success: (data) {
        if (data.sideJobs.isEmpty) {
          return const Center(
            child: Text(
              '등록된 부업 프로젝트가 없습니다.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        return Column(
          children: data.sideJobs.map((sideJob) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                              _Chip(label: '예정'),
                            ] else ...[
                              _Chip(label: sideJob.period),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          sideJob.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // SVG 이미지
                  SvgPicture.asset(
                    'assets/images/characters/sidejob_test.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 4),
                  // 화살표 아이콘 (더 구석으로)
                  const Icon(
                    Icons.chevron_right, 
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ],
              ),
            ),
          )).toList(),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      failure: (_) => const Center(
        child: Text(
          '데이터를 불러오는데 실패했습니다.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      orElse: () => const Center(
        child: Text(
          '데이터를 불러오는 중...',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }


}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
