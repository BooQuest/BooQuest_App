import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/core/navigation/transitions.dart';


import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step4_method_selection_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/features/missions/infrastructure/providers/mission_providers.dart';
import 'package:booquest/core/utils/user_data_utils.dart';
import 'package:booquest/features/sidejob/infrastructure/sidejob_providers.dart';
import 'package:booquest/features/sidejob/domain/sidejob_entity.dart';
import 'package:booquest/features/sidejob/domain/sidejob_failure.dart';
import 'package:booquest/features/missions/domain/entities/subquest_request_data.dart';

/// 부업 추천 화면
class SideJobRecommendationsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> recommendations;
  
  const SideJobRecommendationsScreen({
    super.key,
    required this.recommendations,
  });

  @override
  State<SideJobRecommendationsScreen> createState() => _SideJobRecommendationsScreenState();
}

class _SideJobRecommendationsScreenState extends State<SideJobRecommendationsScreen> {
  static const double _horizontalPadding = 20.0;
  static const double _cardSpacing = 12.0;

  String _characterName = '';
  bool _isLoading = false;
  late List<Map<String, dynamic>> _recommendations;
  List<Map<String, dynamic>>? _subQuests; // 부퀘스트 데이터

  @override
  void initState() {
    super.initState();
    _recommendations = List.from(widget.recommendations);
    _loadCharacterName();
    // 화면 진입 시 기존 추천 목록 자동 로드 (온보딩에서 넘어온 경우 제외)
    // - widget.recommendations가 비어있을 때만 호출
    // - 앱 최초 진입 또는 뒤로가기에서 재진입 시 최근 추천 목록 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.recommendations.isEmpty) {  // widget.recommendations 직접 체크
        _loadExistingRecommendations();
      }
    });
  }

  Future<void> _loadCharacterName() async {
    try {
      final storage = await OnboardingStorageService.getInstance();
      final name = storage.getCharacterName();
      if (name != null && name.isNotEmpty) {
        setState(() => _characterName = name);
      }
    } catch (_) {}
  }

  /// 기존 추천 부업 목록 로드
  /// - GET /api/sideJob/{userId}
  /// - 실패 시 스낵바로 사용자에게 안내
  Future<void> _loadExistingRecommendations() async {
    setState(() { _isLoading = true; });
    final container = ProviderContainer();
    try {
      final userId = await UserDataUtils.instance.getUserId() ?? 0;
      if (userId == 0) {
        setState(() { _isLoading = false; });
        return;
      }

      final usecase = container.read(getExistingSideJobsProvider);
      final result = await usecase(userId);
      result.fold(
        (failure) {
          if (mounted) {
            setState(() { _isLoading = false; });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.userMessage)),
            );
          }
        },
        (list) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _recommendations = list
                  .map((e) => {
                        'id': e.id,
                        'title': e.title,
                        'description': e.description,
                      })
                  .toList();
            });
          }
        },
      );
    } finally {
      container.dispose();
    }
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
                        const SizedBox(height: 12),
                        _buildTopBar(),
                        const SizedBox(height: 16),
                        _buildTitle(),
                        const SizedBox(height: 20),
                        _buildCardList(),
                        const SizedBox(height: 50),
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
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: _handleBack,
        ),
        const Expanded(
          child: Center(child: Text('부업 추천 3가지', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_characterName.isNotEmpty ? _characterName : '사용자'} 에게 딱 맞는\n부업을 3가지 추천할게',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '재생성을 원하거나 맘에드는 부업을 선택해 주세요.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                                                  color: AppColors.textPrimary.withValues(alpha: 0.6),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 39,
          height: 39,
          child: SvgPicture.asset(
            'assets/images/characters/basic_icon_1.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildCardList() {
    // 전달받은 recommendations 데이터 사용
    if (_recommendations.isEmpty) {
      return const Center(
        child: Text(
          '부업 추천 데이터가 없습니다.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final rec = _recommendations[index];
        return _SideJobCard(
          item: _SideJobItem(
            title: rec['title'] ?? '제목 없음',
            subtitle: rec['description'] ?? '설명 없음',
          ),
          onSelect: () => _handleCardSelect(index),
          onRecommendAgain: () => _handleRecommendAgain(index),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: _cardSpacing),
      itemCount: _recommendations.length,
    );
  }



  @override
  void dispose() {
    super.dispose();
  }

  void _handleCardSelect(int index) async {
    final rec = _recommendations[index];
    final sideJobIdStr = rec['id']?.toString() ?? '';
    if (sideJobIdStr.isEmpty) {
      return;
    }
    
    final sideJobId = int.tryParse(sideJobIdStr) ?? 0;
    final sideJobTitle = rec['title']?.toString() ?? '';
    final sideJobDesignNotes = rec['description']?.toString() ?? '';

    // userId 추출 (AuthStorageService via UserDataUtils)
    final userId = await UserDataUtils.instance.getUserId() ?? 0;

    _createMissions(
      userId: userId,
      sideJobId: sideJobId,
      sideJobTitle: sideJobTitle,
      sideJobDesignNotes: sideJobDesignNotes,
    );
  }

  void _handleRecommendAgain(int index) {
    _showFeedbackPopup(index);
  }

  void _showFeedbackPopup(int sideJobIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _FeedbackBottomSheet(
          sideJobIndex: sideJobIndex,
          onApply: (List<String> selectedReasons, String additionalComment) async {
            await _handleFeedbackSubmit(sideJobIndex, selectedReasons, additionalComment);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _handleFeedbackSubmit(
    int sideJobIndex,
    List<String> selectedReasons,
    String additionalComment,
  ) async {
    // 선택된 카드의 sideJobId
    final rec = _recommendations[sideJobIndex];
    final sideJobId = int.tryParse(rec['id']?.toString() ?? '') ?? 0;
    if (sideJobId == 0) return;

    setState(() { _isLoading = true; });

    final container = ProviderContainer();
    try {
      // 재생성에 필요한 사용자 데이터 구성
      final userId = await UserDataUtils.instance.getUserId() ?? 0;
      final job = await UserDataUtils.instance.getJob() ?? '';
      final hobbies = await UserDataUtils.instance.getHobbies() ?? <String>[];
      final expressionStyle = await UserDataUtils.instance.getExpressionStyle() ?? '';
      final strengthType = await UserDataUtils.instance.getStrengthType() ?? '';
      final nickname = await UserDataUtils.instance.getNickname() ?? '';
      final characterType = await UserDataUtils.instance.getCharacterType() ?? '';
      final characterName = await UserDataUtils.instance.getCharacterName() ?? '';

      final generateRequest = SideJobRequestData(
        userId: userId,
        nickname: nickname,
        job: job,
        hobbies: hobbies,
        expressionStyle: expressionStyle,
        strengthType: strengthType,
        characterType: characterType,
        characterName: characterName,
      );

      // 영어 reason 키로 매핑 (이미 영어 키로 저장 중이지만 안전하게 보정)
      final mappedReasons = selectedReasons.map((key) {
        switch (key) {
          case 'low_profitability': return 'LOW_PROFITABILITY';
          case 'not_interesting': return 'NO_INTEREST';
          case 'personality_mismatch': return 'NOT_MY_STYLE';
          case 'too_time_consuming': return 'TAKES_TOO_MUCH_TIME';
          case 'not_capable': return 'NOT_FEASIBLE';
          case 'high_initial_cost': return 'TOO_EXPENSIVE';
          default: return key.toString().toUpperCase();
        }
      }).toList();

      final usecase = container.read(regenerateSingleSideJobProvider);
      final result = await usecase(
        sideJobId: sideJobId,
        reasons: mappedReasons,
        etcFeedback: additionalComment,
        generateSideJobRequest: generateRequest,
      );

      result.fold(
        (failure) {
          if (mounted) {
            setState(() { _isLoading = false; });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.userMessage)),
            );
          }
        },
        (entity) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              // 해당 카드만 새 데이터로 교체
              _recommendations[sideJobIndex] = {
                'id': entity.id,
                'title': entity.title,
                'description': entity.description,
              };
            });
          }
        },
      );
    } finally {
      container.dispose();
    }
  }

  Future<void> _createMissions({
    required int userId,
    required int sideJobId,
    required String sideJobTitle,
    required String sideJobDesignNotes,
  }) async {
    setState(() { _isLoading = true; });
    // Riverpod manual usage through a temporary ProviderScope owner
    final container = ProviderContainer();
    try {
      await container.read(missionNotifierProvider.notifier).createMissions(
        userId: userId,
        sideJobId: sideJobId,
        sideJobTitle: sideJobTitle,
        sideJobDesignNotes: sideJobDesignNotes,
      );
      final state = container.read(missionNotifierProvider);
      state.when(
        initial: () {},
        loading: () {},
        success: (steps) async {
          if (mounted) {
            // 미션 데이터를 Map 형태로 변환
            final missionStepsData = steps.map((step) => {
              'id': step.id,
              'title': step.title,
              'order': step.order,
              'designNotes': step.designNotes,
            }).toList();
            
            // 첫 번째 미션의 ID로 부퀘스트 API 호출
            if (steps.isNotEmpty) {
              final firstMission = steps.first;
              final subQuests = await container.read(missionNotifierProvider.notifier).getSubQuests(
                SubQuestRequestData(
                  userId: userId,
                  missionId: firstMission.id,
                  missionTitle: firstMission.title,
                  missionDesignNotes: firstMission.designNotes,
                ),
              );
              
              // 부퀘스트 데이터를 Map 형태로 변환하여 저장
              if (subQuests != null) {
                _subQuests = subQuests.map((quest) => {
                  'id': quest.id,
                  'title': quest.title,
                  'seq': quest.seq,
                  'status': quest.status,
                  'detail': quest.detail,
                }).toList();
              }
            }
            
            if (mounted) {
              setState(() { _isLoading = false; });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuestStepsScreen(
                    missionSteps: missionStepsData,
                    subQuests: _subQuests,
                    selectedSideJobId: sideJobId,
                    sideJobTitle: sideJobTitle,
                    sideJobDesignNotes: sideJobDesignNotes,
                  ),
                ),
              );
            }
          }
        },
        failure: (f) {
          if (mounted) {
            setState(() { _isLoading = false; });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(f.userMessage)),
            );
          }
        },
      );
    } finally {
      container.dispose();
    }
  }

  Future<void> _handleBack() async {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const Step4MethodSelectionScreen(),
      ),
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
          child: ElevatedButton(
            onPressed: () async {
              await _handleRegenerate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonActive,
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('전체 재생성하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegenerate() async {
    if (_recommendations.isEmpty) {
      return;
    }

    setState(() { _isLoading = true; });

    // 현재 보여지는 3개 부업의 id 수집
    final sideJobIds = _recommendations
        .map((e) => int.tryParse(e['id']?.toString() ?? ''))
        .where((id) => id != null)
        .cast<int>()
        .toList();

    // 재생성에 필요한 사용자 데이터 수집 (기존 sidejob 수집 로직 재사용)
    final container = ProviderContainer();
    try {
      // strengthType은 onboarding 저장값 사용
      // UserDataUtils 통해 strengthType, job, hobbies, expressionStyle 가져오기
      final userId = await UserDataUtils.instance.getUserId() ?? 0;
      final job = await UserDataUtils.instance.getJob() ?? '';
      final hobbies = await UserDataUtils.instance.getHobbies() ?? <String>[];
      final expressionStyle = await UserDataUtils.instance.getExpressionStyle() ?? '';
      final strengthType = await UserDataUtils.instance.getStrengthType() ?? '';
      final nickname = await UserDataUtils.instance.getNickname() ?? '';
      final characterType = await UserDataUtils.instance.getCharacterType() ?? '';
      final characterName = await UserDataUtils.instance.getCharacterName() ?? '';

      // SideJobRequestData 재사용
      final generateRequest = SideJobRequestData(
        userId: userId,
        nickname: nickname,
        job: job,
        hobbies: hobbies,
        expressionStyle: expressionStyle,
        strengthType: strengthType,
        characterType: characterType,
        characterName: characterName,
      );

      final usecase = container.read(regenerateSideJobsProvider);
      final result = await usecase(
        sideJobIds: sideJobIds,
        generateSideJobRequest: generateRequest,
      );

      result.fold(
        (failure) {
          if (mounted) {
            setState(() { _isLoading = false; });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.userMessage)),
            );
          }
        },
        (list) {
          if (mounted) {
            setState(() { _isLoading = false; });
            // 화면의 카드 리스트 데이터 업데이트
            _recommendations = list
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'description': e.description,
                    })
                .toList();
            // setState로 UI 갱신
            setState(() {});
          }
        },
      );
    } finally {
      container.dispose();
    }
  }

}

class _SideJobItem {
  final String title;
  final String subtitle;
  
  const _SideJobItem({required this.title, required this.subtitle});
}

class _SideJobCard extends StatelessWidget {
  final _SideJobItem item;
  final VoidCallback onSelect;
  final VoidCallback onRecommendAgain;
  
  const _SideJobCard({
    required this.item, 
    required this.onSelect, 
    required this.onRecommendAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.cardBorder, 
          width: 1
        ),
        boxShadow: [
          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: onRecommendAgain,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F5F5),
                        foregroundColor: const Color(0xFF666666),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '다시 추천받기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onSelect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonActive,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        '선택하기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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


}

/// 피드백 수집 바텀 시트
class _FeedbackBottomSheet extends StatefulWidget {
  final int sideJobIndex;
  final Future<void> Function(List<String> selectedReasons, String additionalComment) onApply;

  const _FeedbackBottomSheet({
    required this.sideJobIndex,
    required this.onApply,
  });

  @override
  State<_FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<_FeedbackBottomSheet> {
  final Set<String> _selectedReasons = <String>{};
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  static const List<Map<String, dynamic>> _feedbackOptions = [
    {'label': '수익성이 낮아보여요', 'key': 'low_profitability'},
    {'label': '흥미가 생기지 않아요', 'key': 'not_interesting'},
    {'label': '성향과 맞지 않아요', 'key': 'personality_mismatch'},
    {'label': '시간이 너무 많이 필요해요', 'key': 'too_time_consuming'},
    {'label': '할 수 있는 일이 아니에요', 'key': 'not_capable'},
    {'label': '초기 비용이 부담돼요', 'key': 'high_initial_cost'},
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double kb = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: kb > 0 ? kb : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 상단 핸들 바
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // 제목 및 설명
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '더 정확한 추천을 위해,\n어떤 점이 아쉬웠나요?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '아쉬웠던 점을 모두 선택해주세요.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 피드백 옵션들
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // 2열 3행으로 배치
                          for (int row = 0; row < 3; row++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  for (int col = 0; col < 2; col++)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: col == 0 ? 6 : 0,
                                          left: col == 1 ? 6 : 0,
                                        ),
                                        child: _buildFeedbackOption(_feedbackOptions[row * 2 + col]),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 추가 코멘트 입력 필드
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _commentController,
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          decoration: const InputDecoration(
                            hintText: '추가로 고려할 점이 있다면 작성해주세요.',
                            hintStyle: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 적용하기 버튼
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _selectedReasons.isNotEmpty && !_isSubmitting
                              ? () async {
                                  setState(() {
                                    _isSubmitting = true;
                                  });
                                  try {
                                    await widget.onApply(
                                        _selectedReasons.toList(), _commentController.text);
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isSubmitting = false;
                                      });
                                    }
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedReasons.isNotEmpty
                                ? const Color(0xFF666666)
                                : const Color(0xFFE0E0E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '적용하기',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 로딩 오버레이
            if (_isSubmitting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackOption(Map<String, dynamic> option) {
    final String label = option['label'];
    final String key = option['key'];
    final bool isSelected = _selectedReasons.contains(key);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedReasons.remove(key);
          } else {
            _selectedReasons.add(key);
          }
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF666666) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF666666) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}


