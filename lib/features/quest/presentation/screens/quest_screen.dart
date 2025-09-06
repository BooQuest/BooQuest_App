import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';

import 'package:booquest/features/main/presentation/screens/settings_screen.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_success_popup.dart';
import 'package:booquest/features/quest/presentation/widgets/sidejob_guide_popup.dart';
import 'package:booquest/features/quest/presentation/widgets/quest_completion_dialog.dart';
import 'package:booquest/features/quest/presentation/widgets/experience_boost_popup.dart';
import 'package:booquest/features/quest/presentation/screens/verification_complete_screen.dart';
import 'package:booquest/features/quest/presentation/screens/next_quest_setup_screen.dart';
import 'package:booquest/features/quest/infrastructure/providers/mission_step_completion_providers.dart';
import 'package:booquest/features/quest/infrastructure/providers/mission_completion_providers.dart';

class QuestScreen extends ConsumerStatefulWidget {
  const QuestScreen({super.key});

  @override
  ConsumerState<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends ConsumerState<QuestScreen> {
  int _selectedTabIndex = 0; // 0: 진행 중, 1: 예정
  String? _userNickname;
  int? _sideJobId;
  int? _selectedStepId; // 선택된 부퀘스트 스텝 ID (하나만 선택 가능)

  // 반응형을 위한 화면 크기 계산 (home_screen.dart와 동일한 구조)
  bool get _isSmallScreen => MediaQuery.of(context).size.width < 400;

  @override
  void initState() {
    super.initState();
    _loadUserNickname();
  }

  Future<void> _loadUserNickname() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final nickname = authStorage.getNickname();
      setState(() {
        _userNickname = nickname;
      });
    } catch (e) {
      print('❌ 닉네임 로드 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sideJobProgressState = ref.watch(sideJobProgressNotifierProvider);
    final missionListState = ref.watch(missionListNotifierProvider);
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
          child: Column(
            children: [
                          // Fixed top bar
            _buildTopBar(),
            SizedBox(height: _isSmallScreen ? 16 : 20),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20, vertical: _isSmallScreen ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOverallProgressCard(sideJobProgressState),
                      SizedBox(height: _isSmallScreen ? 20 : 24),
                      _buildTabBar(),
                      SizedBox(height: _isSmallScreen ? 16 : 20),
                      _selectedTabIndex == 0 
                          ? _buildMainQuestCard(missionListState)
                          : _buildPlannedQuestCard(missionListState),
                      SizedBox(height: _isSmallScreen ? 16 : 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 16 : 20),
      child: SizedBox(
        height: _isSmallScreen ? 44 : 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                '퀘스트',
                style: TextStyle(
                  fontSize: _isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: _isSmallScreen ? 36 : 40,
                height: _isSmallScreen ? 36 : 40,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings, 
                    color: AppColors.textPrimary,
                    size: _isSmallScreen ? 18 : 20,
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

  Widget _buildOverallProgressCard(SideJobProgressState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: state.maybeWhen(
        success: (data) => Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_userNickname ?? '사용자'}님이 추천받은 부업',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: _isSmallScreen ? 6 : 8),
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0D47A1),
                    ),
                  ),
                  SizedBox(height: _isSmallScreen ? 6 : 8),
                  Text(
                    '${data.currentOrder}단계 진행 중 · 목표까지 ${data.totalStages - data.currentOrder}단계 남음',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: _isSmallScreen ? 16 : 20),
            // 원형 진행률
            SizedBox(
              width: _isSmallScreen ? 70 : 80,
              height: _isSmallScreen ? 70 : 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: _isSmallScreen ? 70 : 80,
                    height: _isSmallScreen ? 70 : 80,
                    child: CircularProgressIndicator(
                      value: data.progressPercent / 100.0,
                      strokeWidth: _isSmallScreen ? 6 : 8,
                      backgroundColor: const Color(0xFFE6F3FF),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  Text(
                    '${data.progressPercent}%',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 14 : 16,
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
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.schedule,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '아직 예정된 퀘스트가 없어요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  '현재 진행 중인 퀘스트를 완료하면\n새로운 퀘스트가 열릴 거예요!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
              padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단 태그들 - 대기 중은 왼쪽, 메인퀘스트/단계는 오른쪽
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 11 : 12, vertical: _isSmallScreen ? 5 : 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF666666),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '대기 중',
                          style: TextStyle(
                            fontSize: _isSmallScreen ? 11.5 : 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 9 : 10, vertical: _isSmallScreen ? 5 : 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '메인 퀘스트',
                          style: TextStyle(
                            fontSize: _isSmallScreen ? 11.5 : 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: _isSmallScreen ? 7 : 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 9 : 10, vertical: _isSmallScreen ? 5 : 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${mission.orderNo ?? 1}단계',
                          style: TextStyle(
                            fontSize: _isSmallScreen ? 11.5 : 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _isSmallScreen ? 16 : 20),
                  // 메인 콘텐츠 - 제목과 설명을 왼쪽에, 아이콘을 오른쪽에
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: TextStyle(
                                fontSize: _isSmallScreen ? 17 : 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: _isSmallScreen ? 7 : 8),
                            Text(
                              mission.designNotes,
                              style: TextStyle(
                                fontSize: _isSmallScreen ? 13.5 : 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: _isSmallScreen ? 14 : 16),
                      // 오른쪽 잠금 아이콘
                      Container(
                        width: _isSmallScreen ? 55 : 60,
                        height: _isSmallScreen ? 55 : 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: _isSmallScreen ? 27 : 30,
                          color: const Color(0xFF999999),
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
      loading: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      failure: (_) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 40,
                color: Color(0xFFE53E3E),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '데이터를 불러오는데 실패했어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '잠시 후 다시 시도해주세요',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // 데이터 새로고침은 MainScreen에서 관리
                // 필요시 여기서 특정 API만 호출
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '다시 시도',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      orElse: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.help_outline,
                size: 40,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '퀘스트 정보를 준비하고 있어요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '잠시만 기다려주세요',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainQuestCard(MissionListState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.all(_isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 태그들 - 진행 중은 왼쪽, 메인퀘스트/단계는 오른쪽
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 11 : 12, vertical: _isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '진행 중',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 11.5 : 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 9 : 10, vertical: _isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '메인 퀘스트',
                    style: TextStyle(
                      fontSize: _isSmallScreen ? 11.5 : 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: _isSmallScreen ? 7 : 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: _isSmallScreen ? 9 : 10, vertical: _isSmallScreen ? 5 : 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: state.maybeWhen(
                    success: (data) {
                      // IN_PROGRESS 상태인 미션만 필터링
                      final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                      return Text(
                        '${inProgressMissions.isNotEmpty ? inProgressMissions.first.orderNo : 1}단계',
                        style: TextStyle(
                          fontSize: _isSmallScreen ? 11.5 : 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      );
                    },
                    orElse: () => Text(
                      '',
                      style: TextStyle(
                        fontSize: _isSmallScreen ? 11.5 : 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _isSmallScreen ? 16 : 20),
            // 메인 콘텐츠 - 제목과 설명을 왼쪽에, 아이콘을 오른쪽에
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.maybeWhen(
                        success: (data) {
                          // IN_PROGRESS 상태인 미션만 필터링
                          final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                          
                          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 표시
                          if (inProgressMissions.isEmpty) {
                            // COMPLETED 상태인 미션들을 orderNo 순으로 정렬하여 가장 최근 것 찾기
                            final completedMissions = data.missions
                                .where((mission) => mission.status == 'COMPLETED')
                                .toList()
                              ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                            
                            if (completedMissions.isNotEmpty) {
                              final latestCompletedMission = completedMissions.first;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    latestCompletedMission.title,
                                    style: TextStyle(
                                      fontSize: _isSmallScreen ? 17 : 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: _isSmallScreen ? 7 : 8),
                                  Text(
                                    latestCompletedMission.designNotes,
                                    style: TextStyle(
                                      fontSize: _isSmallScreen ? 13.5 : 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // 완료된 미션도 없으면 메시지 표시
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '진행중인 메인 퀘스트가 없습니다',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '새로운 퀘스트를 시작해보세요!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                          
                          // 진행 중인 미션이 있으면 기존 내용 표시
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inProgressMissions.first.title,
                                style: TextStyle(
                                  fontSize: _isSmallScreen ? 17 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: _isSmallScreen ? 7 : 8),
                              Text(
                                inProgressMissions.first.designNotes,
                                style: TextStyle(
                                  fontSize: _isSmallScreen ? 13.5 : 14,
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
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: _isSmallScreen ? 17 : 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: _isSmallScreen ? 7 : 8),
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: _isSmallScreen ? 13.5 : 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 경험치 - 작고 회색으로
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          state.maybeWhen(
                            success: (data) {
                              final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                              if (inProgressMissions.isNotEmpty) {
                                return Text(
                                  '+${inProgressMissions.first.missionTotalExp}EXP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                );
                              } else {
                                // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 경험치 표시
                                final completedMissions = data.missions
                                    .where((mission) => mission.status == 'COMPLETED')
                                    .toList()
                                  ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                                
                                if (completedMissions.isNotEmpty) {
                                  return Text(
                                    '+${completedMissions.first.missionTotalExp}EXP',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  );
                                }
                              }
                              return const Text(
                                '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
                            orElse: () => const Text(
                              '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: _isSmallScreen ? 14 : 16),
                // 오른쪽 아이콘
                Container(
                  width: _isSmallScreen ? 55 : 60,
                  height: _isSmallScreen ? 55 : 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0E6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.settings,
                    size: _isSmallScreen ? 27 : 30,
                    color: const Color(0xFFE91E63),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 진행률 바 (진행 중인 미션이 있을 때만 표시)
            state.maybeWhen(
              success: (data) {
                final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                
                // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 진행률 표시
                if (inProgressMissions.isEmpty) {
                  final completedMissions = data.missions
                      .where((mission) => mission.status == 'COMPLETED')
                      .toList()
                    ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                  
                  if (completedMissions.isNotEmpty) {
                    // 완료된 미션이면 100% 진행률 표시
                    return Row(
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
                              widthFactor: 1.0, // 100%
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '100%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // 완료된 미션도 없으면 진행률 바 숨김
                    return const SizedBox.shrink();
                  }
                }
                
                // 진행 중인 미션이 있으면 진행률 바 표시
                return Row(
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
                          widthFactor: inProgressMissions.first.progress.percent / 100.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${inProgressMissions.first.progress.percent}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              },
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
            // 부퀘스트 섹션 (진행 중인 미션이 있거나 완료된 미션이 있을 때 표시)
            state.maybeWhen(
              success: (data) {
                final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                final completedMissions = data.missions
                    .where((mission) => mission.status == 'COMPLETED')
                    .toList()
                  ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                
                // 진행 중인 미션이 없고 완료된 미션도 없으면 부퀘스트 섹션 숨김
                if (inProgressMissions.isEmpty && completedMissions.isEmpty) {
                  return const SizedBox.shrink();
                }
                
                // 진행 중인 미션이 있거나 완료된 미션이 있으면 부퀘스트 섹션 표시
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildSubQuestSection(state),
                );
              },
              orElse: () => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildSubQuestSection(state),
              ),
            ),
            const SizedBox(height: 24),
            // 하단 버튼들 (진행 중인 미션이 있거나 완료된 미션이 있을 때 표시)
            state.maybeWhen(
              success: (data) {
                final inProgressMissions = data.missions.where((mission) => mission.status == 'IN_PROGRESS').toList();
                final completedMissions = data.missions
                    .where((mission) => mission.status == 'COMPLETED')
                    .toList()
                  ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                
                // 진행 중인 미션이 없고 완료된 미션도 없으면 버튼들 숨김
                if (inProgressMissions.isEmpty && completedMissions.isEmpty) {
                  return const SizedBox.shrink();
                }
                
                // 진행 중인 미션이 있거나 완료된 미션이 있으면 버튼들 표시
                return Column(
                  children: [
                    // 완료하기 버튼
                    GestureDetector(
                      onTap: _isCompleteButtonEnabled(state) ? () => _handleButtonTap(context, state) : null,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _isCompleteButtonEnabled(state) ? const Color(0xFF2C2C2C) : AppColors.textSecondary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            _getButtonText(state),
                            style: TextStyle(
                              fontSize: _isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.w700,
                              color: _isCompleteButtonEnabled(state) ? Colors.white : AppColors.textSecondary.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              orElse: () => Column(
                children: [
                  // 완료하기 버튼
                  GestureDetector(
                    onTap: _isCompleteButtonEnabled(state) ? () => _handleButtonTap(context, state) : null,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _isCompleteButtonEnabled(state) ? const Color(0xFF2C2C2C) : AppColors.textSecondary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _getButtonText(state),
                          style: TextStyle(
                            fontSize: _isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w700,
                            color: _isCompleteButtonEnabled(state) ? Colors.white : AppColors.textSecondary.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
            const Icon(
              Icons.info_outline,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const Spacer(),
            state.maybeWhen(
              success: (data) {
                // IN_PROGRESS 상태인 미션 찾기
                final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
                if (inProgressMission != null) {
                  final completedCount = inProgressMission.steps.where((step) => step.status == 'COMPLETED').length;
                  return Text(
                    '($completedCount/5) 완료',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  );
                } else {
                  // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것의 완료 개수 표시
                  final completedMissions = data.missions
                      .where((mission) => mission.status == 'COMPLETED')
                      .toList()
                    ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                  
                  if (completedMissions.isNotEmpty) {
                    final latestCompletedMission = completedMissions.first;
                    final completedCount = latestCompletedMission.steps.where((step) => step.status == 'COMPLETED').length;
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
                // IN_PROGRESS 상태인 미션 찾기
                final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
                
                // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 찾기
                if (inProgressMission == null) {
                  final completedMissions = data.missions
                      .where((mission) => mission.status == 'COMPLETED')
                      .toList()
                    ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
                  
                  if (completedMissions.isNotEmpty) {
                    final latestCompletedMission = completedMissions.first;
                    // seq 순서대로 정렬
                    final sortedSteps = List<MissionStep>.from(latestCompletedMission.steps)
                      ..sort((a, b) => a.seq.compareTo(b.seq));
                    
                    return Column(
                      children: [
                        ...sortedSteps.map((step) => _buildSubQuestItem(
                          step.id,
                          step.title,
                          step.status == 'COMPLETED',
                          step.status == 'PLANNED',
                        )).toList(),
                        const SizedBox(height: 16),
                        // 부업가이드 버튼
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              print('🔍 부업가이드 버튼 1 클릭됨');
                              _showSidejobGuidePopup(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.cardBorder, width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  '부업 가이드 >',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [],
                    );
                  }
                }
                
                // 진행 중인 미션이 있으면 기존 로직
                // seq 순서대로 정렬
                final sortedSteps = List<MissionStep>.from(inProgressMission.steps)
                  ..sort((a, b) => a.seq.compareTo(b.seq));
                
                return Column(
                  children: [
                    ...sortedSteps.map((step) => _buildSubQuestItem(
                      step.id,
                      step.title,
                      step.status == 'COMPLETED',
                      step.status == 'PLANNED',
                    )).toList(),
                    const SizedBox(height: 16),
                    // 부업가이드 버튼
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          print('🔍 부업가이드 버튼 2 클릭됨');
                          _showSidejobGuidePopup(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.cardBorder, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              '부업 가이드 >',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
          orElse: () => Column(
              children: [
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildSubQuestItem(int stepId, String title, bool isCompleted, bool isPlanned) {
    final isSelected = _selectedStepId == stepId;
    
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
          GestureDetector(
            onTap: isCompleted ? null : () => _handleStepSelection(stepId),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? const Color(0xFF666666) 
                    : isSelected 
                        ? AppColors.primary 
                        : AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted 
                      ? const Color(0xFF666666) 
                      : isSelected 
                          ? AppColors.primary 
                          : AppColors.cardBorder,
                  width: 2,
                ),
              ),
              child: isCompleted || isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  /// 부퀘스트 완료 버튼이 활성화되어야 하는지 확인하는 메서드
  bool _isCompleteButtonEnabled(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          // 부퀘스트가 선택되었거나, 모든 부퀘스트가 완료된 상태면 버튼 활성화
          return _selectedStepId != null || _isAllSubQuestsCompleted(inProgressMission);
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 항상 활성화 (메인 퀘스트 완료 버튼)
            return true;
          }
        }
        return false;
      },
      orElse: () => false,
    );
  }

  /// 모든 부퀘스트가 완료되었는지 확인하는 메서드
  bool _isAllSubQuestsCompleted(dynamic mission) {
    return mission.steps.every((step) => step.status == 'COMPLETED');
  }

  /// 버튼 텍스트를 동적으로 반환하는 메서드
  String _getButtonText(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          if (_isAllSubQuestsCompleted(inProgressMission)) {
            return '메인 퀘스트 완료';
          } else if (_selectedStepId != null) {
            return '부퀘스트 완료하기';
          }
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 메인 퀘스트 완료 버튼 표시
            return '메인 퀘스트 완료';
          }
        }
        return '부퀘스트 완료하기';
      },
      orElse: () => '부퀘스트 완료하기',
    );
  }

  /// 버튼 탭 처리 메서드 (부퀘스트 완료 또는 메인 퀘스트 완료)
  Future<void> _handleButtonTap(BuildContext context, MissionListState state) async {
    state.maybeWhen(
      success: (data) {
        // IN_PROGRESS 상태인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        if (inProgressMission != null) {
          if (_isAllSubQuestsCompleted(inProgressMission)) {
            // 모든 부퀘스트가 완료된 상태: 메인 퀘스트 완료 처리
            _handleMainQuestCompletion(context, inProgressMission.id);
          } else if (_selectedStepId != null) {
            // 부퀘스트가 선택된 상태: 부퀘스트 완료 처리
            _handleSelectedStepCompletion(context);
          }
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 확인
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          if (completedMissions.isNotEmpty) {
            // 완료된 미션이 있으면 메인 퀘스트 완료 처리
            _handleMainQuestCompletion(context, completedMissions.first.id);
          }
        }
      },
      orElse: () {},
    );
  }

  /// 메인 퀘스트 완료 처리
  Future<void> _handleMainQuestCompletion(BuildContext context, int missionId) async {
    try {
      print('🎉 메인 퀘스트 완료 처리 시작: missionId=$missionId');
      
      // 메인 퀘스트 완료 API 호출
      await ref.read(missionCompletionNotifierProvider.notifier).completeMission(missionId);
      
      // 상태 확인
      final state = ref.read(missionCompletionNotifierProvider);
      
      if (mounted) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            // 일반적인 완료 처리 - 성공 팝업 표시
            _showMainQuestSuccessPopup(context, data);
            
            // 데이터 새로고침은 MainScreen에서 관리
            // 필요시 여기서 특정 API만 호출
          },
          failure: (message) {
            // 실패 시 에러 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('메인 퀘스트 완료 실패: $message'),
                backgroundColor: Colors.red,
              ),
            );
          },
          alreadyCompleted: () {
            // 이미 완료된 메인 퀘스트 - 바로 다음 퀘스트 설정 화면으로 이동
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NextQuestSetupScreen(),
              ),
            );
          },
        );
      }
    } catch (e) {
      
      // 이미 완료된 메인 퀘스트인 경우
      if (e.toString().contains('already-completed')) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NextQuestSetupScreen(),
            ),
          );
        }
        return;
      }
      
      // 다른 오류인 경우
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('메인 퀘스트 완료 처리 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 선택된 부퀘스트가 있는지 확인하는 메서드
  bool _hasSelectedSubQuest() {
    return _selectedStepId != null;
  }

  /// 부퀘스트 선택 처리 (라디오 버튼처럼 하나만 선택)
  void _handleStepSelection(int stepId) {
    setState(() {
      if (_selectedStepId == stepId) {
        // 같은 스텝을 다시 클릭하면 선택 해제
        _selectedStepId = null;
      } else {
        // 다른 스텝을 클릭하면 기존 선택 해제하고 새로 선택
        _selectedStepId = stepId;
      }
    });
  }

  /// 선택된 부퀘스트를 완료 처리
  Future<void> _handleSelectedStepCompletion(BuildContext context) async {
    if (_selectedStepId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('완료할 부퀘스트를 선택해주세요.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 퀘스트 완료 확인 다이얼로그 표시
    final result = await QuestCompletionDialog.show(
      context,
      questTitle: '부퀘스트',
      onComplete: () {
        // 빈 콜백 (QuestCompletionDialog에서 자동으로 닫힘)
      },
    );

    // 완료 버튼을 눌렀을 때만 기존 API 로직 실행
    if (result == true) {
      await _completeSelectedStep(context);
    }
  }

  /// 실제 부퀘스트 완료 처리 (기존 로직)
  Future<void> _completeSelectedStep(BuildContext context) async {
    try {
      // 선택된 스텝을 완료 처리
      await ref.read(missionStepCompletionNotifierProvider.notifier).completeStep(
        _selectedStepId!,
        'COMPLETED',
      );

      // 상태 확인
      final state = ref.read(missionStepCompletionNotifierProvider);
      
      if (mounted) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            // 성공 시 ExperienceBoostPopup 표시
            _showExperienceBoostPopup(context, _selectedStepId!);
            
            // 선택 상태 초기화
            setState(() {
              _selectedStepId = null;
            });
            
            // 데이터 새로고침은 MainScreen에서 관리
            // 필요시 여기서 특정 API만 호출
          },
          failure: (message) {
            // 실패 시 에러 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('부퀘스트 완료 실패: $message'),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      }
    } catch (e) {
      print('❌ 부퀘스트 완료 처리 중 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('부퀘스트 완료 처리 중 오류가 발생했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ExperienceBoostPopup 표시
  void _showExperienceBoostPopup(BuildContext context, int stepId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ExperienceBoostPopup(stepId: stepId),
    );
  }

  /// 부퀘스트 성공 팝업 표시
  void _showQuestSuccessPopup(BuildContext context, int stepId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => QuestSuccessPopup(stepId: stepId),
    );
  }

  /// 메인 퀘스트 성공 팝업 표시
  void _showMainQuestSuccessPopup(BuildContext context, dynamic data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationCompleteScreen(
          method: 'main_quest',
          content: '메인 퀘스트 완료',
          expReward: data.totalExpReward,
        ),
      ),
    );
  }

  /// 부업 가이드 팝업 표시
  void _showSidejobGuidePopup(BuildContext context) {
    print('🔍 _showSidejobGuidePopup 호출됨');
    final missionListState = ref.read(missionListNotifierProvider);
    print('🔍 missionListState: $missionListState');
    
    missionListState.when(
      initial: () => _showEmptyGuidePopup(context),
      loading: () => _showEmptyGuidePopup(context),
      success: (data) {
        print('🔍 success 케이스 - missions 개수: ${data.missions.length}');
        // 현재 진행 중인 미션 찾기
        final inProgressMission = data.missions.where((mission) => mission.status == 'IN_PROGRESS').firstOrNull;
        print('🔍 inProgressMission: ${inProgressMission?.title}');
        
        if (inProgressMission != null) {
          // 진행 중인 미션이 있으면 해당 미션만 전달
          print('🔍 진행 중인 미션으로 팝업 표시');
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) => SidejobGuidePopup(missions: [inProgressMission]),
          );
        } else {
          // 진행 중인 미션이 없으면 완료된 미션 중 가장 최근 것 사용
          final completedMissions = data.missions
              .where((mission) => mission.status == 'COMPLETED')
              .toList()
            ..sort((a, b) => (b.orderNo ?? 0).compareTo(a.orderNo ?? 0));
          
          print('🔍 completedMissions 개수: ${completedMissions.length}');
          if (completedMissions.isNotEmpty) {
            print('🔍 완료된 미션으로 팝업 표시: ${completedMissions.first.title}');
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) => SidejobGuidePopup(missions: [completedMissions.first]),
            );
          } else {
            print('🔍 빈 가이드 팝업 표시');
            _showEmptyGuidePopup(context);
          }
        }
      },
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('부업 가이드 로드 실패: $message'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
  
  /// 빈 가이드 팝업 표시 (데이터가 없을 때)
  void _showEmptyGuidePopup(BuildContext context) {
    print('🔍 _showEmptyGuidePopup 호출됨');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const SidejobGuidePopup(missions: []),
    );
  }
}


