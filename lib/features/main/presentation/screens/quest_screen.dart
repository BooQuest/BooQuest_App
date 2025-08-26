import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

class QuestScreen extends ConsumerStatefulWidget {
  const QuestScreen({super.key});

  @override
  ConsumerState<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends ConsumerState<QuestScreen> {
  int _selectedTabIndex = 0; // 0: 진행 중, 1: 예정
  String? _userNickname;
  int? _sideJobId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      _sideJobId = authStorage.getSideJobId();
      _userNickname = authStorage.getNickname();

      if (_sideJobId != null) {
        await Future.wait([
          ref.read(sideJobProgressNotifierProvider.notifier).getSideJobProgress(_sideJobId!),
          ref.read(missionListNotifierProvider.notifier).getMissionList(''), // status 빈칸으로 모든 데이터 가져오기
        ]);
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sideJobProgressState = ref.watch(sideJobProgressNotifierProvider);
    final missionListState = ref.watch(missionListNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed top bar
            _buildTopBar(),
            const SizedBox(height: 20),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverallProgressCard(sideJobProgressState),
                    const SizedBox(height: 24),
                    _buildTabBar(),
                    const SizedBox(height: 20),
                    // 탭에 따라 다른 카드 표시
                    _selectedTabIndex == 0 
                        ? _buildMainQuestCard(missionListState)
                        : _buildPlannedQuestCard(missionListState),
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
                '퀘스트',
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
                  onPressed: () {},
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

  Widget _buildOverallProgressCard(SideJobProgressState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: state.maybeWhen(
        success: (data) => Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_userNickname ?? '사용자'}님이 추천받은 부업',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${data.currentOrder}단계 진행 중 · 목표까지 ${data.totalStages - data.currentOrder}단계 남음',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // 원형 진행률
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: data.progressPercent / 100.0,
                      strokeWidth: 8,
                      backgroundColor: const Color(0xFFE0E0E0),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  Text(
                    '${data.progressPercent}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        _buildTab(0, '진행 중'),
        const SizedBox(width: 20),
        _buildTab(1, '예정'),
      ],
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildPlannedQuestCard(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        // PLANNED 상태인 미션만 필터링
        final plannedMissions = data.missions.where((mission) => mission.status == 'PLANNED').toList();
        
        if (plannedMissions.isEmpty) {
          return const Center(
            child: Text(
              '예정된 퀘스트가 없습니다.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        // 디버깅용: 데이터 개수 표시
        print('🔍 예정 탭 데이터: ${plannedMissions.length}개 (전체: ${data.missions.length}개)');
        for (int i = 0; i < plannedMissions.length; i++) {
          final mission = plannedMissions[i];
          print('  [$i] orderNo: ${mission.orderNo}, title: ${mission.title}');
        }

        // orderNo 순서로 정렬 (null 체크 포함)
        final sortedMissions = List<dynamic>.from(plannedMissions)
          ..sort((a, b) {
            final aOrder = a.orderNo ?? 0;
            final bOrder = b.orderNo ?? 0;
            return aOrder.compareTo(bOrder);
          });

        return Column(
          children: sortedMissions.map((mission) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단 태그들
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF666666),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '메인 퀘스트',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF999999),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${mission.orderNo ?? 1}단계',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // 대기 중 태그
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCCCCC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '대기 중',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 잠금 아이콘과 퀘스트 정보
                  Row(
                    children: [
                      // 잠금 아이콘
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock,
                          size: 30,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 퀘스트 제목과 설명
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              mission.designNotes,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildMainQuestCard(MissionListState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 태그들
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '메인 퀘스트',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: state.maybeWhen(
                    success: (data) {
                      // IN_PROGRESS 상태인 미션만 필터링
                      final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                      return Text(
                        '${inProgressMissions.isNotEmpty ? inProgressMissions.first.orderNo : 1}단계',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      );
                    },
                    orElse: () => const Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '진행 중',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 메인 콘텐츠
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 플레이스홀더
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.maybeWhen(
                        success: (data) {
                          // IN_PROGRESS 상태인 미션만 필터링
                          final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inProgressMissions.isNotEmpty ? inProgressMissions.first.title : '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                inProgressMissions.isNotEmpty ? inProgressMissions.first.designNotes : '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          );
                        },
                        orElse: () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 경험치
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+10 EXP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 진행률 바
            state.maybeWhen(
              success: (data) => Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: data.missions.isNotEmpty ? data.missions.first.progress.percent / 100.0 : 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${data.missions.isNotEmpty ? data.missions.first.progress.percent : 50}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              orElse: () => Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 부퀘스트 섹션
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildSubQuestSection(state),
            ),
            const SizedBox(height: 24),
            // 하단 버튼들
            Column(
              children: [
                // 부업가이드 버튼
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '부업가이드',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_upward,
                        size: 16,
                        color: AppColors.textPrimary.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // 완료하기 버튼
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _isAllSubQuestsCompleted(state) ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '완료하기 + 10 EXP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _isAllSubQuestsCompleted(state) ? AppColors.white : AppColors.textSecondary.withValues(alpha: 0.6),
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

  Widget _buildSubQuestSection(MissionListState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '부 퀘스트',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            state.maybeWhen(
              success: (data) {
                if (data.missions.isNotEmpty) {
                  final mission = data.missions.first;
                  final completedCount = mission.steps.where((step) => step.status == 'COMPLETED').length;
                  return Text(
                    '($completedCount/5) 완료',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  );
                } else {
                  return const Text(
                    '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  );
                }
              },
              orElse: () => const Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_up,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        state.maybeWhen(
          success: (data) {
            if (data.missions.isNotEmpty) {
              final mission = data.missions.first;
              // seq 순서대로 정렬
              final sortedSteps = List<MissionStep>.from(mission.steps)
                ..sort((a, b) => a.seq.compareTo(b.seq));
              
              return Column(
                children: sortedSteps.map((step) => _buildSubQuestItem(
                  step.title,
                  step.status == 'COMPLETED',
                  step.status == 'PLANNED',
                )).toList(),
              );
            } else {
              return Column(
                children: [
                ],
              );
            }
          },
          orElse: () => Column(
              children: [
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildSubQuestItem(String title, bool isCompleted, bool isPlanned) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isCompleted 
                    ? AppColors.textSecondary 
                    : isPlanned 
                        ? AppColors.textSecondary.withValues(alpha: 0.6)
                        : AppColors.textPrimary,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF666666) : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted ? const Color(0xFF666666) : AppColors.cardBorder,
                width: 2,
              ),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  /// 모든 부퀘스트가 완료되었는지 확인하는 메서드
  bool _isAllSubQuestsCompleted(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        if (data.missions.isNotEmpty) {
          final mission = data.missions.first;
          // 모든 steps가 COMPLETED 상태인지 확인
          return mission.steps.every((step) => step.status == 'COMPLETED');
        }
        return false;
      },
      orElse: () => false,
    );
  }
}


