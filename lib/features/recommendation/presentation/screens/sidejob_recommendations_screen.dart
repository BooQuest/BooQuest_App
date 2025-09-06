import 'package:flutter/material.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/features/recommendation/presentation/widgets/feedback_bottom_sheet.dart';


import 'package:booquest/features/recommendation/presentation/screens/quest_steps_screen.dart';
import 'package:booquest/features/onboarding/presentation/screens/step6_method_selection_screen.dart';
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
                  .map((e) => <String, dynamic>{
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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05, 
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: isSmallScreen ? 8 : 12),
                        _buildTopBar(context),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        _buildTitle(context),
                        SizedBox(height: isSmallScreen ? 16 : 20),
                        _buildCardList(),
                        SizedBox(height: isSmallScreen ? 40 : 50),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(context),
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

  Widget _buildTopBar(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded, 
            size: isSmallScreen ? 18 : 20, 
            color: AppColors.textPrimary
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: _handleBack,
        ),
        Expanded(
          child: Center(
            child: Text(
              '부업 추천 3가지', 
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18, 
                fontWeight: FontWeight.w700, 
                color: AppColors.textPrimary
              )
            )
          ),
        ),
        SizedBox(width: isSmallScreen ? 32 : 40),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: '${_characterName.isNotEmpty ? _characterName : '사용자'}님에게 딱 맞는\n'),
                    TextSpan(
                      text: '부업 3가지',
                      style: TextStyle(
                        color: const Color(0xFF1976D2),
                      ),
                    ),
                    const TextSpan(text: '를 추천할게요\n'),
                  ],
                ),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                '다시 추천 받기를 원하거나 마음에 드는 부업을 선택해 주세요.',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardList() {
    // 전달받은 recommendations 데이터 사용
    if (_recommendations.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = MediaQuery.of(context).size;
          final isSmallScreen = screenSize.height < 700;
          
          return Center(
            child: Text(
              '부업 추천 데이터가 없습니다.',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16, 
                color: Colors.grey,
              ),
            ),
          );
        },
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
        return FeedbackBottomSheet(
          sideJobIndex: sideJobIndex,
          onApply: (List<String> selectedReasons, String additionalComment) async {
            // 팝업 닫기
            Navigator.of(context).pop();
            // API 처리 시작
            await _handleFeedbackSubmit(sideJobIndex, selectedReasons, additionalComment);
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

    // 로딩 상태 시작
    if (mounted) {
      setState(() { _isLoading = true; });
    }

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

      // frontend key와 API request value를 동일하게 사용
      final mappedReasons = selectedReasons.toList();

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
              // 해당 카드만 새 데이터로 교체 (타입 안전하게 처리)
              _recommendations[sideJobIndex] = <String, dynamic>{
                'id': entity.id, // String으로 저장 (API 응답과 일치)
                'title': entity.title,
                'description': entity.description,
              };
              
              print('✅ 재생성 완료 - 카드 인덱스: $sideJobIndex, 새 ID: ${entity.id}');
            });
            // 성공 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('부업이 성공적으로 재생성되었습니다!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      );
    } catch (e) {
      // 예외 발생 시에도 로딩 상태 해제
      if (mounted) {
        setState(() { _isLoading = false; });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('재생성 중 오류가 발생했습니다: $e')),
        );
      }
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
        builder: (_) => const Step6MethodSelectionScreen(),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          height: isSmallScreen ? 46 : 60,
          child: ElevatedButton(
            onPressed: () async {
              await _handleRegenerate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text(
              '전체 재생성하기', 
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18, 
                fontWeight: FontWeight.w500
              )
            ),
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
                .map((e) => <String, dynamic>{
                      'id': e.id,
                      'title': e.title,
                      'description': e.description,
                    })
                .toList();
            // setState로 UI 갱신
            setState(() {});
            
            // 성공 메시지 표시
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('전체 부업이 성공적으로 재생성되었습니다!'),
                backgroundColor: Colors.green,
              ),
            );
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double cardPadding = screenWidth * 0.04; // 화면 너비의 4% (반응형 패딩)
        final double titleFontSize = screenWidth * 0.045; // 화면 너비의 4.5% (반응형 폰트 크기)
        final double subtitleFontSize = screenWidth * 0.035; // 화면 너비의 3.5% (반응형 폰트 크기)
        final double buttonFontSize = screenWidth * 0.035; // 화면 너비의 3.5% (반응형 폰트 크기)
        final double buttonHeight = screenWidth * 0.12; // 화면 너비의 12% (반응형 버튼 높이)
        
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
            padding: EdgeInsets.all(cardPadding.clamp(12.0, 20.0)), // 최소 12, 최대 20으로 제한
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: titleFontSize.clamp(16.0, 22.0), // 최소 16, 최대 22로 제한
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: cardPadding * 0.5), // 패딩의 절반만큼 간격
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: subtitleFontSize.clamp(12.0, 16.0), // 최소 12, 최대 16으로 제한
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: cardPadding * 1.25), // 패딩의 1.25배만큼 간격
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight.clamp(36.0, 48.0), // 최소 36, 최대 48으로 제한
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
                          child: Text(
                            '다시 추천받기',
                            style: TextStyle(
                              fontSize: buttonFontSize.clamp(12.0, 16.0), // 최소 12, 최대 16으로 제한
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: cardPadding * 0.75), // 패딩의 0.75배만큼 간격
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight.clamp(36.0, 48.0), // 최소 36, 최대 48으로 제한
                                                  child: ElevatedButton(
                            onPressed: onSelect,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF424242), // 더 진한 회색으로 변경
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              '선택하기',
                              style: TextStyle(
                                fontSize: buttonFontSize.clamp(12.0, 16.0), // 최소 12, 최대 16으로 제한
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
      },
    );
  }


}




