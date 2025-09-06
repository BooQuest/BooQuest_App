import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booquest/core/constants/colors.dart';
import 'package:booquest/features/recommendation/presentation/screens/tutorial_completion_screen.dart';
import 'package:booquest/core/storage/local_storage_service.dart';
import 'package:booquest/core/storage/onboarding_storage_service.dart';
import 'package:booquest/features/recommendation/presentation/screens/sidejob_recommendations_screen.dart';
import 'package:booquest/core/navigation/transitions.dart';
import 'package:booquest/features/missions/infrastructure/providers/mission_providers.dart';
import 'package:booquest/features/missions/application/states/mission_state.dart';
import 'package:booquest/core/presentation/widgets/ai_loading_overlay.dart';
import 'package:booquest/features/sidejob/infrastructure/sidejob_providers.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';


class QuestStepsScreen extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>>? missionSteps;
  final int? selectedSideJobId; 
  final List<Map<String, dynamic>>? subQuests; // 부퀘스트 데이터
  final String? sideJobTitle; // 부업 제목
  final String? sideJobDesignNotes; // 부업 설명
  
  const QuestStepsScreen({
    super.key, 
    this.missionSteps,
    this.selectedSideJobId,
    this.subQuests, // 부퀘스트 데이터
    this.sideJobTitle,
    this.sideJobDesignNotes,
  });

  @override
  ConsumerState<QuestStepsScreen> createState() => _QuestStepsScreenState();
}

class _QuestStepsScreenState extends ConsumerState<QuestStepsScreen> {
  // 공통 스타일 상수
  static const _cardColor = Colors.white;
  static const _cardBorderRadius = BorderRadius.all(Radius.circular(12));
  static const _cardBorderColor = Color(0xFFE0E0E0);
  static const _cardBorderWidth = 1.0;
  static const _cardShadow = [
    BoxShadow(
      color: Color(0x0D000000), // alpha: 0.05
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
  ];

  static const _tagDecoration = BoxDecoration(
    color: Color(0xFFE7E7E7),
    borderRadius: BorderRadius.all(Radius.circular(100)),
  );

  static const _tagTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const _titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const _descriptionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const _iconSize = 56.0;

  bool _isSubQuestExpanded = true; // 부퀘스트 펼침/접힘 상태
  List<Map<String, dynamic>>? _subQuests; // 부퀘스트 로컬 상태
  bool _isSubQuestLoading = false; // 부퀘스트 로딩 상태 

  @override
  void initState() {
    super.initState();
    _subQuests = widget.subQuests;
    
    if (widget.selectedSideJobId != null && widget.missionSteps == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(missionNotifierProvider.notifier).getMissionsBySideJobId(widget.selectedSideJobId!);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final missionState = ref.watch(missionNotifierProvider);
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
                      horizontal: screenSize.width * 0.05, // 화면 너비의 5%
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: isSmallScreen ? 8 : 12),
                        _buildTopRow(context),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        _buildTitle(),
                        SizedBox(height: isSmallScreen ? 16 : 20),
                        _buildMainQuestSection(missionState),
                        SizedBox(height: isSmallScreen ? 40 : 50), 
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(context),
              ],
            ),
          ),
          if (_isSubQuestLoading || missionState.maybeWhen(loading: () => true, orElse: () => false))
            const AILoadingOverlay(
              title: 'AI가 미션을 불러오고 있어요...',
              subtitle: '잠시만 기다려주세요',
            ),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
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
          onPressed: () => _handleBack(),
        ),
        Expanded(
          child: Center(
            child: Text(
              '메인 퀘스트', 
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

  void _handleBack() {
    Navigator.of(context).pushReplacement(
      SlideFromLeftPageRoute(
        builder: (_) => const SideJobRecommendationsScreen(recommendations: []),
      ),
    );
  }

  Widget _buildTitle() {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '메인 퀘스트 생성 완료',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                '이렇게 진행하면 될까요?',
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

  Widget _buildMainQuestSection(MissionState missionState) {
    final screenSize = MediaQuery.of(context).size;
    
    // widget.missionSteps가 있으면 로컬 데이터 우선 사용
    if (widget.missionSteps != null && widget.missionSteps!.isNotEmpty) {
      return Column(
        children: [
          for (int i = 0; i < widget.missionSteps!.length; i++) ...[
            if (i > 0) SizedBox(height: screenSize.height < 700 ? 12 : 16),
            _buildMainQuestListItem(
              widget.missionSteps![i]['title'] ?? '',
              '${widget.missionSteps![i]['order']}단계',
              widget.missionSteps![i]['designNotes'] ?? '',
              isFirstCard: i == 0,
            ),
          ],
        ],
      );
    }
    
    // widget.missionSteps가 없으면 전역 상태 사용
    return missionState.when(
      initial: () => _buildEmptyState(),
      loading: () => const SizedBox.shrink(), // 로딩은 오버레이로 처리
      success: (steps) {
        if (steps.isEmpty) {
          return _buildEmptyState();
        }
        
        // 부퀘스트 데이터는 missionSteps에서 직접 추출
        if (steps.isNotEmpty) {
          final firstMission = steps.first;
          if (firstMission.missionSteps != null && firstMission.missionSteps!.isNotEmpty) {
            // seq 순서대로 정렬하여 부퀘스트 리스트에 설정
            final sortedSteps = List<Map<String, dynamic>>.from(firstMission.missionSteps!);
            sortedSteps.sort((a, b) => (a['seq'] ?? 0).compareTo(b['seq'] ?? 0));
            
            setState(() {
              _subQuests = sortedSteps.map((step) => {
                'id': step['id'],
                'title': step['title'],
                'seq': step['seq'],
                'status': step['status'],
                'detail': step['detail'],
              }).toList();
            });
          }
        }
        
        return Column(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              if (i > 0) SizedBox(height: screenSize.height < 700 ? 12 : 16), // 카드 간격을 반응형으로 조정
              _buildMainQuestListItem(
                steps[i].title,
                '${steps[i].order}단계',
                steps[i].designNotes,
                isFirstCard: i == 0, // 첫 번째 카드에만 부퀘스트 표시
              ),
            ],
          ],
        );
      },
      failure: (failure) => _buildErrorState(failure.userMessage),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '미션 데이터가 없습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '부업을 다시 선택해주세요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            '오류가 발생했습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 부퀘스트 섹션 위젯
  Widget _buildSubQuestSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // 연한 회색 배경으로 메인퀘스트와 구분
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSubQuestExpanded = !_isSubQuestExpanded;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '부 퀘스트',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.orange,
                ),
                const Spacer(),
                const Text(
                  '(0/5)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: _isSubQuestExpanded ? 0.0 : 0.5, // 180도 회전
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isSubQuestExpanded ? null : 0,
              child: _isSubQuestExpanded 
                ? _buildSubQuestList()
                : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  /// 부퀘스트 목록 위젯
  Widget _buildSubQuestList() {
    if (_subQuests == null || _subQuests!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '부퀘스트가 없습니다',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    // seq 순서대로 정렬
    final sortedSubQuests = List<Map<String, dynamic>>.from(_subQuests!);
    sortedSubQuests.sort((a, b) => (a['seq'] ?? 0).compareTo(b['seq'] ?? 0));

    return Column(
      children: [
        const SizedBox(height: 16),
        for (int i = 0; i < sortedSubQuests.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _buildSubQuestItem(sortedSubQuests[i]['title'] ?? '제목 없음'),
        ],
      ],
    );
  }

  /// 공통 태그 위젯 생성 메서드
  Widget _buildTag(String text, {Color? backgroundColor, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? _tagDecoration.color,
        borderRadius: _tagDecoration.borderRadius,
      ),
      child: Text(
        text,
        style: _tagTextStyle.copyWith(
          color: textColor ?? _tagTextStyle.color,
        ),
      ),
    );
  }

  /// 부퀘스트 아이템 위젯
  Widget _buildSubQuestItem(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildMainQuestListItem(String title, String difficulty, String description, {bool isFirstCard = false}) {
    // 1단계 메인퀘스트인 경우 새로운 디자인 적용
    if (isFirstCard) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: _cardBorderRadius,
          border: Border.all(color: _cardBorderColor, width: _cardBorderWidth),
          boxShadow: _cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 태그 섹션
            Row(
              children: [
                // 진행 예정 태그 (파란색)
                _buildTag(
                  '진행 예정',
                  backgroundColor: const Color(0xFF1976D2),
                  textColor: Colors.white,
                ),
                const Spacer(),
                // 메인 퀘스트 태그 (회색)
                _buildTag('메인 퀘스트'),
                const SizedBox(width: 12),
                // 단계 태그 (회색)
                _buildTag(difficulty),
              ],
            ),
            const SizedBox(height: 12),
            // 메인 콘텐츠 섹션
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 텍스트 영역
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: _titleTextStyle),
                      const SizedBox(height: 6),
                      Text(description, style: _descriptionTextStyle),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Image.asset(
                  'assets/images/quest/main_quest_1.png',
                  width: _iconSize,
                  height: _iconSize,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            // 첫 번째 카드에만 부퀘스트 섹션 추가
            const SizedBox(height: 20),
            _buildSubQuestSection(),
          ],
        ),
      );
    }
    
    // 기존 디자인 (2단계, 3단계 등) - 새로운 디자인으로 수정
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: _cardBorderRadius,
        border: Border.all(color: _cardBorderColor, width: _cardBorderWidth),
        boxShadow: _cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 태그 섹션
          Row(
            children: [
              // 대기 중 태그 (회색)
              _buildTag('대기 중'),
              const Spacer(),
              // 메인 퀘스트 태그 (회색) - 완전 오른쪽 정렬
              _buildTag('메인 퀘스트'),
              const SizedBox(width: 12),
              // 단계 태그 (회색) - 완전 오른쪽 정렬
              _buildTag(difficulty),
            ],
          ),
          const SizedBox(height: 12),
          // 메인 콘텐츠 섹션
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 텍스트 영역
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _titleTextStyle),
                    const SizedBox(height: 6),
                    Text(description, style: _descriptionTextStyle),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // 아이콘 (텍스트 오른쪽)
              Container(
                width: _iconSize,
                height: _iconSize,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0), // 연한 회색 배경
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock, // 자물쇠 아이콘
                  size: 24,
                  color: Color(0xFF666666), // 짙은 회색 아이콘
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
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
          height: 46,
          child: ElevatedButton(
            onPressed: () async {
              // 사용자 부업 선택 API 호출
              if (widget.selectedSideJobId != null) {
                await ref.read(sideJobNotifierProvider.notifier).selectUserSideJob(widget.selectedSideJobId!);
                
                // API 응답 확인
                final sideJobState = ref.read(sideJobNotifierProvider);
                final isSuccess = sideJobState.maybeWhen(
                  userSideJobSelected: (_) => true,
                  orElse: () => false,
                );
                
                if (!isSuccess) {
                  // API 실패 시 에러 메시지 표시
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('부업 선택에 실패했습니다. 다시 시도해주세요.')),
                    );
                  }
                  return;
                }
                
                // 부업 선택 성공 후 sideJobId를 storage에 저장
                final authStorage = await AuthStorageService.getInstance();
                await authStorage.setSideJobId(widget.selectedSideJobId!);
                
                // 부업 선택 성공 후, 미션 데이터 로드
                await ref.read(missionNotifierProvider.notifier).getMissionsBySideJobId(widget.selectedSideJobId!);
                
                // 미션 데이터 로드 완료 후 상태 확인
                final missionState = ref.read(missionNotifierProvider);
                final missionData = missionState.maybeWhen(
                  success: (steps) => steps.isNotEmpty ? steps.first : null,
                  orElse: () => null,
                );
                
                if (missionData != null) {
                  final missionStartSuccess = await ref.read(missionNotifierProvider.notifier).startMission(missionData.id);
                  
                  if (!missionStartSuccess) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('미션 시작에 실패했습니다. 다시 시도해주세요.')),
                      );
                    }
                    return; // 실패 시 온보딩 중단
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('미션 데이터를 찾을 수 없습니다. 다시 시도해주세요.')),
                    );
                  }
                  return; // 미션 데이터 없으면 온보딩 중단
                }
              }
              
              // 사용자 이름과 캐릭터 정보 미리 가져오기 (데이터 삭제 전)
              final authStorage = await AuthStorageService.getInstance();
              final userName = authStorage.getNickname() ?? '';
              
              // 온보딩 스토리지에서 캐릭터 정보 가져오기
              final onboardingStorage = await OnboardingStorageService.getInstance();
              final characterName = onboardingStorage.getCharacterName() ?? userName;
              final characterType = onboardingStorage.getCharacterType();
              
              // 온보딩 완료 상태로 설정 (데이터 삭제)
              await _markOnboardingCompleted();
              
              // 다음 화면으로 이동
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TutorialCompletionScreen(
                      userName: characterName,
                      characterType: characterType,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: AppColors.buttonText,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('다음', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  /// 온보딩 완료 상태 설정
  Future<void> _markOnboardingCompleted() async {
    try {
      // 토큰을 제외한 모든 로컬 데이터 초기화
      final storage = await LocalStorageService.getInstance();
      await storage.clearAllDataExceptToken();
      
      // OnboardingStorageService: 모든 온보딩 데이터 삭제
      final onboardingStorage = await OnboardingStorageService.getInstance();
      await onboardingStorage.clearAllData();
      
      // 온보딩 완료 처리 성공
    } catch (error) {
      // 온보딩 완료 처리 실패 (에러 무시하고 계속 진행)
    }
  }
}


