import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';

import 'package:booquest/features/missions/infrastructure/providers/mission_providers.dart';
import 'package:booquest/features/missions/application/states/mission_state.dart';
import 'package:booquest/features/missions/domain/entities/mission_entity.dart';
import 'package:booquest/features/missions/domain/entities/subquest_request_data.dart';
import 'package:booquest/features/missions/domain/entities/subquest_regenerate_request_data.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import 'package:booquest/features/quest/presentation/widgets/feedback_popup.dart';

/// 새로운 퀘스트 시작 화면 - 다음 퀘스트 진행하기 버튼 클릭 시
class NextQuestStartScreen extends ConsumerStatefulWidget {
  final int nextMissionId;
  final int nextMissionOrder;
  final String nextMissionTitle;
  final String nextMissionDesignNotes;
  final int? sideJobId;
  final VoidCallback? onHomeTabRequested;
  
  const NextQuestStartScreen({
    super.key,
    required this.nextMissionId,
    required this.nextMissionOrder,
    required this.nextMissionTitle,
    required this.nextMissionDesignNotes,
    this.sideJobId,
    this.onHomeTabRequested,
  });

  @override
  ConsumerState<NextQuestStartScreen> createState() => _NextQuestStartScreenState();
}

class _NextQuestStartScreenState extends ConsumerState<NextQuestStartScreen> {
  String? _userNickname;
  int? _sideJobId;
  int? _userId;
  int? _nextMissionId;
  String? _nextMissionTitle;
  String? _nextMissionDesignNotes;
  bool _isSubQuestExpanded = true; // 부퀘스트 섹션 펼침/접힘 상태



  Future<void> _loadData() async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      _sideJobId = widget.sideJobId ?? authStorage.getSideJobId();
      _userNickname = authStorage.getNickname();
      _userId = authStorage.getUserId();

      if (_sideJobId != null && _userId != null) {
        // 전달받은 실제 메인퀘스트 정보 사용
        _nextMissionId = widget.nextMissionId;
        _nextMissionTitle = widget.nextMissionTitle;
        _nextMissionDesignNotes = widget.nextMissionDesignNotes;
        
        // 부퀘스트 생성 API 호출
        final subQuests = await ref.read(missionNotifierProvider.notifier).getSubQuests(
          SubQuestRequestData(
            userId: _userId!,
            missionId: _nextMissionId!,
            missionTitle: _nextMissionTitle!,
            missionDesignNotes: _nextMissionDesignNotes!,
          ),
        );
        
        // 부퀘스트 데이터를 MissionStepEntity로 변환하여 저장
        if (subQuests != null) {
          final missionSteps = subQuests.map((subQuest) => MissionStepEntity(
            id: subQuest.id,
            title: subQuest.title,
            order: subQuest.seq,
            designNotes: subQuest.detail,
          )).toList();
          
          // MissionState를 직접 업데이트 (setState 메서드 사용)
          ref.read(missionNotifierProvider.notifier).setState(MissionState.success(missionSteps));
        }
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  /// 피드백 팝업 표시
  void _showFeedbackPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
          return FeedbackPopup(
            onSubmit: (List<String> selectedReasons, String additionalComment) async {
              // 피드백 제출 및 부퀘스트 재생성
              await _handleFeedbackSubmit(selectedReasons, additionalComment);
              
              // 팝업 닫기
              Navigator.of(context).pop();
            },
          );
      },
    );
  }

  /// 퀘스트 시작
  Future<void> _startQuest() async {
    try {

      // 퀘스트 시작 API 호출
      await ref.read(missionNotifierProvider.notifier).startMission(_nextMissionId!);

      // 성공 메시지 표시
      if (mounted) {
        // 메인퀘스트 시작 알림 스낵바
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.celebration,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '🎉 메인퀘스트가 시작되었습니다!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );

      }

      // 홈 탭으로 강제 이동
      widget.onHomeTabRequested?.call();
      Navigator.of(context).popUntil((route) => route.isFirst);
      
    } catch (e) {
      print('Error starting quest: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('퀘스트 시작에 실패했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 피드백 제출 처리 및 부퀘스트 재생성
  Future<void> _handleFeedbackSubmit(List<String> selectedReasons, String additionalComment) async {
    try {
      // 부퀘스트 재생성 API 호출 (Provider를 통한 간접 호출)
      await ref.read(missionNotifierProvider.notifier).regenerateSubQuests(
        SubQuestRegenerateRequestData(
          feedbackData: FeedbackData(
            reasons: selectedReasons,
            etcFeedback: additionalComment,
          ),
          generateMissionStep: GenerateMissionStep(
            userId: _userId!,
            missionId: _nextMissionId!,
            missionTitle: _nextMissionTitle!,
            missionDesignNotes: _nextMissionDesignNotes!,
          ),
        ),
      );

      // 성공 메시지 표시 (MissionState 변화를 감지하여 자동으로 UI 업데이트)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('부퀘스트가 재생성되었습니다!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // 부퀘스트 섹션 확장
        setState(() {
          _isSubQuestExpanded = true;
        });
      }
    } catch (e) {
      print('Error regenerating sub-quests: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final missionState = ref.watch(missionNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: missionState.when(
          initial: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  '부퀘스트를 생성하고 있습니다...',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  '부퀘스트를 생성하고 있습니다...',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          success: (data) => Column(
            children: [
              // 상단 바 
              _buildTopBar(),
              // 스크롤 가능한 콘텐츠
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 안내 메시지 카드
                      _buildGuideMessageCard(),
                      const SizedBox(height: 24),
                      // 퀘스트 카드들
                      _buildQuestCards(missionState),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // 하단 버튼
              _buildBottomButton(context),
            ],
          ),
          failure: (failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  '오류가 발생했습니다: ${failure.userMessage}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _loadData();
                  },
                  child: const Text('다시 시도'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 상단 바
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

  /// 안내 메시지 카드 
  Widget _buildGuideMessageCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 첫 번째 줄: "이제" (검은색) + "새로운 퀘스트를" (파란색)
          Row(
            children: [
              const Text(
                '이제 ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Text(
                '새로운 퀘스트를',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary, // 파란색
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // 두 번째 줄: "시작할 수 있어요!" (검은색)
          const Text(
            '시작할 수 있어요!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          // 세 번째 줄: 설명 (회색)
          const Text(
            '다음을 눌러 도전을 이어가 보세요.',
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

  /// 퀘스트 카드
  Widget _buildQuestCards(MissionState state) {
    return state.maybeWhen(
      success: (data) {
        if (data == null || data.isEmpty) {
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
                  '부퀘스트 정보가 없습니다',
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

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary, // 진행중: 파란색 테두리
              width: 2,
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
              // 상단: 상태 태그들 (진행 예정은 왼쪽, 메인퀘스트/단계는 오른쪽)
              Row(
                children: [
                  // 진행 예정 태그 (파란색) - 왼쪽
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '진행 예정',
                      style: TextStyle(
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
                      '${widget.nextMissionOrder}단계',
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
                          widget.nextMissionTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.nextMissionDesignNotes,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 경험치 보상 (이미지와 동일)
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Color(0xFF999999),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '+50EXP',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF999999),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 아이콘 (오른쪽) - 이미지와 동일하게 빨간색 비디오 카메라
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6), // 연한 빨간색 배경
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.videocam, // 비디오 카메라 아이콘
                      size: 30,
                      color: Color(0xFFE53E3E), // 빨간색
                    ),
                  ),
                ],
              ),
              
              // 부퀘스트 섹션 (이미지와 동일하게 항상 표시)
              const SizedBox(height: 20),
              _buildSubQuestSection(data), // API에서 받은 부퀘스트 데이터 전달
              const SizedBox(height: 20),
              // 재생성하기 버튼 (부퀘스트 섹션 밖으로 이동)
              _buildRegenerateButton(),
            ],
          ),
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

  /// 하단 버튼 (이미지와 동일하게 "시작하기")
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
                  onPressed: () async {
                    // 퀘스트 시작 API 호출
                    await _startQuest();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    '시작하기',
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
  
  /// 부퀘스트 섹션 (생성된 부퀘스트 표시)
  Widget _buildSubQuestSection(List<MissionStepEntity> missionSteps) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSubQuestExpanded = !_isSubQuestExpanded;
        });
      },
      child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
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
                    // 느낌표 아이콘 (배경 제거)
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const Spacer(),
                    Text(
                      '(0/${missionSteps.length}) 완료', // 동적으로 부퀘스트 개수 표시
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _isSubQuestExpanded ? 0.0 : 0.5,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isSubQuestExpanded
                      ? Column(
                          children: [
                            const SizedBox(height: 16),
                            // 부퀘스트 아이템들
                            ...missionSteps.map((step) => _buildSubQuestItem(step)).toList(),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
  }
  
  /// 부퀘스트 아이템 (이미지와 동일하게 체크박스)
  Widget _buildSubQuestItem(MissionStepEntity step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              step.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 빈 체크박스 (이미지와 동일)
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.cardBorder,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }


  /// 재생성하기 버튼 (부퀘스트 섹션 밖에)
  Widget _buildRegenerateButton() {
    return GestureDetector(
      onTap: _showFeedbackPopup,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.cardBorder, width: 1),
        ),
        child: const Center(
          child: Text(
            '재생성하기',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
