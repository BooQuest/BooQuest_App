import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/main/infrastructure/providers/sidejob_progress_providers.dart';
import 'package:booquest/features/main/application/states/sidejob_progress_state.dart';
import 'package:booquest/features/main/infrastructure/providers/mission_list_providers.dart';
import 'package:booquest/features/main/application/states/mission_list_state.dart';
import 'package:booquest/features/main/domain/entities/mission_entity.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/presentation/screens/next_quest_start_screen.dart';
import 'package:booquest/core/presentation/widgets/custom_loading_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 다음 퀘스트 설정 화면 - 메인 퀘스트 완료 후 다음 퀘스트 준비
class NextQuestSetupScreen extends ConsumerStatefulWidget {
  final VoidCallback? onHomeTabRequested;
  
  const NextQuestSetupScreen({super.key, this.onHomeTabRequested});

  @override
  ConsumerState<NextQuestSetupScreen> createState() => _NextQuestSetupScreenState();
}

class _NextQuestSetupScreenState extends ConsumerState<NextQuestSetupScreen> {
  String? _userNickname;
  int? _sideJobId;
  InterstitialAd? _interstitialAd;
  bool _isAdReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      _loadInterstitialAd(); // ✅ 광고 로드
    });
  }

  Future<void> _loadData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      _sideJobId = authStorage.getSideJobId();
      _userNickname = authStorage.getNickname();

      if (_sideJobId != null) {
        await Future.wait([
          ref.read(missionListNotifierProvider.notifier).getMissionList('', _sideJobId!),
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
            // 상단 바 (quest_screen.dart와 동일한 구조)
            _buildTopBar(),
            // 스크롤 가능한 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 성공 메시지 카드
                    _buildSuccessMessageCard(),
                    const SizedBox(height: 24),
                    // 퀘스트 카드들
                    _buildQuestCards(missionListState),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // 하단 버튼
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  /// 상단 바 (quest_screen.dart와 동일한 구조)
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 뒤로가기 버튼
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            // 제목
            const Center(
              child: Text(
                '메인/부 퀘스트 생성',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 성공 메시지 카드
  Widget _buildSuccessMessageCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 첫 번째 줄: "메인 퀘스트를" (초록색) + "성공적으로" (검은색)
          Row(
            children: [
              const Text(
                '메인 퀘스트를 ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4CAF50), // 초록색
                ),
              ),
              const Text(
                '성공적으로',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // 두 번째 줄: "클리어했네요!" (검은색)
          const Text(
            '클리어했네요!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          // 세 번째 줄: 설명 (회색)
          const Text(
            '잠시 후 광고가 끝나면 새로운 퀘스트가 열려요.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  /// 퀘스트 카드들
  Widget _buildQuestCards(MissionListState state) {
    return state.maybeWhen(
      success: (data) {
        if (data.missions.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 40,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: 16),
                Text(
                  '퀘스트 정보가 없습니다',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        // orderNo 순서로 정렬
        final sortedMissions = List<MissionEntity>.from(data.missions)
          ..sort((a, b) {
            final aOrder = a.orderNo ?? 0;
            final bOrder = b.orderNo ?? 0;
            return aOrder.compareTo(bOrder);
          });

        return Column(
          children: sortedMissions.map((MissionEntity mission) {
            final isCompleted = mission.status == 'COMPLETED';
            final isInProgress = mission.status == 'IN_PROGRESS';
            
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCompleted 
                      ? const Color(0xFF4CAF50) // 완료: 초록색 테두리
                      : AppColors.cardBorder, // 나머지: 기본 테두리
                  width: isCompleted ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단: 상태 태그들 (완료는 왼쪽, 메인퀘스트/단계는 오른쪽)
                  Row(
                    children: [
                      // 상태 태그 (완료/진행중/대기중) - 왼쪽
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? const Color(0xFF4CAF50) // 완료: 초록색
                              : isInProgress 
                                  ? AppColors.primary // 진행중: 파란색
                                  : const Color(0xFF999999), // 나머지: 회색
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isCompleted 
                              ? '완료' 
                              : isInProgress 
                                  ? '진행중'
                                  : '대기중',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // 메인 퀘스트 태그 - 오른쪽
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(12),
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
                      // 단계 태그 - 오른쪽
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${mission.orderNo ?? 1}단계',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 중간: 제목과 설명 (왼쪽) + 아이콘 (오른쪽)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 퀘스트 정보 (왼쪽)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
                      
                      const SizedBox(width: 16),
                      
                      // 아이콘 (오른쪽)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? const Color(0xFF4CAF50) // 완료: 초록색
                              : const Color(0xFFF0F0F0), // 나머지: 회색
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted 
                              ? Icons.settings // 완료: 설정 아이콘
                              : Icons.lock, // 나머지: 잠금 아이콘
                          size: 30,
                          color: isCompleted 
                              ? AppColors.white // 완료: 흰색
                              : const Color(0xFF999999), // 나머지: 회색
                        ),
                      ),
                    ],
                  ),
                  
                  // 완료된 퀘스트인 경우 부퀘스트 섹션 추가
                  if (isCompleted) ...[
                    const SizedBox(height: 20),
                    _buildSubQuestSection(mission),
                  ],
                ],
              ),
            );
          }).toList(),
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
        child: const Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            SizedBox(height: 16),
            Text(
              '퀘스트 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
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
            const Icon(
              Icons.error_outline,
              size: 40,
              color: Color(0xFFE53E3E),
            ),
            const SizedBox(height: 16),
            const Text(
              '데이터를 불러오는데 실패했어요',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _loadData(),
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
        child: const Column(
          children: [
            Icon(
              Icons.help_outline,
              size: 40,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              '퀘스트 정보를 준비하고 있어요',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 완료된 퀘스트 카드 (첫 번째 카드 - 초록색 테두리)
  Widget _buildCompletedQuestCard(dynamic mission) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50), width: 2), // 초록색 테두리
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
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
                    color: const Color(0xFF4CAF50), // 초록색
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '완료',
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
              ],
            ),
            const SizedBox(height: 20),
            // 퀘스트 정보
            Row(
              children: [
                // 설정 아이콘 (초록색)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                    color: AppColors.white,
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
                          color: Color(0xFF4CAF50), // 초록색
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
            const SizedBox(height: 20),
            // 부퀘스트 정보
            Row(
              children: [
                const Text(
                  '부 퀘스트',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                Text(
                  '(5/5) 완료',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 다음 퀘스트 카드 (두 번째 카드 - 잠금 상태)
  Widget _buildPlannedQuestCard(dynamic mission) {
    return Container(
      width: double.infinity,
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
                    '${mission.orderNo ?? 2}단계',
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
    );
  }

  /// 하단 버튼
  Widget _buildBottomButton(BuildContext context) {
  return SafeArea(
    top: false,
    child: Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // CustomLoadingScreen으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomLoadingScreen(
                        topText: '다음 단계를 위한 퀘스트를\n생성하고 있어요...',
                        bottomText: '잠시만 기다려주세요',
                      ),
                    ),
                  );

                  /// 실제 퀘스트 시작 로직
                  void startNextQuest() async {
                    try {
                      // 데이터 새로고침 후 다음 퀘스트 찾기
                      await ref.read(missionListNotifierProvider.notifier).getMissionList('', _sideJobId!);
                      
                      // 새로고침된 데이터로 다음 퀘스트 찾기
                      final missionListState = ref.read(missionListNotifierProvider);
                      missionListState.maybeWhen(
                        success: (data) {
                          // 완료된 메인퀘스트들 중 가장 최근 것 찾기
                          final completedMissions = data.missions.where((m) => m.status == 'COMPLETED').toList();
                          if (completedMissions.isNotEmpty) {
                            // 가장 최근에 완료된 메인퀘스트 (orderNo가 가장 큰 것)
                            final latestCompletedMission = completedMissions.reduce(
                              (a, b) => (a.orderNo ?? 0) > (b.orderNo ?? 0) ? a : b,
                            );

                            // 다음 메인퀘스트 단계 찾기 (orderNo + 1)
                            final nextMissionOrder = (latestCompletedMission.orderNo ?? 0) + 1;
                            final nextMission = data.missions.firstWhere(
                              (m) => m.orderNo == nextMissionOrder,
                              orElse: () => data.missions.first, // fallback
                            );

                            // CustomLoadingScreen 닫기
                            Navigator.of(context).pop();
                            
                            // NextQuestStartScreen으로 이동
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NextQuestStartScreen(
                                  nextMissionId: nextMission.id,
                                  nextMissionOrder: nextMission.orderNo ?? 0,
                                  nextMissionTitle: nextMission.title,
                                  nextMissionDesignNotes: nextMission.designNotes,
                                  sideJobId: _sideJobId,
                                  onHomeTabRequested: widget.onHomeTabRequested,
                                ),
                              ),
                            );
                          } else {
                            // CustomLoadingScreen 닫기
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('완료된 메인퀘스트를 찾을 수 없습니다.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        orElse: () {
                          // CustomLoadingScreen 닫기
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('퀘스트 데이터를 불러올 수 없습니다.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      // CustomLoadingScreen 닫기
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('오류가 발생했습니다: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }

                  /// 광고가 준비되어 있으면 광고 먼저 실행
                  if (_isAdReady && _interstitialAd != null) {
                    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                      // 광고 닫힌 후 호출
                      onAdDismissedFullScreenContent: (ad) {
                        ad.dispose();
                        _interstitialAd = null;
                        _isAdReady = false;
                        _loadInterstitialAd(); // 다음 광고 미리 로딩
                        startNextQuest(); // 광고 끝나고 퀘스트 시작
                      },
                      // 광고 실행 실패 시
                      onAdFailedToShowFullScreenContent: (ad, error) {
                        ad.dispose();
                        _interstitialAd = null;
                        _isAdReady = false;
                        startNextQuest(); // 실패해도 퀘스트는 진행
                      },
                    );
                    _interstitialAd!.show();
                  } else {
                    // 광고 준비가 안 된 경우 그냥 바로 퀘스트 시작
                    startNextQuest();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  '다음 퀘스트 진행하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void _loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712', // ✅ 테스트용 ID
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        _interstitialAd = ad;
        _isAdReady = true;
      },
      onAdFailedToLoad: (error) {
        print('❌ 전면 광고 로드 실패: $error');
        _interstitialAd = null;
        _isAdReady = false;
      },
    ),
  );
}
  
  /// 부퀘스트 섹션 (완료된 퀘스트에만 표시)
  Widget _buildSubQuestSection(MissionEntity mission) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isExpanded = true; // 기본적으로 펼쳐진 상태
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Row(
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
                    Text(
                      '(5/5) 완료',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                                         Icon(
                       isExpanded 
                           ? Icons.keyboard_arrow_down 
                           : Icons.keyboard_arrow_up,
                       size: 20,
                       color: AppColors.textSecondary,
                     ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                const SizedBox(height: 16),
                // 부퀘스트 아이템들
                ...mission.steps.map((step) => _buildSubQuestItem(step)).toList(),
              ],
            ],
          ),
        );
      },
    );
  }
  
  /// 부퀘스트 아이템
  Widget _buildSubQuestItem(MissionStep step) {
    final isCompleted = step.status == 'COMPLETED';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              step.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isCompleted 
                    ? AppColors.textSecondary 
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
              color: isCompleted 
                  ? const Color(0xFF4CAF50) // 완료: 초록색
                  : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted 
                    ? const Color(0xFF4CAF50) // 완료: 초록색
                    : AppColors.cardBorder,
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
}
